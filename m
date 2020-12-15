Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FAE2DA61D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 03:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgLOCSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 21:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgLOCR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:17:28 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67829C0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 18:16:48 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id i6so17921970otr.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 18:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=barWCp514FjI25PzXmxIiJLF9ZYJy6zAnVMGHuNnvjw=;
        b=eSfw5tE5a2wyn/jRdln7YAqK4uoJDzhoOSSzqwQ5qxbNTUu8xMlWjaXC7G3TEn4e8r
         uLpGMcOzcVFpNK3nmRELzDuOc45uXP0skLftpKCCwBENsio2lWi5P1Wgq7ikEROkQpWQ
         3YbtThWQJ1IxnwaeruDgP25bwNonC1HTWo8kTUjSaF3Unc485ytQGNh3h82CaFGMHANU
         piMpvmtCW6oI0m9ysD4F2cWp1l3oXEFVwPlJ5D51AG1RA1eI2Wj8xrRzZLFicod9+PFm
         M/E9NqaLWYBojoQRlPJp6aAUV7d0J/UeDq0xB0AEniFLbz2HOFIn8J8CK/R7uHSboKd1
         BqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=barWCp514FjI25PzXmxIiJLF9ZYJy6zAnVMGHuNnvjw=;
        b=S6PYmszDkbODAKacYOx5H8rawd7clW+5OaAak/Obyd7XG0l4SAR5IBh9hm0SoHvt8p
         AHq/ZSztQGeQ2Gn/xVsQMfVaoRNPISqbNwp3JuTNms0F7ZLjfunrUKVh6clDWcpPgdOX
         ZyZiqPsGsvFsgOpZ5s5RYq/Og2nRNg5bvBLGpp7aoP8F89CaAImYcbYDZ9WCGrIF+SFh
         vqnblvvhFs/0oFKsoy5AwMZT4mHQZKS8yewt7NMYprs9xnX7gNBeHATEqfMTMxiypQIW
         Y/UwTnKcJsTUNHGB6a4udjX6aI+Az0MeJEKiir/sKLq4oAGHfZzCgB/Z2A1LE5BsZpu5
         +YDw==
X-Gm-Message-State: AOAM532AirHB3fZm01LYTXu5LxFOLFn0vdc4+QXdgZRrCqe3hXxzMF+t
        voADwjFVoEg/HiqJuhybITifMQ==
X-Google-Smtp-Source: ABdhPJzRPydU4OJ/E6A2C8PdGop5Zh9B2jUkd0I+/UULhPwHa+kobZec9ipOyjV5B7KLcLPYyIAMIQ==
X-Received: by 2002:a9d:63cd:: with SMTP id e13mr22108569otl.37.1607998607438;
        Mon, 14 Dec 2020 18:16:47 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j126sm4754700oib.13.2020.12.14.18.16.45
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 14 Dec 2020 18:16:47 -0800 (PST)
Date:   Mon, 14 Dec 2020 18:16:34 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alex Shi <alex.shi@linux.alibaba.com>, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Subject: Re: [PATCH v21 00/19] per memcg lru lock
In-Reply-To: <20201214164712.39da20f908c6199eb4cde961@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.2012141734060.3082@eggly.anvils>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com> <20201214164712.39da20f908c6199eb4cde961@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020, Andrew Morton wrote:
> On Thu,  5 Nov 2020 16:55:30 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
> > This version rebase on next/master 20201104, with much of Johannes's
> > Acks and some changes according to Johannes comments. And add a new patch
> > v21-0006-mm-rmap-stop-store-reordering-issue-on-page-mapp.patch to support
> > v21-0007.
> 
> I assume the consensus on this series is 'not yet"?

Speaking for my part in the consensus: I don't share that assumption,
the series by now is well-baked and well reviewed by enough people over
more than enough versions, has been completely untroublesome since it
entered mmotm/linux-next a month ago, not even any performance bleats
from 0day, and has nothing to gain from any further delay.

I think it was my fault that v20 didn't get into 5.10: I'd said "not yet"
when you first tried a part of v19 or earlier in mmotm, and by the time
I'd completed review it was too late in the cycle; Johannes and Vlastimil
have gone over it since then, and I'd be glad to see it go ahead into
5.11 very soon. Silence on v21 meaning that it's good.

Various of us have improvements or cleanups in mind or in private tree,
but nothing to hold back what's already there.

> 
> Also, did
> https://lkml.kernel.org/r/0000000000000340a105b49441d3@google.com get
> resolved?

Alex found enough precedents for that, before inclusion of his series,
so it should not discourage from moving his series forward.  I have
ignored that syzreport until now, but will take a quick try at the
repro now, to see if I'm inspired - probably not, but we'll see.

Hugh
