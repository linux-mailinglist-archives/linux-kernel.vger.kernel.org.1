Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BFC29EDAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 14:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgJ2Ny4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 09:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgJ2Nyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 09:54:55 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0EF20825
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603979694;
        bh=1ANRlVoC4oc0lkbRKU8wnq7MF9OsR9WaKuPX3Cj5i9A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lBOtG/P0fnS53uEWstzEOsaf6sF8kkFOIdkSMWEpXf7dEoshMZH7h/iAcSqdr7Me0
         DYNZf5t9xXr2VpbpotBNn6ftRuPuw4vBU2AMR4D+pt2HRApaMXvoIyW2tSjT2CgwrK
         oaAX7VUO4Ji3Rc+h5u1OegJVrtsOw8TCeUml6pXI=
Received: by mail-qv1-f46.google.com with SMTP id w9so1368667qvj.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 06:54:54 -0700 (PDT)
X-Gm-Message-State: AOAM532nFas/zSQziQ0uu7jM1XqWU/YKDKedt0fQP6eFo1bjR+LrDkjw
        FLBMplPoK4LK0sYHn2wszfDOVXCC4Rv39uaYqsQ=
X-Google-Smtp-Source: ABdhPJxn8R/mToGpaGrOgoAMWUjysLAb++20PByhOgLH+QGelMxT49ZVpmYKT1GeLnTuyQB0EX/xv1DJLj/oF2ByiMM=
X-Received: by 2002:a0c:c187:: with SMTP id n7mr4614787qvh.19.1603979693670;
 Thu, 29 Oct 2020 06:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201023092650.GB29066@infradead.org> <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027062802.GC207971@kroah.com> <VI1PR04MB4960C0E76374B2775D99A82192160@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027151106.e4skr6dsbwvo4al6@axis.com> <VI1PR04MB49603783EF3FD3F3635FCDAF92170@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <93bd1c60ea4d910489a7592200856eaf8022ced0.camel@intel.com>
 <AM0PR04MB4947F01860DE953B8496FA8892170@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <CAK8P3a1JRx32VfFcwFpK0i6F5MQMCK-yCKw8=d_R08Y3iQ7wLQ@mail.gmail.com>
 <CAK8P3a3u06ZHdAb_n3byTqfxAvy_wi48X1g0N4ODuH2uEM0xLA@mail.gmail.com>
 <20201029100727.trbppgbusd5vogpz@axis.com> <CAK8P3a3T2Riy-vfd8RcdWeeER4usc2m78rkmx4Q_8N3zGA6r_A@mail.gmail.com>
 <87mu05f94g.wl-ashutosh.dixit@intel.com>
In-Reply-To: <87mu05f94g.wl-ashutosh.dixit@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 29 Oct 2020 14:54:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0j8bi64yzPA=p9uP5cU8Z1NAS7Bp5a1BVjFBt-4LLzGQ@mail.gmail.com>
Message-ID: <CAK8P3a0j8bi64yzPA=p9uP5cU8Z1NAS7Bp5a1BVjFBt-4LLzGQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used ring
To:     "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        "Dutt, Sudeep" <sudeep.dutt@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 2:35 PM Dixit, Ashutosh
<ashutosh.dixit@intel.com> wrote:
> On Thu, 29 Oct 2020 04:53:09 -0700, Arnd Bergmann wrote:
> >
> > - PCIe endpoint, with the endpoint controlling the virtio configuration
> > - PCIe endpoint, with the host (the side that has the pci_driver) controlling
> >   the virtio configuration
> > - NTB connections
> > - your  loopback mode
> > - Virtio tunnels between VM guests (see https://www.linaro.org/projects/#STR)
> > - Intel MIC (to be removed, but it would be wrong to make assumptions that
> >   cannot be made on that type of hardware)
>
> A virtio interface being one between host and guest is inherently
> asymmetric. The whole innovation of the VOP design was to treat Linux on a
> PCIe device as a guest, there was even talk at some point of the "guest"
> being managed via libvirt. So here host and guest retain their specific
> role/personality. The host "inserts" devices which appear in the guest
> e.g. So I am not sure how this asymmetry plays in the scenarios mentioned
> above.

This is the reason I listed the PCIe endpoint mode twice. I expect that
some use cases require the same setup as MIC, with Linux on some
kind of PCIe add-on card using devices that are implemented on the host.
In other cases we may need the opposite: you may have a PCIe
add-on card that provides arbitrary services to the host in the same
way that most PCIe endpoint devices work. An example might be
a smart NIC running a standalone Linux, but implementing virtio-net
to avoid the need for custom drivers on the host.

In the endpoint framework, it is always the endpoint that decides what
PCI devices it wants to implement, but in case of VOP that device
could be either the side that configures and implements the virtio
devices, or the side that probes and uses them.

      Arnd
