Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC90828AFEC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgJLIQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:16:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44450 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgJLIQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:16:44 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09C8GZuf098418;
        Mon, 12 Oct 2020 03:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602490595;
        bh=n39Krt8LWMfBKfq39pnWds8VbAZOF+IQjxmrqmorgfs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Vbu17lwYM2NEDPMmZuAzMccD5fZN2sCO9APZGaWr5gqZFcW+f6MCkFHCPZn/9hzgK
         vdUbEOUMV5inCqFjgmDWYp6wYy9E6y8P35llPwyFVrYK+BjFEzV6y9SrgFboW5Rf2k
         UiStKbc+Q83fDAFdu0jtHibaWiAKqTP/x7Y8tOs4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09C8GZlo012100
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 03:16:35 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 12
 Oct 2020 03:16:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 12 Oct 2020 03:16:35 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09C8GWi5051101;
        Mon, 12 Oct 2020 03:16:33 -0500
Subject: Re: [PATCH v2] usb: cdns3: Variable 'length' set but not used
To:     Pawel Laszczak <pawell@cadence.com>, <balbi@kernel.org>
CC:     <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>
References: <20201012064548.8725-1-pawell@cadence.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <902c4a1b-a5f1-b0ed-b2d6-af5c2893fee2@ti.com>
Date:   Mon, 12 Oct 2020 11:16:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012064548.8725-1-pawell@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/2020 09:45, Pawel Laszczak wrote:
> Patch removes not used variable 'length' from
> cdns3_wa2_descmiss_copy_data function.
> 
> Fixes: 141e70fef4ee ("usb: cdns3: gadget: need to handle sg case for workaround 2 case")
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
> Changelog:
> v2
> - added "Fixes" tag.
> 
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
