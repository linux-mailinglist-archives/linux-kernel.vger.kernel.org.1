Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E441EDFF8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 10:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgFDIpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 04:45:00 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:48268 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727026AbgFDIo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:44:58 -0400
Received: from [37.160.65.106] (port=1546 helo=[192.168.43.3])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jglUd-000GGv-Jr; Thu, 04 Jun 2020 10:44:55 +0200
Subject: Re: [RFC 2/4] regulator: lp87565: dt: remove duplicated section
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Axel Lin <axel.lin@ingics.com>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
 <20200603200319.16184-3-luca@lucaceresoli.net> <20200604064734.GS3714@dell>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <ca06e449-c0cd-311d-a1ab-1c212352b8cf@lucaceresoli.net>
Date:   Thu, 4 Jun 2020 10:44:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604064734.GS3714@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

thanks for the very prompt review!

On 04/06/20 08:47, Lee Jones wrote:
> On Wed, 03 Jun 2020, Luca Ceresoli wrote:
> 
>> The "Required properties:" section is copied verbatim for each of the two
>> supported chips. In preparation to add a new chip variant make it a common
>> section and keep the two examples to differentiate between the two chips.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>>  .../devicetree/bindings/mfd/lp87565.txt       | 21 ++++---------------
>>  1 file changed, 4 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/lp87565.txt b/Documentation/devicetree/bindings/mfd/lp87565.txt
>> index 41671e0dc26b..b75ae23a1ef3 100644
>> --- a/Documentation/devicetree/bindings/mfd/lp87565.txt
>> +++ b/Documentation/devicetree/bindings/mfd/lp87565.txt
>> @@ -1,7 +1,7 @@
>>  TI LP87565 PMIC MFD driver
>>  
>>  Required properties:
>> -  - compatible:	"ti,lp87565", "ti,lp87565-q1"
>> +  - compatible:		one of "ti,lp87565", "ti,lp87565-q1", "ti,lp87561-q1"
> 
> What happened to your tabbing here?

Looks weird, but I actually fixed it. The patch format is misleading, it
you look at the file you'll see there's a missing tab there before the
patch. Hm, guess I should have mentioned it in the commit message, will
do in v2.

> All the other entries start with a capital letter.  So should this.

Right.

-- 
Luca
