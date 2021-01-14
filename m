Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC6E2F668E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbhANQ53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbhANQ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:57:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0F4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:56:48 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:56:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610643405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKn/QBNXkiTZkcqk/tbHW0VAwn02yIglBIczfs2pWxk=;
        b=Jz+NmKaxVaMHpUsW7Hh1j5qPs2sj7kyFbOqBNrWm0cMUdY2ZZfVk2L9Jf+yBQm3bjkGvnh
        NI0Gk9w4jF4AaSzgUYZzvfvOAiLL4BBmeNE+RyBghcmbvE4ExFFUmVXkQM9E43sgoP6t8X
        LTepvsiHIeKjtHk/f4+FcZDCU5brI9qk3Adc7kwWzC5u2G5HUrqWLa94Yk461j1/blvRHP
        q4NTxrMutgmXgvmVUucmgWMoWC/jjNVt4+BVBbhKEeRRmKb+yxYHXBqsrjOLhM2UTnSCKs
        +ddaLMrN7d4k2vpXs29ySkEvPPE81aHgnM3BNoWhSHHOrARTz7khHE/U5Jr3sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610643405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKn/QBNXkiTZkcqk/tbHW0VAwn02yIglBIczfs2pWxk=;
        b=w/mI3YHVjVFaxxTfR5j8PmKOJIehUjsQFIFbqEJAH/XsbC/4nXyvuhEEM5OM9d1X0gl978
        QUzA/0UgsC/xanDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     "tiantao (H)" <tiantao6@huawei.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, NitinGupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
Message-ID: <20210114165645.czqpsk3lacmiyiik@linutronix.de>
References: <4490cb6a7e2243fba374e40652979e46@hisilicon.com>
 <CAM4kBBK=5eBdCjWc5VJXcdr=Z4PV1=ZQ2n8fZmJ6ahJbpUyv2A@mail.gmail.com>
 <08cbef1e43634c4099709be8e99e5d27@hisilicon.com>
 <CAM4kBBJjCYX0DQZ8de9LsFV6L+eF4tZe-NN=jiAz9WLWYrsCsQ@mail.gmail.com>
 <1d0d4a3576e74d128d7849342a7e9faf@hisilicon.com>
 <CAM4kBB+uRrnpta908Gf93VfH90NVpmqv4jNY2kxrrGSdWApz_w@mail.gmail.com>
 <4e686c73-b453-e714-021a-1fcd0a565984@huawei.com>
 <CAM4kBB+jtJd5mqBby7j+ou-AxvPgCU777pX4cnwneLi8P4U+7g@mail.gmail.com>
 <20210114161850.zjcfhsgtmojjjqba@linutronix.de>
 <CAM4kBBKcj+ZVEv8mkh+rWc0xbomKsyc60UNuuRem_iWPf9YxVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM4kBBKcj+ZVEv8mkh+rWc0xbomKsyc60UNuuRem_iWPf9YxVA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-14 17:29:37 [+0100], Vitaly Wool wrote:
> On Thu, 14 Jan 2021, 17:18 Sebastian Andrzej Siewior,
> <bigeasy@linutronix.de> wrote:
> >
> > On 2020-12-23 19:25:02 [+0100], Vitaly Wool wrote:
> > > > write the following patch according to your idea, what do you think ?
> > >
> > > Yep, that is basically what I was thinking of. Some nitpicks below:
> >
> > Did this go somewhere? The thread just ends here on my end.
> > Mike, is this patch fixing / helping your case in anyway?
> 
> Please see
> * https://marc.info/?l=linux-mm&m=160889419514019&w=2
> * https://marc.info/?l=linux-mm&m=160889418114011&w=2
> * https://marc.info/?l=linux-mm&m=160889448814057&w=2

Thank you, that would be
   1608894171-54174-1-git-send-email-tiantao6@hisilicon.com

for b4 compatibility :)

> Haven't had time to test these yet but seem to be alright.

So zs_map_object() still disables preemption but the mutex part is
avoided by the patch?

> Best regards,
>    Vitaly

Sebastian
