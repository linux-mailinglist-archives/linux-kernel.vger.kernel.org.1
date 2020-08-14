Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7602449E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgHNMmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 08:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgHNMmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:42:45 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07B4A20866;
        Fri, 14 Aug 2020 12:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597408965;
        bh=v6BupMXhSJGsud9dXh3OevLWR5gn2Z7rdfjyxsqbWg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mRrqSCDYom6Bm8EVKW1i3eFVe8yxd1slDYKclxYXhVJ+V1iW9FWqtdN9/oMfFYD2X
         ve31bFp+wv4GwRafi2NBpVjbjdXYITmrIRpiRduYpeuUYRmvl8lNe1wSwdiQgnE+g8
         OLOGPxPXLM/Yir2pBm97QPChB07NJrPVppDifL4g=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C9B3F40D3D; Fri, 14 Aug 2020 09:42:42 -0300 (-03)
Date:   Fri, 14 Aug 2020 09:42:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peng Fan <fanpeng@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bench numa: Remove dead code in parse_nodes_opt()
Message-ID: <20200814124242.GE13995@kernel.org>
References: <1597401894-27549-1-git-send-email-fanpeng@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597401894-27549-1-git-send-email-fanpeng@loongson.cn>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 14, 2020 at 06:44:54PM +0800, Peng Fan escreveu:
> In the function parse_nodes_opt(), the statement "return 0;" is dead 
> code, remove it.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Peng Fan <fanpeng@loongson.cn>
> ---
>  tools/perf/bench/numa.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 5797253..70c8c2c 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -729,8 +729,6 @@ static int parse_nodes_opt(const struct option *opt __maybe_unused,
>  		return -1;
>  
>  	return parse_node_list(arg);
> -
> -	return 0;
>  }
>  
>  #define BIT(x) (1ul << x)
> -- 
> 2.1.0
> 

-- 

- Arnaldo
