Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D066A2FA5A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406433AbhARQHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:07:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406409AbhARQGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:06:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48AF822472;
        Mon, 18 Jan 2021 16:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610985942;
        bh=zRzNpYETySFvElMPmAn1EDRcJKD6ENrHFykLFQlHWBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CbghjvFGnS+lndRsHx9yfTSzUxjSkIGYfBz3gEHkJqA10T8OJFNvKNjDdfB4Z0ccw
         wSY+ojjfLiAmdAUw2x6z8DG1+8E7ICohycEfOHDUY5/SfO9txHZl8L/fDyNdn1ZmrX
         BnALXzcF5WCxrTbBHr3xODh0I89YKYRAgdhJlMtTw6CZyqwPIpBGcQxw0dMlPRXQaa
         42QCQCLq+ct9EvLIhWSd6Ir2DFzw6ykGOZkuI1d2lwwgHMUQK/Pi0SWrJaqNDUDS0G
         Yx68+Fvixbnpfl2q8w+N76YWhD9udHenjiPqxEksl5Lz5ZaJIQoqk1+pYE5cs4evqd
         4K+wfih0tvn8g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1B34640CE2; Mon, 18 Jan 2021 13:05:40 -0300 (-03)
Date:   Mon, 18 Jan 2021 13:05:40 -0300
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
Subject: Re: [PATCH 06/22] perf tools: Make perf_config_global gobal
Message-ID: <20210118160540.GF12699@kernel.org>
References: <20210102220441.794923-1-jolsa@kernel.org>
 <20210102220441.794923-7-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210102220441.794923-7-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jan 02, 2021 at 11:04:25PM +0100, Jiri Olsa escreveu:
> Making perf_config_global global, it will be used
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
> index 4e0455a6bb5f..6984c77068a3 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -526,7 +526,7 @@ int perf_config_system(void)
>  	return !perf_env_bool("PERF_CONFIG_NOSYSTEM", 0);
>  }
>  
> -static int perf_config_global(void)
> +int perf_config_global(void)
>  {
>  	return !perf_env_bool("PERF_CONFIG_NOGLOBAL", 0);
>  }
> diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
> index bf68e4acea73..2fd77aaff4d2 100644
> --- a/tools/perf/util/config.h
> +++ b/tools/perf/util/config.h
> @@ -39,6 +39,7 @@ int config_error_nonbool(const char *);
>  const char *perf_etc_perfconfig(void);
>  const char *perf_home_perfconfig(void);
>  int perf_config_system(void);
> +int perf_config_global(void);
>  
>  struct perf_config_set *perf_config_set__new(void);
>  struct perf_config_set *perf_config_set__load_file(const char *file);
> -- 
> 2.26.2
> 

-- 

- Arnaldo
