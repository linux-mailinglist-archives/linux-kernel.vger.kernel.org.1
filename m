Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC2D27EA5D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgI3Nzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:55:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33480 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3Nzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:55:33 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UDtUfI002781;
        Wed, 30 Sep 2020 08:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601474130;
        bh=kCUPBSD9BeBAldv0NSzCtJD6RA+ofMuVYvODKzaCcmo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IdP//ExhU3WlscnHHHlL13Qtuz7DfeLNIrsZt8v6EvvshFYZq7dZ7FborRmY1eF4Q
         jWVUkFRfc9hg2aQd/khUm/t9CpD3sCMIPGfdnPRuBfgHfTX5cquuLJ7GZEameZ6Ivm
         5dlnMmQe/cA+ubCyBzNDrqknLu0N1YWmpgxePXoU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UDtUd3129106
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 08:55:30 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 08:55:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 08:55:29 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UDtS2e103550;
        Wed, 30 Sep 2020 08:55:28 -0500
Subject: Re: [PATCH 09/11] firmware: ti_sci: rm: Remove unused config() from
 ti_sci_rm_ringacc_ops
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <nm@ti.com>,
        <t-kristo@ti.com>, <ssantosh@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200928083429.17390-1-peter.ujfalusi@ti.com>
 <20200928083429.17390-10-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <7d7b6343-6974-75c3-9848-5cb8997eb3e8@ti.com>
Date:   Wed, 30 Sep 2020 16:55:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928083429.17390-10-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/09/2020 11:34, Peter Ujfalusi wrote:
> The ringacc driver has been converted to use the new set_cfg function to
> configure the ring, the old config ops can be removed.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   drivers/firmware/ti_sci.c              | 72 --------------------------
>   include/linux/soc/ti/ti_sci_protocol.h |  7 ---
>   2 files changed, 79 deletions(-)
> 
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
