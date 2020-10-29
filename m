Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0C29E865
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgJ2KHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:07:31 -0400
Received: from smtp2.axis.com ([195.60.68.18]:63878 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgJ2KHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1235; q=dns/txt; s=axis-central1;
  t=1603966049; x=1635502049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3dDfRpZrXdi2h9cyLECrD8Pi4UfPbqkN/AeqV38WhpY=;
  b=F6eKyWXOkleM/r0Mfnqe1Aw5wmvWH6QHiRdzY7j6MONzqEuyLuFXU5jw
   TX/Y793eUC87QxsyJHVOXR4kFobVJaB0Fg2DzU4KT4tdm+TSqCmDs0Xnx
   rDHr+HbgfmfYuUJdq6GkUm4GQdJR94b1OYB7YM2+1Pcxk47SoZGSjYIgb
   /NZVmefHwRO20PNqPhOOio66ucTMev313AYOhZJPlzzZ3YHkUFplYTGoQ
   YNTg8w0ggZGtrEZjjq74r/1C9Y86vYK1vpdKF6e6Be3R8k0GtoO4NQRt8
   6IAQka70ZMHeBcsK9PnGBgzVObce0zcvKdymFjtoXVIvDfGY0zzDlEInN
   w==;
IronPort-SDR: cYyEylfPzxmDd4ZhHRuVfvgvp2Zcdmv3PoASyiieKb4bE8CRzutBYe8oqq+FRwKO3Ew26Z24iA
 vI+jqeGTsC/njYhc7yudJuhSJESfkNevUfqq8wmigJcb0pxCAWVPEkB5LwAOGNYWTliqxaRB2O
 HGFaLFoopbJF3DQEl9HjhHyNLrs9wahjlBIrXBkjJThypoheDAjqgVgWt0B7AKrBBca8ULrI8Q
 eyKe6qnjQvU/NW7gQX9Ejrs2AusAkTchZTY7zMnzJ1Ug954iC0KmSGxDffqLO6wJ7J7kOybGeW
 HqQ=
X-IronPort-AV: E=Sophos;i="5.77,429,1596492000"; 
   d="scan'208";a="14036188"
Date:   Thu, 29 Oct 2020 11:07:27 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Sherry Sun <sherry.sun@nxp.com>,
        "Dutt, Sudeep" <sudeep.dutt@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Message-ID: <20201029100727.trbppgbusd5vogpz@axis.com>
References: <20201023092650.GB29066@infradead.org>
 <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027062802.GC207971@kroah.com>
 <VI1PR04MB4960C0E76374B2775D99A82192160@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027151106.e4skr6dsbwvo4al6@axis.com>
 <VI1PR04MB49603783EF3FD3F3635FCDAF92170@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <93bd1c60ea4d910489a7592200856eaf8022ced0.camel@intel.com>
 <AM0PR04MB4947F01860DE953B8496FA8892170@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <CAK8P3a1JRx32VfFcwFpK0i6F5MQMCK-yCKw8=d_R08Y3iQ7wLQ@mail.gmail.com>
 <CAK8P3a3u06ZHdAb_n3byTqfxAvy_wi48X1g0N4ODuH2uEM0xLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3u06ZHdAb_n3byTqfxAvy_wi48X1g0N4ODuH2uEM0xLA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 04:50:36PM +0100, Arnd Bergmann wrote:
> I think we should try to do something on top of the PCIe endpoint subsystem
> to make it work across arbitrary combinations of host and device
> implementations,
> and provide a superset of what the MIC driver, (out-of-tree) Bluefield endpoint
> driver, and the NTB subsystem as well as a couple of others used to do,
> each of them tunneling block/network/serial/... over a PCIe link of some
> sort, usually with virtio.

VOP is not PCIe-specific (as demonstrated by the vop-loopback patches I
posted a while ago [1]), and it would be a shame for a replacement to be
tied to the PCIe endpoint subsystem.  There are many SOCs out there
which have multiple Linux-capable processors without cache-coherency
between them.  VOP is (or should I say was since I guess it's being
deleted) the closest we have in mainline to easily get generic virtio
(and not just rpmsg) running between these kind of Linux instances.  If
a new replacement framework were to be PCIe-exclusive then we'd have to
invent one more framework for non-PCIe links to do pretty much the same
thing.

[1] https://lore.kernel.org/lkml/20190403104746.16063-1-vincent.whitchurch@axis.com/
