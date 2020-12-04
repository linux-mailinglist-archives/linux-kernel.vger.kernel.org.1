Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7C2CF1AE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbgLDQNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgLDQNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:13:23 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3881C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 08:12:43 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id e5so3351774pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 08:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgBK6gNRJdzBFc9vMwzbFn3dmf1hBTZHlv0OSygLjJk=;
        b=1sagrwP/FVGDih5ebdMkoXfp/7l+m3CFyw+VwGe6s7hnyBJkj1OCbcWJs6EQsuZbeB
         pbHStSPO2i64md/0IbNCHlRzcvz2brcSwdXUY6LkN1Br6xwtHiyZTxv3oZxLMrr4kUAA
         9GsOrYKHTekTKILQANM/eemKSkFbE9yb9RsstW9j+OBdmwN5u0Jvy6O20AEPihKsHnHA
         kgxlgBqci7fjgnksBtC1/YOF9g2Sv29hm3SeZBNhclmAL0cphUigc/ukjcXRZr4WRXj7
         TqDDUl9C5AHrsBguZ1iyzIwBA/xjmRlytmybQVNMd4m76hwTYsUljwnsq6EMrbjqSH99
         3p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgBK6gNRJdzBFc9vMwzbFn3dmf1hBTZHlv0OSygLjJk=;
        b=maZtXzmllnwnrDBNEm0fuXdeAbXW8AIJpT53ebU32ZudM/eBLY3RPC2yZrcVHaeZXI
         0CtBDrS51OZwwMigX+h3hRqqGJQxLBU44H33Y4XjYP/4s0x8iW19igPyfXTBqRkZUY0g
         89YFzcL2wH/8NdHsZ/h86tQHjVlyi8t1JqzKH3wOwUBKj3UlT8EbilS2Mrk28LpX5Js4
         aMmCXeUfQzZaCkityCFHbHQ6vebYQ5Xo39ilxRyiD+FSs3eaBJXOzqUm3+AB6CZEB1q0
         MWu4p+R/q8qaklHEpj/hJtZX74Dd3tnzlHKDfVI/ozkO+ApKSy1AARI23P5tELLjckhV
         LKJg==
X-Gm-Message-State: AOAM533CxXKueCOoLLndZE7M0JxXvAQdmrAQyeCGZDoqVhi3DS2GPix9
        w/+eFV7rRAMWAI+PS6WFAKxaR6eZNwXSNvNA3Ws7AxbJGe5d+A==
X-Google-Smtp-Source: ABdhPJyLaDNma2sWdL6BfboS+XrP7SCgS1iMGsBIQVI6ZPAsifoMRSkbIa0G9agbEQiwezzKGGDL5d1+GQRQWOJdQjQ=
X-Received: by 2002:a17:902:76c8:b029:d9:d6c3:357d with SMTP id
 j8-20020a17090276c8b02900d9d6c3357dmr4605653plt.34.1607098363125; Fri, 04 Dec
 2020 08:12:43 -0800 (PST)
MIME-Version: 1.0
References: <20201203162237.21885-1-songmuchun@bytedance.com> <46fcf0c1-7c38-723b-8905-953d72f1d6bc@redhat.com>
In-Reply-To: <46fcf0c1-7c38-723b-8905-953d72f1d6bc@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 5 Dec 2020 00:12:06 +0800
Message-ID: <CAMZfGtVdFtLB8f2uDfJ1H-YG4CsJ+RxxFbAWzePDnqBB1MU0ig@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm/page_isolation: do not isolate the
 max order page
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 12:28 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 03.12.20 17:22, Muchun Song wrote:
> > The max order page has no buddy page and never merge to other order.
> > So isolating and then freeing it is pointless. And if order == MAX_ORDER
> > - 1, then the buddy can actually be a !pfn_valid() in some corner case?
> > pfn_valid_within(buddy_pfn) that follows would only catch it on archs
> > with holes in zone. Then is_migrate_isolate_page(buddy) might access an
> > invalid buddy. So this is also a bug fix.
> >
> > Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
>
> As just replied to v1, I don't think this is required and the patch

You mean we should remove the Fixes tag? Thanks.

> description can be simplified - e.g., stating that we have/had not such
> users.
>
>
> --
> Thanks,
>
> David / dhildenb
>


-- 
Yours,
Muchun
