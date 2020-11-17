Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB72B5C35
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgKQJvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:51:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbgKQJvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:51:53 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B8F2078E;
        Tue, 17 Nov 2020 09:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605606712;
        bh=iHE9RAnQLkyx8y3cmGgcwjxd7Z4g7wQ3Exd7zWtOw5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NpT1yoy1UrT6V+QTgn6JElcmwV3hdG2JGBsFWVJ3cdcuIn+O8ubigST8UBcGamAY+
         M3QSzyzq+JY1EtZ5xo1Opub0cj/O7qlU9gtd+IrXX+J9xbD62hB7vA0gCw9p9EjkGt
         Xq+k76QlnKaMYoJzxPyUG7xqFr8o58rdFqKG7cBM=
Date:   Tue, 17 Nov 2020 15:21:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] phy: phy-hi3670-usb3: move driver from staging into
 phy
Message-ID: <20201117095148.GE50232@vkoul-mobl>
References: <cover.1605530560.git.mchehab+huawei@kernel.org>
 <420faf39bb03d07f8823b03bc55a429e975e23a0.1605530560.git.mchehab+huawei@kernel.org>
 <20201116153106.GA1682049@bogus>
 <20201117075542.734f429b@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117075542.734f429b@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-11-20, 07:55, Mauro Carvalho Chehab wrote:
> Em Mon, 16 Nov 2020 09:31:06 -0600
> Rob Herring <robh@kernel.org> escreveu:
> 
> > On Mon, Nov 16, 2020 at 01:59:27PM +0100, Mauro Carvalho Chehab wrote:
> > > The phy USB3 driver for Hisilicon 970 (hi3670) is ready
> > > for mainstream. Mode it from staging into the main driver's  
> > 
> > s/Mode/Move/
> > 
> > > phy/ directory.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  .../bindings/phy/phy-hi3670-usb3.yaml         |  72 ++
> > >  MAINTAINERS                                   |   9 +-
> > >  drivers/phy/hisilicon/Kconfig                 |  10 +
> > >  drivers/phy/hisilicon/Makefile                |   1 +
> > >  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 671 ++++++++++++++++++
> > >  drivers/staging/hikey9xx/Kconfig              |  11 -
> > >  drivers/staging/hikey9xx/Makefile             |   2 -
> > >  drivers/staging/hikey9xx/phy-hi3670-usb3.c    | 671 ------------------
> > >  drivers/staging/hikey9xx/phy-hi3670-usb3.yaml |  72 --  
> > 
> > I assume this is only a move? Use '-M' option.
> 
> This is a move, although I explicitly disabled -M on this series, as both
> the driver code and DT may still require some review, as those patches
> are for subsystems that I haven't made any relevant contributions
> so far.

I for one am appreciating the intent here, it helps to review the patch
coming in from staging

Thanks
-- 
~Vinod
