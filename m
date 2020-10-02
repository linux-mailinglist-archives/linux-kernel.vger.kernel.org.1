Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFC0281323
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbgJBMtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:49:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40178 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBMtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:49:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 092CnQPq101968;
        Fri, 2 Oct 2020 07:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601642966;
        bh=DIr+K1xQCW/Rcaq19mKmaMXxG7mGcseJhQmSdu1WAWI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DXSzVbQDyfM72ndqghi1FvtbKPlcBukuyIJdB5dpcmEntQn9AOVzoron4GXOg+S2I
         80BqBE71q68pqboHioWBQmbr0foeqvzDVIa68f8qnGvp9rhYO01SFz6LzXQE8ibK0L
         /KYwBUkNEU3UOt7HK//pXP8IGkm3xbw+odQ+Z8J0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 092CnQeq050504
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Oct 2020 07:49:26 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 07:49:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 2 Oct 2020 07:49:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 092CnQ36123431;
        Fri, 2 Oct 2020 07:49:26 -0500
Date:   Fri, 2 Oct 2020 07:49:26 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <will@kernel.org>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>
Subject: Re: [PATCH 0/8] Add support for UHS modes in TI's J721e and J7200
 boards
Message-ID: <20201002124926.rr5dk5hhygavgqs3@akan>
References: <20201001190541.6364-1-faiz_abbas@ti.com>
 <20201001191302.dlp2tzbvkk35vzgd@akan>
 <2a7ceab9-37ec-9117-1d98-9f307b4b5390@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2a7ceab9-37ec-9117-1d98-9f307b4b5390@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:14-20201002, Faiz Abbas wrote:
> Hi Nishanth,
> 
> On 02/10/20 12:43 am, Nishanth Menon wrote:
> > On 00:35-20201002, Faiz Abbas wrote:
> >> The following patches add support for UHS modes for TI's j721e and j7200
> >> boards.
> >>
> >> Patches 1-3 add support for gpios to j7200-evm
> >>
> >> Patches 4-6 add support for voltage regulators for required by the
> >> SD card in both devices as well as enable UHS modes at 1.8V
> >>
> >> Patches 5-6 add some required configs to the arm64 defconfig.
> >>
> >> This series depends on driver patches adding tuning support here:
> >> https://lore.kernel.org/linux-arm-kernel/20200923105206.7988-1-faiz_abbas@ti.com/
> >>
> >> Faiz Abbas (8):
> >>   arm64: dts: ti: k3-j7200-main: Add gpio nodes in main domain
> >>   arm64: dts: ti: k3-j7200: Add gpio nodes in wakeup domain
> >>   arm64: dts: ti: k3-j7200-common-proc-board: Disable unused gpio
> >>     modules
> >>   arm64: dts: ti: k3-j721e-main: Add output tap delay values
> >>   arm64: dts: ti: k3-j721e-common-proc-board: Add support SD card UHS
> >>     modes
> >>   arm64: dts: ti: k3-j7200-common-proc-board: Add support SD card UHS
> >>     modes
> > 
> > Split these up please!
> 
> Into SD card UHS and gpio series?
> 
> >>   arm64: defconfig: Enable OMAP I2C driver
> >>   arm64: defconfig: Enable DAVINCI_GPIO driver
> >>
> > 
> > defconfig patches can be posted independent of dts patches, they go to
> > different branches.
> 
> I was trying to follow Arnd's advice here:
> https://lore.kernel.org/linux-arm-kernel/CAK8P3a1JpCCCV-CVQj3+eMfWF+=4AuHPpv390Tyj2pKn63_ZVg@mail.gmail.com/
> 
> He says that defconfig patches can be sent at the same time as dts updates and maintainers can send those
> as separate pull requests.

BTW, [1] your patches 7/8 and 8/8 never hit the mailing list, So, I am
commenting on the defconfig patches without actually seeing the patches,
and solely based on $subject in the cover letter.

The reason for my comment was that I think defconfig series could go
independent of the remaining series into 5.10, since they are not
related specifically to this series, they are probably needed even for
am654 and j721e nodes that already exist and was a miss that we didn't
enable. Tying that to this specific series didn't make sense to me.

But either way, we are way past rc7. I don't have enough time for
these patches to bake in -next to make it to 5.10 window. So, lets try
reposting this after rc1 tag is done so that I can send the defconfig
(separately for 5.10 window) and the dts staged towards 5.11 (and no,
I don't consider the dts patches as fixes - they are enabling the next
level of functionality).

[1] https://lore.kernel.org/linux-arm-kernel/20201001190541.6364-7-faiz_abbas@ti.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
