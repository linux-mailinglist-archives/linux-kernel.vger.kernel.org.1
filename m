Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2489127DF37
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 06:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgI3EQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 00:16:24 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52699 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI3EQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 00:16:24 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4C1NH905Lnz1qs3c;
        Wed, 30 Sep 2020 06:16:21 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4C1NH85hlxz1r0lV;
        Wed, 30 Sep 2020 06:16:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id uocxygdTIoRI; Wed, 30 Sep 2020 06:16:18 +0200 (CEST)
X-Auth-Info: IvmyAxbJEAd69WOlatFN9LfnQYIdwtjZzEUk+GsQJZc=
Received: from [192.168.1.106] (82-131-157-111.pool.digikabel.hu [82.131.157.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 30 Sep 2020 06:16:18 +0200 (CEST)
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-12-krzk@kernel.org>
 <2a329c9b-8bfc-fbd8-62a3-759f608347d6@denx.de>
Reply-To: hs@denx.de
From:   Heiko Schocher <hs@denx.de>
Message-ID: <686af5e6-d16a-7750-e47f-1ced9cb6c34a@denx.de>
Date:   Wed, 30 Sep 2020 06:16:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <2a329c9b-8bfc-fbd8-62a3-759f608347d6@denx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

Am 28.09.2020 um 06:04 schrieb Heiko Schocher:
> Hello Krzysztof,
> 
> Am 26.09.2020 um 18:28 schrieb Krzysztof Kozlowski:
>> Document binding for an unknown entity Aristainetos with few boards
>> mainlined.
>>
>> Cc: Heiko Schocher <hs@denx.de>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>
>> ---
>>
>> I tried to Google but except the patches from Heiko Schocher, I could
>> not find any meaningful data.
>>
>> Heiko, you posted this. Do you know what is it?
> 
> aristainetos is the name of the board, so it is not the vendor name.
> 
> I just asked the customer if we can add a valid vendor name...

Ok, it is not easy to get an okay from the customer to publish
his name.

Is there a dummy or unknown entry for vendor?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
