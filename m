Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A563727E77F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 13:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgI3LPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:15:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57990 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3LPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:15:03 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UBEwiw075667;
        Wed, 30 Sep 2020 06:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601464498;
        bh=cEjevU+tABlcZLSiAqUyr3WIL0O1JBNJ5d3k5kiw3Mw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=W3kmVr46sIcwEgCPhx12HxuNMziz+dmuJy2eXm8Z7d6rxpeVAceLiMCVwYmsnSgGR
         MKBUlqD1p6oX00sihWL78HczfaNNAczBiPs+q0FhtzVDUgDw1hy9Q8fzUBi8NX0MSN
         IwofYoKQbMkswFlrGsn0Ntssh5JIFn286AM7Y2os=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UBEwkW033474;
        Wed, 30 Sep 2020 06:14:58 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 06:14:58 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 06:14:58 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UBEqf9128800;
        Wed, 30 Sep 2020 06:14:54 -0500
Subject: Re: [PATCH 06/11] firmware: ti_sci: rm: Remove ring_get_config
 support
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <nm@ti.com>,
        <t-kristo@ti.com>, <ssantosh@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200928083429.17390-1-peter.ujfalusi@ti.com>
 <20200928083429.17390-7-peter.ujfalusi@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <58b90ef1-8fa4-50de-b8aa-911346b45576@ti.com>
Date:   Wed, 30 Sep 2020 14:14:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928083429.17390-7-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/09/2020 11:34, Peter Ujfalusi wrote:
> The ring_get_cfg (0x1111 message) is not used and it is not supported by
> sysfw for a long time.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   drivers/firmware/ti_sci.c              | 80 --------------------------
>   drivers/firmware/ti_sci.h              | 44 --------------
>   include/linux/soc/ti/ti_sci_protocol.h |  6 --
>   3 files changed, 130 deletions(-)
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
Best regards,
grygorii
