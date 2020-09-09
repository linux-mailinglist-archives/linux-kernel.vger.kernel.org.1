Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C12D262FFA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbgIIOsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 10:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730179AbgIIMfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:35:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBCDF21D82;
        Wed,  9 Sep 2020 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599654478;
        bh=I/BuSjwh37WfU0KbhjgeLgeoZag8kYlwsv0uru7BOck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHXD+AqK7CQ2nI30zlH5jAj4Y25gkwqhowHovWDzHgLRWec7KI/CclOURxZBbua80
         tXmoj7W3W7CFlWNNJrDeFzlZOX1vNPtmzHxExA+/oy098NDSIAg49AJgKPDJ7IEYq5
         TzhLJy0eW7LQ8w0KwyA1ul8PcMWuFLcDsocZXRmo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7820840D3D; Wed,  9 Sep 2020 09:27:55 -0300 (-03)
Date:   Wed, 9 Sep 2020 09:27:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/3] perf list: Remove dead code in argument check
Message-ID: <20200909122755.GA3788224@kernel.org>
References: <20200909055849.469612-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909055849.469612-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 09, 2020 at 02:58:47PM +0900, Namhyung Kim escreveu:
> The sep is already checked being not NULL.  The code seems to be a
> leftover from some refactoring.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

There is a missing --- separator from the description to the patch, I
had to add it so that 'git am' works on it, please check.

- Arnaldo

I.e. it should be right here:

---

> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 0a7fe4cb5555..10ab5e40a34f 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -92,13 +92,6 @@ int cmd_list(int argc, const char **argv)
>  		else if ((sep = strchr(argv[i], ':')) != NULL) {
>  			int sep_idx;
>  
> -			if (sep == NULL) {
> -				print_events(argv[i], raw_dump, !desc_flag,
> -							long_desc_flag,
> -							details_flag,
> -							deprecated);
> -				continue;
> -			}
>  			sep_idx = sep - argv[i];
>  			s = strdup(argv[i]);
>  			if (s == NULL)
> -- 
> 2.28.0.526.ge36021eeef-goog
> 

-- 

- Arnaldo
