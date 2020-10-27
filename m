Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F8F29BBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1808849AbgJ0QXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:23:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51400 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1808828AbgJ0QXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:23:16 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09RGNBq1009068;
        Tue, 27 Oct 2020 11:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603815791;
        bh=yrHwBlL1eUnwnAL3OM85lEQF4sNPXZDR54SkK1s3gEM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rhhTFLbpY2gjpWezRwCKfbOky78+eRTqGOl+G47RZyrM6gWrTyc7UfWSed5lyeXvH
         5+bU5fIsnBnmqmInkjQA8aV3yyR5HIFG15Ac9av35QasmTb8sLnDNOhLevynyToqMu
         6OHkX0oSTQct8M/YyFpV7KotOMP48r3tf+fFXUnY=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09RGNBq7035093
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 11:23:11 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 27
 Oct 2020 11:23:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 27 Oct 2020 11:23:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09RGNBnl130559;
        Tue, 27 Oct 2020 11:23:11 -0500
Date:   Tue, 27 Oct 2020 11:23:11 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Jyri Sarha <jsarha@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] soc: ti: Kconfig: Drop ARM64 SoC specific configs
Message-ID: <20201027162311.jyia2it4o4u2ajda@snorkel>
References: <20201026170624.24241-1-nm@ti.com>
 <d741c4d0-9e76-99de-7081-10f3a7a5cb1a@ti.com>
 <20201026190808.im4nb32jn4rd3xhu@crayon>
 <30760d91-cfe0-1b25-ab3d-2cb6a58f7b45@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30760d91-cfe0-1b25-ab3d-2cb6a58f7b45@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:29-20201027, Lokesh Vutla wrote:
> 
> 
> On 27/10/20 12:38 am, Nishanth Menon wrote:
> > On 23:30-20201026, Lokesh Vutla wrote:
> > [..]
> >> ➜  linux git:(master) git grep -in ARCH_K3_AM6_SOC
> >> arch/arm64/configs/defconfig:961:CONFIG_ARCH_K3_AM6_SOC=y
> >> drivers/soc/ti/Kconfig:7:config ARCH_K3_AM6_SOC
> >> ➜  linux git:(master) git grep -in ARCH_K3_J721E_SOC
> >> arch/arm64/configs/defconfig:962:CONFIG_ARCH_K3_J721E_SOC=y
> >> drivers/gpu/drm/bridge/cadence/Kconfig:16:  depends on ARCH_K3_J721E_SOC ||
> >> COMPILE_TEST
> >> drivers/soc/ti/Kconfig:12:config ARCH_K3_J721E_SOC
> >>
> >>
> >> I see drm bridge Kconfig is cleaned[0]. Please clean the defconfig as well.
> >>
> >> [0]
> >> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201026165441.22894-1-nm@ti.com/
> >>
> > 
> > Yes, the defconfig patches have to be queued up in a different queue,
> > Lets see where the two patches fall and will post the defconfig
> > updates as well.
> 
> Sure. IMHO, the cleanup patches should get merged before this Kconfig removal patch.
> 
> Otherwise, this patch as-is looks good to me.
> 
> Acked-by: Lokesh Vutla <lokeshvutla@ti.com>


Ofcourse, thanks for highlighting the dependencies.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
