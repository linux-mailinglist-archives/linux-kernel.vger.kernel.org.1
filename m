Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A6927EA73
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgI3N6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:58:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33912 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730442AbgI3N6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:58:21 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UDwHCe003622;
        Wed, 30 Sep 2020 08:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601474297;
        bh=6Fj7OFueIfHApZmAdzpm3tSO0kawVKtkcyhqkTWeAFs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PEvcddilJvb/JfuAfpExQ20uaZLfgNKaTtnj9qboWueVTgMWSIFaz5jYCnYwjrtSz
         SfOdSYKRALtFks/ikmmu6S2F/Y2yPBsebqREp38hXwBI3iieO7QpI5wdbFY/J8bxeY
         R9e+TNMtBLfftyo747HlQpIUlcicTa8gspCwZ2ss=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UDwHXs091308
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 08:58:17 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 08:58:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 08:58:17 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UDwFNo111098;
        Wed, 30 Sep 2020 08:58:15 -0500
Subject: Re: [PATCH 10/11] soc: ti: k3-ringacc: Use correct device for
 allocation in RING mode
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <nm@ti.com>,
        <t-kristo@ti.com>, <ssantosh@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200928083429.17390-1-peter.ujfalusi@ti.com>
 <20200928083429.17390-11-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <3bbe1568-3ceb-07df-4c40-bcc54c8935c0@ti.com>
Date:   Wed, 30 Sep 2020 16:58:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928083429.17390-11-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/09/2020 11:34, Peter Ujfalusi wrote:
> In RING mode the ringacc does not access the ring memory. In this access
> mode the ringacc coherency does not have meaning.
> 
> If the ring is configured in RING mode, then the ringacc itself will not
> access to the ring memory. Only the requester (user) of the ring is going
> to read/write to the memory.
> Extend the ring configuration parameters with a device pointer to be used
> for DMA API when the ring is configured in RING mode.
> 
> Extending the ring configuration struct will allow per ring selection of
> device to be used for allocation, thus allowing per ring coherency.
> 
> To avoid regression, fall back to use the ringacc dev in case the alloc_dev
> is not provided.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   drivers/soc/ti/k3-ringacc.c       | 14 +++++++++++---
>   include/linux/soc/ti/k3-ringacc.h |  5 +++++
>   2 files changed, 16 insertions(+), 3 deletions(-)
> 
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
