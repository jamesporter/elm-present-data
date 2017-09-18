const gulp = require('gulp'),
    s3 = require("gulp-s3"),
    fs = require('fs');

gulp.task('deploy', function(){
    const aws = JSON.parse(fs.readFileSync('aws-config.json'));
    const options = { headers: {'Cache-Control': 'max-age=6000, public'} };

    return gulp.src('dist/**')
        .pipe(s3(aws, options));
});
