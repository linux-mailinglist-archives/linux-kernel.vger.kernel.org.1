Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129961F8BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 02:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgFOAyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 20:54:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55534 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgFOAyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 20:54:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05F0s4je018923;
        Sun, 14 Jun 2020 19:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592182444;
        bh=Oz1YSn/W4SBlIArRiGTjbpxWU3lZEZJtI7nMR5vuj2A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TpMr33nXRNu4XFwe7YcxGBrt6qekjfnr0T5oHJ7PvYmk12F2HuVqGD7s4W0iDI7Fj
         5npvSececNaodoptz0tmUZPsNcPL6GoUyY9m/cJ2MMLPgwYroiHstb4dM3CqsLKKDY
         cl4ypxYw2taQRKO45oUo3jqqpEm0LoIb6MnvB4yU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05F0s48b004590
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 14 Jun 2020 19:54:04 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 14
 Jun 2020 19:54:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 14 Jun 2020 19:54:04 -0500
Received: from [10.250.232.146] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05F0s0TC057768;
        Sun, 14 Jun 2020 19:54:01 -0500
Subject: Re: [RFC 2/4] regulator: lp87565: dt: remove duplicated section
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        Rob Herring <robh@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Axel Lin <axel.lin@ingics.com>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
 <20200603200319.16184-3-luca@lucaceresoli.net>
 <20200612221954.GA3919662@bogus>
 <532c0ac1-b520-3443-1f8f-12fd87011076@lucaceresoli.net>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <38c5b884-30ac-730f-600b-9708c24bf670@ti.com>
Date:   Mon, 15 Jun 2020 06:24:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <532c0ac1-b520-3443-1f8f-12fd87011076@lucaceresoli.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2020 1:30 AM, Luca Ceresoli wrote:
> Hi Rob, Keerthy,
> 
> On 13/06/20 00:19, Rob Herring wrote:
>> On Wed, Jun 03, 2020 at 10:03:17PM +0200, Luca Ceresoli wrote:
>>> The "Required properties:" section is copied verbatim for each of the two
>>> supported chips. In preparation to add a new chip variant make it a common
>>> section and keep the two examples to differentiate between the two chips.
>>>
>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>> ---
>>>   .../devicetree/bindings/mfd/lp87565.txt       | 21 ++++---------------
>>>   1 file changed, 4 insertions(+), 17 deletions(-)
>>
>> If you want to clean this up, can you convert it to DT schema?
> 
> Sure, no problem. My only question is who should I set in the
> "maintainers" property.
> 
> Keerty, as the original author and TI employee, you surely know this
> chip series much better than I do. Would you like to be the maintainer
> for this binding document? Otherwise I can do it "best effort".

Hi Luca,

You can add me as the maintainer.

Regards,
Keerthy
> 
> Regards,
> 
