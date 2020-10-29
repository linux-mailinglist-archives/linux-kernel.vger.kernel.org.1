Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BBB29E90F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgJ2KdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbgJ2KdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:33:15 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2C420791;
        Thu, 29 Oct 2020 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603967595;
        bh=DarAx8CnpZzYucDYL/4Zv1VMXltEccO/0bM3VgBxOos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ro+pc3jhNgABZL8AgOYxcimXl1LI6JDvx3dT9rwNbzBcJR8ggizD3rfhumcrLwTU0
         OaLQDJaGZh4b/MdENLVzHi0eTFGwve/XOSjR2dBEHLSpMifY/COPKkdnM3IZCju6I4
         Dj1rBvpu41hoOYQUSDp+f9jLonHqIJujczEk3Vz0=
Date:   Thu, 29 Oct 2020 11:34:04 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Sherry Sun <sherry.sun@nxp.com>,
        "Dutt, Sudeep" <sudeep.dutt@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Message-ID: <20201029103404.GE3764182@kroah.com>
References: <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027062802.GC207971@kroah.com>
 <VI1PR04MB4960C0E76374B2775D99A82192160@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027151106.e4skr6dsbwvo4al6@axis.com>
 <VI1PR04MB49603783EF3FD3F3635FCDAF92170@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <93bd1c60ea4d910489a7592200856eaf8022ced0.camel@intel.com>
 <AM0PR04MB4947F01860DE953B8496FA8892170@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <CAK8P3a1JRx32VfFcwFpK0i6F5MQMCK-yCKw8=d_R08Y3iQ7wLQ@mail.gmail.com>
 <CAK8P3a3u06ZHdAb_n3byTqfxAvy_wi48X1g0N4ODuH2uEM0xLA@mail.gmail.com>
 <20201029100727.trbppgbusd5vogpz@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029100727.trbppgbusd5vogpz@axis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 11:07:27AM +0100, Vincent Whitchurch wrote:
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

If this works well, please restore the existing code and move it to a
new directory and we can take it from there, right?

thanks,

greg k-h
