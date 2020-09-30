Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E803B27EA5A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgI3Ny4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:54:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52454 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3Nyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:54:55 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UDsqeS035821;
        Wed, 30 Sep 2020 08:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601474092;
        bh=M20BOPS5H/G5NXkhn2m+algW/H3ixf6IQIcCKNdwnnI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jNhZu+zSF2osHh488EuubKtJLgPrOd3fNWvFx1q9SX6H3vWB/B4sidxsjhrR7WC8i
         E3yiaNDuvWsSJIkqfb/GqkR8ewglTVjfQHzaMpjvW/RIiDxvwZG6ItD1Ns1dfitu02
         RCvxMKtnvMOM3/jrAlwNVr/IZ75Z616HGOC6cUps=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UDsqv1127866
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 08:54:52 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 08:54:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 08:54:51 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UDsodx101838;
        Wed, 30 Sep 2020 08:54:50 -0500
Subject: Re: [PATCH 07/11] firmware: ti_sci: rm: Add new ops for ring
 configuration
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <nm@ti.com>,
        <t-kristo@ti.com>, <ssantosh@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200928083429.17390-1-peter.ujfalusi@ti.com>
 <20200928083429.17390-8-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <e38f9096-8b12-309f-f910-b7fe0843c902@ti.com>
Date:   Wed, 30 Sep 2020 16:54:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928083429.17390-8-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/09/2020 11:34, Peter Ujfalusi wrote:
> The sysfw ring configuration message has been extended to include virtid
> and asel value for the ring.
> Add the ASEL_VALID to TI_SCI_MSG_VALUE_RM_ALL_NO_ORDER as it is required
> for DMA rings.
> 
> Instead of extending the current .config() ops - which would need same
> patch change in the ringacc driver - add ti_sci_msg_rm_ring_cfg struct and
> a new ops using it to configure the ring.
> 
> This will allow easy update path in case new members are added for the ring
> configuration.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   drivers/firmware/ti_sci.c              | 63 ++++++++++++++++++++++++++
>   drivers/firmware/ti_sci.h              |  7 +++
>   include/linux/soc/ti/ti_sci_protocol.h | 31 ++++++++++++-
>   3 files changed, 100 insertions(+), 1 deletion(-)
> 
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
