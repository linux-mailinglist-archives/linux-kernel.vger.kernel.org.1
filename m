Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179532D3CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgLIIGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbgLIIFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:05:51 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D743CC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 00:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8HsTtDLuWCXntoHuecpg9AJF1MlRfD2utdhXh6KHrB8=; b=ETOICxgfdCoPo+ISJtjI72Y1pA
        qA7SyLMrtn5pMLWfwYeRQXkV4LQcJtS2+/2kJNPH9tNiP2WjD05M7sbtkRgXFQ0eGCENshOMYd35v
        qNywizr0mCg9QwrpXYWBoSyQHBocpVGWT9GzFnQLFSXNjh6G7uzQDdXlXBzcXtl3dxIg=;
Received: from p200300ccff0981001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff09:8100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kmuT6-0002Qf-9h; Wed, 09 Dec 2020 09:05:00 +0100
Date:   Wed, 9 Dec 2020 09:04:59 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Message-ID: <20201209090459.60ecb5ea@aktux>
In-Reply-To: <ED67B0A3-1098-4B4C-A4F4-EE52B0E5F1E3@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
        <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com>
        <20201201121620.GB5239@sirena.org.uk>
        <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com>
        <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
        <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com>
        <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
        <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com>
        <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com>
        <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com>
        <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com>
        <A88317FA-52CC-41D3-B11A-BFAD36C35AE4@goldelico.com>
        <CAGngYiUPaR=_1NKZSjUQRK9+zUw3ztUpro7NV-O=sGAC2eOzUw@mail.gmail.com>
        <7702A943-FCC5-416B-B53A-3B0427458915@goldelico.com>
        <CACRpkdYgu+fyYm8aSCRuPeVe0EieyboZsWC=XsrRs5Tubog6nA@mail.gmail.com>
        <ED67B0A3-1098-4B4C-A4F4-EE52B0E5F1E3@goldelico.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 5 Dec 2020 08:04:25 +0100
"H. Nikolaus Schaller" <hns@goldelico.com> wrote:

> Hi Linus,
> 
> > Am 05.12.2020 um 01:25 schrieb Linus Walleij <linus.walleij@linaro.org>:
> > 
> > On Fri, Dec 4, 2020 at 5:52 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
> >   
> >> But what I don't know is if I can omit spi-cs-high and have to keep
> >> ACTIVE_HIGH (my revert patch) or also change to ACTIVE_LOW (my additional
> >> patch). This is arbitrary and someone has to decide what it should be.  
> > (...)  
> >> I'd prefer if you or maybe Linus could submit such a patch and I am happy to review it.  
> > 
> > It seems really ill-advised to have me do that since I have not
> > managed very well to deal with this. Clearly better developers
> > are needed. But I can review a patch and see if it makes me
> > smarter :) 
 
Hmm, if those developers are not available, then probably finding
those bugs has to be time-optimized, like establishing better automatic
display testing.

> 
> I find it interesting that so far nobody wants to take responsibility
> for a decision and to write down the behaviour really should be. Coding
> is the second step then.
> 
well, the interesting people are not involved yet (DTML) because no
patch is sent.

> Anyways you did not cite the really important part of my mail. So let me
> copy it back. Here it is again:
> 
> > What I can do is to provide just a skeleton for the table that you or Linus
> > can fix/fill in and make a patch out of it. Is attached and the ??? is
> > something you should discuss and define.  
> 
> Please take the attached diff, comment it here and define the question marks
> according to your intention and then make a patch for the YAML bindings out
> of it. (I can't do because I don't know your intentions and what to write into
> the commit message).
> 
Well, I the easiest step forward is just to document clearer how things
behave now, so the commit message is just something like

"Behavior of CS signal is not clearly documented, clarify the
documentation". And then send the patch to the proper mailing lists
including devicetree folks.

Regards,
Andreas

> As soon as we have settled this, we can check if code is correct and really
> define if my device tree fits and which change it needs exactly.
> 
> BR and thanks,
> Nikolaus
> 
> [slightly edited]
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> index 1b56d5e40f1f..4f8755dabecc 100644
> --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> @@ -42,6 +42,30 @@ properties:
>         cs2 : &gpio1 1 0
>         cs3 : &gpio1 2 0
> 
> +      The second flag of a gpio descriptor can be GPIO_ACTIVE_HIGH/0
> +      or GPIO_ACTIVE_LOW/1.
> +
> +      There is a special rule set for combining the second flag of an
> +      cs-gpio with the optional spi-cs-high flag for SPI slaves.
> +
> +      Each table entry defines how the CS pin is physically driven
> +      (not considering potential gpio inversions by pinmux):
> +
> +      device node     | cs-gpio       | CS pin state active | Note
> +      ================+===============+=====================+=====
> +      spi-cs-high     | -             | H                   |
> +      -               | -             | L                   |
> +      spi-cs-high     | ACTIVE_HIGH   | H                   |
> +      -               | ACTIVE_HIGH   | L (or H ???)        | 1
> +      spi-cs-high     | ACTIVE_LOW    | H (or L ???)        | 2
> +      -               | ACTIVE_LOW    | L                   |
> +
> +      Notes:
> +      1) should print a warning about polarity inversion
> +         because here it would be wise to define the gpio as ACTIVE_LOW
> +      2) could print a warning about polarity inversion
> +         because ACTIVE_LOW is overridden by spi-cs-high
> +      3) Effectively this rule defines that the ACTIVE level of the
> +         gpio has to be ignored
> +
>   num-cs:
>     $ref: /schemas/types.yaml#/definitions/uint32
>     description:
> 
> 
> 

