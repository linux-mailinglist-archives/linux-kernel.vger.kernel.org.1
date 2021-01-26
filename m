Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A346304618
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394318AbhAZSPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:15:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389909AbhAZRui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:50:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF4BD2224C;
        Tue, 26 Jan 2021 17:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611683398;
        bh=ix5zJ6JWxdoag7Pi/sGk5niBB/BRtMgouJs8I7834qI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QlmBe9gDOtXQz1sz7N3XMxwQGKMs/kj/5q94ltAL+JYThZi2SOYOO/qoDyHa5+qIr
         JE56dqfoBYM7SOGJj1LFEGSI5KdlbEsJ1OGvB+asxu+UzpPRMyQS7HCEl9ZC9EWHK3
         qdcDshfRJ7tGjJ2edO1Aw8EDjHUUgKxBPkG1eAKs=
Date:   Tue, 26 Jan 2021 18:49:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        Yu Chen <chenyu56@huawei.com>, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alex Dewar <alex.dewar90@gmail.com>
Subject: Re: [PATCH v4 0/5] Promote Hikey 970 USB phy out of staging
Message-ID: <YBBWQeglmuDn1g11@kroah.com>
References: <cover.1611052729.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1611052729.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 11:44:38AM +0100, Mauro Carvalho Chehab wrote:
> Hi Vinod/Rob,
> 
> This series moves  the Hikey 970 USB PHY driver out of staging.
> 
> Patches 1 to 4 contain the fixes from staging. Patch 5 moves the
> driver from staging:
> 
> 	$ git show 82ce73ac9a38 --summary
> 	...
> 	 rename drivers/staging/hikey9xx/phy-hi3670-usb3.yaml => Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml (100%)
> 	 rename drivers/{staging/hikey9xx => phy/hisilicon}/phy-hi3670-usb3.c (100%)
> 
> I opted to use --no-renames on this series in order to make easier to
> review via e-mail, as the entire driver and DT bindings will be seen
> at the last patch on this series.

First 4 patches applied to my tree, thanks.

greg k-h
