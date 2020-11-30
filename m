Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6C42C840D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 13:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgK3MXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 07:23:19 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52018 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3MXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:23:18 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AUCM25e066159;
        Mon, 30 Nov 2020 06:22:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606738922;
        bh=EU4OenXwaAFJBf/I8U12xdgXc31i0aM0k0UxVokNYtg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rAPXFzc7IlLryn/uyvUnAfIIWdzivYxIgK+Fas99z/mtnmGBR55mcWP+UphECsmKV
         1hci9uCb+1L9xorSn6UfaYlvAob/FVDbd48+hxJxlmko4Mc9SuTohFvyJSJwHgAI0A
         3EMFaQk3P8ROtm0oN0jD7zYCR/Q3ZoEIaj0wEzls=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AUCM2QM104160
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 06:22:02 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 30
 Nov 2020 06:22:02 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 30 Nov 2020 06:22:02 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AUCM28H005990;
        Mon, 30 Nov 2020 06:22:02 -0600
Date:   Mon, 30 Nov 2020 06:22:02 -0600
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
Subject: Re: [PATCH 2/2] ARM: multi_v7_defconfig: drop unused POWER_AVS option
Message-ID: <20201130122202.s67y2c3nh2aztxzu@reoccur>
References: <20201130112731.30599-1-andrey.zhizhikin@leica-geosystems.com>
 <20201130112731.30599-3-andrey.zhizhikin@leica-geosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201130112731.30599-3-andrey.zhizhikin@leica-geosystems.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:27-20201130, Andrey Zhizhikin wrote:
> Commit 785b5bb41b0a ("PM: AVS: Drop the avs directory and the
> corresponding Kconfig") moved AVS code to SOC-specific folders, and
> removed corresponding Kconfig from drivers/power, leaving original
> POWER_AVS config option enabled in multi_v7_defconfig file.
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
