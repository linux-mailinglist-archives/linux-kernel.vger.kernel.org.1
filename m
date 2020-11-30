Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33642C8827
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgK3PhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:37:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbgK3PhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:37:02 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A726207F7;
        Mon, 30 Nov 2020 15:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606750580;
        bh=LzsPK0L9PUxgZ6Z+37fS4TS1uDQ2SzZG9WCwz1ZOsgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mXcLdHi6/vI0ZnBL6aMniEUMTAcGPibdZXYZIGd4FwUOv6Kp8ngTcEugAxRct5IU0
         XrDAIX5lEawYz8bjbG2kkwo7hFFava230fTsjpBiZ7nFGznkf3kIM+3WXy5gIlAPov
         Xb/02fkxekRvwz/ZugD64UozkzQFjFdmxQsMw6DU=
Received: by mail-ej1-f50.google.com with SMTP id x16so15466091ejj.7;
        Mon, 30 Nov 2020 07:36:20 -0800 (PST)
X-Gm-Message-State: AOAM532y8JDvRCAxNBlHxZGDqMMZrgIASuJTd14JSNGpAUDDSp2ht8uT
        ClRIKAZiZlYKlFI8k97vlu1QcamOyxeFYSg+PA==
X-Google-Smtp-Source: ABdhPJxWrvafzpbFRaZpB7xhU0lMwNaXi8tL7tYdUxlmVXzNWJKkwJnGaiNrJS+0OBFJq4dDKn0z8a9HVtiXLS5lu1U=
X-Received: by 2002:a17:906:a418:: with SMTP id l24mr8806944ejz.360.1606750578769;
 Mon, 30 Nov 2020 07:36:18 -0800 (PST)
MIME-Version: 1.0
References: <1605172274-44916-1-git-send-email-yash.shah@sifive.com>
 <20201121125443.GA2076465@robh.at.kernel.org> <BY5PR13MB445328314FB3521DE257C57782FC0@BY5PR13MB4453.namprd13.prod.outlook.com>
In-Reply-To: <BY5PR13MB445328314FB3521DE257C57782FC0@BY5PR13MB4453.namprd13.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Nov 2020 08:36:06 -0700
X-Gmail-Original-Message-ID: <CAL_JsqLy8kVNcMwkHCXRPvazrRmX+mfUmD4iwAAFvna+1zRaXg@mail.gmail.com>
Message-ID: <CAL_JsqLy8kVNcMwkHCXRPvazrRmX+mfUmD4iwAAFvna+1zRaXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Update l2 cache DT documentation to add
 support for SiFive FU740
To:     Yash Shah <yash.shah@openfive.com>
Cc:     "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        Sagar Kadam <sagar.kadam@openfive.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "bp@suse.de" <bp@suse.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@openfive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 3:32 AM Yash Shah <yash.shah@openfive.com> wrote:
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: 21 November 2020 18:25
> > To: Yash Shah <yash.shah@openfive.com>
> > Cc: Paul Walmsley ( Sifive) <paul.walmsley@sifive.com>;
> > palmer@dabbelt.com; aou@eecs.berkeley.edu;
> > Jonathan.Cameron@huawei.com; wsa@kernel.org; sam@ravnborg.org;
> > Sagar Kadam <sagar.kadam@openfive.com>; anup@brainfault.org;
> > bp@suse.de; devicetree@vger.kernel.org; linux-riscv@lists.infradead.org;
> > linux-kernel@vger.kernel.org; Sachin Ghadi <sachin.ghadi@openfive.com>
> > Subject: Re: [PATCH 1/2] RISC-V: Update l2 cache DT documentation to add
> > support for SiFive FU740
> >
> > [External Email] Do not click links or attachments unless you recognize the
> > sender and know the content is safe
> >
> > On Thu, Nov 12, 2020 at 02:41:13PM +0530, Yash Shah wrote:
> > > The L2 cache controller in SiFive FU740 has 4 ECC interrupt sources as
> > > compared to 3 in FU540. Update the DT documentation accordingly with
> > > "compatible" and "interrupt" property changes.
> > >
> > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > ---
> > >  .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 33
> > > +++++++++++++++++-----
> > >  1 file changed, 26 insertions(+), 7 deletions(-)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > > b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > > index efc0198..4873d5c 100644
> > > --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
>
> <...>
>
> > > @@ -51,12 +54,6 @@ properties:
> > >
> > >    cache-unified: true
> > >
> > > -  interrupts:
> > > -    description: |
> > > -      Must contain entries for DirError, DataError and DataFail signals.
> > > -    minItems: 3
> > > -    maxItems: 3
> >
> > Keep this here and just change maxItems to 4. Really, what each interrupt is
> > should be listed out as an 'items' entry.
> >
>
> Sure will send a v2 with the above modifications.
>
> <...>
>
> >
> > > +
> > > +else:
> > > +  properties:
> > > +    interrupts:
> > > +      description: |
> > > +        Must contain entries for DirError, DirFail, DataError, DataFail signals.
> >
> > DirFail should be last so you keep the same indices.
>
> Actually, the interrupts have been numbered like that in FU740 SoCs and the driver expects the interrupts to be in this order.
> I will keep the same order for v2 as well. Let me know if you still disagree.

Numbered within the cache block or the interrupt controller? If the
former, then fine. The latter would be outside the scope of the
binding. Another SoC could hook up interrupts differently.

It's going to be easier for the driver to deal with 1 new irq index
rather than 2 whole sets of different indices, but if you want to do
it the hard way...

Rob
