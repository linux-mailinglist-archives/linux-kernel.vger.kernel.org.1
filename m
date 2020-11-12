Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2A62B10BD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgKLV4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:56:06 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49492 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgKLV4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:56:05 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACLu0EY010957;
        Thu, 12 Nov 2020 15:56:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605218160;
        bh=vZeuvlVCxBHj41lGZcfVpWofJ2yUXkbd5bHCA2deX1k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=jVNCypw4Fvue8pTZQgVBHHe51fWMGqciGKTEKcAEFH+RMBOg2wk/DuMxKWJt74OHK
         00/QmEBavmh30NfkSJQTsYEfy9FdQvZMvn2IA7lX1GkBbGMLxOf08asRdjJZuZJ3Lm
         etSo2UJwy9yaHs5HYUhWH1hsxsyG1MbybQb2jNzg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACLu0Re024449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 15:56:00 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 15:56:00 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 15:56:00 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACLu0Fl096988;
        Thu, 12 Nov 2020 15:56:00 -0600
Date:   Thu, 12 Nov 2020 15:56:00 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: Kconfig: Drop ARM64 SoC specific configs
Message-ID: <20201112215600.npr4g24gt4tvc5tm@kahuna>
References: <20201026170624.24241-1-nm@ti.com>
 <d741c4d0-9e76-99de-7081-10f3a7a5cb1a@ti.com>
 <20201026190808.im4nb32jn4rd3xhu@crayon>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201026190808.im4nb32jn4rd3xhu@crayon>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:08-20201026, Nishanth Menon wrote:
> On 23:30-20201026, Lokesh Vutla wrote:
> [..]
> > ➜  linux git:(master) git grep -in ARCH_K3_AM6_SOC
> > arch/arm64/configs/defconfig:961:CONFIG_ARCH_K3_AM6_SOC=y
> > drivers/soc/ti/Kconfig:7:config ARCH_K3_AM6_SOC
> > ➜  linux git:(master) git grep -in ARCH_K3_J721E_SOC
> > arch/arm64/configs/defconfig:962:CONFIG_ARCH_K3_J721E_SOC=y
> > drivers/gpu/drm/bridge/cadence/Kconfig:16:  depends on ARCH_K3_J721E_SOC ||
> > COMPILE_TEST
> > drivers/soc/ti/Kconfig:12:config ARCH_K3_J721E_SOC
> > 
> > 
> > I see drm bridge Kconfig is cleaned[0]. Please clean the defconfig as well.
> > 
> > [0]
> > https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201026165441.22894-1-nm@ti.com/
> > 
> 
> Yes, the defconfig patches have to be queued up in a different queue,
> Lets see where the two patches fall and will post the defconfig
> updates as well.


Santosh,

https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201026165441.22894-1-nm@ti.com/
looks available in next now.

Can we queue this patch[1] up for 5.11 window?

Depending on your preference, I can carry the defconfig patch[2] (to
prevent merge dependencies, might be good to get an immutable tag) OR
you can pick the defconfig patch up that cleans after removing the
symbol.

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201026170624.24241-1-nm@ti.com/
[2] https://lore.kernel.org/lkml/20201112215438.31432-1-nm@ti.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
