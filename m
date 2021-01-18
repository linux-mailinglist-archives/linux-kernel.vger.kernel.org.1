Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9EE2FAC70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438007AbhARVSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438031AbhARVQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 16:16:45 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EE2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 13:15:57 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id be12so9304129plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 13:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n6ccMeFbQ5o+gz4ZLG3v85J3POpNhHyS8cqYFbBY9Nw=;
        b=Okf4zD4ZvjiKYhpxXhqvo/q91mDIgDpEHaknqMjRYq1Tj9eADuXtzDZk5pnS5f3Zho
         Uz68jsEh3R4KogqWJLEyahcGkTlCvOV48aUER2+r3FYHhsVqRMQIJQV5PtE5OQsFaNEO
         7WYGMCe+NER8LcHV3UGe+Mx0sGkfGq0sA8ct+ITT2MfSk6QT27Uuu49rxlUWTomZC7V4
         1bpIzqUBl72XiW+F7lUO9+0Wx8pSjOdbZ2YWIQN+EsPROjqscc5+9nfZ1aAoI/gvQjgM
         j5FZA7vJXIxDMKVeTk99MIpNJyI5fLHi3MHpnOlz76BHZF6PbjuFxJQxNnMhL5NZcz5x
         FMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6ccMeFbQ5o+gz4ZLG3v85J3POpNhHyS8cqYFbBY9Nw=;
        b=fJhROgBsXMZMLevtLxn0bt+rG/eNe1Pu5SUAiyienzZ72r+ZQpqUhP7lSA0fXWVApc
         47nGzvv9nod5esfs9Zx0LXi6SgW4A9TWn0QiiPE/CvdXOg46UU3PYqHPsQDBYPpXqS5m
         fW2T1lV3KXpWRPNu5rXq84wboot+If9KOFbcyGqateHZd3/MV1BGvweN3kq2Qc0aYyAa
         pCpEHKOJTFZ9dPXm8p0DmCC9APO+jUjPOMYfL1bwOUHjeKzxJnK+ZyXRa+bOr5itscGI
         KqKziGfjLX1Z+j0Y49OyLzGaFzMkLPPhjpNTEER3ANC+L9DK5F33stvjGAhyAj0fWfQb
         vHPw==
X-Gm-Message-State: AOAM530Dvf00dDNeyCM+YGN/BedqptCj8rsLpeMcgm0MYU3/bixsWk5x
        Qf6wF/6zPZTqb5SDf0pC2Ng=
X-Google-Smtp-Source: ABdhPJwr7otRnwzmlhyKKc7fxrw9vPkypltSjfr/FJoMTsNeIkowL9MfQnTdO/GY8z8Orr5F5OxWAg==
X-Received: by 2002:a17:902:7149:b029:db:a6de:4965 with SMTP id u9-20020a1709027149b02900dba6de4965mr1324421plm.3.1611004557389;
        Mon, 18 Jan 2021 13:15:57 -0800 (PST)
Received: from localhost (g238.115-65-210.ppp.wakwak.ne.jp. [115.65.210.238])
        by smtp.gmail.com with ESMTPSA id i62sm10487833pfc.150.2021.01.18.13.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 13:15:56 -0800 (PST)
Date:   Tue, 19 Jan 2021 06:15:54 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2] drivers/soc/litex: Add restart handler
Message-ID: <20210118211554.GH2002709@lianli.shorne-pla.net>
References: <20210104164500.1311091-1-geert@linux-m68k.org>
 <CAMuHMdXG_B-3y1MWh64T6LU3Gmo6UQGGWU8EbLApjDeXVLL3GQ@mail.gmail.com>
 <20210114020311.GE2002709@lianli.shorne-pla.net>
 <CAMuHMdWnrPBAh_U43C7jA8wDvyAegqCM3OP++NkkiT1Co5yjkQ@mail.gmail.com>
 <20210118114331.GF2002709@lianli.shorne-pla.net>
 <CAMuHMdUxAEE2A=dyhdH5Tscin_=m_b61WfRpLvj6pJfdPjd1nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUxAEE2A=dyhdH5Tscin_=m_b61WfRpLvj6pJfdPjd1nA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 01:27:32PM +0100, Geert Uytterhoeven wrote:
> Hi Stafford,
> 
> On Mon, Jan 18, 2021 at 12:43 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Thu, Jan 14, 2021 at 02:48:49PM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Jan 14, 2021 at 3:03 AM Stafford Horne <shorne@gmail.com> wrote:
> > > > On Mon, Jan 04, 2021 at 05:49:03PM +0100, Geert Uytterhoeven wrote:
> > > > > On Mon, Jan 4, 2021 at 5:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > Let the LiteX SoC Controller a register a restart handler, which resets

I think there is a typo here:

  Let the LiteX SoC Controller a register a restart ...

should remove the first 'a' and say

 Let the LiteX SoC Controller register a restart ...

> > > > > > the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
> > > > > >
> > > > > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > ---
> > > > > > Tested with linux-on-litex-vexriscv.
> > > > > >
> > > > > > This patch is based on upstream, i.e. not on top of Gabriel Somlo's
> > > > > > "[PATCH v5 0/4] drivers/soc/litex: support 32-bit subregisters, 64-bit
> > > > > > CPUs"
> > > > > > (https://lore.kernel.org/lkml/20201227161320.2194830-1-gsomlo@gmail.com/)
> > > > >
> > > > > Bummer, and that's why the RESET_REG_* definitions are no longer
> > > > > next to the SCRATCH_REG_* definitions :-(
> > > >
> > > > If it helps I have accepted Gabriel's patches and put them onto for-next.
> > > >
> > > >   https://github.com/openrisc/linux/commits/for-next
> > > >
> > > > I am happy to take and test a patch based on that.  Or I can do the adjustments
> > > > to base the patch on that myself.  Let me know.
> > >
> > > Thanks for letting me know! V3 sent.
> >
> > Hi Geert,
> >
> > I don't seem to see v3 anywhere.  Where did you send it and what is the subject?
> 
> https://lore.kernel.org/linux-riscv/20210114134813.2238587-1-geert@linux-m68k.org/
> 
> So "b4 am 20210114134813.2238587-1-geert@linux-m68k.org" should give you
> a copy.

Thanks I got it, I am not sure why it does not show up in my inbox anywhere,
sometimes gmail drops mails.  Hence, I am replying here.

As per the typo above I can fix during applying or you could send during a v4.

One more small nit is that you move soc_ctrl_dev out to a static instance it
might help to mention.  But it's easy to see why.

-Stafford
