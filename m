Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F1227E652
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgI3KOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3KOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:14:24 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EFDC061755;
        Wed, 30 Sep 2020 03:14:24 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4C1XDC5pfLz1rvxy;
        Wed, 30 Sep 2020 12:14:19 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4C1XDC4QNmz1qwSd;
        Wed, 30 Sep 2020 12:14:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id lSjqKsdcroXZ; Wed, 30 Sep 2020 12:14:17 +0200 (CEST)
X-Auth-Info: 3Km55nFviOQ9m+t7cmTtalmXRGV8uRb8HejNlpesE8M=
Received: from [192.168.1.106] (82-131-157-111.pool.digikabel.hu [82.131.157.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 30 Sep 2020 12:14:17 +0200 (CEST)
Reply-To: hs@denx.de
Subject: Re: [RFC 12/14] dt-bindings: vendor-prefixes: add Aristainetos
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-12-krzk@kernel.org>
 <2a329c9b-8bfc-fbd8-62a3-759f608347d6@denx.de>
 <686af5e6-d16a-7750-e47f-1ced9cb6c34a@denx.de>
 <CAJKOXPe7XOQspzTFDRtb=y79mwXEZSGiYiQP3J58JMjCkVRSCQ@mail.gmail.com>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <abccfe07-4218-50a2-346b-bde77d1a987e@denx.de>
Date:   Wed, 30 Sep 2020 12:14:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAJKOXPe7XOQspzTFDRtb=y79mwXEZSGiYiQP3J58JMjCkVRSCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

Am 30.09.2020 um 09:11 schrieb Krzysztof Kozlowski:
> On Wed, 30 Sep 2020 at 06:16, Heiko Schocher <hs@denx.de> wrote:
>>
>> Hello Krzysztof,
>>
>> Am 28.09.2020 um 06:04 schrieb Heiko Schocher:
>>> Hello Krzysztof,
>>>
>>> Am 26.09.2020 um 18:28 schrieb Krzysztof Kozlowski:
>>>> Document binding for an unknown entity Aristainetos with few boards
>>>> mainlined.
>>>>
>>>> Cc: Heiko Schocher <hs@denx.de>
>>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>>
>>>> ---
>>>>
>>>> I tried to Google but except the patches from Heiko Schocher, I could
>>>> not find any meaningful data.
>>>>
>>>> Heiko, you posted this. Do you know what is it?
>>>
>>> aristainetos is the name of the board, so it is not the vendor name.
>>>
>>> I just asked the customer if we can add a valid vendor name...
>>
>> Ok, it is not easy to get an okay from the customer to publish
>> his name.
>>
>> Is there a dummy or unknown entry for vendor?
> 
> We could use "denx" as it was done as part of your work or "linux".
> Rob, any hints here?

Ok we can use as vendor "abb" in all DTS files and regarding your
change in Documentation/devicetree/bindings/vendor-prefixes.yaml
it can be:

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml 
b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 789a01b3d93a..bb4c85f00c8f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -105,6 +105,8 @@ patternProperties:
      description: arcx Inc. / Archronix Inc.
    "^aries,.*":
      description: Aries Embedded GmbH
+  "^abb,.*":
+    description: ABB
    "^arm,.*":
      description: ARM Ltd.
    "^armadeus,.*":

Would you work in this changes?

Many thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
