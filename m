Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96A026901B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgINPg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:36:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgINPf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:35:57 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BA8920756;
        Mon, 14 Sep 2020 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600097756;
        bh=2+4B6RAbGc9i3Tx8xEDAYkXUWx9WFTF4EhEwdS56i54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cax/+F3yWyBZu1V9axjiaAPjMy/tZmrtZootMqNpiGEpzWJeVkOXoQbSFuuoZZA03
         P6uHN/M8czybC0ao5Aa0w6L3xDergHaSmpNRGa128Fvz73vVTRlkc98Fb4HfptiAMW
         lJOFXmBYFWVU6sGhc8GmSu7FuvxZMsyFKIJzIQ7w=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A9DF040D3D; Mon, 14 Sep 2020 12:35:54 -0300 (-03)
Date:   Mon, 14 Sep 2020 12:35:54 -0300
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
Subject: Re: [PATCH 04/26] perf tools: Add filename__decompress function
Message-ID: <20200914153554.GF160517@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-5-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913210313.1985612-5-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Sep 13, 2020 at 11:02:51PM +0200, Jiri Olsa escreveu:
> Factor filename__decompress from decompress_kmodule function.
> It can decompress files with compressions supported in perf -
> xz and gz, the support needs to be compiled in.
> 
> It will to be used in following changes to get build id out of
> compressed elf objects.

This is prep work, can be applied now, done.

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/dso.c | 31 +++++++++++++++++++------------
>  tools/perf/util/dso.h |  2 ++
>  2 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 5a3b4755f0b3..0faa96ca7a04 100644
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
> index 8ad17f395a19..f1efd2e11547 100644
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
