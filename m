Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46552FA5B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391586AbhARQLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:11:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405923AbhARQEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:04:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1790522C9C;
        Mon, 18 Jan 2021 16:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610985840;
        bh=J6NpMp0NPKuO97iBfNt9hYs8ZZSyHPbQhori3CpJO4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBHdKdaIoNV7Iis1gwh0Ltj6k+n2XAB2brhKxbew0ep90IQtOdynxvYLaY/lzLRHp
         Sw63r6l7xJiUtDcoWcjKepe1Vhu2f65WKIm40QE8LhLvnsZDbre2snS5CX0bswkuWr
         EJKTBfUYYqVV3ByKEDl6g4JLwhgRvxWrLkvQ9o94yn7GBS5vnjeJ1DY4Zg6pwAbe8q
         wm1Fmo02FrUcqhbzFi/7THNIHimUuLEzaI5EkRj2yQj+zhsFpz2eyTHNmFyIW+tWIR
         Yk9/E94W/jwYD+Fnadl7aQ/NpOxJy+fzch4PUtYFbi9HFHtEHiga/86hgP65/vz9ho
         Owx9Tqs+BU5UA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1F53440CE2; Mon, 18 Jan 2021 13:03:58 -0300 (-03)
Date:   Mon, 18 Jan 2021 13:03:58 -0300
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
Subject: Re: [PATCH 05/22] perf tools: Make perf_config_system global
Message-ID: <20210118160358.GD12699@kernel.org>
References: <20210102220441.794923-1-jolsa@kernel.org>
 <20210102220441.794923-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210102220441.794923-6-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jan 02, 2021 at 11:04:24PM +0100, Jiri Olsa escreveu:
> Making perf_config_system global, it will be used
> outside the config.c object in following patches.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/config.c | 2 +-
>  tools/perf/util/config.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index 34fe80ccdad1..4e0455a6bb5f 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -521,7 +521,7 @@ static int perf_env_bool(const char *k, int def)
>  	return v ? perf_config_bool(k, v) : def;
>  }
>  
> -static int perf_config_system(void)
> +int perf_config_system(void)
>  {
>  	return !perf_env_bool("PERF_CONFIG_NOSYSTEM", 0);
>  }
> diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
> index d6c4f80f367c..bf68e4acea73 100644
> --- a/tools/perf/util/config.h
> +++ b/tools/perf/util/config.h
> @@ -38,6 +38,7 @@ int perf_config_bool(const char *, const char *);
>  int config_error_nonbool(const char *);
>  const char *perf_etc_perfconfig(void);
>  const char *perf_home_perfconfig(void);
> +int perf_config_system(void);
>  
>  struct perf_config_set *perf_config_set__new(void);
>  struct perf_config_set *perf_config_set__load_file(const char *file);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
