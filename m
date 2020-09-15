Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E85269D49
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 06:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIOEYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 00:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgIOEYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 00:24:14 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8992AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 21:24:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w3so1561383ljo.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 21:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PBQszRvBcpddfdSGm+HLooLgRnTgwy/19XVpfGXCozI=;
        b=uGJMXjqhCGd3SZkZNGGSyYMd0UpuNBHn8EY307GGWrsURCr0IYnhfzsd2LsuILvVBD
         nhq31oHLmEj/x0agiZelOjAa82Zkloe/gbYmGcT3kE9IM0Hhrp6587dA0g/NkeDoK06y
         TJeLCow/s0tr43DsoN+ZLLg46X7CxtZfFmIz8eJlSxPha0T5zdywm9w5bs5swQtjLLYZ
         y3e6jC6HvnM8gdSm1CzmzsZgVa6ZxhNA91F84gVmB/ebZl4uJJ0I8eqi2HgnLrXTO4rb
         Mwr4SK3ZUcus4de2TKsJzq5HcVnLnxNfzHOtptW/vSuSjsxdyMmo9VQId0s1ZAAEWDD3
         I4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PBQszRvBcpddfdSGm+HLooLgRnTgwy/19XVpfGXCozI=;
        b=e5+MqgSSRTUXJ+7JWSY7+7tpTC9xVNHgdwMGaQA9q16keHDtaqp/U3cgaM7wSg2YK5
         NV2gy4WwylDsnTLhFv2HcQMJ9EKMuPq6xEaJvol6zhBvzxoDmTqVFV9uU2Pep7Z3PuNc
         cEnh9Yuy/E6HqQNocTlVvydF/EVr4oTJorVdgsDNKB/W1H2yqltNysPpCyv/zUojtSoA
         fCM1Q4EbC7u9B8b8hutMegdC+ZhK9afODUgFcUPB0x+cLthqMBOWkmQgU61FG/0bQK8o
         /0EuxduAJ6GZ3ypPbUeTx3pWvvFqJb/UBqEvv4wVxFj885VcP1eGSaOx+jAz38EA2Jp0
         0H/Q==
X-Gm-Message-State: AOAM530HBWmaNlvisiZlvEJWK8CbmKN9WYawr7en8K/EeSw84T9kHykL
        xWSrbADtiRIjyvBCRt88e1ZsZaGKKIRe1CiXJpOIojkOquVMlMSp
X-Google-Smtp-Source: ABdhPJy5vhhyUJ1ZCfBYqoNmC8bZgbT/qPaLlMhIvu1fHG+IKPeYfzky1LiSmZ5e/eIWs/dXZjluz6WJBbSRmjQHwgY=
X-Received: by 2002:a2e:b8d1:: with SMTP id s17mr5818687ljp.222.1600143850965;
 Mon, 14 Sep 2020 21:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200909152047.27905-1-zangchunxin@bytedance.com>
 <20200914093032.GG16999@dhcp22.suse.cz> <CAKRVAeP1yPDTcdcW+H6EnMrDHsWGNkooGcSyeYWHi8CXCc+u4Q@mail.gmail.com>
 <20200914134713.GS16999@dhcp22.suse.cz> <CAKRVAeOejq8D63FC=Vhhu7VcRba__d-m8OGUQoRDvcUuh7L2ZA@mail.gmail.com>
 <20200914151736.GA16999@dhcp22.suse.cz>
