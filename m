Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5800420B90D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 21:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgFZTIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 15:08:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37854 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFZTIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 15:08:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05QJ7Uix127728;
        Fri, 26 Jun 2020 14:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593198450;
        bh=RXgIqTsjjsVGtkFNUb/fZEasvCl1DphpAUN05XsW4DM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Vpyhr2o56Xc2AZoBzTQIF4mORPsX27UycN3QjyplDHbMW7AbxhGb4Qgfntffrtblu
         j7Ij3mTY98mhv5kMPAtMptVx3t+UBZY+x33RcAkWwkYHkKxXin5lkl89/dcahb3PrZ
         5dSQEY7GG/B935JZC7ZVyxZQNSOqyFw9QK6buXBc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05QJ7TOQ064942
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Jun 2020 14:07:29 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 26
 Jun 2020 14:07:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 26 Jun 2020 14:07:29 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05QJ7QwW063032;
        Fri, 26 Jun 2020 14:07:27 -0500
Subject: Re: [PATCH 1/3] irqchip/ti-sci-inta: Remove dead code in
 ti_sci_inta_set_type()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     Xuefeng Li <lixuefeng@loongson.cn>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1591437017-5295-1-git-send-email-yangtiezhu@loongson.cn>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <b1bd0bb8-a1cb-120a-b075-b8fa1886c8a8@ti.com>
Date:   Fri, 26 Jun 2020 22:07:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591437017-5295-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/06/2020 12:50, Tiezhu Yang wrote:
> In the function ti_sci_inta_set_type(), the statement "return -EINVAL;"
> out of switch case is dead code, remove it.
> 

Fixes: 9f1463b86c13 ("irqchip/ti-sci-inta: Add support for Interrupt Aggregator driver")
Right?

> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   drivers/irqchip/irq-ti-sci-inta.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
> index 7e3ebf6..c20c9f7 100644
> --- a/drivers/irqchip/irq-ti-sci-inta.c
> +++ b/drivers/irqchip/irq-ti-sci-inta.c
> @@ -433,8 +433,6 @@ static int ti_sci_inta_set_type(struct irq_data *data, unsigned int type)
>   	default:
>   		return -EINVAL;
>   	}
> -
> -	return -EINVAL;
>   }
>   
>   static struct irq_chip ti_sci_inta_irq_chip = {
> 

For all 3 patches:
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

And you might need re-send it with  --cover-letter
-- 
Best regards,
grygorii
