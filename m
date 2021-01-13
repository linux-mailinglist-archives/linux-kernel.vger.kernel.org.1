Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DA12F423F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 04:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbhAMDJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 22:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbhAMDJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 22:09:48 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4390DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 19:09:08 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e22so1304232iom.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 19:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4XTi7qJz193CCatw1VL2i3e99Yr9iMSuW3P/w0vdhec=;
        b=PxOgB6nmU8940+rhdi7M4XIClsmAPp7uzUth/w8zjkT8ydmCU8lCAZ4WxaP8adIJu3
         aLP39ElSUSKGa2i6fFRmUVodCm9dSFwB7h8L9vXP8X4jnOmxNIxC9i/4kEpcu3x7SRYY
         MjWHw29oqza5CmwpqY4I4NTEgLnf+JsfWvIx7tWVccTmm3XGzAF5mVR1aUVEfvqd6sOo
         edEYkE++Za2DhKeAtzOJT6hd4z9VvwdQGsbBFt7iU1NDZ+f6u+M23CKdqHsZrsJiwoaH
         ZWcbym3YoQu/E2y0pyzFkeR8fa6rdrLdzP9cItsLyM5g78a8Y+lsrxzPwzeLY85giuXA
         d5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XTi7qJz193CCatw1VL2i3e99Yr9iMSuW3P/w0vdhec=;
        b=WtMpzlJHsoyqQCrd2hzvtDf6uwbEIZj+e1gpEGFiq+IrzpqftV+xI7jOsScSTawyzP
         9dk0iXFszqlD+fGF/ck47vt+lUUXy3AkXlb9Qf/lEhYSPq1PZi4ZrTT78HJrO9/j4Oag
         y937uBQr0OvQ/zmk0MTcP0wgWcuqdbo60DGXkrXzlgUmvi45lW7i3Lav6X09vIcsPETq
         OrLVRnB7JpPo4nw5wcksStToRwEAGPVAgh0sKQKoAerx7ygQnqG323CTZKaIqiGr6qh0
         NBWIpJdAQoB7PiNmkpFYQstogR0rzXpbAepbnMBfNcCvXw7FoZ1o6sQxydnvEavmXPHU
         cz9w==
X-Gm-Message-State: AOAM5323RpSZ/lFuoYuNbJTLmQAzsqcF8j3MS4XXhwPF774NYaU+N7dH
        lREGzN8GZ45cc5hBCQFE1VjjSrwa/00IrPNUrh8=
X-Google-Smtp-Source: ABdhPJzLik9CoIlicN7Wwc7b+qPIIs9aqFWsy1UISq0XsAKz1vRr1M9lw1Dkg2nhP+KAwrEGerQCC7Ajk4EGmQQ/vcA=
X-Received: by 2002:a6b:8d91:: with SMTP id p139mr1231iod.96.1610507347561;
 Tue, 12 Jan 2021 19:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20210113024241.179113-1-ying.huang@intel.com> <CAHk-=whn5kVxEitkC0AyzvWRyxbF91rMrO9ZG6JHBNYLckpDDw@mail.gmail.com>
In-Reply-To: <CAHk-=whn5kVxEitkC0AyzvWRyxbF91rMrO9ZG6JHBNYLckpDDw@mail.gmail.com>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Wed, 13 Jan 2021 11:08:56 +0800
Message-ID: <CAC=cRTNpoqHpbtZM1uDvVQYQZVyRbfPh+Dirb=-Xgoh22u_W1A@mail.gmail.com>
Subject: Re: [PATCH] mm: Free unused swap cache page in write protection fault handler
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Huang Ying <ying.huang@intel.com>,
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

On Wed, Jan 13, 2021 at 10:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jan 12, 2021 at 6:43 PM Huang Ying <ying.huang@intel.com> wrote:
> >
> > So in this patch, at the end of wp_page_copy(), the old unused swap
> > cache page will be tried to be freed.
>
> I'd much rather free it later when needed, rather than when you're in
> a COW section.

Unused swap cache isn't unused file cache.  Nobody can reuse them
directly before freeing them firstly.  It will make COW a little
faster via keeping them.  But I think the overhead to free them isn't
high.  While keeping them in system will confuse users (users will
expect file cache to use free memory, but not expect unused swap cache
to use much free memory), make the swap space more fragmented, and add
system overall overhead (scanning LRU list, etc.).

Best Regards,
Huang, Ying
