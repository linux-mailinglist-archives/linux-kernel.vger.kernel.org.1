Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF892D1A96
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgLGUeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgLGUeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:34:17 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5DCC061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 12:33:37 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id j12so13763969ota.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 12:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VF+dRBuajSL16Efm+Qk9iftapw2E7SOSirPhcnw+PnQ=;
        b=ZRA2+e52xlSYiJHPZTaBAxFXuVgSCguGt+17cXdyunFJAuKyaHC0N9M0+4wVV+JNu/
         aS6Ru6m3Y+wnCnDvTaR0B9YOhtU4H+7LE/3LGO0G8PmR1IrdqhucfywKGLBMNQLyMXu/
         XJSr+UlHYySaZWgshmFkJXhyvI//6ZYqsYHP2wgrjLmT1qlB1JlPb9O13tbr6L0bBWLe
         GRMCt7godtRnbrHZWJKC5DL6rW4nmuRO1x9OHwbZyq7CAqDi7cjSnTBdGjEjq1IFVhKo
         fbeRgmd7/Vs61w3QEF43+SBNzMP6YdnFO+5G59r4xPy9OUThCHiccAY3BNCrGBsllVky
         hvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=VF+dRBuajSL16Efm+Qk9iftapw2E7SOSirPhcnw+PnQ=;
        b=tpvpICwGoQ16SoUO3OUY4Dgisc/0pJBte+sxNPxUyP+OCBP/rJWa+nNQHAoWAMeX6O
         NNrYPFvAs40WmYj03g9n9TrufJcOGk9PnKmDCPh6wKALc5G/sDvdsSuTWMxVHBzux3B5
         wrFzJBeFcl1vf+ize40vu5ZF0D7200e4u3Co99ZGm70AaKoob2rAIqtJxAzODSj7ZjbN
         SXMBGfd4p92+wTlXp3DVHD5cgU9rquRafnzNyBulcOUxUg5V2OyanJ5Ookzvnygauvuk
         z2PQMAHKF971jrRCvfHGMjT9QFq2m+FVm0+xtRYejwEcvrk6hKFroQ+vSAVUbQmPNKxy
         yLFw==
X-Gm-Message-State: AOAM530UF/gn0DRb9szQTzAbES5QNdiyblooSqMszFHFTUB9aQ76UmHy
        DzBYQpo+IiX8yxEOSieM0BQ4+Q==
X-Google-Smtp-Source: ABdhPJz9sBLcEczItc+x7GzdpccmdUkQq4OA2vpq4vUs629hT03tlx7plX6XLEideED+DfI8x+oGZg==
X-Received: by 2002:a9d:4588:: with SMTP id x8mr14555151ote.169.1607373216384;
        Mon, 07 Dec 2020 12:33:36 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n6sm2874818ota.73.2020.12.07.12.33.34
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 07 Dec 2020 12:33:35 -0800 (PST)
Date:   Mon, 7 Dec 2020 12:33:18 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Roman Gushchin <guro@fb.com>
cc:     Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com,
        Suren Baghdasaryan <surenb@google.com>, avagin@openvz.org,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [External] Re: [RESEND PATCH v2 00/12] Convert all vmstat counters
 to pages or bytes
In-Reply-To: <20201207195141.GB2238414@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.LSU.2.11.2012071218540.9574@eggly.anvils>
References: <20201206101451.14706-1-songmuchun@bytedance.com> <20201207130018.GJ25569@dhcp22.suse.cz> <CAMZfGtWSEKWqR4f+23xt+jVF-NLSTVQ0L0V3xfZsQzV7aeebhw@mail.gmail.com> <20201207150254.GL25569@dhcp22.suse.cz>
 <20201207195141.GB2238414@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020, Roman Gushchin wrote:
> On Mon, Dec 07, 2020 at 04:02:54PM +0100, Michal Hocko wrote:
> > 
> > As I've said the THP accounting change makes more sense to me because it
> > allows future changes which are already undergoing so there is more
> > merit in those.
> 
> +1
> And this part is absolutely trivial.

It does need to be recognized that, with these changes, every THP stats
update overflows the per-cpu counter, resorting to atomic global updates.
And I'd like to see that mentioned in the commit message.

But this change is consistent with 4.7's 8f182270dfec ("mm/swap.c: flush
lru pvecs on compound page arrival"): we accepted greater overhead for
greater accuracy back then, so I think it's okay to do so for THP stats.

Hugh
