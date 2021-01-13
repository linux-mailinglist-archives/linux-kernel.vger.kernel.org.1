Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE852F4D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbhAMOhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:37:33 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:58913 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726433AbhAMOhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:37:32 -0500
Received: from [185.56.157.72] (port=39770 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kzhGT-00E4X8-5N; Wed, 13 Jan 2021 15:36:49 +0100
Subject: Re: [RFC 1/2] dt-bindings: clk: versaclock5: Add load capacitance
 properties
To:     Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210106173900.388758-1-aford173@gmail.com>
 <20210113031602.GA1443816@robh.at.kernel.org>
 <CAHCN7xKLRj=bbMQAXNDZ+8cHh+jon5Bb7GdQYpVUos91uiV5Tw@mail.gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <8f896ca0-d270-787c-74c9-2bca91ccf7f2@lucaceresoli.net>
Date:   Wed, 13 Jan 2021 15:36:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHCN7xKLRj=bbMQAXNDZ+8cHh+jon5Bb7GdQYpVUos91uiV5Tw@mail.gmail.com>
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

On 13/01/21 13:31, Adam Ford wrote:
> On Tue, Jan 12, 2021 at 9:16 PM Rob Herring <robh@kernel.org> wrote:
>>
>> On Wed, Jan 06, 2021 at 11:38:59AM -0600, Adam Ford wrote:
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
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> Already has a type, so you can drop the $ref.
>>
>>> +    minimum: 9000
>>> +    maximum: 25000
> 
> Luca,
> 
> Do you want the range to the 9000 - 25000 per the datasheet, or should
> I use the max value based on the programmer guide?  Currently, my
> intent was to cap the value to 11111b, so anyone who writes 23000,
> 24000, or 25000 will all be the same value based on the feedback I got
> from Renesas.

DT should describe the HW, so I'd use the same range that can be set in
hardware, regardless of driver support. Thus it should be:

9000 - [9000 + 430 * 32] = 9000 - 22760

-- 
Luca
