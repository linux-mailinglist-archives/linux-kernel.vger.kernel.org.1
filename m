Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52412883BB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 09:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbgJIHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 03:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730797AbgJIHhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 03:37:52 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C480C2227F;
        Fri,  9 Oct 2020 07:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602229071;
        bh=uwHGsExUwomnGZGAB9Ig2cy91/4zjXFRWuSoOtt/2uc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hr/EfPQdRr7YOMI/Ml+6/nicYKOq2pzsRkwJDK4QOWHasA7h3oiXAIpK8Icq9k0cv
         B+Pr4QjjAsu4RyNsMNzqa5+CA1tTcrgTjx2kn0DhJTQgTTn8izNoFlcMq6d6kgu0vn
         6IJ/b+FrCQ4BlPeeC2xEElSxY1bwAgxst0UX0QZs=
Received: by mail-ot1-f43.google.com with SMTP id t15so8221341otk.0;
        Fri, 09 Oct 2020 00:37:51 -0700 (PDT)
X-Gm-Message-State: AOAM530+uVUm1XCA+uDCpdVKBCrQXmLUvJIzyI1k4EW6mbiT1WfLZlx4
        m/RGNLdnCGnALb3h5jUVO08WY+cXqZG17+mpcVQ=
X-Google-Smtp-Source: ABdhPJwm7Itaee4mU5h+ix4hYGBefWmG86wT+rm9HR2eTuMvzP6PBTs811cyWxyuLFCA+ubq6YIJxYBgULsTYR7jHG8=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr8311994otq.77.1602229071004;
 Fri, 09 Oct 2020 00:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201001161740.29064-1-nsaenzjulienne@suse.de>
 <20201001161740.29064-2-nsaenzjulienne@suse.de> <20201001171500.GN21544@gaia>
 <20201001172320.GQ21544@gaia> <b47232e2173e9e5ddf8f5be4c7b5a2f897f34eb7.camel@suse.de>
 <20201002115541.GC7034@gaia> <12f33d487eabd626db4c07ded5a1447795eed355.camel@suse.de>
 <20201009071013.GA12208@lst.de>
In-Reply-To: <20201009071013.GA12208@lst.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 9 Oct 2020 09:37:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
Message-ID: <CAMj1kXG+7Lq=rgUfyU_XS9LrJwpUiC8nKsRPom+R0=phuXioHQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] of/fdt: Update zone_dma_bits when running in bcm2711
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020 at 09:11, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Oct 08, 2020 at 12:05:25PM +0200, Nicolas Saenz Julienne wrote:
> > Sadly I just realised that the series is incomplete, we have RPi4 users that
> > want to boot unsing ACPI, and this series would break things for them. I'll
> > have a word with them to see what we can do for their use-case.
>
> Stupid question:  why do these users insist on a totally unsuitable
> interface?  And why would we as Linux developers care to support such
> a aims?
>

The point is really whether we want to revert changes in Linux that
made both DT and ACPI boot work without quirks on RPi4. Having to
check the RPi4 compatible string or OEM id in core init code is awful,
regardless of whether you boot via ACPI or via DT.

The problem with this hardware is that it uses a DMA mask which is
narrower than 32, and the arm64 kernel is simply not set up to deal
with that at all. On DT, we have DMA ranges properties and the likes
to describe such limitations, on ACPI we have _DMA methods as well as
DMA range attributes in the IORT, both of which are now handled
correctly. So all the information is there, we just have to figure out
how to consume it early on.

Interestingly, this limitation always existed in the SoC, but it
wasn't until they started shipping it with more than 1 GB of DRAM that
it became a problem. This means issues like this could resurface in
the future with existing SoCs when they get shipped with more memory,
and so I would prefer fixing this in a generic way.

Also, I assume papering over the issue like this does not fix the
kdump issue fundamentally, it just works around it, and so we might
run into this again in the future.
