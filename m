Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9961F2F4D63
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbhAMOkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:40:19 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:54778 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725858AbhAMOkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:40:18 -0500
Received: from [185.56.157.72] (port=39782 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kzhJA-00E61H-5h; Wed, 13 Jan 2021 15:39:36 +0100
Subject: Re: [RFC 1/2] dt-bindings: clk: versaclock5: Add load capacitance
 properties
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210106173900.388758-1-aford173@gmail.com>
 <833e228f-6fb5-ae98-a367-9566cf5fcf69@lucaceresoli.net>
 <CAHCN7x+57x4WLbq0+7OCPhJs-1=7SJidVHD2jYjdbqn_F+d3dA@mail.gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <7bad753d-a551-8810-7b12-5ec5ea9263d4@lucaceresoli.net>
Date:   Wed, 13 Jan 2021 15:39:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHCN7x+57x4WLbq0+7OCPhJs-1=7SJidVHD2jYjdbqn_F+d3dA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 09/01/21 03:48, Adam Ford wrote:
> On Fri, Jan 8, 2021 at 4:49 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>>
>> Hi Adam,
>>
>> On 06/01/21 18:38, Adam Ford wrote:
>>> There are two registers which can set the load capacitance for
>>> XTAL1 and XTAL2. These are optional registers when using an
>>> external crystal.  Update the bindings to support them.
>>>
>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>> ---
>>>  .../devicetree/bindings/clock/idt,versaclock5.yaml   | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
>>> index 2ac1131fd922..e5e55ffb266e 100644
>>> --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
>>> @@ -59,6 +59,18 @@ properties:
>>>      minItems: 1
>>>      maxItems: 2
>>>
>>> +  idt,xtal1-load-femtofarads:
>>
>> I wonder whether we should have a common, vendor independent property.
> 
> That would be nice.
> 
>> In mainline we have xtal-load-pf (ti,cdce925.txt bindings) which has no
>> vendor prefix. However I don't know how much common it is to need
> 
> rtc-pcf85063.c uses  quartz-load-femtofarads, so there is already some
> discrepancy.
> 
> Since the unit of measure here is femtofarads, using pF in the name seems wrong.
> We need to read the data as a u32, so femtofarads works better than
> pF, which would require a decimal point.
> 
>> different loads for x1 and x2. Any hardware engineer around?
> 
> I talked to a hardware engineer where I work, and he said it makes
> sense to keep them the same.  I only separated them because there are
> two registers, and I assumed there might be a reason to have X1 and X2
> be different, but I'm ok with reading one value and writing it to two
> different registers.

If both your HW engineer and the Renesas docs say setting different
values is not useful in real life, and other drivers don't set different
values as well, it looks like that is the reasonable way. I think it
also increases likelihood of establishing a unique property name to be
used for all future chips.

-- 
Luca
