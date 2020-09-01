Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F29259D34
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 19:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgIAR3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 13:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgIAR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:29:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D82C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 10:29:42 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so1184181pfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FW5La7opiv4KWG16c7XYpf3DTcgrj7Pdfd83aUNKNrc=;
        b=jAYS2ZZc79qZYnTsWwjv1SadjMN4RsSUm73yL30/GRwcwxgx4b2Nzm1acr8EpXHU9A
         boOwDj4V+fB5mPRPo+Bphq2QhUwtv9CGHRTG0Mst/tBdwp4NX2vO6i7ag2MSCNrd/HIi
         AZQ+fBRYvWGIFiYzyOdjiuLJEwGDoPjfTasrm4iP6Bxhunex1Odsdg877c+L2oeUIjyl
         BvD61dtjU9PXUL0yTB3RKH36Q/pHpRkVTcfkriR5wU0n1ydpyKxsMdyKoKf2KiK0Wrgh
         jFGMvRTtmQI4gSn4b684qUrpZw/MICxUnYbOWXjmbDcERxcrngcctPQze1oDKK2bpbTD
         aFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FW5La7opiv4KWG16c7XYpf3DTcgrj7Pdfd83aUNKNrc=;
        b=K0iOYNwbbbQXhw9F0hbL/vdt6FilqB/PSyy18prx3MxQOMOjAeHFirtoNFvbG8Xl1q
         Ge0kmQGl9m131MXcIz53in3KpWocJceW6M87PG7CYgTFgoQ18Q5U5vv8oUD7Hv+5QTeQ
         TCASlkoJBbd36FQ6bwU35tecO/m8C4vujMfaRd/fCMNY9mU/DQ6YArcmW9UpTDgwcQmf
         LBqB3JTAH8aMFca/2Sicdcrxd9CpruyFfAUGRIOj60FORDPiWyUzP2SQ70rHPrN03LK+
         saK53nUgUDVDN5YpFJ9KyOD+kALYolVOg5nfZs9CulrBBLrASDmcv0FZtd7yR1slIQrK
         rwBA==
X-Gm-Message-State: AOAM533Xp/WpQIz3DGhoZew/32qETEOXxoXOgxgkJr+vwU/daV5MEH5V
        +TK2AJwJNg3ZC77BkbqrMzjAv5YVnoE5stBqAWXbOA==
X-Google-Smtp-Source: ABdhPJy+wnhFDll+mv7LIiKSNfRQ41dAABi9B9GZjw2dwvoiws5enWPEeNCL3N0k/xB5qaMMi/h/yGiXziML8E6Nkz4=
X-Received: by 2002:a63:d62:: with SMTP id 34mr2356233pgn.179.1598981381718;
 Tue, 01 Sep 2020 10:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200727175720.4022402-1-willmcvicker@google.com>
 <20200727175720.4022402-2-willmcvicker@google.com> <20200729214607.GA30831@salvia>
 <20200731002611.GA1035680@google.com> <20200731175115.GA16982@salvia>
 <20200731181633.GA1209076@google.com> <20200803183156.GA3084830@google.com>
 <20200804113711.GA20988@salvia> <20200901153607.GC4292@willie-the-truck>
In-Reply-To: <20200901153607.GC4292@willie-the-truck>
From:   William Mcvicker <willmcvicker@google.com>
Date:   Tue, 1 Sep 2020 10:29:25 -0700
Message-ID: <CABYd82ZDVqJo4KUiF0oMX6CW7pC_Y0DB_PdXJMft-yU=c5TCBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] netfilter: nat: add a range check for l3/l4 protonum
To:     Will Deacon <will@kernel.org>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>, security@kernel.org,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

Pablo is going to add the latest patch to the nf.git tree. Once that
happens, I'm going to propose the patch in nf.git get cherry-picked to
the -stable branches.

Thanks,
Will


On Tue, Sep 1, 2020 at 8:36 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Will, Pablo,
>
> On Tue, Aug 04, 2020 at 01:37:11PM +0200, Pablo Neira Ayuso wrote:
> > This patch is much smaller and if you confirm this is address the
> > issue, then this is awesome.
>
> Did that ever get confirmed? AFAICT, nothing ended up landing in the stable
> trees for this.
>
> Cheers,
>
> Will
>
>
> > On Mon, Aug 03, 2020 at 06:31:56PM +0000, William Mcvicker wrote:
> > [...]
> > > diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
> > > index 31fa94064a62..56d310f8b29a 100644
> > > --- a/net/netfilter/nf_conntrack_netlink.c
> > > +++ b/net/netfilter/nf_conntrack_netlink.c
> > > @@ -1129,6 +1129,8 @@ ctnetlink_parse_tuple(const struct nlattr * const cda[],
> > >     if (!tb[CTA_TUPLE_IP])
> > >             return -EINVAL;
> > >
> > > +   if (l3num >= NFPROTO_NUMPROTO)
> > > +           return -EINVAL;
> >
> > l3num can only be either NFPROTO_IPV4 or NFPROTO_IPV6.
> >
> > Other than that, bail out with EOPNOTSUPP.
> >
> > Thank you.
