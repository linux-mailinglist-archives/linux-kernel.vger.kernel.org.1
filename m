Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA8129D4E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgJ1Vyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbgJ1VwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:52:24 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 111AB247D9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603900253;
        bh=+fltwhrBNsbSzN01punGsYvOfjxgYJKWrVwmEfe9vgs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jtwo+tArJtv7N9Se/DtXjCWwXi9dawJY0o96P9kKNfuV7NisBo6AvxSVSjmTpeK1M
         kQ7f6G6dBOn+PQkMODl1drfo4Xxcb8426Mu/nmE1reQO9p4ZEl79+8G44JMBx6GWFf
         VdCRQL3zSW5X7Nf57oG4Cc5+R5mRSoJhws6lDCco=
Received: by mail-qk1-f171.google.com with SMTP id z6so4954648qkz.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 08:50:53 -0700 (PDT)
X-Gm-Message-State: AOAM532dzN18JGaRC5BQcWx1OzccVKjpmM9pAPUXrrJ8GgG0uzgjqRh7
        PJ95PS5nM3bWbqGcOsUoYMyUN30riyQ/hO7KwHA=
X-Google-Smtp-Source: ABdhPJyfVvnTcJuzPbdCf/DfsTdqy1FgAIenfqV3AJu6HyZtCYCOHGUB7g7dbfOyIaXnGnFebSGwegf2ClVSPC80ymQ=
X-Received: by 2002:a37:4e57:: with SMTP id c84mr7906625qkb.394.1603900252080;
 Wed, 28 Oct 2020 08:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201022050638.29641-1-sherry.sun@nxp.com> <20201022050638.29641-3-sherry.sun@nxp.com>
 <20201023092650.GB29066@infradead.org> <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027062802.GC207971@kroah.com> <VI1PR04MB4960C0E76374B2775D99A82192160@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027151106.e4skr6dsbwvo4al6@axis.com> <VI1PR04MB49603783EF3FD3F3635FCDAF92170@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <93bd1c60ea4d910489a7592200856eaf8022ced0.camel@intel.com>
 <AM0PR04MB4947F01860DE953B8496FA8892170@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <CAK8P3a1JRx32VfFcwFpK0i6F5MQMCK-yCKw8=d_R08Y3iQ7wLQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1JRx32VfFcwFpK0i6F5MQMCK-yCKw8=d_R08Y3iQ7wLQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 28 Oct 2020 16:50:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3u06ZHdAb_n3byTqfxAvy_wi48X1g0N4ODuH2uEM0xLA@mail.gmail.com>
Message-ID: <CAK8P3a3u06ZHdAb_n3byTqfxAvy_wi48X1g0N4ODuH2uEM0xLA@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used ring
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "Dutt, Sudeep" <sudeep.dutt@intel.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
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

(resending from the kernel.org address after getting bounces again)

On Wed, Oct 28, 2020 at 7:29 AM Sherry Sun <sherry.sun@nxp.com> wrote:
> > Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
> >
> > Both Ashutosh and I have moved on to other projects. The MIC devices have
> > been discontinued. I have just sent across a patch to remove the MIC drivers
> > from the kernel tree.
> >
> > We are very glad to see that Sherry is able to reuse some of the VOP logic
> > and it is working well. It is best if the MIC drivers are removed so Sherry can
> > add the specific VOP logic required for imx8qm subsequently without having
> > to worry about other driver dependencies.
> > Hoping this results in a cleaner imx8qm driver moving forward.
>
> I'm ok with your patch.
> Since you have deprecated the MIC related code, may I ask do you have
> a better solution instead of vop/scif?

I think we should try to do something on top of the PCIe endpoint subsystem
to make it work across arbitrary combinations of host and device
implementations,
and provide a superset of what the MIC driver, (out-of-tree) Bluefield endpoint
driver, and the NTB subsystem as well as a couple of others used to do,
each of them tunneling block/network/serial/... over a PCIe link of some
sort, usually with virtio.

At the moment, there is only one driver for the endpoint framework in the
kernel, in drivers/pci/endpoint/functions/pci-epf-test.c, but I think this can
serve as a starting point.

The PCI endpoint subsystem already uses configfs for configuring the
available devices, and this seems like a good fit for making it work
in general. However, there are a number of use cases that have
somewhat conflicting requirements, so the first step would be to
figure out what everyone actually needs for virtio communication.

These are some of the main differences that I have noticed in the
past:

- The simple case would be to use one PCIe endpoint device
  for each virtio device, but I think this needs to be multiplexed
  so that hardware that only supports a single PCIe endpoint
  can still have multiple virtio devices tunneled through it.

- While sometimes the configuration is hardcoded in the driver, ideally
  the type of virtio device(s) that is tunneled over the PCIe link should
  be configurable. The configuration of the endpoint device itself is
  done on the machine running on the endpoint side, but for the
  virtio devices, this might be either on the host or the endpoint.
  Not sure if one of the two ways is common enough, or we have to
  allow both.

- When the link is configured, you still need one side to provide a
  virtio device host implementation, while the other side would
  run the normal virtio device driver. Again, these could be done
  either way, and it is independent of which side has configured
  the link, and we might want to only allow one of the two options,
  or do both, or tie it to who configures it (e.g. the side that creates
  the device must be the virtio device host, while the other side
  just sees the device pop up and uses a virtio driver).

       Arnd
