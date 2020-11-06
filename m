Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BAF2A93F7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgKFKTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:19:07 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BE8C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:19:07 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id x20so613759ilj.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sdK5L9LlPpSjmRzKF8fKPQux7TO4MN23Bk2tcXAjg8U=;
        b=eTkda+8ePvyiA3OB64oUVgvBl6/wGPdkBmwVrHs5GpikZ6yvSet20NZ/A2SHxeNsR9
         hC4yjjRYMctJJu2wePpWU2Bs2qnjDTHdNiBQDKPhGx9yR7JP6UsbdadbclNX+WeMaPPA
         Ku/rJWNVJHb91Udl8dzGwQhVbpEVA6IDjNTePL9zubTvDqEFkynmchU1RNmOlmnLvFxt
         aDFXsUmec4dRTMHM1C/AnQ2i2vPfIK2xdy2e6ubT/HhgX9TWP/LGKVWzJaNa29bcI3hX
         6XR1VCYWzp31R7GanSJk0kaPsugEV+hoAF5PNmq7Pli2IeYopyVr6vfHVwcdyCxLXb3/
         Og6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sdK5L9LlPpSjmRzKF8fKPQux7TO4MN23Bk2tcXAjg8U=;
        b=kFcdhO3pepY0skIv+V2MpgCXbAtr4PoJkvM6nRx+aSK0jtg+RdSuc/rgDAYii1Y7jv
         i7Bac4pQIYe7CfgNScdaMj8ONU3sZ+boF+M8oJc/cUU/R5C6ORVvs7cyJ9JGfWo9MVDM
         L7kKzUlX/6LoVyCayXGAduRlj2piDAyy6oDW2aAgWtWC2ZjMzZIvwprRogLZrGpRFbBt
         h+IKCYdOWwz23wrPcdwJbuOJQ8Clw/MdAiDIZaEPA2I6CdTcjLDUGsJjlWIoYa+tDTI3
         UqXX5m7D/2iYus+N6TtfwHEQnRDI3DvB1GUqJebDYmJt2AKURHCziLvqRz1x/4m6SGtN
         mOAg==
X-Gm-Message-State: AOAM533L2g1T8bfDirRQBXvLjAEac7vAE4eN+IeYFFpyjGBNzJUogprI
        jyhj3xNt+n+6AgTF5FScS6c=
X-Google-Smtp-Source: ABdhPJwd0JSKDUWFvjaIWWV2EGI7Rx2SUHqBaTju4TGBKRFjEyTdpGnqLO7CKt7o704eC6qLRMUfoQ==
X-Received: by 2002:a05:6e02:2cc:: with SMTP id v12mr853240ilr.115.1604657946689;
        Fri, 06 Nov 2020 02:19:06 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id m10sm752952ilg.77.2020.11.06.02.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:19:06 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 002C627C005A;
        Fri,  6 Nov 2020 05:19:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 06 Nov 2020 05:19:01 -0500
X-ME-Sender: <xms:FCOlX5y8HjuaoyAkq7jwIDTU1Sl_wV8SH2oO1vsYNFXpxLzwy4MYow>
    <xme:FCOlX5SSUDneF7LCh2UOnRwxLQSL5RiYNkjzYwYiivcHaNuYrKjPiCmznGAUuz1PH
    mVgr1KttBK_cUfv0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecukfhppedufedurddutdejrddugeejrdduvdeinecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:FCOlXzW5zzpl33uxIFt6V_BfqKtAnVQP1Y1Uwa8p5BWOrO4kUfIYaA>
    <xmx:FCOlX7jllqIUs289gjOnJ0K0a3YpZutrl6BgFqBdNpk0lcbsyNg8dw>
    <xmx:FCOlX7Djhl6IXzlhIkktPtv6yVVIZfUNGsdr_M3uxqAHAAmq1bUG_w>
    <xmx:FCOlX_1Y45FrP0a2wr7Lsr7TwGfc_ExHvlLs8trJHwxVlpUJP8bvMVpq9hQ>
