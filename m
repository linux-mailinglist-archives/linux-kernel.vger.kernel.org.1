Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D844D276CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgIXJXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:23:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56632 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgIXJXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:23:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08O9NWBW115705;
        Thu, 24 Sep 2020 04:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600939412;
        bh=vYe1QDL6vFHk5ZouUTxPojLccsvE8rm0wEk5/S9nmkw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hNQi99hOAnShRsVX28fEqtdNoP5fMfFodXPRk2Gd7lTSDXBdyOKlA47k2kunjykyz
         3jNGoMNCW5C5sKiXfdIitbOXxelUQcux/9TMqAYCMs+CAtpE4/QSEWUQl+hM+zOV2V
         Elxv8zFfjjBUBqMs10uz4AE1E2m5kLmkkUo7uq08=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08O9NWW4076494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 04:23:32 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 04:23:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 04:23:32 -0500
Received: from [10.250.232.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08O9NSXS084251;
        Thu, 24 Sep 2020 04:23:29 -0500
Subject: Re: [PATCH v2 0/2] J7200: Add I2C support
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200923155400.13757-1-vigneshr@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <fabd854b-93a8-0f86-796e-81ef761cc2f5@ti.com>
Date:   Thu, 24 Sep 2020 14:53:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923155400.13757-1-vigneshr@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/09/20 9:23 pm, Vignesh Raghavendra wrote:
> Add I2C and I2C IO expanders nodes for J7200
> 
> v2:
> Align reg address format with that of file's (s/0x0/0x00)
> 
> Vignesh Raghavendra (2):
>   arm64: dts: ti: j7200: Add I2C nodes
>   arm64: dts: ti: k3-j7200-common-proc-board: Add I2C IO expanders
> 
>  .../dts/ti/k3-j7200-common-proc-board.dts     | 49 ++++++++++++
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 77 +++++++++++++++++++
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 33 ++++++++
>  3 files changed, 159 insertions(+)
> 

Reviewed-by: Faiz Abbas <faiz_abbas@ti.com>

Thanks,
Faiz


