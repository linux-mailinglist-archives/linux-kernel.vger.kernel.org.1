Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494782F324B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbhALN4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:56:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbhALN4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:56:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EA9523125;
        Tue, 12 Jan 2021 13:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610459719;
        bh=JtgDus3RlRKCNLMJU5n8LTJwheyPVPV3P1FCNE/3hDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UUHNrIoGgg39yGyWAmKBqQE3T7Nc2vpJdJBqK8PNMSXEC/xPTRzwN+q83W5WmsvJm
         ln71BYNMEsnE6Aim3WTmcVwKzctUfdolP5Rqd+9/3naBgHTyHhyOgb+mqxg+6zd7Cs
         l/vGKpCWAaRXoJHA2a2DqsdRxowq2yCYTiuJdVAxh1R6AfxkdNBJTQmX54HFH10bay
         NciPc0Sokd/GAfj9nIUG8jnMwkeqnFRUgpiEckP74+GRCvYfkeGTLqlCkW01kvD4qN
         6Bl7nz9Gc/eYPI72KeZk6mzYxH6IK8TFVU+tSg3xN2IX0Mk+HLc8Jrl3skKJcjZVh4
         MJzFKRHLHqmoQ==
Received: by mail-ot1-f54.google.com with SMTP id j20so2302257otq.5;
        Tue, 12 Jan 2021 05:55:19 -0800 (PST)
X-Gm-Message-State: AOAM532pvUPDbTcCmM3S70cMUinyCzMCGJhswaGvm6m/LueQWEyDGBRu
        Ku62uUqEZovcoDOmTrnHGXxrXekQZejvIJ6ZZuk=
X-Google-Smtp-Source: ABdhPJyjfW3VIxHOGv1CcXu0RcKWWw84/dtZP4ZYXG4Ahn9W5rp0DQ0WHXCtgyU0xjgg5DHlYP5JPWYtXgwzRqdK8IE=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr2830989otm.305.1610459718264;
 Tue, 12 Jan 2021 05:55:18 -0800 (PST)
MIME-Version: 1.0
References: <20210112015602.497-1-thunder.leizhen@huawei.com>
 <20210112015602.497-3-thunder.leizhen@huawei.com> <CAK8P3a0VcLtOrvXKEd2dDuP8HhKzU+uB0U6OiJXtefQQYjTheg@mail.gmail.com>
 <a11515e2-1fc6-be7d-f50c-8e3ad20f9e6c@huawei.com>
In-Reply-To: <a11515e2-1fc6-be7d-f50c-8e3ad20f9e6c@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 12 Jan 2021 14:55:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1jcg3CEP0QhtTP4gES9MHLdrHPZffkSxtxbr78FScrrg@mail.gmail.com>
Message-ID: <CAK8P3a1jcg3CEP0QhtTP4gES9MHLdrHPZffkSxtxbr78FScrrg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: hisilicon: Add binding for L3
 cache controller
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 1:35 PM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
> On 2021/1/12 16:46, Arnd Bergmann wrote:
> > On Tue, Jan 12, 2021 at 2:56 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> >
> >> +---
> >> +$id: http://devicetree.org/schemas/arm/hisilicon/l3cache.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Hisilicon L3 cache controller
> >> +
> >> +maintainers:
> >> +  - Wei Xu <xuwei5@hisilicon.com>
> >> +
> >> +description: |
> >> +  The Hisilicon L3 outer cache controller supports a maximum of 36-bit physical
> >> +  addresses. The data cached in the L3 outer cache can be operated based on the
> >> +  physical address range or the entire cache.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    items:
> >> +      - const: hisilicon,l3cache
> >> +
> >
> > The compatible string needs to be a little more specific, I'm sure
> > you cannot guarantee that this is the only L3 cache controller ever
> > designed in the past or future by HiSilicon.
> >
> > Normally when you have an IP block that is itself unnamed but that is specific
> > to one or a few SoCs but that has no na, the convention is to include the name
> > of the first SoC that contained it.
>
> Right, thanks for your suggestion, I will rename it to "hisilicon,hi1381-l3cache"
> and "hisilicon,hi1215-l3cache".

Sounds good.

> > Can you share which products actually use this L3 cache controller?
>
> This L3 cache controller is used on Hi1381 and Hi1215 board. I don't know where
> these two boards are used. Our company is too large. Software is delivered level
> by level. I'm only involved in the Kernel-related part.
>
> >
> > On a related note, what does the memory map look like on this chip?
>
> memory@a00000 {
>      device_type = "memory";
>      reg = <0x0 0xa00000 0x0 0x1aa00000>, <0x1 0xe0000000 0x0 0x1d000000>, <0x0 0x1f400000 0x0 0xb5c00000>;
> };
>
> Currently, the DTS is being maintained by ourselves, I'll try to upstream it later.
>
> > Do you support more than 4GB of total installed memory? If you
>
> Currently, the total size does not exceed 4 GB. However, the physical address is wider than 32 bits.

Ok, so it appears that the memory is actually contiguous in the first
3.5GB (with a few holes), plus the remaining 0.5GB being offset in
the physical memory by 4GB (starting at 0x1e0000000 instead of
0xe0000000), presumably to allow the use of 32-bit DMA addresses.

This works fine for the moment, but it does require support for
a nonlinear virt_to_phys()/phys_to_virt() translation after highmem
gets removed, and you would get at most 3.75GB anyway, so it
might be easier at that point to just drop the entire last block at
0x1e0000000, but this will depend on how well we get the 4G:4G
code to work, and whether the users will still need kernel updates for
this platform then.

     Arnd
