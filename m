Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACDD2F43C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 06:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbhAMFZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 00:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbhAMFY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 00:24:59 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F65DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:24:19 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id w18so1833348iot.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F/OA+LEep844St+cLlN9bVuByZKQc9ECoZJDuSzWDXM=;
        b=pM2UxjNfimjxWa+YA7Vc6k4xjRxRbAliS/VyfsvmN2KD+U4L9sFrImXRd5NSwWrYIF
         qixPKyw8S4nzL7HHDqBg0+zxsBrq7hBytISqZs6qOK/N3TwAWWoBcm1zzhDiyvFcsRbl
         T6guDKnfqBUORiWuBzAlAz7uXih5uvczPcqewlEFtu/66bwj3HF4ELC4o6eKplzA+nB2
         R8n9/lDh+nt29C6ZgZxu1WYSs/N5LiJIHzpcAwYDytH/n31RMAX0ePUo/S60y+HTnEDO
         UJRjD/38h4Mkss3d/uMCuwVxtl6pCGgrYuVS7iTPBJqOxq4i6HdxYlGU6F8PgqM5MG8o
         oXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F/OA+LEep844St+cLlN9bVuByZKQc9ECoZJDuSzWDXM=;
        b=lp3AMwyL4OS6In4ezAGXUAAFSUJjJILXNus+AQs/zz84hv2J+aaJCEkNR7fGbiQcap
         LvJ1E34xPDKhQORUnTnWD60AS6MSHmwgNAFB5ifN6T37+euNqWqtoQBEueCQDr5OLPIE
         3TjraFbxL/BczEVAzigS2XS0sgUO0XaMXxhS6dpE9MyURzpW2XYTXFee/t5ECWWYUyFp
         rSgqk9/WA5mpHDIZmcAXPUMqqw3ZxAOYURMzzlgTVqX8GMDlI1yr1Hal+rXWTK7wDPoB
         rBtdsqbKICW6sWmQV9qotQw0TrOnUyIaacZfbyvv/E0PQXCwYlxTdlpluRVsNzRWP3Nu
         hBCA==
X-Gm-Message-State: AOAM5300ZVyShkhtVvNY6HfwVtOJjssA8wPzGYYZ1xATT3fqWiyxPPBP
        t+RQqVxMs2xACFbOpVFJvyW2TNb/x9r14wXw/dU=
X-Google-Smtp-Source: ABdhPJyL0YYvYyzO8fms7Tt132zPWXgDIVrVPUF/0TpbLxbDoeyxjZ55FsZVk1YbvzSwgi0ALEDFidNoPecLUwiI8vE=
X-Received: by 2002:a02:c7cb:: with SMTP id s11mr885489jao.94.1610515458507;
 Tue, 12 Jan 2021 21:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20210113024241.179113-1-ying.huang@intel.com> <CAHk-=whn5kVxEitkC0AyzvWRyxbF91rMrO9ZG6JHBNYLckpDDw@mail.gmail.com>
 <CAC=cRTNpoqHpbtZM1uDvVQYQZVyRbfPh+Dirb=-Xgoh22u_W1A@mail.gmail.com> <20210113031142.GM35215@casper.infradead.org>
In-Reply-To: <20210113031142.GM35215@casper.infradead.org>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Wed, 13 Jan 2021 13:24:07 +0800
Message-ID: <CAC=cRTNMN5Pmz2PC8p3N2-uJkqLUCW95wr=VWTZmodoECmj6nQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Free unused swap cache page in write protection fault handler
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 11:12 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jan 13, 2021 at 11:08:56AM +0800, huang ying wrote:
> > On Wed, Jan 13, 2021 at 10:47 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Tue, Jan 12, 2021 at 6:43 PM Huang Ying <ying.huang@intel.com> wrote:
> > > >
> > > > So in this patch, at the end of wp_page_copy(), the old unused swap
> > > > cache page will be tried to be freed.
> > >
> > > I'd much rather free it later when needed, rather than when you're in
> > > a COW section.
> >
> > Unused swap cache isn't unused file cache.  Nobody can reuse them
> > directly before freeing them firstly.  It will make COW a little
> > faster via keeping them.  But I think the overhead to free them isn't
> > high.  While keeping them in system will confuse users (users will
> > expect file cache to use free memory, but not expect unused swap cache
> > to use much free memory), make the swap space more fragmented, and add
> > system overall overhead (scanning LRU list, etc.).
>
> Couldn't we just move it to the tail of the LRU list so it's reclaimed
> first?  Or is locking going to be a problem here?

Yes.  That's a way to reduce the disturbance to the page reclaiming.
For LRU lock contention, is it sufficient to use another pagevec?

Best Regards,
Huang, Ying
