Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C82B59E6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 07:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgKQGzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 01:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKQGzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 01:55:49 -0500
Received: from coco.lan (ip5f5ad5cc.dynamic.kabel-deutschland.de [95.90.213.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891EE20E65;
        Tue, 17 Nov 2020 06:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605596148;
        bh=cGf90cxOk4enH15mxLAGIs0fBknMa6LCpcQRUFZeb4A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kOI8CK5s/FBBia2UB+hfbeLQeOx0k6CIYipvUxM+343W+K/H/EvzOlVa5yjMbNaAB
         B4Tixubiso0iht/zuyH5l8kyTJg4+CL9YAKu8MbRug3cGdIl76K+k/GTUL4MCeb63R
         qIbauobehr8dWB6Ki5acvvl/+Ef1o4V+wM8Mkrw8=
Date:   Tue, 17 Nov 2020 07:55:42 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linuxarm@huawei.com,
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
Message-ID: <20201117075542.734f429b@coco.lan>
In-Reply-To: <20201116153106.GA1682049@bogus>
References: <cover.1605530560.git.mchehab+huawei@kernel.org>
        <420faf39bb03d07f8823b03bc55a429e975e23a0.1605530560.git.mchehab+huawei@kernel.org>
        <20201116153106.GA1682049@bogus>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 16 Nov 2020 09:31:06 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Mon, Nov 16, 2020 at 01:59:27PM +0100, Mauro Carvalho Chehab wrote:
> > The phy USB3 driver for Hisilicon 970 (hi3670) is ready
> > for mainstream. Mode it from staging into the main driver's  
> 
> s/Mode/Move/
> 
> > phy/ directory.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../bindings/phy/phy-hi3670-usb3.yaml         |  72 ++
> >  MAINTAINERS                                   |   9 +-
> >  drivers/phy/hisilicon/Kconfig                 |  10 +
> >  drivers/phy/hisilicon/Makefile                |   1 +
> >  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 671 ++++++++++++++++++
> >  drivers/staging/hikey9xx/Kconfig              |  11 -
> >  drivers/staging/hikey9xx/Makefile             |   2 -
> >  drivers/staging/hikey9xx/phy-hi3670-usb3.c    | 671 ------------------
> >  drivers/staging/hikey9xx/phy-hi3670-usb3.yaml |  72 --  
> 
> I assume this is only a move? Use '-M' option.

This is a move, although I explicitly disabled -M on this series, as both
the driver code and DT may still require some review, as those patches
are for subsystems that I haven't made any relevant contributions
so far.

Thanks,
Mauro
