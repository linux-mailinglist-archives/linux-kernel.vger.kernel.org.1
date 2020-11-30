Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7562C8746
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgK3O64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:58:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbgK3O64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:58:56 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 476BF20725;
        Mon, 30 Nov 2020 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606748295;
        bh=b/MCI1CHgTxdFgi97gwnhlTrwv0Lqog/dfBx21I6rPY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MAFqCo7H8oelm63xRjmLJsSNS0PcM2c5zVDJHFoVCxDahCB+3GXQ0kil3W4VFowMG
         h7oZdGWLnF+2I4cXX6PWdmXWkwE9mxGFeTtnHifjCfjoedILg6I1kpGyzBz3EqMlBN
         2MlqQPA6Rwi4gr+LVpEdyQMe5gzGMupyxSmmCB5c=
Received: by mail-ot1-f49.google.com with SMTP id t18so3069757otk.2;
        Mon, 30 Nov 2020 06:58:15 -0800 (PST)
X-Gm-Message-State: AOAM530hiH8SoucH6hvrWK0/YyEnOfMOHdUVre//psaRBBOj+n84ItQt
        6LYSbeTah8ZyICJpIhp3j4P8k2tUlIMr7zm5tHI=
X-Google-Smtp-Source: ABdhPJyEsDj83c39B/yKqumUg6NRPSWr9AkBO1DJNWG4L9CS8X2nKsDjX5Ek23PxYsaWYqXQRb7n4LpUaYFDGm6CwPc=
X-Received: by 2002:a9d:be1:: with SMTP id 88mr17243238oth.210.1606748294497;
 Mon, 30 Nov 2020 06:58:14 -0800 (PST)
MIME-Version: 1.0
References: <20201130131047.2648960-1-daniel@0x0f.com> <20201130131047.2648960-9-daniel@0x0f.com>
 <CAK8P3a2oqc51Aw7fyjW7t_zzRYX4Xxa7SS72faj7zvcZfyuaFg@mail.gmail.com> <CAFr9PXnkxBeujWFqVWfonEKEJ81ExnYcjr3jRMTBobGf9q2jsA@mail.gmail.com>
In-Reply-To: <CAFr9PXnkxBeujWFqVWfonEKEJ81ExnYcjr3jRMTBobGf9q2jsA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 30 Nov 2020 15:57:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2MC5m4PdmXnwjGw_oZinKU93LP+eYQ8qaCmH4EesH0Bw@mail.gmail.com>
Message-ID: <CAK8P3a2MC5m4PdmXnwjGw_oZinKU93LP+eYQ8qaCmH4EesH0Bw@mail.gmail.com>
Subject: Re: [PATCH 8/9] ARM: mstar: Add smp ctrl registers to infinity2m dtsi
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 3:11 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Hi Arnd,
>
> On Mon, 30 Nov 2020 at 22:44, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Mon, Nov 30, 2020 at 2:10 PM Daniel Palmer <daniel@0x0f.com> wrote:
> > >
> > > +&riu {
> > > +       smpctrl@204000 {
> > > +               compatible = "mstar,smpctrl";
> > > +               reg = <0x204000 0x200>;
> > > +               status = "okay";
> > > +       };
> >
> > You probably want some more specific compatible value, in case there are
> > multiple SoCs from mstar that have an smpctrl block and they don't all use
> > an exactly identical register layout.
>
> From what I can tell these are in the same place for the infinity2m and
> the other SMP chip in this series that are in the infinity6 series.
>
> Would "mstar,i2m-smpctrl" make more sense?

Please use the exact name of the chip for the most specific name,
plus a generic identifier that makes sense for all of them. For the
generic identifier, you can normally just use whatever the oldest
chip is that you can find with that IP block.

      Arnd
