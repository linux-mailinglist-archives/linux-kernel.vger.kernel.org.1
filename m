Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE532FBFFE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbhAST22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392147AbhAST0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:26:52 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898FFC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:26:12 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w14so3852046pfi.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=hfjS8PpIK8Sw4H2BcFdwSk9imrJFBiUObKqAE346rrk=;
        b=jyZa03UY8jzWno2ByRrYjgjIuxfrx8l6GP0hi8fyQo1ibeyOebB//A/mTKgQk8fLOk
         kV3jtIUFrA5uLcVGBtVIXP/+sM51GSwpXGMHSIXIQLkJ9xojm+qZNkDcYruKKsrO/8Fi
         1ZXeflrRW7G3tUdtxoKWm0qaXcR0gPonGzp2DvuY/XlYsRflR2P19m1xaEwXAtWe6LJw
         uAkCj5qCL7hdEl2V4MwSj1idaEwSL2s8fViYo18/Lqk7Z612cms7cyZhI8k7bLYoEzQz
         VB3ResK/cl0l4jjet8E6r1hopiVM9BlmBuMjAABJJZBcwcaFJX4TzDvK4ddji7zbZwnL
         tHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=hfjS8PpIK8Sw4H2BcFdwSk9imrJFBiUObKqAE346rrk=;
        b=DdhX6n732jnTvkESvF43LzI1+reUkula7kwHlA3l7TnOeYPPwYbHmxd+k5IMdU7J1K
         rFn00JPcUsCzUiR3sO/3xvWaSuHEHbnEIuXAFFh/x7uMsPymPhAcfv3H1IVXSiTrCubs
         n/crSxIBtGFhOz0Oo9wub6Tc/DG4Mj8hAusvszC61uLm8Be6s3YpEjBbhgZTnlI7lykJ
         mByQntfihp5x9nlE5GNylY722PDMBg82at2+akoerhZ1CrT+zIqmzepLQ2TvOcT4+1Eq
         FbmYuxAF4AlsXn4j3ZN6KSirUHxXVlbPvcN+PrgEDqzn81XzYq1Y2XXXsqdVUaB7kCHW
         +Vwg==
X-Gm-Message-State: AOAM532YBVQp/v0XxU7eZRNR3ObSPvZnG288GrqxfinllNZVVol9VHsB
        POY8sMrRuTulmmKaCHXakqvOmQ==
X-Google-Smtp-Source: ABdhPJzQwpiDV5HQytZYjQWGdyI9tq13ne04cT1sfU9a98D/zozIZ7EUoNl+9+wMtJrdPfxxmr1q6Q==
X-Received: by 2002:a63:1b1e:: with SMTP id b30mr5791504pgb.421.1611084370066;
        Tue, 19 Jan 2021 11:26:10 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id a9sm19569815pfn.178.2021.01.19.11.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:26:09 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:26:08 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Charan Teja Reddy <charante@codeaurora.org>
cc:     akpm@linux-foundation.org, vbabka@suse.cz, mhocko@suse.com,
        khalid.aziz@oracle.com, ngupta@nitingupta.dev,
        vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] mm/compaction: correct deferral logic for proactive
 compaction
In-Reply-To: <1610989938-31374-1-git-send-email-charante@codeaurora.org>
Message-ID: <af22a056-5c27-256f-74d-63de8fd33084@google.com>
References: <1610989938-31374-1-git-send-email-charante@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021, Charan Teja Reddy wrote:

> should_proactive_compact_node() returns true when sum of the
> weighted fragmentation score of all the zones in the node is greater
> than the wmark_high of compaction, which then triggers the proactive
> compaction that operates on the individual zones of the node. But
> proactive compaction runs on the zone only when its weighted
> fragmentation score is greater than wmark_low(=wmark_high - 10).
> 
> This means that the sum of the weighted fragmentation scores of all the
> zones can exceed the wmark_high but individual weighted fragmentation
> zone scores can still be less than wmark_low which makes the unnecessary
> trigger of the proactive compaction only to return doing nothing.
> 
> Issue with the return of proactive compaction with out even trying is
> its deferral. It is simply deferred for 1 << COMPACT_MAX_DEFER_SHIFT if
> the scores across the proactive compaction is same, thinking that
> compaction didn't make any progress but in reality it didn't even try.

Isn't this an issue in deferred compaction as well?  It seems like 
deferred compaction should check that work was actually performed before 
deferring subsequent calls to compaction.

In other words, I don't believe deferred compaction is intended to avoid 
checks to determine if compaction is worth it; it should only defer 
*additional* work that was not productive.

Thoughts?

> With the delay between successive retries for proactive compaction is
> 500msec, it can result into the deferral for ~30sec with out even trying
> the proactive compaction.
> 
> Test scenario is that: compaction_proactiveness=50 thus the wmark_low =
> 50 and wmark_high = 60. System have 2 zones(Normal and Movable) with
> sizes 5GB and 6GB respectively. After opening some apps on the android,
> the weighted fragmentation scores of these zones are 47 and 49
> respectively. Since the sum of these fragmentation scores are above the
> wmark_high which triggers the proactive compaction and there since the
> individual zones weighted fragmentation scores are below wmark_low, it
> returns without trying the proactive compaction. As a result the
> weighted fragmentation scores of the zones are still 47 and 49 which
> makes the existing logic to defer the compaction thinking that
> noprogress is made across the compaction.
> 
> Fix this by checking just zone fragmentation score, not the weighted, in
> __compact_finished() and use the zones weighted fragmentation score in
> fragmentation_score_node(). In the test case above, If the weighted
> average of is above wmark_high, then individual score (not adjusted) of
> atleast one zone has to be above wmark_high. Thus it avoids the
> unnecessary trigger and deferrals of the proactive compaction.
> 
> Fix-suggested-by: Vlastimil Babka <vbabka@suse.cz>

Suggested-by

> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

Acked-by: David Rientjes <rientjes@google.com>
