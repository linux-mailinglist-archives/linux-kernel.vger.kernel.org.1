Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6458328D1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbgJMQNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731655AbgJMQNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:13:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF37425243;
        Tue, 13 Oct 2020 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602605623;
        bh=RTGij8Y6IuET2q+ILAg6hbp7K43QVaCxkIdiWh+r7WU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yj4YHpo+7n+t91PedS0EInA6/OnwFBjaXqGjEZNrO4iDgvAymG8CqDc3SaX1EzdM4
         ThHTpaf8BF8o6PLVDSNQ9ufIywT/RX+XWj8LsAXhJkzUWcQ3Vp3+5pI3iJk/cVLwmc
         oAsgkr8dS8nY9RSiHagqsF3ChY3KKbvMBtjBITgk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DBF0A4047F; Tue, 13 Oct 2020 13:13:40 -0300 (-03)
Date:   Tue, 13 Oct 2020 13:13:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/9] perf tools: Add build id shell test
Message-ID: <20201013161340.GH1063281@kernel.org>
References: <20200930171512.3986425-1-jolsa@kernel.org>
 <20200930171512.3986425-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930171512.3986425-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 30, 2020 at 07:15:04PM +0200, Jiri Olsa escreveu:
> Adding test for build id cache that adds binary
> with sha1 and md5 build ids and verifies it's
> added properly.
> 
> The test updates build id cache with perf record
> and perf buildid-cache -a.


[root@five ~]# perf test "build id"
82: build id cache operations                                       : Skip
[root@five ~]# set -o vi
[root@five ~]# perf test -v "build id"
82: build id cache operations                                       :
--- start ---
test child forked, pid 88384
failed: no test binaries
test child finished with -2
---- end ----
build id cache operations: Skip
[root@five ~]#

Also the other patches clashed with Namhyung's patch series, can you
please check?

I've just pushed what I have to acme/perf/core

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
>  	$(QUIET_CC)$(CC) -mx32 $(filter -static,$(LDFLAGS)) -Wall -Werror -o $@ perf-read-vdso.c
>  endif
>  
> +ifndef NO_BUILDID_EX
> +$(OUTPUT)buildid-ex-sha1:
> +	$(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=sha1 -o $@ -x c -
> +$(OUTPUT)buildid-ex-md5:
> +	$(QUIET_LINK)echo 'int main(void) { return 0; }' | $(CC) -Wl,--build-id=md5 -o $@ -x c -
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
> +	echo "failed: no test binaries"
> +	exit 2
> +fi
> +
> +# skip if there's no readelf
> +if [ ! -x `which readelf` ]; then
> +	echo "failed: no readelf, install binutils"
> +	exit 2
> +fi
> +
> +check()
> +{
> +	id=`readelf -n $1 2>/dev/null | grep 'Build ID' | awk '{print $3}'`
> +
> +	echo "build id: ${id}"
> +
> +	link=${build_id_dir}/.build-id/${id:0:2}/${id:2}
> +	echo "link: ${link}"
> +
> +	if [ ! -h $link ]; then
> +		echo "failed: link ${link} does not exist"
> +		exit 1
> +	fi
> +
> +	file=${build_id_dir}/.build-id/${id:0:2}/`readlink ${link}`/elf
> +	echo "file: ${file}"
> +
> +	if [ ! -x $file ]; then
> +		echo "failed: file ${file} does not exist"
> +		exit 1
> +	fi
> +
> +	diff ${file} ${1}
> +	if [ $? -ne 0 ]; then
> +		echo "failed: ${file} do not match"
> +		exit 1
> +	fi
> +
> +	echo "OK for ${1}"
> +}
> +
> +test_add()
> +{
> +	build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
> +	perf="perf --buildid-dir ${build_id_dir}"
> +
> +	${perf} buildid-cache -v -a ${1}
> +	if [ $? -ne 0 ]; then
> +		echo "failed: add ${1} to build id cache"
> +		exit 1
> +	fi
> +
> +	check ${1}
> +
> +	rm -rf ${build_id_dir}
> +}
> +
> +test_record()
> +{
> +	data=$(mktemp /tmp/perf.data.XXX)
> +	build_id_dir=$(mktemp -d /tmp/perf.debug.XXX)
> +	perf="perf --buildid-dir ${build_id_dir}"
> +
> +	${perf} record --buildid-all -o ${data} ${1}
> +	if [ $? -ne 0 ]; then
> +		echo "failed: record ${1}"
> +		exit 1
> +	fi
> +
> +	check ${1}
> +
> +	rm -rf ${build_id_dir}
> +	rm -rf ${data}
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

-- 

- Arnaldo
