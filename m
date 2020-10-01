Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9213027F7A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 04:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgJACAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 22:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJACAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 22:00:21 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C11DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:00:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so1293440wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivrZpUtEROi7RAF0nFuQJJGKHFNcErwlwJXYrDh//aU=;
        b=oU7XD9Ld1nZHRqmxXUxeVkd21g26csgtsRw2bgqpywRnNiOrAVj+am/gNJr8tsj48Z
         hp1GbD1RYs5OYrmSpu+1B+WeqgbIIhwJJdOqj5uasnxF0vYHYJD18PQSbZJLoah3yauB
         sXERv2A67binehzAiFSfVcpaUoqMqOdPRdTdnJLl7dP/DU5UDN5qCNZbl4bxGMVhtlYp
         GRDzz25ewfkKPUnJ0/TF+FY+mQvid7yWvtTvxF+Vnym6CdVSaMOEiB/kskp90WBP0/ck
         weSe74LTfnjrloch601fC1KGW+7CXzO1h0GvdO/iL0ty3CcVtqaDIQSz9OV1EqzDja6X
         bh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivrZpUtEROi7RAF0nFuQJJGKHFNcErwlwJXYrDh//aU=;
        b=Wh+1hFWyFKyCDSKDeFsztvcK92kVx1x9rHX5NVQ2AT5hI5AAjVY2Gn0W0zzvqm0WGK
         G2TjoMEFyEug/qOe1hLx6oIDdLgrK0PZ6GQ89/8Kik2Fk4zWte6fvSPs6qOKLaZcfyLc
         jT2wDUJTxxu0OzFdtbk8soVf+lae7qCzX8e8pWlljfg5qSYlLtKDgPVjt6Oq7MAoj+J3
         pMTRCd2UDJRxlFqRwh5UG2+9O4+FedPeq/QcQa4Bly6GGgIXDacGw7fZTzXlcocIlK9k
         bDb4C4sJRplL33sHdn3f5DWX3ViJYF6dofpvRrpbCKO9S1RDCwmctb4Bi9p4E6ape0lQ
         AfpA==
X-Gm-Message-State: AOAM531IoL5aqyRlDz+7gvRiw9gF0333otQTLkd12JiSmj1Q5j6f8WJX
        6LAaliIFJ9ie6vXsI10j48/PASsgD6RpEW5xOcbhtA==
X-Google-Smtp-Source: ABdhPJy42uAhDqsBhqu4iUoXSCFJaRfduXkKQY9F4EkWVxWaqmoyUk18P5mCGBD7Y5fqSSEXbrIjBwyIPuMtAtRmkmo=
X-Received: by 2002:a7b:cd08:: with SMTP id f8mr5736758wmj.124.1601517618007;
 Wed, 30 Sep 2020 19:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-2-jolsa@kernel.org>
In-Reply-To: <20200930171512.3986425-2-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Sep 2020 19:00:05 -0700
Message-ID: <CAP-5=fVwe5wowm9Z6RgMAKA-nRd01U6DL0LGuUJSnPc_H=w17w@mail.gmail.com>
Subject: Re: [PATCH 1/9] perf tools: Add build id shell test
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 10:15 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test for build id cache that adds binary
> with sha1 and md5 build ids and verifies it's
> added properly.
>
> The test updates build id cache with perf record
> and perf buildid-cache -a.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

This is great! If I build perf and test from the build directory the
test gets run. If I build using O=/tmp/perf and run from that
directory then ./tests/shell isn't found and the test doesn't run.
Similarly the install directory doesn't contain the executables and so
the test is skipped. Is there any way to get the test running in these
other scenarios?

Thanks,
Ian

