Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27072C5AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404435AbgKZRoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:44:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403951AbgKZRoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:44:21 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE163207BC;
        Thu, 26 Nov 2020 17:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606412661;
        bh=yay4r5Dlw7NPaG6pSjpBUo5Y6nle77nuPt4XIUjjDP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X7S1oTcsXeqBMWGQyqKDvstzHeKUclPlhfwXZfcx+t4FMdxTPF8DVcYmlOj0xq822
         ltxRa6idjcStcA6X+PWtlqpsLewhmkmhgqh9SQK13ryuETDVYNyxCPBH40F6afOHhm
         QifgnhrcJ/oMiv5dC8VYXUYTp1cGRvXOFl66Bn24=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 10E8C40E29; Thu, 26 Nov 2020 14:44:18 -0300 (-03)
Date:   Thu, 26 Nov 2020 14:44:18 -0300
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
Subject: Re: [PATCH 08/25] perf tools: Add filename__decompress function
Message-ID: <20201126174418.GJ53384@kernel.org>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-9-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126170026.2619053-9-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 26, 2020 at 06:00:09PM +0100, Jiri Olsa escreveu:
> Factor filename__decompress from decompress_kmodule function.
> It can decompress files with compressions supported in perf -
> xz and gz, the support needs to be compiled in.
> 
> It will to be used in following changes to get build id out of
> compressed elf objects.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/dso.c | 31 +++++++++++++++++++------------
>  tools/perf/util/dso.h |  2 ++
>  2 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 89b5fd2b5de3..d786cf6b0cfa 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -279,18 +279,12 @@ bool dso__needs_decompress(struct dso *dso)
>  		dso->symtab_type == DSO_BINARY_TYPE__GUEST_KMODULE_COMP;
>  }
>  
> -static int decompress_kmodule(struct dso *dso, const char *name,
> -			      char *pathname, size_t len)
> +int filename__decompress(const char *name, char *pathname,
> +			 size_t len, int comp, int *err)
>  {
>  	char tmpbuf[] = KMOD_DECOMP_NAME;
>  	int fd = -1;
>  
> -	if (!dso__needs_decompress(dso))
> -		return -1;
> -
> -	if (dso->comp == COMP_ID__NONE)
> -		return -1;
> -
>  	/*
>  	 * We have proper compression id for DSO and yet the file
>  	 * behind the 'name' can still be plain uncompressed object.
> @@ -304,17 +298,17 @@ static int decompress_kmodule(struct dso *dso, const char *name,
>  	 * To keep this transparent, we detect this and return the file
>  	 * descriptor to the uncompressed file.
>  	 */
> -	if (!compressions[dso->comp].is_compressed(name))
> +	if (!compressions[comp].is_compressed(name))
>  		return open(name, O_RDONLY);
>  
>  	fd = mkstemp(tmpbuf);
>  	if (fd < 0) {
> -		dso->load_errno = errno;
> +		*err = errno;
>  		return -1;
>  	}
>  
> -	if (compressions[dso->comp].decompress(name, fd)) {
> -		dso->load_errno = DSO_LOAD_ERRNO__DECOMPRESSION_FAILURE;
> +	if (compressions[comp].decompress(name, fd)) {
> +		*err = DSO_LOAD_ERRNO__DECOMPRESSION_FAILURE;
>  		close(fd);
>  		fd = -1;
>  	}
> @@ -328,6 +322,19 @@ static int decompress_kmodule(struct dso *dso, const char *name,
>  	return fd;
>  }
>  
> +static int decompress_kmodule(struct dso *dso, const char *name,
> +			      char *pathname, size_t len)
> +{
> +	if (!dso__needs_decompress(dso))
> +		return -1;
> +
> +	if (dso->comp == COMP_ID__NONE)
> +		return -1;
> +
> +	return filename__decompress(name, pathname, len, dso->comp,
> +				    &dso->load_errno);
> +}
> +
>  int dso__decompress_kmodule_fd(struct dso *dso, const char *name)
>  {
>  	return decompress_kmodule(dso, name, NULL, 0);
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index d8cb4f5680a4..cd2fe64a3c5d 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -274,6 +274,8 @@ bool dso__needs_decompress(struct dso *dso);
>  int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
>  int dso__decompress_kmodule_path(struct dso *dso, const char *name,
>  				 char *pathname, size_t len);
> +int filename__decompress(const char *name, char *pathname,
> +			 size_t len, int comp, int *err);
>  
>  #define KMOD_DECOMP_NAME  "/tmp/perf-kmod-XXXXXX"
>  #define KMOD_DECOMP_LEN   sizeof(KMOD_DECOMP_NAME)
> -- 
> 2.26.2
> 

-- 

- Arnaldo
