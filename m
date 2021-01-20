Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677C72FCE1F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbhATKR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731595AbhATJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:40:11 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C81C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:39:30 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s11so17661891edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M02M4vY/73I1o0pHPZPaDHowhdEnpk4jaG+nDUhmK0Q=;
        b=Sv51ODuHZp+gbzZ475xDvy7TK+pCmrNxsAmue7LbBis9z6OrfvX7dONJFdZuONZlc5
         6aRQHxmXP7/H5K/Imq2SM7/GabnVOLrDbe1xsYp/XNnFn69XShzzJ91id6m2EeS4Y3Kz
         rbtp9GSfGBCe8AChDt4s7qPYvu4i6TQzmDoDQl7XTswKX45UscoXXUVlP/DdGk//oewf
         HkO/V2/27pFoeaZDdncn+9nWxc2kpBwB9EJBhOxrtirtGJfzEeKxAkVRVy5+cl21FeUt
         N2YDE44k+SlQ+JefAx1CJ4cIm9UaCFEjfke+q8HzImeb+oeen2G+H17cCxSiRFQLI5/P
         5Ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M02M4vY/73I1o0pHPZPaDHowhdEnpk4jaG+nDUhmK0Q=;
        b=CvDTdhAzAMEfuPayFfh+nqBIdMOi6bUa4fqLFAWlJCe5avRbvxi/7W3jvYw4Xhe4ST
         u4Qi43Doh08FNIzUYalP892pZwQbM5WOVRIhrvDbVlZDztO0DiW3f0dvLdQdGvbLS9qB
         tCynJRKWFiuM9UDszR9an9DSfFhJT7rSe5mWKqZWEZJ1n7NvzdVsBLEuA0xOqKBIXS/J
         jPP764s5gG0UZQ6hxMXU0h7E94eNaOzZHaLCX26PscIgD8ggkZhwEPC+BsoIjR2ikyqf
         b3JohCnq8Pvkojl4Fly9SsCtMHvSYqE48CWZwD+pSGp/lbYyzjPdEnBmtJWCiYmffIb4
         LSRA==
X-Gm-Message-State: AOAM531/cUEQNTlr8PoMxQ9LUHYsyW2GnNCpomxeANQWcvSYagvWR9aF
        qY7tqMTiSXVDRSplr0MXgMc2p61wHYmeGG6WQGTpAw==
X-Google-Smtp-Source: ABdhPJzLurKwE2+XAnKXso4/n6qvcwtwwSCLDad7Ih+sHBjY9o5r59BNkd4F8KylyYHvgvU0+edqSEGg2e9PdtkIK0s=
X-Received: by 2002:aa7:c3d3:: with SMTP id l19mr6863124edr.366.1611135568961;
 Wed, 20 Jan 2021 01:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20210119102757.2395-1-dnlplm@gmail.com> <20210119220619.GA2510101@bjorn-Precision-5520>
In-Reply-To: <20210119220619.GA2510101@bjorn-Precision-5520>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 20 Jan 2021 10:46:34 +0100
Message-ID: <CAMZdPi9mNOb4w-Q2MH9dt9cuCFPiiJ2PUWczSdtG-LE8Qp8xvg@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: add Telit Vendor ID
To:     Daniele Palmas <dnlplm@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniele,

On Tue, 19 Jan 2021 at 23:06, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jan 19, 2021 at 11:27:57AM +0100, Daniele Palmas wrote:
> > Add Telit Vendor ID to pci_ids.h
>
> From the top of the file:
>
>  *      Do not add new entries to this file unless the definitions
>  *      are shared between multiple drivers.
>
> If this is the case, include this patch in a series that adds multiple
> uses or mention the uses in this commit log.

Ok, in that case, you can add this define directly in mhi_pci_generic
along with a new entry for matching the sub-vendor/device IDs of your
module.

Regards,
Loic

>
> > Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
> > ---
> > Reference: https://pcisig.com/membership/member-companies?combine=telit
> > ---
> >  include/linux/pci_ids.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index d8156a5dbee8..b10a04783287 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2590,6 +2590,8 @@
> >
> >  #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS  0x1c36
> >
> > +#define PCI_VENDOR_ID_TELIT          0x1c5d
> > +
> >  #define PCI_VENDOR_ID_CIRCUITCO              0x1cc8
> >  #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD       0x0001
> >
> > --
> > 2.17.1
> >
