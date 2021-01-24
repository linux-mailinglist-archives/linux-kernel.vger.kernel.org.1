Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0AA5301F71
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 23:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbhAXWzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 17:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbhAXWza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 17:55:30 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2814CC061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 14:54:50 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x18so6460877pln.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 14:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=2M4GL8HSPHB4CnNzd+6jrJbF6ak+SGdq4mvPyBQeBag=;
        b=kqFVBKhqD95318pJbQOIvxd5hAbt2uqIPrp1brXnxNxQ36zAXpQ5H/oiH7qgB8jGrs
         /Wb8zT5XkZ+Hte6MoWxMz1N7wAzDjS+lAcfH32hNC/SrLgXUjo5BZA10ULzWT5obIlRH
         lWfIB+JSZAasYIrCG8TUcN8ksaDOMalcGvwtB+aPTO/Y3AP7g1W5JDwRcqVN0w2Z+Cud
         HO3slEj8yrqqoRlqQ58ng2RM8E2bV37r3wj9mTvIlLvIfpwiF/E9kZtWi11whY4RVYyj
         Za80tnv00CqTwTa3XNSHu0LY0AKTfMIWhjOc52d6WPds3///LKPO3Ncg9mUusmLaufbu
         Eu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2M4GL8HSPHB4CnNzd+6jrJbF6ak+SGdq4mvPyBQeBag=;
        b=kSSbkx59JNcwg48MfiIG8syjjeIYaQAd/lA3/Q/ZdTXYaH3b2uZFhefBdp7fEf6NDT
         1Thecnj0fCy+sXxGLusd0QhYgd3HU2CcO9YMogX5PChdnPAe4rbUqyz7R98etPTRKgrZ
         3FqrGT9Z7BbNrQ4V0Y7MAlj9Nd+dxz4jhXMF0Ri7kA8fhOIFeYvsFCnPz+hA+zFRvBeI
         h4A8G5eJdJr1uQans/Y6PDyvHls+PMBzjTOvCjsdVQyCtPAPl1d9lN4fpHWa1zvcB9LK
         ULTa8sczNNmP75V84n64rT0djGhyOxxI1IiNKjxaICut8IgEDk7VHen9b24ry4POv6cv
         poiA==
X-Gm-Message-State: AOAM530JTMzUqWGli6UWeFRgPFI3wynNL9yd/toEVZQWR+el5W0qcPCY
        nxWQdT5B68rahwfNGONhXv57yQ==
X-Google-Smtp-Source: ABdhPJxFkKarmvQr7zce29NhIu0fFt7Pbg2oEVXhpM8d3urzv2f1NT6QsyGJCc4q7ItdIFsEivMOaw==
X-Received: by 2002:a17:90a:5914:: with SMTP id k20mr18538440pji.199.1611528889521;
        Sun, 24 Jan 2021 14:54:49 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id c5sm14845346pgt.73.2021.01.24.14.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 14:54:48 -0800 (PST)
Date:   Sun, 24 Jan 2021 14:54:47 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Charan Teja Reddy <charante@codeaurora.org>,
        akpm@linux-foundation.org, mhocko@suse.com, khalid.aziz@oracle.com,
        ngupta@nitingupta.dev, vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] mm/compaction: correct deferral logic for proactive
 compaction
In-Reply-To: <80a1a433-c520-4c73-61ce-55cf33739fc5@suse.cz>
Message-ID: <627a82ec-94ef-a233-4637-28bc82a886e9@google.com>
References: <1610989938-31374-1-git-send-email-charante@codeaurora.org> <af22a056-5c27-256f-74d-63de8fd33084@google.com> <80a1a433-c520-4c73-61ce-55cf33739fc5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021, Vlastimil Babka wrote:

> On 1/19/21 8:26 PM, David Rientjes wrote:
> > On Mon, 18 Jan 2021, Charan Teja Reddy wrote:
> > 
> >> should_proactive_compact_node() returns true when sum of the
> >> weighted fragmentation score of all the zones in the node is greater
> >> than the wmark_high of compaction, which then triggers the proactive
> >> compaction that operates on the individual zones of the node. But
> >> proactive compaction runs on the zone only when its weighted
> >> fragmentation score is greater than wmark_low(=wmark_high - 10).
> >> 
> >> This means that the sum of the weighted fragmentation scores of all the
> >> zones can exceed the wmark_high but individual weighted fragmentation
> >> zone scores can still be less than wmark_low which makes the unnecessary
> >> trigger of the proactive compaction only to return doing nothing.
> >> 
> >> Issue with the return of proactive compaction with out even trying is
> >> its deferral. It is simply deferred for 1 << COMPACT_MAX_DEFER_SHIFT if
> >> the scores across the proactive compaction is same, thinking that
> >> compaction didn't make any progress but in reality it didn't even try.
> > 
> > Isn't this an issue in deferred compaction as well?  It seems like 
> > deferred compaction should check that work was actually performed before 
> > deferring subsequent calls to compaction.
> 
> Direct compaction does, proactive not.
> 
> > In other words, I don't believe deferred compaction is intended to avoid 
> > checks to determine if compaction is worth it; it should only defer 
> > *additional* work that was not productive.
> 
> Yeah, that should be more optimal.
> 

Charan, is this something you'd like to follow up on, or should I take a 
look instead?

Thanks!
