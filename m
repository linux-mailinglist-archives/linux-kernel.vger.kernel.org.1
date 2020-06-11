Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A011F6E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 21:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgFKTqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 15:46:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47260 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFKTqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:46:30 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05BJkS46079079;
        Thu, 11 Jun 2020 14:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591904788;
        bh=YuZ2zHvyVYgqCnf9DRpBa7biybrInY1I5skTmeiufwg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eG3gnZ8I3nuo/xoBOhCjGiv9DwcJfrbOEmBEwHmt1PGgGCJlcRtP8QiCm0i1UXU35
         7dGOC6UJX/ocCe9+qOISSkubkWRogmerY2khCoT46fV6sCglfcVEz352/chnk9VRwO
         39oSeVlJBRSiIhlXCG+d5X2KvfpRXdfZ+kjM870M=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05BJkSHk073200
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jun 2020 14:46:28 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 11
 Jun 2020 14:46:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 11 Jun 2020 14:46:28 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05BJkSnu093360;
        Thu, 11 Jun 2020 14:46:28 -0500
Subject: Re: [RESEND PATCH] dt-bindings: property-units: Add picoseconds type
To:     <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200602164219.3159-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e7644623-e9c2-2ebc-8bbd-1bd5dea8942a@ti.com>
Date:   Thu, 11 Jun 2020 14:46:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602164219.3159-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bump

On 6/2/20 11:42 AM, Dan Murphy wrote:
> Add the '-ps' picosecond unit suffix for property names.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   Documentation/devicetree/bindings/property-units.txt | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/property-units.txt b/Documentation/devicetree/bindings/property-units.txt
> index e9b8360b3288..00094070bdac 100644
> --- a/Documentation/devicetree/bindings/property-units.txt
> +++ b/Documentation/devicetree/bindings/property-units.txt
> @@ -17,6 +17,7 @@ Time/Frequency
>   -ms		: millisecond
>   -us		: microsecond
>   -ns		: nanosecond
> +-ps		: picosecond
>   
>   Distance
>   ----------------------------------------
