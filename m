Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4B72AFF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgKLFtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgKLFtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 00:49:46 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B197C0613D1;
        Wed, 11 Nov 2020 21:49:46 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q22so4314448qkq.6;
        Wed, 11 Nov 2020 21:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4a2oSB1VYPakWNSHoJzJAW0JkOV/UfRXeOLulthOs2A=;
        b=BpoMJ/zFwtaKZkXrXCWPYeFmFimpEX1DySUcOH0lLRwFsEcVV1lOgP9b6OMXD3Zfs9
         KDB7YwsP7DDbnTzf3DCCMgnMWXuoCFrYFMmeGVWilof8Y65AfxJtkfasPsf6arrZFUnf
         CtH6k4zMiHH1KSGn1A+HzkRDq1qhYaXl9HJuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4a2oSB1VYPakWNSHoJzJAW0JkOV/UfRXeOLulthOs2A=;
        b=if0z6pxPi/fNcIZEMkEt5VJImTQej9zV/AqZAwMRgNFMFjshULj/jSqER3R2BdIhB5
         SavEwoh5WXZ7gBSpZIInDV0tUc31vhaMEozB+zg2jvr+etP4Zk4Ghbr5gDBRoBQZeqao
         Br1Nv+Edap6+n1PrEhJ5MvxKqjoszJk7DadvYLrcl1P7x1AsB3M81HbOcAqUNQ50fD+1
         vEB0EEJowxvNIwUK2/AytMb4Q/42PbGGef+Uxe0KCEXD9H4yIRVBRdBS3PLDS0t9r70f
         6mI0FnrKzphsfTl7vct3yrBTM+LogGRg3vfHYuyjUEMcCvik9UdnClH9Qt4GGZU03J0/
         pv+g==
X-Gm-Message-State: AOAM531ZUsk6NvWypdQAQVzEpyDIjdEluC7TPgBoh4E1d1b9C/lFl+5L
        ZtuAi5Ygn+6SmtyOzF7DOI+PwAkp14FnMMNnbPc=
X-Google-Smtp-Source: ABdhPJxU7xvfiJ65YQ5ovY7yFDZRtlv6qHOAerJCI7Uj6w7moqYf46aVjZDaxwp39Bj/PBVIUX/RBZi88EVUBvOqsgg=
X-Received: by 2002:a37:664d:: with SMTP id a74mr20150207qkc.487.1605160185441;
 Wed, 11 Nov 2020 21:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20201111232330.30843-1-rentao.bupt@gmail.com> <CACPK8XdC8FRKOLQ9e583gVuDrL5829MOfx5L=O68dou6mjW_6g@mail.gmail.com>
 <20201112031828.GA4495@heinlein>
In-Reply-To: <20201112031828.GA4495@heinlein>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 12 Nov 2020 05:49:30 +0000
Message-ID: <CACPK8Xf07AZNb3K76sDsZDHNOPuhpkkUGST0=RTCTS5BXgncmA@mail.gmail.com>
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: Add Facebook Galaxy100 BMC
To:     Patrick Williams <patrick@stwcx.xyz>
Cc:     Tao Ren <rentao.bupt@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>, Tao Ren <taoren@fb.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 at 03:18, Patrick Williams <patrick@stwcx.xyz> wrote:
>
> On Wed, Nov 11, 2020 at 11:34:10PM +0000, Joel Stanley wrote:
> > On Wed, 11 Nov 2020 at 23:23, <rentao.bupt@gmail.com> wrote:
> > >
> > > From: Tao Ren <rentao.bupt@gmail.com>
> > >
> > > The patch series adds the initial version of device tree for Facebook
> > > Galaxy100 (AST2400) BMC.
> > >
> > > Patch #1 adds common dtsi to minimize duplicated device entries across
> > > Facebook Network AST2400 BMC device trees.
> > >
> > > Patch #2 simplfies Wedge40 device tree by using the common dtsi.
> > >
> > > Patch #3 simplfies Wedge100 device tree by using the common dtsi.
> > >
> > > Patch #4 adds the initial version of device tree for Facebook Galaxy100
> > > BMC.
> >
> > Nice. They look good to me.
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> >
> > Is there another person familiar with the design you would like to
> > review before I merge?
>
> Also,
>
> Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

Thanks. I have merged them into the aspeed tree for 5.11.

Cheers,

Joel
