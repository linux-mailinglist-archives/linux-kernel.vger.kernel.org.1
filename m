Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A052813B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbgJBNHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:07:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36856 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJBNHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:07:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so1771123wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 06:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5HbFDBSjL7EUWkYabBUa3SFc6Lu0+HERvQNMyj+amo=;
        b=naGsx1ccG9L1ndbrIk3xYxV0VJTQnTtIOmSgdBoBmYe1VHNw1T7kb83qwUfIQTIwM1
         CwISoAijxNZZjbBUftyPutp0my8I0t2V/42N0TcKamlbqBLpeoKGj1HYAc/PJmxY6Lha
         teIpeBDPhlfhGcI+d73pVTYRU/pPckQfJPS8Yqo6Xf7le4QJaahP1x+VRZsphoO8khk4
         9pRD++TNvbG78ILk+YQspZHwEK+OHU+ouaG2b4KRz8Qvxoe2uxa1nkhFgy58RXMU7iwK
         ATNS3WnIz4GnKH+mkrTrchX6R4n0d3kkC75ect/nDEbHW7UJRsRDvWG8cyxuwrninU6e
         yz8Q==
X-Gm-Message-State: AOAM531+MR1+10MDVDY4EgoQ87NxTaG1oUBnwK+QyRp3aE6shc+gxLo4
        7J8ZDubJD09Ra6w6z+SEwk96tlPWXbECAYC2MSQ=
X-Google-Smtp-Source: ABdhPJzsp+XJI/98t/pmF9S8uAhzjel7RRSiclkywiRUqHvjQ41OCu4ZhwruXAPXHblvOYCBlBmtHizu+80nIgeP4Hg=
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr2887245wrp.332.1601644037164;
 Fri, 02 Oct 2020 06:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200930171512.3986425-1-jolsa@kernel.org> <20200930171512.3986425-2-jolsa@kernel.org>
 <20201001190530.GD3999500@krava>
In-Reply-To: <20201001190530.GD3999500@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 2 Oct 2020 22:07:06 +0900
Message-ID: <CAM9d7chyjSaqhjjT4myfs5p9ExH-3Rugme-OFaF8454yO4_s1w@mail.gmail.com>
Subject: Re: [PATCHv2 1/9] perf tools: Add build id shell test
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Fri, Oct 2, 2020 at 4:05 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> Adding test for build id cache that adds binary
> with sha1 and md5 build ids and verifies it's
> added properly.
>
> The test updates build id cache with perf record
> and perf buildid-cache -a.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
> v2 changes:
>   - detect perf build directory when checking for build-ex* binaries
>
>  tools/perf/Makefile.perf          |  14 +++++
>  tools/perf/tests/shell/buildid.sh | 101 ++++++++++++++++++++++++++++++
>  2 files changed, 115 insertions(+)
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

Can we just build them in the test shell script instead?

Thanks
Namhyung


> +
>  ifndef NO_JVMTI
>  LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
>
> diff --git a/tools/perf/tests/shell/buildid.sh b/tools/perf/tests/shell/buildid.sh
> new file mode 100755
> index 000000000000..dd9f9c306c34
> --- /dev/null
> +++ b/tools/perf/tests/shell/buildid.sh
> @@ -0,0 +1,101 @@
> +#!/bin/sh
> +# build id cache operations
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ex_md5=buildid-ex-md5
> +ex_sha1=buildid-ex-sha1
> +
> +# skip if there are no test binaries
> +if [ ! -x buildid-ex-sha1 -a ! -x buildid-ex-md5 ]; then
> +       ex_dir=$(dirname `which perf`)
> +       ex_md5=${ex_dir}/buildid-ex-md5
> +       ex_sha1=${ex_dir}/buildid-ex-sha1
> +
> +       if [ ! -x ${ex_sha1} -a ! -x ${ex_md5} ]; then
> +               echo "failed: no test binaries"
> +               exit 2
> +       fi
> +fi
> +
> +echo "test binaries: ${ex_sha1} ${ex_md5}"
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
> +test_add ${ex_sha1}
> +test_add ${ex_md5}
> +
> +# add binaries via perf record post processing
> +test_record ${ex_sha1}
> +test_record ${ex_md5}
> +
> +exit ${err}
> --
> 2.26.2
>
