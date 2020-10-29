Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE6429EB05
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgJ2Lx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgJ2Lx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:53:28 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 820CB20838
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 11:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603972407;
        bh=MjO/w8dLadPJO8+mgZEz2PmE6+PcETiEPBl3XbddTNU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dRAdWSNxaeoTpEj8ap8c12XBqypxZXbdObNzss4wOkm8t6QBuRKJgeidTG8xQ2vOD
         0rFK1+mcQOGPjE18kCeiqqCeUcXdrp+9GRx44+dYOAH28SKOSjcCfUbXZOE7SDlQlj
         xsjFiLVPhLqC0r0Bn7X+zKqnUKdesTgvSbYTTw8A=
Received: by mail-qk1-f178.google.com with SMTP id r7so1727072qkf.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 04:53:27 -0700 (PDT)
X-Gm-Message-State: AOAM530lnw8MsePk1DA1IZRfWAvgMXA9zrf97h7Vqd+UWNV78LJq0NDZ
        JrSJeXo3+I1qzrRQkce1xhW98yKflwQuWC2pSzA=
X-Google-Smtp-Source: ABdhPJyrF9HRuhB8NCT6MXOZyMdOFceqoDOKhNXS4DhX309opkS8RN3D5h4K35F8wuUOnFDT3t9hGAmZ47pPyWVOXkU=
X-Received: by 2002:a05:620a:22c9:: with SMTP id o9mr3287427qki.286.1603972405589;
 Thu, 29 Oct 2020 04:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201023092650.GB29066@infradead.org> <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027062802.GC207971@kroah.com> <VI1PR04MB4960C0E76374B2775D99A82192160@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027151106.e4skr6dsbwvo4al6@axis.com> <VI1PR04MB49603783EF3FD3F3635FCDAF92170@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <93bd1c60ea4d910489a7592200856eaf8022ced0.camel@intel.com>
 <AM0PR04MB4947F01860DE953B8496FA8892170@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <CAK8P3a1JRx32VfFcwFpK0i6F5MQMCK-yCKw8=d_R08Y3iQ7wLQ@mail.gmail.com>
 <CAK8P3a3u06ZHdAb_n3byTqfxAvy_wi48X1g0N4ODuH2uEM0xLA@mail.gmail.com> <20201029100727.trbppgbusd5vogpz@axis.com>
In-Reply-To: <20201029100727.trbppgbusd5vogpz@axis.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 29 Oct 2020 12:53:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3T2Riy-vfd8RcdWeeER4usc2m78rkmx4Q_8N3zGA6r_A@mail.gmail.com>
Message-ID: <CAK8P3a3T2Riy-vfd8RcdWeeER4usc2m78rkmx4Q_8N3zGA6r_A@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used ring
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Sherry Sun <sherry.sun@nxp.com>,
        "Dutt, Sudeep" <sudeep.dutt@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:07 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Wed, Oct 28, 2020 at 04:50:36PM +0100, Arnd Bergmann wrote:
> > I think we should try to do something on top of the PCIe endpoint subsystem
> > to make it work across arbitrary combinations of host and device
> > implementations,
> > and provide a superset of what the MIC driver, (out-of-tree) Bluefield endpoint
> > driver, and the NTB subsystem as well as a couple of others used to do,
> > each of them tunneling block/network/serial/... over a PCIe link of some
> > sort, usually with virtio.
>
> VOP is not PCIe-specific (as demonstrated by the vop-loopback patches I
> posted a while ago [1]), and it would be a shame for a replacement to be
> tied to the PCIe endpoint subsystem.  There are many SOCs out there
> which have multiple Linux-capable processors without cache-coherency
> between them.  VOP is (or should I say was since I guess it's being
> deleted) the closest we have in mainline to easily get generic virtio
> (and not just rpmsg) running between these kind of Linux instances.  If
> a new replacement framework were to be PCIe-exclusive then we'd have to
> invent one more framework for non-PCIe links to do pretty much the same
> thing.
>
> [1] https://lore.kernel.org/lkml/20190403104746.16063-1-vincent.whitchurch@axis.com/

Right, sorry I forgot about that. I think this means we should keep having
an abstraction between VOP (under whichever name) and the lower levels,
and be aware that it might run on any number of these:

- PCIe endpoint, with the endpoint controlling the virtio configuration
- PCIe endpoint, with the host (the side that has the pci_driver) controlling
  the virtio configuration
- NTB connections
- your  loopback mode
- Virtio tunnels between VM guests (see https://www.linaro.org/projects/#STR)
- Intel MIC (to be removed, but it would be wrong to make assumptions that
  cannot be made on that type of hardware)
- ...

The existing VOP codebase does look like a reasonable start, though
I think we need to discuss whether the ioctl interface should be
replaced with a configfs interface, and what other changes would
be needed to make it support the generalized hardware case.

       Arnd
