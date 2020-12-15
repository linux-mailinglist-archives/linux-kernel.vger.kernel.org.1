Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E068A2DAFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgLOPVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:21:10 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39404 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgLOPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:21:10 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BFFJHNi087003;
        Tue, 15 Dec 2020 09:19:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608045557;
        bh=IiBIuwWLd+/N9utzdTqFy9iYAwPYd+SNDmJ8szz0ebs=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=pQ00NHK/AGDChuYikM5txlxbm6K/Gsuv9OUh976s6BwIw5y4BgzwEvaPV9eI4N7z+
         /aUXPCpvmvAUYT3B1uxRnG3IEuAQV+CKwH7atALj79PuP0E17+Qop/w2ep3xg5ELHQ
         BHnzkSFZ4ALLDCeKJqmE5PG7/8BWFwUDZEnsQFEc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BFFJHax045012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 09:19:17 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Dec 2020 09:19:17 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Dec 2020 09:19:17 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BFFJFJ8104203;
        Tue, 15 Dec 2020 09:19:16 -0600
Subject: Re: [PATCH -next] drm: omapdrm: Delete useless kfree code
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20201214134628.4937-1-zhengyongjun3@huawei.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <abb56979-eb18-a13c-6c0c-25d3b814c48a@ti.com>
Date:   Tue, 15 Dec 2020 17:19:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201214134628.4937-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2020 15:46, Zheng Yongjun wrote:
> The parameter of kfree function is NULL, so kfree code is useless, delete it.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>   drivers/gpu/drm/omapdrm/tcm-sita.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/tcm-sita.c b/drivers/gpu/drm/omapdrm/tcm-sita.c
> index 817be3c41863..af59e9c03917 100644
> --- a/drivers/gpu/drm/omapdrm/tcm-sita.c
> +++ b/drivers/gpu/drm/omapdrm/tcm-sita.c
> @@ -254,6 +254,5 @@ struct tcm *sita_init(u16 width, u16 height)
>   	return tcm;
>   
>   error:
> -	kfree(tcm);
>   	return NULL;
>   }

Thanks, I'll merge this.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
