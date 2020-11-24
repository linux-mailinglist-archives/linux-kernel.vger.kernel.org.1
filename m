Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E9A2C22CD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgKXKWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732036AbgKXKWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:22:00 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E10FC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:22:00 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so21696170wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oIEXcZA2TOdMgRmsLXiqN7phffnIRHVjxdhFOEAsWBc=;
        b=IRJN0B6LtIMdrg5M6Z0vG73O7E9NJiljb9TeTYlp/kYRkLteGx/g2y67ROmZJDM1TJ
         9GiYnG1VJ4fCzlSKaU34SzEFQCAqStfXEaLL6tuXxzBBkEdBxxg1fzKlpH1ySqyW+M5A
         4JbUlMUSs59TDiT6sviFfM1OBzIQ0PBLEgjgC85/rWmBS7RAvc2NkqcBhtN3FSsn9Nhv
         mvgbJyipOzVxqBsH1Qu2FkbpalvHDL5Q2fCxm/Own2sqA1/XgWEuVo5IjeFXNuRGQobz
         66W4f/UMMZV0ic0eeGWM1KMoOUzuOVU1fBAvv7M2Hbi5PxX7NHGlEgeUl8F1i5/NXmor
         A2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oIEXcZA2TOdMgRmsLXiqN7phffnIRHVjxdhFOEAsWBc=;
        b=HFCJebvmrKkTKl/6cguLNFEc6hh5gIEQithFSeOKbn3cbpOxMAWTQlr18jezx5TH8u
         Sxgi8QRC1N3JlfbSesmSkJTpprm6uPj2qv2Gp8fqjyscv/p52dKnRbmjWPsvP4t9TJ+D
         ehiArmCrM3VnBXwBTwLANj/Auv0h7rORPBOF5M+5aS4cIqdbxh6no8QJjLV8Do+QVLQ8
         KZx7ON4XhI8wTQ0PatTJtlabvv1bQ+AGoE2cmmmqLoqzsrx9StE9JpNBHLprjxDdeYik
         s6o1UFjSw+1P/lQGVMRslrlHRv85TZU/EgTdzPjQWfFGNMs8mybgwGO0K5AYtjFWsY9G
         i4hA==
X-Gm-Message-State: AOAM533gU8wMGU3R+hE/zq8Oxz3yTvU9gj2trwFIFk60f/ZqvvZzjkKq
        NovPyQ/Q0sTp2WOae6hq+QMSKPzPCqvbkDMH
X-Google-Smtp-Source: ABdhPJy6sVozIL/E52ff1PeoIF6OkR4zZV6SvlbBeqn3AqvFUJC6jys6qnzMgwMdmOn34fFKDY0+fg==
X-Received: by 2002:a5d:60d1:: with SMTP id x17mr4595069wrt.338.1606213318955;
        Tue, 24 Nov 2020 02:21:58 -0800 (PST)
Received: from ntb.petris.klfree.czf (snat2.klfree.cz. [81.201.48.25])
        by smtp.gmail.com with ESMTPSA id o13sm4197817wmc.44.2020.11.24.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:21:58 -0800 (PST)
Date:   Tue, 24 Nov 2020 11:21:51 +0100
From:   Petr Malat <oss@malat.biz>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH 3/3] perf session: Avoid infinite loop if an event is
 truncated
Message-ID: <20201124102151.GA14932@ntb.petris.klfree.czf>
References: <20201124095923.3683-1-oss@malat.biz>
 <20201124095923.3683-3-oss@malat.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124095923.3683-3-oss@malat.biz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I made a rebase mistake and picked old change, I will send the series
again rebased on v5.10-rc5. Sorry for the inconvenience.
  Petr

On Tue, Nov 24, 2020 at 10:59:21AM +0100, Petr Malat wrote:
> If an event was truncated at the end of a perf.data file larger than
> MAP_SIZE, the event reading code ended up in an infinite loop. Break
> this loop by making sure the mapping window is always shifting
> towards the end of the file.
> 
> Fixes: bb1835a3b86c ("perf session: Fix decompression of PERF_RECORD_COMPRESSED records")
> Fixes: 57fc032ad643 ("perf session: Avoid infinite loop when seeing invalid header.size")
> Signed-off-by: Petr Malat <oss@malat.biz>
> ---
>  tools/perf/util/session.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index e57b0d09d196..b73b85d99628 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2168,6 +2168,12 @@ reader__process_events(struct reader *rd, struct perf_session *session,
>  		}
>  
>  		page_offset = page_size * (head / page_size);
> +		if (!page_offset) {
> +			pr_err("%#" PRIx64 " [%#x]: truncated event\n",
> +					file_offset + head);
> +			err = -EINVAL;
> +			goto out;
> +		}
>  		file_offset += page_offset;
>  		head -= page_offset;
>  		goto remap;
> -- 
> 2.20.1
> 
