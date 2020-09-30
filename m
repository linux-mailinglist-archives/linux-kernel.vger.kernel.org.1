Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD0827EA64
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgI3N4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:56:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33642 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbgI3N4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:56:53 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UDuoHR003116;
        Wed, 30 Sep 2020 08:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601474210;
        bh=nvddhHYdrm6PO2SjKBJhzcvT4yhTqPyQ2t4w9s9uIpk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fUkWuUeprgjwR67Z8Ea0EKrgqCLqbHFQcqjz4eUG6pPZNneE28dXp7YeHo+Kwbgwe
         ajUmU5ZPFfX+Zs0eoCPuaK709AZx16Hi6MPoFGrJMeEA3pVSoakkf1AWpEygTJLuJ8
         PbPi3d8K33ExQUVQh22cbp/bYWdcphZfCfdwOf6Y=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UDuos8015651
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 08:56:50 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 08:56:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 08:56:48 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UDujjo107072;
        Wed, 30 Sep 2020 08:56:46 -0500
Subject: Re: [PATCH 11/11] soc: ti: k3-socinfo: Add entry for AM64 SoC family
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <nm@ti.com>,
        <t-kristo@ti.com>, <ssantosh@kernel.org>, <lokeshvutla@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Anna, Suman" <s-anna@ti.com>
References: <20200928083429.17390-1-peter.ujfalusi@ti.com>
 <20200928083429.17390-12-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <aa10c7a1-ddbd-a3ae-3035-f26a5ce073ae@ti.com>
Date:   Wed, 30 Sep 2020 16:56:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928083429.17390-12-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/09/2020 11:34, Peter Ujfalusi wrote:
> It's JTAG PARTNO is 0xBB38.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   drivers/soc/ti/k3-socinfo.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
> index bbbc2d2b7091..a14ec68846dd 100644
> --- a/drivers/soc/ti/k3-socinfo.c
> +++ b/drivers/soc/ti/k3-socinfo.c
> @@ -40,6 +40,7 @@ static const struct k3_soc_id {
>   	{ 0xBB5A, "AM65X" },
>   	{ 0xBB64, "J721E" },
>   	{ 0xBB6D, "J7200" },
> +	{ 0xBB38, "AM64" }

Shouldn't it be AM64X

>   };
>   
>   static int
> 

-- 
Best regards,
grygorii
