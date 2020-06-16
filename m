Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B219C1FB4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 16:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgFPOvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 10:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFPOvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:51:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2E8C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:51:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c185so19381061qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WFLTgGJ5LOxQenKARdYfCrtk1t6VepdL6VzhUDlajMc=;
        b=Kts+k6euY5oLtf5tmwXRNFGUhGHWkdA7OewYzlqCFmqsO+oP0gOkY9veTjBzlWEVYl
         UORvYhTCJc2coOGYzHiOfO209HA2dXWViqq2uItkXW9GiBStJbWAuyqNnAzsi87QFenO
         tVsl5e/8qY72GrV51aSGSGpp84hSGPA9tqRgdswktLogXcOb/mrl/DivaUgypINt6eJC
         Pqh79vjuddjzhus+huIbYxGlzNM3acc/mdoRsswn+fU0cHTCXQ0FzIsresCNiQRRfdo/
         e1LGh8lQMxzk4O9P8KReJAj6xsnscr8TBP1awTvFnHlZY5Y6XPgzfsP32D7wG+lIbvnw
         kxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WFLTgGJ5LOxQenKARdYfCrtk1t6VepdL6VzhUDlajMc=;
        b=YagMvvKJwgZZ+YDkiKPRmbGHZpJNNvN3hO+PvTy4BXGSvqdk5UXNDCDAkw8y+AExXO
         mZt6crl3xpn/8Lq4d2VXSPyXbh0bwsB4Oij1glmmYlZ/dtZCSiEk6ujKjBMVowSqTTWW
         fg8jlrwua0GpHuB9iQyk6UIb7jGrf9i4IkTHEnMsk0Q03mRLu6itztD1n6NxtLSnrxA2
         6pcvpppFvhdoWCiWcChthjMOGj0z+i2LHIO7+4+2HuvTmfPGdHcjmKSI8iJ+HNnayoiA
         IVYJF5TzMMmNB4yQ8NfqeBB4Ja+jfxgQO8xByJxf4/txd+OOJF4RFzSyzj/Q9qbVH3Cj
         QmGA==
X-Gm-Message-State: AOAM533gC7CiITs8kp+Nnv4Jk1Aj/Gz7d0Wx2RMPdzf2TEtb3ZfQjRWj
        Azu7M+gSYNNvCMpY7xm5efP8SQ==
X-Google-Smtp-Source: ABdhPJxoUuTjR/HnDD2RiYFZgrfAUGyaCqz8mMZepgrb6ol93ORKtTjYRCMvmCGQ/4segqqcHUSyrA==
X-Received: by 2002:a05:620a:1114:: with SMTP id o20mr21147059qkk.120.1592319073084;
        Tue, 16 Jun 2020 07:51:13 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id z19sm16357992qtz.81.2020.06.16.07.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:51:12 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:50:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH for v5.8 3/3] mm/memory: fix IO cost for anonymous page
Message-ID: <20200616145035.GC616830@cmpxchg.org>
References: <1592288204-27734-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592288204-27734-4-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592288204-27734-4-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 03:16:44PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> With synchronous IO swap device, swap-in is directly handled in fault
> code. Since IO cost notation isn't added there, with synchronous IO swap
> device, LRU balancing could be wrongly biased. Fix it to count it
> in fault code.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
