Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A362E75A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 03:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgL3CRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 21:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgL3CRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 21:17:07 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE54CC061799
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 18:16:26 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id 7so10230775qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 18:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4rO7Co7WzIAwVSZ8ozsY8HDb9mFde5EJnTF+blPVPzY=;
        b=oEZHg6vvmpcKi6d3ukkihO+h7vAEsVhPC2dmvABehsnEB28zdRVikdubDHGTnLxv9V
         C/Xct1axEznRTHbBUhRvFt8//nsX8ZWK2piX7YiPkXsQqbZEPDUSDfax1Vvjhnb93NIs
         uIp1kgrPR0T4TyevE3MMeESW29rxL3YeaUk/Y6Gv4I5xh8QTEUdPY+n7KIhoOZIRKi9R
         1SCTAbQmg/n6rD5F3azAh4Ry9klP3wk4t9OjXMmkW4MIMOTq0eA90VmUesab8D50R7T0
         wuIh/VdzLJkOWbLI08ZrxI8AKYqzrMsf/Scn8eN7ag/peyYO+lewLdxfY2AvnqG4Q79S
         i76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4rO7Co7WzIAwVSZ8ozsY8HDb9mFde5EJnTF+blPVPzY=;
        b=JLfyjHJjVg9uR8CULsvWxf6m/3OhqDToNQPi2Ele4ugJ/0WWsAOn2yQrECCt7pONEM
         pg+o1iCw+DHDrjt/Ls7KvOB9Os4IAgoy9d0mvVA6b2K8vKj2wygfirLadyHNonZn8hoH
         s7fnpOHw4NGs/D9R2RS/3LvLltiLuQFBPrHcHwBE8nzZSGbiMi6LC2DUUkqtrbp2FEKk
         ozu/FdXtuUTUcWEe3HB3SjeyAcVnDyOz7Bri3r7DFC30covy9q6xqS6CVn7a+YbyWF/N
         drzf+NmFX7vzeJ4b3cue6aWy0votKjktS+jbgi5TKs3TL44vpkKsNlFNMFGa6EbqD2+F
         GxLA==
X-Gm-Message-State: AOAM530LNqnIUrKRQgksZWg/YeB5MFpBK/6nXs/x3PU2QocoxrN199OL
        rJA/x3Lb3LfslhuEXL+4gG58AGBrfeIj/nsbsPKu0vHVHo17Yg==
X-Google-Smtp-Source: ABdhPJyz+fwefS0eTEh7UeBxDQf1zgFD529BZRyjo1viUtlvab9/fTHFXwt+oS/6y8cDAo8M+voe6sti5z4VD836ZQw=
X-Received: by 2002:ac8:5745:: with SMTP id 5mr50874850qtx.131.1609294586096;
 Tue, 29 Dec 2020 18:16:26 -0800 (PST)
MIME-Version: 1.0
References: <1609226114-32933-1-git-send-email-yejune.deng@gmail.com> <36538faa77fd0e34f559ec547b983c72@kernel.org>
In-Reply-To: <36538faa77fd0e34f559ec547b983c72@kernel.org>
From:   Yejune Deng <yejune.deng@gmail.com>
Date:   Wed, 30 Dec 2020 10:16:14 +0800
Message-ID: <CABWKuGUar=8HYkkS-KGjN_TB4NAh6+cSspk8J=sB+sZ70VyscQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/gic: add WARN_ON() to facilitate backtracking
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK=EF=BC=8CI will adopt it and resubmit.

On Tue, Dec 29, 2020 at 5:27 PM Marc Zyngier <maz@kernel.org> wrote:
>
> Yejune,
>
> On 2020-12-29 07:15, Yejune Deng wrote:
> > There is two function gic_of_init() and gic_of_init_child() called
> > gic_of_setup(),so add WARN_ON() to facilitate backtracking.
> >
> > Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> > ---
> >  drivers/irqchip/irq-gic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> > index b1d9c22..7c11705 100644
> > --- a/drivers/irqchip/irq-gic.c
> > +++ b/drivers/irqchip/irq-gic.c
> > @@ -1380,7 +1380,7 @@ static bool gic_check_eoimode(struct device_node
> > *node, void __iomem **base)
> >
> >  static int gic_of_setup(struct gic_chip_data *gic, struct device_node
> > *node)
> >  {
> > -     if (!gic || !node)
> > +     if (WARN_ON(!gic || !node))
> >               return -EINVAL;
> >
> >       gic->raw_dist_base =3D of_iomap(node, 0);
>
> I don't immediately see what you gain with this. If you end-up here
> with NULL pointers, that either because:
>
> - you have failed to allocate the GIC private data structure:
>    but as it turns out, these allocations either cannot fail (gic_data[]
>    is static), or the dynamic allocation in gic_of_init_child() is
> already
>    checked.
>
> - node is NULL: both paths already check for a NULL node, so that cannot
>    fail either.
>
> My conclusion is that these checks can never trigger, and we should be
> able to *remove* them altogether.
>
> Am I missing something?
>
>          M.
> --
> Jazz is not dead. It just smells funny...
