Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEFC271F58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgIUJzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:55:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4126 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbgIUJzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:55:08 -0400
X-Greylist: delayed 1675 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 05:55:06 EDT
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08L9NIRM030944;
        Mon, 21 Sep 2020 11:26:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=SxC5y+mXZZSNchwDuU2t3Zth2X164XhsRrYANymsVQc=;
 b=wH8d2hYHXKkEm/9E45YgiBFiEANU5yXYenE1oQUy+pZ07QTv1/U7hSCwRWcVK6Eksc+c
 HY9YNnV3rtblztxM9Sd7nP4zr/TZltoFXKcJUSw0e1UICPxKmU0M3x72NaoJVGZWRa7T
 s0xSnIsyurB+Ll67SgaaF4DmfV5WcXUelom7TYNBSjsGvrNSO8XS8N7gb1ojodrAPy6A
 s3LMcYOpQwErAU8+GdEIvhbWFOT6Crt8LjnLlbwNMfsdK3QY6RD2o2Ly6KDrASr0Ujo3
 xZ8s2CzMHibJHhV8zTkfp0Qqz3+GbYkZs5iNOvnxt5geaVWnMo1kohOrPi226mfDzX9u dA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33n747seav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Sep 2020 11:26:47 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C47B710002A;
        Mon, 21 Sep 2020 11:26:45 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 92E6F21FEBE;
        Mon, 21 Sep 2020 11:26:45 +0200 (CEST)
Received: from lmecxl0923.lme.st.com (10.75.127.49) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 11:26:44 +0200
Subject: Re: [PATCH] irqchip/stm32: fix return value of
 stm32_exti_h_set_affinity
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20200612072901.14388-1-ludovic.barre@st.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <272066d2-35db-0441-a49d-9315894ae674@st.com>
Date:   Mon, 21 Sep 2020 11:26:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200612072901.14388-1-ludovic.barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-21_01:2020-09-21,2020-09-20 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

Just a gentleman ping about this patch.
I verified, you could always apply this patch on linux master branch.

Regards
Ludo

Le 6/12/20 à 9:29 AM, Ludovic Barre a écrit :
> exti hardware point of view, there is no specific action on set_affinity.
> So the affinity must be forwarded to parent if there is a
> descendent irqchips, otherwise just return IRQ_SET_MASK_OK_DONE.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>   drivers/irqchip/irq-stm32-exti.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
> index faa8482c8246..1a0a60ee7140 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -555,7 +555,7 @@ static int stm32_exti_h_set_affinity(struct irq_data *d,
>   	if (d->parent_data->chip)
>   		return irq_chip_set_affinity_parent(d, dest, force);
>   
> -	return -EINVAL;
> +	return IRQ_SET_MASK_OK_DONE;
>   }
>   
>   static int __maybe_unused stm32_exti_h_suspend(void)
> 
