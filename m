Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920E7269146
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgINQSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgINQEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:04:36 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFB6721741;
        Mon, 14 Sep 2020 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600099476;
        bh=gxJ861/HDIwIg1r044UrU7ZGXLCp0CaXHOZrM61fJdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vP96kvC0WLPjxogbq0anLCv1wJI8GCBWpP5ei4RAR0nOaesG2n/MbHRTELOBnSgin
         aZ52uPMEH5+wQ8+eaIV5NZCRcEcHFzpHuYbdHb/vWHyexJuSGSuDHNf/bcrcnjnfuY
         3zXuWPmwnc9JM0EOatRGKTCmi7dOfDqxNzRvpHsA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1621C40D3D; Mon, 14 Sep 2020 13:04:34 -0300 (-03)
Date:   Mon, 14 Sep 2020 13:04:34 -0300
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
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 06/26] perf tools: Add support to read build id from
 compressed elf
Message-ID: <20200914160434.GH160517@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913210313.1985612-7-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 13, 2020 at 11:02:53PM +0200, Jiri Olsa escreveu:
> Adding support to decompress file before reading build id.
> 
> Adding filename__read_build_id and change its current
> versions to read_build_id.

Also a standalone, generally useful, prep patch, applyed.

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/symbol-elf.c | 37 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 94a156df22d5..6770572620f3 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -534,7 +534,7 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
>  
>  #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
>  
> -int filename__read_build_id(const char *filename, void *bf, size_t size)
> +static int read_build_id(const char *filename, void *bf, size_t size)
>  {
>  	int err = -1;
>  	bfd *abfd;
> @@ -562,7 +562,7 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
>  
>  #else // HAVE_LIBBFD_BUILDID_SUPPORT
>  
> -int filename__read_build_id(const char *filename, void *bf, size_t size)
> +static int read_build_id(const char *filename, void *bf, size_t size)
>  {
>  	int fd, err = -1;
>  	Elf *elf;
> @@ -591,6 +591,39 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
>  
>  #endif // HAVE_LIBBFD_BUILDID_SUPPORT
>  
> +int filename__read_build_id(const char *filename, void *bf, size_t size)
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
> +	err = read_build_id(filename, bf, size);
> +
> +	if (m.comp)
> +		unlink(filename);
> +	return err;
> +}
> +
>  int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
>  {
>  	int fd, err = -1;
> -- 
> 2.26.2
> 

-- 

- Arnaldo
