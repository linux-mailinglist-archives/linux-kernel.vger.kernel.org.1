Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E312DDF59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbgLRICJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:02:09 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37748 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgLRICI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:02:08 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BI819MM074020;
        Fri, 18 Dec 2020 02:01:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608278469;
        bh=xcTb8qYiKGxzuikMSclKbE3udkTmV/7/x9FE2GiyPCY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=M6kmSKQhQqfl9YhUZn+PY7onXrKICFx16ivOSLZEzuUwQxoNPbe7/LhS3qT/Zf/NC
         BFQDS48jCOjy0hf/NCOlfy135TosuJM4QUTjUlI7hz5gfIqfMvfUxcosZgSISs+M99
         RxoLxSc6bxk4QMKcSYSPMz+zUgvRfYaBgmzUqxkc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BI819jR071370
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 02:01:09 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Dec 2020 02:01:08 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Dec 2020 02:01:08 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BI815GB029687;
        Fri, 18 Dec 2020 02:01:06 -0600
Subject: Re: [PATCH] dt-bindings: display: bridge: tc358768: Remove maintainer
 information
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <jernej.skrabec@siol.net>, <narmstrong@baylibre.com>,
        <airlied@linux.ie>, <jonas@kwiboo.se>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <a.hajda@samsung.com>, <robh+dt@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>
References: <20201215124227.1872-1-peter.ujfalusi@ti.com>
 <1608042367.307112.3775381.nullmailer@robh.at.kernel.org>
 <90d45716-4f4e-7379-07fd-74eff793e498@ti.com>
 <20201217172556.GA1339623@ravnborg.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <dfc9fe88-40c6-93c8-4c25-a0c977579ebf@ti.com>
Date:   Fri, 18 Dec 2020 10:02:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201217172556.GA1339623@ravnborg.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 17/12/2020 19.25, Sam Ravnborg wrote:
>>> dtschema/dtc warnings/errors:
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml: 'maintainers' is a required property
>>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml: ignoring, error in schema: 
>>> warning: no schema found in file: ./Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
>>
>> Right, so it is not that easy to not been able to maintain this... :o
>>
>> Who should be documented as maintainer?
>> Andrzej, Neil, David or Daniel?
> 
> I have no problem being listed as maintainer despite my very limited
> knowledge on the HW. So unless you end up volunteering then just
> add me.

thank you. it is not easy to give up on something one has spent time on,
but without the hardware and manual it would be not right to just move
it to my private email as I did for the DMA and Audio drivers:

https://lore.kernel.org/lkml/20201215130512.8753-1-peter.ujfalusi@ti.com/

https://lore.kernel.org/lkml/20201215131348.11282-1-peter.ujfalusi@ti.com/

I'll send v2 as may last patch from ti.com

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
