Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E4E2B115E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 23:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgKLWWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 17:22:53 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55670 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgKLWWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 17:22:52 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACMMhIU021142;
        Thu, 12 Nov 2020 16:22:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605219763;
        bh=rMFv6s7cOOZFk9zFns5usOPZiaBH6o27a0exLHX/3n8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=l5aTBRDjZ1XuBCwT/uCOf5FrvzktaHJebHOntTPcb4LLMZe697hNW5IcuAYCmW31D
         8UCaLz82sXE+pFVslaFF3CfajyGxkQhEfQ8r7BJ+EsEy3oH90PlDvLZ22OYUOJB4wi
         4KsfNx4WLDgpMJHPDPXMl6bWTEG8HoNtTdHHDqYM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACMMhuA002967
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 16:22:43 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 16:22:42 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 16:22:42 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACMMgD3012184;
        Thu, 12 Nov 2020 16:22:42 -0600
Date:   Thu, 12 Nov 2020 16:22:42 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <santosh.shilimkar@oracle.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: Kconfig: Drop ARM64 SoC specific configs
Message-ID: <20201112222242.hala5ocnrc43s6cs@scribing>
References: <20201026170624.24241-1-nm@ti.com>
 <d741c4d0-9e76-99de-7081-10f3a7a5cb1a@ti.com>
 <20201026190808.im4nb32jn4rd3xhu@crayon>
 <20201112215600.npr4g24gt4tvc5tm@kahuna>
 <4b23cb5b-b1c9-34b9-2bdf-4f9c2df9ad0d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b23cb5b-b1c9-34b9-2bdf-4f9c2df9ad0d@oracle.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:59-20201112, santosh.shilimkar@oracle.com wrote:
> On 11/12/20 1:56 PM, Nishanth Menon wrote:
> > On 14:08-20201026, Nishanth Menon wrote:
> > > On 23:30-20201026, Lokesh Vutla wrote:
> > > [..]
> > > > ➜  linux git:(master) git grep -in ARCH_K3_AM6_SOC
> > > > arch/arm64/configs/defconfig:961:CONFIG_ARCH_K3_AM6_SOC=y
> > > > drivers/soc/ti/Kconfig:7:config ARCH_K3_AM6_SOC
> > > > ➜  linux git:(master) git grep -in ARCH_K3_J721E_SOC
> > > > arch/arm64/configs/defconfig:962:CONFIG_ARCH_K3_J721E_SOC=y
> > > > drivers/gpu/drm/bridge/cadence/Kconfig:16:  depends on ARCH_K3_J721E_SOC ||
> > > > COMPILE_TEST
> > > > drivers/soc/ti/Kconfig:12:config ARCH_K3_J721E_SOC
> > > > 
> > > > 
> > > > I see drm bridge Kconfig is cleaned[0]. Please clean the defconfig as well.
> > > > 
> > > > [0]
> > > > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201026165441.22894-1-nm@ti.com/__;!!GqivPVa7Brio!KWOx2aLl7hlHQrN--kiz1N5WaPWgeZzFZ12ptg8NzJE2BSnxxrWmsoqn5vjMvpfO1bSGYQ$
> > > > 
> > > 
> > > Yes, the defconfig patches have to be queued up in a different queue,
> > > Lets see where the two patches fall and will post the defconfig
> > > updates as well.
> > 
> > 
> > Santosh,
> > 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201026165441.22894-1-nm@ti.com/__;!!GqivPVa7Brio!KWOx2aLl7hlHQrN--kiz1N5WaPWgeZzFZ12ptg8NzJE2BSnxxrWmsoqn5vjMvpfO1bSGYQ$
> > looks available in next now.
> > 
> > Can we queue this patch[1] up for 5.11 window?
> > 
> > Depending on your preference, I can carry the defconfig patch[2] (to
> > prevent merge dependencies, might be good to get an immutable tag) OR
> > you can pick the defconfig patch up that cleans after removing the
> > symbol.
> > 
> 
> I can apply SOC kconfig patch [1] to my soc branch. That branch with
> some additional patches am going to send up, so it should
> work. Let me know.

OK, sounds fine to me, If you can give me a tag, I can add queue up
defconfig on top to prevent bisect issues.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
