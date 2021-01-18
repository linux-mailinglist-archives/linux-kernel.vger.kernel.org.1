Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03A22FA537
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406038AbhARPxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:53:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:32822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406021AbhARPwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:52:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD83F22AAA;
        Mon, 18 Jan 2021 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610985116;
        bh=AB8E4rNT4/olxwU47FHDvrZY5FoQsL+/jFIyw1bY5kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCbPJZ9PMqQ+OkD6vMBRT9gJxBC+/ttZdYP0DsVRDVfLWr9fS7NnblCAlMiYwblFM
         7713QXen8hz42WcGwsLQ4tSicRXRc4injmdMh+ZFvv1ESPza6aX7Inxv45rHsOR0la
         f/EAIbaRS6eSnrRSrlg+Evfq6BKzQzcKzkmX4yyPqYxFc+/EeBzrYeOkZGG+pC7WHB
         qDSv73qPL5arEj6cELeCtskGDqLpYjZUThQX9qbDugmKEIoiW3Ed3y7EgFqmTHVmmL
         N3sAufA7wIF/YevT3X295KBj7sURCYBLvOH5fzL9qaSBmYaMS4h2EydvN709mapVkx
         sUjwk0AzGvNqQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ACEC140CE2; Mon, 18 Jan 2021 12:51:53 -0300 (-03)
Date:   Mon, 18 Jan 2021 12:51:53 -0300
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
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 01/22] perf tools: Make perf_config_from_file static
Message-ID: <20210118155153.GA12699@kernel.org>
References: <20210102220441.794923-1-jolsa@kernel.org>
 <20210102220441.794923-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210102220441.794923-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jan 02, 2021 at 11:04:20PM +0100, Jiri Olsa escreveu:
> It's not used outside config.c object.

Thanks, applied.
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/config.c | 2 +-
>  tools/perf/util/config.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 6969f82843ee..20be0504fb95 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -489,7 +489,7 @@ int perf_default_config(const char *var, const char *value,
>  	return 0;
>  }
>  
> -int perf_config_from_file(config_fn_t fn, const char *filename, void *data)
> +static int perf_config_from_file(config_fn_t fn, const char *filename, void *data)
>  {
>  	int ret;
>  	FILE *f = fopen(filename, "r");
> diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
> index 8c881e3a3ec3..2f753b2a034b 100644
> --- a/tools/perf/util/config.h
> +++ b/tools/perf/util/config.h
> @@ -27,7 +27,6 @@ extern const char *config_exclusive_filename;
>  
>  typedef int (*config_fn_t)(const char *, const char *, void *);
>  
> -int perf_config_from_file(config_fn_t fn, const char *filename, void *data);
>  int perf_default_config(const char *, const char *, void *);
>  int perf_config(config_fn_t fn, void *);
>  int perf_config_int(int *dest, const char *, const char *);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
