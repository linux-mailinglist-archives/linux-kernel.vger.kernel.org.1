Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140D02B5F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgKQMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbgKQMd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:33:27 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 745602222A;
        Tue, 17 Nov 2020 12:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605616406;
        bh=a9U740DOhAgvSETdSFX2dByGdJRi8rwwrKDsyYyqZwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bp/qErDw6v3Ql3SwuLn6uKPPCDwYEW5m+AigWZjVwAMkNnroDicwr9fq8enu7Ow9f
         2HejWUXrsDwHfNDBQMuAhxAG5ZktEGN7qM0mNI0XqEF3g0mWPeDYYIURdUKqEx6C1h
         DIlgo/J0glX610rHISxokRrfswWd2sIG0YkU6uEQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5474440E29; Tue, 17 Nov 2020 09:33:24 -0300 (-03)
Date:   Tue, 17 Nov 2020 09:33:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 08/24] perf tools: Add support to read build id from
 compressed elf
Message-ID: <20201117123324.GL614220@kernel.org>
References: <20201117110053.1303113-1-jolsa@kernel.org>
 <20201117110053.1303113-9-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117110053.1303113-9-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 17, 2020 at 12:00:37PM +0100, Jiri Olsa escreveu:
> Adding support to decompress file before reading build id.
> 
> Adding filename__read_build_id and change its current
> versions to read_build_id.
> 
> Shutting down stderr output of perf list in the shell test:
>   82: Check open filename arg using perf trace + vfs_getname          : Ok
> 
> because with decompression code in the place we the
> filename__read_build_id function is more verbose in case
> of error and the test did not account for that.

---
because with decompression code in place filename__read_build_id() is
more verbose in case of an error and the test didn't account for that.
---

I'll  fix it up when applying :-)

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../tests/shell/trace+probe_vfs_getname.sh    |  2 +-
>  tools/perf/util/symbol-elf.c                  | 37 ++++++++++++++++++-
>  2 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> index 11cc2af13f2b..3660fcc02fef 100755
> --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> @@ -20,7 +20,7 @@ skip_if_no_perf_trace || exit 2
>  file=$(mktemp /tmp/temporary_file.XXXXX)
>  
>  trace_open_vfs_getname() {
> -	evts=$(echo $(perf list syscalls:sys_enter_open* 2>&1 | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
> +	evts=$(echo $(perf list syscalls:sys_enter_open* >&1 2>/dev/nul | egrep 'open(at)? ' | sed -r 's/.*sys_enter_([a-z]+) +\[.*$/\1/') | sed 's/ /,/')
>  	perf trace -e $evts touch $file 2>&1 | \
>  	egrep " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch\/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +${file}, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
>  }
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 44dd86a4f25f..f3577f7d72fe 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -534,7 +534,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
>  
>  #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
>  
> -int filename__read_build_id(const char *filename, struct build_id *bid)
> +static int read_build_id(const char *filename, struct build_id *bid)
>  {
>  	size_t size = sizeof(bid->data);
>  	int err = -1;
> @@ -563,7 +563,7 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
>  
>  #else // HAVE_LIBBFD_BUILDID_SUPPORT
>  
> -int filename__read_build_id(const char *filename, struct build_id *bid)
> +static int read_build_id(const char *filename, struct build_id *bid)
>  {
>  	size_t size = sizeof(bid->data);
>  	int fd, err = -1;
> @@ -595,6 +595,39 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
>  
>  #endif // HAVE_LIBBFD_BUILDID_SUPPORT
>  
> +int filename__read_build_id(const char *filename, struct build_id *bid)
> +{
> +	struct kmod_path m = { .name = NULL, };
> +	char path[PATH_MAX];
> +	int err;
> +
> +	if (!filename)
> +		return -EFAULT;
> +
> +	err = kmod_path__parse(&m, filename);
> +	if (err)
> +		return -1;
> +
> +	if (m.comp) {
> +		int error = 0, fd;
> +
> +		fd = filename__decompress(filename, path, sizeof(path), m.comp, &error);
> +		if (fd < 0) {
> +			pr_debug("Failed to decompress (error %d) %s\n",
> +				 error, filename);
> +			return -1;
> +		}
> +		close(fd);
> +		filename = path;
> +	}
> +
> +	err = read_build_id(filename, bid);
> +
> +	if (m.comp)
> +		unlink(filename);
> +	return err;
> +}
> +
>  int sysfs__read_build_id(const char *filename, struct build_id *bid)
>  {
>  	size_t size = sizeof(bid->data);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
