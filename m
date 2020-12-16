Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8C12DBC2F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 08:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgLPHo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 02:44:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49336 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgLPHo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 02:44:57 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BG7hxf7017765;
        Wed, 16 Dec 2020 01:43:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608104639;
        bh=byAY0YOySDZHqN3AMHRmiG2cAHMSpPrHA212GEHba1k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vxyzAt/MjY7EdKOjyQW80QXWKobbukKS/c9jb8SeKGQ0ScGPA5okiop9qJzYH3znF
         5Ef1wuciuo9jYktpk5SoYwR8n0XrxMcvZ8I061EzjQl1JVn/KekqN9Op5Wda4ploNr
         HlMGzptpZgREOr6PVdmI7KK0U5RlER5HWkv2jIIY=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BG7hxxF074913
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 01:43:59 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Dec 2020 01:43:58 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Dec 2020 01:43:58 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BG7ht1Q114860;
        Wed, 16 Dec 2020 01:43:56 -0600
Subject: Re: [PATCH] dt-bindings: display: bridge: tc358768: Remove maintainer
 information
To:     Rob Herring <robh@kernel.org>
CC:     <robh+dt@kernel.org>, <a.hajda@samsung.com>, <jonas@kwiboo.se>,
        <narmstrong@baylibre.com>, <airlied@linux.ie>,
        <jernej.skrabec@siol.net>, <linux-kernel@vger.kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>
References: <20201215124227.1872-1-peter.ujfalusi@ti.com>
 <1608042367.307112.3775381.nullmailer@robh.at.kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <90d45716-4f4e-7379-07fd-74eff793e498@ti.com>
Date:   Wed, 16 Dec 2020 09:44:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1608042367.307112.3775381.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/12/2020 16.26, Rob Herring wrote:
> On Tue, 15 Dec 2020 14:42:27 +0200, Peter Ujfalusi wrote:
>> My employment with TI is coming to an end and I will not have access to
>> the board where this bridge is connected to.
>>
>> It is better to remove a soon bouncing email address.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  .../devicetree/bindings/display/bridge/toshiba,tc358768.yaml   | 3 ---
>>  1 file changed, 3 deletions(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml: 'maintainers' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml: ignoring, error in schema: 
> warning: no schema found in file: ./Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml

Right, so it is not that easy to not been able to maintain this... :o

Who should be documented as maintainer?
Andrzej, Neil, David or Daniel?

I will have no access to the EVM (I no longer have) and the
documentation is going to be wiped along with the disk as well...

> See https://patchwork.ozlabs.org/patch/1416419
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
