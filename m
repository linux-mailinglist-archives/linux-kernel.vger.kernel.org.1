Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9F3274135
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgIVLrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:47:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47904 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgIVLrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:47:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08MBknuH116918;
        Tue, 22 Sep 2020 06:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600775209;
        bh=vBbafl7fEA1/CjC7Cf2Do+x7azKOAfufAmMH0n8iMUY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=d2wmt7zlElrpCj4+tv8c8gcC/u9iOpKCAeyvlp06YqiwI7uZ2ake76Vcp6kLVxx9L
         7p1cHnfsSzinmpv+4cg5xhTx/skQsCA91qHxWORN8zxfbOdHiBrAYah1yW6JvUldGh
         i7JsMSAN+8Dhj4k4gW9Xew2GP8OCsqzt1P4c0xNA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08MBknCs078468
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 06:46:49 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Sep 2020 06:46:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Sep 2020 06:46:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08MBknuj013488;
        Tue, 22 Sep 2020 06:46:49 -0500
Date:   Tue, 22 Sep 2020 06:46:49 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Zou Wei <zou_wei@huawei.com>
CC:     <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH -next] firmware: ti_sci: Remove unneeded semicolon
Message-ID: <20200922114649.g3lpmdx2gcbgj7u4@akan>
References: <1600772344-79841-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1600772344-79841-1-git-send-email-zou_wei@huawei.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:59-20200922, Zou Wei wrote:
> Fixes coccicheck warning:
> 
> ./drivers/firmware/ti_sci.c:1759:2-3: Unneeded semicolon
> ./drivers/firmware/ti_sci.c:2191:2-3: Unneeded semicolon
> 
> Fixes: 9c19fb6895be ("firmware: ti_sci: Add support for RM core ops")
> Fixes: 68608b5e5063 ("firmware: ti_sci: Add resource management APIs for ringacc, psi-l and udma")
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/firmware/ti_sci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 896f53e..e0c8adf 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -1756,7 +1756,7 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
>  	} else {
>  		*range_start = resp->range_start;
>  		*range_num = resp->range_num;
> -	};
> +	}
>  
>  fail:
>  	ti_sci_put_one_xfer(&info->minfo, xfer);
> @@ -2188,7 +2188,7 @@ static int ti_sci_cmd_ring_get_config(const struct ti_sci_handle *handle,
>  			*size = resp->size;
>  		if (order_id)
>  			*order_id = resp->order_id;
> -	};
> +	}
>  
>  fail:
>  	ti_sci_put_one_xfer(&info->minfo, xfer);

Thanks.
Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