Received: from localhost (unknown [131.107.147.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id D88B33060060;
        Fri,  6 Nov 2020 05:18:59 -0500 (EST)
Date:   Fri, 6 Nov 2020 18:18:56 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH kcsan 3/3] kcsan: Fix encoding masks and regain address
 bit
Message-ID: <20201106101856.GC3025@boqun-archlinux>
References: <20201105220302.GA15733@paulmck-ThinkPad-P72>
 <20201105220324.15808-3-paulmck@kernel.org>
 <20201106012335.GA3025@boqun-archlinux>
 <CANpmjNNj1cc2LUrLdbYy1QkVv80HUPztPXmLfscYB=pU_nffaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNj1cc2LUrLdbYy1QkVv80HUPztPXmLfscYB=pU_nffaA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:03:21AM +0100, Marco Elver wrote:
> On Fri, 6 Nov 2020 at 02:23, Boqun Feng <boqun.feng@gmail.com> wrote:
> > Hi Marco,
> >
> > On Thu, Nov 05, 2020 at 02:03:24PM -0800, paulmck@kernel.org wrote:
> > > From: Marco Elver <elver@google.com>
> > >
> > > The watchpoint encoding masks for size and address were off-by-one bit
> > > each, with the size mask using 1 unnecessary bit and the address mask
> > > missing 1 bit. However, due to the way the size is shifted into the
> > > encoded watchpoint, we were effectively wasting and never using the
> > > extra bit.
> > >
> > > For example, on x86 with PAGE_SIZE==4K, we have 1 bit for the is-write
> > > bit, 14 bits for the size bits, and then 49 bits left for the address.
> > > Prior to this fix we would end up with this usage:
> > >
> > >       [ write<1> | size<14> | wasted<1> | address<48> ]
> > >
> > > Fix it by subtracting 1 bit from the GENMASK() end and start ranges of
> > > size and address respectively. The added static_assert()s verify that
> > > the masks are as expected. With the fixed version, we get the expected
> > > usage:
> > >
> > >       [ write<1> | size<14> |             address<49> ]
> > >
> > > Functionally no change is expected, since that extra address bit is
> > > insignificant for enabled architectures.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > ---
> > >  kernel/kcsan/encoding.h | 14 ++++++--------
> > >  1 file changed, 6 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> > > index 4f73db6..b50bda9 100644
> > > --- a/kernel/kcsan/encoding.h
> > > +++ b/kernel/kcsan/encoding.h
> > > @@ -37,14 +37,12 @@
> > >   */
> > >  #define WATCHPOINT_ADDR_BITS (BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
> > >
> > > -/*
> > > - * Masks to set/retrieve the encoded data.
> > > - */
> > > -#define WATCHPOINT_WRITE_MASK BIT(BITS_PER_LONG-1)
> > > -#define WATCHPOINT_SIZE_MASK                                                   \
> > > -     GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS)
> > > -#define WATCHPOINT_ADDR_MASK                                                   \
> > > -     GENMASK(BITS_PER_LONG-3 - WATCHPOINT_SIZE_BITS, 0)
> > > +/* Bitmasks for the encoded watchpoint access information. */
> > > +#define WATCHPOINT_WRITE_MASK        BIT(BITS_PER_LONG-1)
> > > +#define WATCHPOINT_SIZE_MASK GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
> > > +#define WATCHPOINT_ADDR_MASK GENMASK(BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS, 0)
> > > +static_assert(WATCHPOINT_ADDR_MASK == (1UL << WATCHPOINT_ADDR_BITS) - 1);
> >
> > Nit:
> >
> > Since you use the static_assert(), why not define WATCHPOINT_ADDR_MASK
> > as:
> >
> > #define WATCHPOINT_ADDR_MASK (BIT(WATCHPOINT_SIZE_BITS) - 1)
> 
> This is incorrect, as the static_assert()s would have indicated. It
> should probably be (BIT(WATCHPOINT_ADDR_BITS) - 1)?
> 
> As an aside, I explicitly did *not* want to use additional arithmetic
> to generate the masks but purely rely on BIT(), and GENMASK(), as it
> would be inconsistent otherwise. The static_assert()s then sanity
> check everything without BIT+GENMASK (because I've grown slightly
> paranoid about off-by-1s here). So I'd rather not start bikeshedding
> about which way around things should go.
> 
> In general, GENMASK() is safer, because subtracting 1 to get the mask
> doesn't always work, specifically e.g. (BIT(BITS_PER_LONG) - 1) does
> not work.
> 
> > Besides, WATCHPOINT_SIZE_MASK can also be defined as:
> 
> No, sorry it cannot.
> 
> > #define WATCHPOINT_SIZE_MASK GENMASK(BITS_PER_LONG - 2, WATCHPOINT_SIZE_BITS)
> 
>    GENMASK(BITS_PER_LONG - 2, WATCHPOINT_SIZE_BITS)
> 
> is not equivalent to the current
> 
>   GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
> 
> Did you mean GENMASK(BITS_PER_LONG-2, WATCHPOINT_ADDR_BITS)? I can

You're right! Guess I should check first about what vim completes for me
;-) And I agree with you on the preference to GENMASK()

> send a v2 for this one.

Let me add an ack for that one, thanks!

Regards,
Boqun

> 
> Thanks,
> -- Marco
