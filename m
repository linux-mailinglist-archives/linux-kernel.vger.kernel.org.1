Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C88029BAC0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1807575AbgJ0QLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:11:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46346 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1804959AbgJ0QAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:00:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09RG03EB130507;
        Tue, 27 Oct 2020 11:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603814403;
        bh=nJbxpEs1Sj02R3uv62Gtsp2WcPBFGlsuy6h1U+1SaRs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pTkfiNOICv4xNbuZAX/V7eRQNNC5QRCnC7iy9rAWdkgQbSFoFr6jkiLRAdYS4WS7F
         OBibz3Mq9eDnZKGjVFpgEtg2GoObVoncUk7P8a2DfI59w9fPa6girQD6PgVXFRbJey
         Bvmh3Eixx04b0Tgr59r+LJVAVDfUlsvSezRCWJ00=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09RG02Bw000731
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 11:00:02 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 27
 Oct 2020 11:00:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 27 Oct 2020 11:00:01 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09RFxwFY051252;
        Tue, 27 Oct 2020 10:59:58 -0500
Subject: Re: [PATCH] soc: ti: Kconfig: Drop ARM64 SoC specific configs
To:     Nishanth Menon <nm@ti.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Jyri Sarha <jsarha@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20201026170624.24241-1-nm@ti.com>
 <d741c4d0-9e76-99de-7081-10f3a7a5cb1a@ti.com>
 <20201026190808.im4nb32jn4rd3xhu@crayon>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <30760d91-cfe0-1b25-ab3d-2cb6a58f7b45@ti.com>
Date:   Tue, 27 Oct 2020 21:29:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201026190808.im4nb32jn4rd3xhu@crayon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/10/20 12:38 am, Nishanth Menon wrote:
> On 23:30-20201026, Lokesh Vutla wrote:
> [..]
>> ➜  linux git:(master) git grep -in ARCH_K3_AM6_SOC
>> arch/arm64/configs/defconfig:961:CONFIG_ARCH_K3_AM6_SOC=y
>> drivers/soc/ti/Kconfig:7:config ARCH_K3_AM6_SOC
>> ➜  linux git:(master) git grep -in ARCH_K3_J721E_SOC
>> arch/arm64/configs/defconfig:962:CONFIG_ARCH_K3_J721E_SOC=y
>> drivers/gpu/drm/bridge/cadence/Kconfig:16:  depends on ARCH_K3_J721E_SOC ||
>> COMPILE_TEST
>> drivers/soc/ti/Kconfig:12:config ARCH_K3_J721E_SOC
>>
>>
>> I see drm bridge Kconfig is cleaned[0]. Please clean the defconfig as well.
>>
>> [0]
>> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201026165441.22894-1-nm@ti.com/
>>
> 
> Yes, the defconfig patches have to be queued up in a different queue,
> Lets see where the two patches fall and will post the defconfig
> updates as well.

Sure. IMHO, the cleanup patches should get merged before this Kconfig removal patch.

Otherwise, this patch as-is looks good to me.

Acked-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