> ---
>  tools/perf/Makefile.perf          | 14 +++++
>  tools/perf/tests/shell/buildid.sh | 90 +++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100755 tools/perf/tests/shell/buildid.sh
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 920d8afb9238..b2aeefa64e92 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -126,6 +126,8 @@ include ../scripts/utilities.mak
>  #
>  # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
>  #
> +# Define NO_BUILDID_EX if you do not want buildid-ex-* binaries
> +#
>
>  # As per kernel Makefile, avoid funny character set dependencies
>  unexport LC_ALL
> @@ -349,6 +351,11 @@ ifndef NO_PERF_READ_VDSOX32
>  PROGRAMS += $(OUTPUT)perf-read-vdsox32
>  endif
>
> +ifndef NO_BUILDID_EX
> +PROGRAMS += $(OUTPUT)buildid-ex-sha1
> +PROGRAMS += $(OUTPUT)buildid-ex-md5
> +endif
> +
>  LIBJVMTI = libperf-jvmti.so
>
>  ifndef NO_JVMTI
> @@ -756,6 +763,13 @@ $(OUTPUT)perf-read-vdsox32: perf-read-vdso.c util/find-map.c
>         $(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
>  endif
>
> +ifndef NO_BUILDID_EX
> +$(OUTPUT)buildid-ex-sha1:
> +       $(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=sha1 -o $@ -x c -
> +$(OUTPUT)buildid-ex-md5:
> +       $(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=md5 -o $@ -x c -
> +endif
> +
>  ifndef NO_JVMTI
>  LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
>
> diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
> new file mode 100755
> index 000000000000..57fcd28bc4bd
> --- /dev/null
> +++ b/tools/perf/tests/shell/buildid.sh
> @@ -0,0 +1,90 @@
> +#!/bin/sh
> +# build id cache operations
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# skip if there are no test binaries
> +if [ ! -x buildid-ex-sha1 -a ! -x buildid-ex-md5 ]; then
> +       echo "failed: no test binaries"
> +       exit 2
> +fi
> +
> +# skip if there's no readelf
> +if [ ! -x `which readelf` ]; then
> +       echo "failed: no readelf, install binutils"
> +       exit 2
> +fi
> +
> +check()
> +{
> +       id=`readelf -n $1 2>/dev/null | grep 'Build ID' | awk '{print $3}'`
> +
> +       echo "build id: ${id}"
> +
> +       link=${build_id_dir}/.build-id/${id:0:2}/${id:2}
> +       echo "link: ${link}"
> +
> +       if [ ! -h $link ]; then
> +               echo "failed: link ${link} does not exist"
> +               exit 1
> +       fi
> +
> +       file=${build_id_dir}/.build-id/${id:0:2}/`readlink ${link}`/elf
> +       echo "file: ${file}"
> +
> +       if [ ! -x $file ]; then
> +               echo "failed: file ${file} does not exist"
> +               exit 1
> +       fi
> +
> +       diff ${file} ${1}
> +       if [ $? -ne 0 ]; then
> +               echo "failed: ${file} do not match"
> +               exit 1
> +       fi
> +
> +       echo "OK for ${1}"
> +}
> +
> +test_add()
> +{
> +       build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
> +       perf="perf --buildid-dir ${build_id_dir}"
> +
> +       ${perf} buildid-cache -v -a ${1}
> +       if [ $? -ne 0 ]; then
> +               echo "failed: add ${1} to build id cache"
> +               exit 1
> +       fi
> +
> +       check ${1}
> +
> +       rm -rf ${build_id_dir}
> +}
> +
> +test_record()
> +{
> +       data=$(mktemp /tmp/perf.data.XXX)
> +       build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
> +       perf="perf --buildid-dir ${build_id_dir}"
> +
> +       ${perf} record --buildid-all -o ${data} ${1}
> +       if [ $? -ne 0 ]; then
> +               echo "failed: record ${1}"
> +               exit 1
> +       fi
> +
> +       check ${1}
> +
> +       rm -rf ${build_id_dir}
> +       rm -rf ${data}
> +}
> +
> +# add binaries manual via perf buildid-cache -a
> +test_add buildid-ex-sha1
> +test_add buildid-ex-md5
> +
> +# add binaries via perf record post processing
> +test_record buildid-ex-sha1
> +test_record buildid-ex-md5
> +
> +exit ${err}
> --
> 2.26.2
>
