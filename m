Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A7E2C840E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgK3MX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:23:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48296 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgK3MX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:23:27 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AUCMJdk088105;
        Mon, 30 Nov 2020 06:22:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606738939;
        bh=7UvRl7kK+AIqbIbQ7zEESs9Zed+8y5YgG+drM7dIuyg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=duUY7Z85XGCXylrYu6LJlZPVLVnx2qhTwyrXu8zHRhjCUcLepsjfQ2/bfWp/m1Pwh
         fuqye3cGWGJTUshz+5SB9n6x6FtCeJT1x+2es1m9KgXiMtOLLbfT1u8khntydXmNlI
         Y4zp7/dBrVvwRwYFdAX2rxWCXm0gUJ4XfFgxHIeA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AUCMJrJ109759
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 06:22:19 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 30
 Nov 2020 06:22:19 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 30 Nov 2020 06:22:19 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AUCMJeD065699;
        Mon, 30 Nov 2020 06:22:19 -0600
Date:   Mon, 30 Nov 2020 06:22:19 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <bjorn.andersson@linaro.org>, <shawnguo@kernel.org>,
        <leoyang.li@nxp.com>, <vkoul@kernel.org>,
        <geert+renesas@glider.be>, <Anson.Huang@nxp.com>,
        <michael@walle.cc>, <krzk@kernel.org>, <olof@lixom.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] arm64: defconfig: drop unused POWER_AVS option
Message-ID: <20201130122219.zttxek6qtsfpsydk@strainer>
References: <20201130112731.30599-1-andrey.zhizhikin@leica-geosystems.com>
 <20201130112731.30599-2-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201130112731.30599-2-andrey.zhizhikin@leica-geosystems.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:27-20201130, Andrey Zhizhikin wrote:
> Commit 785b5bb41b0a ("PM: AVS: Drop the avs directory and the
> corresponding Kconfig") moved AVS code to SOC-specific folders, and
> removed corresponding Kconfig from drivers/power, leaving original
> POWER_AVS config option enabled in defconfig file.
> 
> Remove the option, which has no references in the tree anymore.
> 
> Fixes: 785b5bb41b0a ("PM: AVS: Drop the avs directory and the corresponding Kconfig")
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>

Reviewed-by: Nishanth Menon <nm@ti.com>


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