In-Reply-To: <20200914151736.GA16999@dhcp22.suse.cz>
From:   Chunxin Zang <zangchunxin@bytedance.com>
Date:   Tue, 15 Sep 2020 12:23:59 +0800
Message-ID: <CAKRVAeOQyx4+OjvQa2UV2cy3E6bB5epznjHudOJYqe8NC=Uqkg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm/vmscan: fix infinite loop in drop_slab_node
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 11:17 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 14-09-20 23:02:15, Chunxin Zang wrote:
> > On Mon, Sep 14, 2020 at 9:47 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > > On Mon 14-09-20 21:25:59, Chunxin Zang wrote:
> > > > On Mon, Sep 14, 2020 at 5:30 PM Michal Hocko <mhocko@suse.com> wrot=
e:
> > > >
> > > > > The subject is misleading because this patch doesn't fix an infin=
ite
> > > > > loop, right? It just allows the userspace to interrupt the operat=
ion.
> > > > >
> > > > >
> > > > Yes,  so we are making a separate patch follow Vlastimil's
> > > recommendations.
> > > > Use double of threshold to end the loop.
> > >
> > > That still means the changelog needs an update
> > >
> >
> > The patch is already merged in Linux-next branch.  Can I update the
> > changelog now?
>
> Yes. Andrew will refresh it. He doesn't have a git tree which would
> prevent rewriting the patch.
>
> > This is my first patch, please forgive me :)
>
> No worries. The mm patch workflow is rather different from others.
>
> > > > On Thu, Sep 10, 2020 at 1:59 AM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> > > > > > From: Chunxin Zang <zangchunxin@bytedance.com>
> > > > > >
> > > > > ...
> > > > > - IMHO it's still worth to bail out in your scenario even without=
 a
> > > > > signal, e.g.
> > > > > by the doubling of threshold. But it can be a separate patch.
> > > > > Thanks!
> > > > > ...
> > > >
> > > >
> > > >
> > > > On Wed 09-09-20 23:20:47, zangchunxin@bytedance.com wrote:
> > > > > > From: Chunxin Zang <zangchunxin@bytedance.com>
> > > > > >
> > > > > > On our server, there are about 10k memcg in one machine. They u=
se
> > > memory
> > > > > > very frequently. When I tigger drop caches=EF=BC=8Cthe process =
will infinite
> > > loop
> > > > > > in drop_slab_node.
> > > > >
> > > > > Is this really an infinite loop, or it just takes a lot of time t=
o
> > > > > process all the metadata in that setup? If this is really an infi=
nite
> > > > > loop then we should look at it. My current understanding is that =
the
> > > > > operation would finish at some time it just takes painfully long =
to get
> > > > > there.
> > > > >
> > > >
> > > > Yes,  it's really an infinite loop.  Every loop spends a lot of tim=
e. In
> > > > this time,
> > > > memcg will alloc/free memory,  so the next loop, the total of  'fre=
ed'
> > > > always bigger than 10.
> > >
> > > I am still not sure I follow. Do you mean that there is somebody
> > > constantly generating more objects to reclaim?
> > >
> >
> > Yes, this is my meaning. :)
> >
> >
> > > Maybe we are just not agreeing on the definition of an infinite loop =
but
> > > in my book that means that the final condition can never be met. Whil=
e a
> > > busy adding new object might indeed cause drop caches to loop for a l=
ong
> > > time this is to be expected from that interface as it is supposed to
> > > drop all the cache and that can grow during the operation.
> > > --
> > >
> >
> > Because I have 10k memcg , all of them are heavy users of memory.
> > During each loop, there are always more than 10 reclaimable objects
> > generating, so the
> > condition is never met.
>
> 10k or any number of memcgs shouldn't really make much of a difference.
> Except for the time the scan adds. Fundamentally we are talking about
> freed objects and whether they are on the global or per memcg lists
> should result in a similar behavior.
>
> > The drop cache process has no chance to exit the
> > loop.
> > Although the purpose of the 'drop cache' interface is to release all
> > caches, we still need a
> > way to terminate it, e.g. in this case, the process took too long to ru=
n .
>
> Yes, this is perfectly understandable. Having a bail out on fatal signal
> is a completely reasonable thing to do. I am mostly confused by your
> infinite loop claims and what the relation of this patch to it. I would
> propose this wording instead
>
> "
> We have observed that drop_caches can take a considerable amount of
> time (<put data here>). Especially when there are many memcgs involved
> because they are adding an additional overhead.
>
> It is quite unfortunate that the operation cannot be interrupted by a
> signal currently. Add a check for fatal signals into the main loop
> so that userspace can control early bailout.
> "

I understand what you mean. Yes, you are right, The patch only
provides a way for
users to terminate the process, not to reduce time consumption, not improve
the situation about loops.
I will update the description of the patch in v3.
Thanks so much :)

> or something along those lines.
>
> >
> >   root  357956 ... R    Aug25 21119854:55 echo 3 > /proc/sys/vm/drop_ca=
ches
>
> --
> Michal Hocko
> SUSE Labs

Best wishes
Chunxin
