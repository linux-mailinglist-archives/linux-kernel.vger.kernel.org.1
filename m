Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0030285A40
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgJGIPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:15:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43356 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgJGIPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:15:14 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0978F7pD107578;
        Wed, 7 Oct 2020 03:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602058507;
        bh=wqXQa7yDqeTfTN4+dVx9Ap6+imKExZWyNom9gVP47/I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=riBrpFE3gjypVvqiCcriCxFJndWJBkIcq0JtpIZ7tMTQXshIrRpPFZpCMF4DxYkRo
         IWpuO8gKC9WTkKQYeylTJ+gs+Auqm/sf7nL6RI1Zefz3U1gxxhlcIVBhM6M1XMzjii
         NKuqVoBNemdry7bhYM1anTTo7Nt+c9PT9KSzCMtQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0978F7VH001165
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Oct 2020 03:15:07 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 7 Oct
 2020 03:15:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 7 Oct 2020 03:15:04 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0978F1Xq119443;
        Wed, 7 Oct 2020 03:15:02 -0500
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzJdIHVzYjogY2RuczM6IFZhcmlhYmxlIOKAmGxl?=
 =?UTF-8?Q?ngth=e2=80=99_set_but_not_used?=
To:     Pawel Laszczak <pawell@cadence.com>, <balbi@kernel.org>
CC:     <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>
References: <20201007033932.23050-1-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <8994106d-2cc5-fa2c-bbcc-6526632ff80b@ti.com>
Date:   Wed, 7 Oct 2020 11:15:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007033932.23050-1-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/10/2020 06:39, Pawel Laszczak wrote:
> Patch removes not used variable 'length' from
> cdns3_wa2_descmiss_copy_data function.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Fixes: commit 141e70fef4ee ("usb: cdns3: gadget: need to handle sg case for workaround 2 case")

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>   drivers/usb/cdns3/gadget.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 6e7b70a2e352..692acf7b9b14 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -506,7 +506,6 @@ static void cdns3_wa2_descmiss_copy_data(struct cdns3_endpoint *priv_ep,
>   
>   	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
>   		int chunk_end;
> -		int length;
>   
>   		descmiss_priv_req =
>   			cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
> @@ -517,7 +516,6 @@ static void cdns3_wa2_descmiss_copy_data(struct cdns3_endpoint *priv_ep,
>   			break;
>   
>   		chunk_end = descmiss_priv_req->flags & REQUEST_INTERNAL_CH;
> -		length = request->actual + descmiss_req->actual;
>   		request->status = descmiss_req->status;
>   		__cdns3_descmiss_copy_data(request, descmiss_req);
>   		list_del_init(&descmiss_priv_req->list);
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
