Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A45A2F3617
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405428AbhALQp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:45:56 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:44433 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728150AbhALQp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:45:56 -0500
Received: from [185.56.157.72] (port=32796 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kzMn9-0031SN-97; Tue, 12 Jan 2021 17:45:11 +0100
Subject: Re: [RFC 2/2] clk: vc5: Add support for optional load capacitance
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210106173900.388758-1-aford173@gmail.com>
 <20210106173900.388758-2-aford173@gmail.com>
 <c5a97aca-ce74-bbd3-e99d-358e079c4c4a@lucaceresoli.net>
 <CAHCN7x+gUQwv4cWgg7Jt2oca1n4KW=o08rzoK9TB1Z_rKE0qog@mail.gmail.com>
 <e64a590d-1b3a-73cd-fb93-970013385224@lucaceresoli.net>
 <CAHCN7x+NFTn9Jqzbdm7d2UZt68DSAZ9Z-r+7Txwqi1=eE=W3Ug@mail.gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <e50740b9-4ab1-bb14-da51-acd3f98fab1b@lucaceresoli.net>
Date:   Tue, 12 Jan 2021 17:45:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHCN7x+NFTn9Jqzbdm7d2UZt68DSAZ9Z-r+7Txwqi1=eE=W3Ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 11/01/21 17:40, Adam Ford wrote:
> On Sat, Jan 9, 2021 at 12:02 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>>
>> Hi Adam,
>>
>> On 09/01/21 04:00, Adam Ford wrote:
>>> On Fri, Jan 8, 2021 at 4:49 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>>>>
>>>> Hi Adam,
>>>>
>>>> On 06/01/21 18:39, Adam Ford wrote:
>>>>> There are two registers which can set the load capacitance for
>>>>> XTAL1 and XTAL2. These are optional registers when using an
>>>>> external crystal.  Parse the device tree and set the
>>>>> corresponding registers accordingly.
>>>>
>>>> No need to repeat the first 2 sentences, they are already in patch 1.
>>>
>>> The reason I did that was because if someone does a git log on the
>>> individual file, they'd see the comment.  While it's redundant not, it
>>> might not be as obvious in the future when looking back.   Not
>>> everyone reviews the history of the binding, but the source files' git
>>> logs usually have some value.   However, if you want me to drop it or
>>> rephrase it, I can do that.
>>
>> Makes sense, I had never considered that before.
>>
>>>>> +static int vc5_map_cap_value(u32 femtofarads)
>>>>> +{
>>>>> +     int mapped_value;
>>>>> +
>>>>> +     /* The datasheet explicitly states 9000 - 25000 */
>>>>> +     if ((femtofarads < 9000) || (femtofarads > 25000))
>>>>> +             return -EINVAL;
>>>>> +
>>>>> +     /* The lowest target we can hit is 9430, so exit if it's less */
>>>>> +     if (femtofarads < 9430)
>>>>> +             return 0;
>>>>> +
>>>>> +     /*
>>>>> +      * According to VersaClock 6E Programming Guide, there are 6
>>>>> +      * bits which translate to 64 entries in XTAL registers 12 and
>>>>> +      * 13. Because bits 0 and 1 increase the capacitance the
>>>>> +      * same, some of the values can be repeated.  Plugging this
>>>>> +      * into a spreadsheet and generating a trendline, the output
>>>>> +      * equation becomes x = (y-9098.29) / 216.44, where 'y' is
>>>>> +      * the desired capacitance in femtofarads, and x is the value
>>>>> +      * of XTAL[5:0].
>>>>> +      * To help with rounding, do fixed point math
>>>>> +      */
>>>>> +     femtofarads *= 100;
>>>>> +     mapped_value = (femtofarads - 909829) / 21644;
>>>>
>>>> Thanks for the extensive comment, but I am confused. Not by your code
>>>> which is very clean and readable, but by the chip documentation
>>>> (disclaimer: I haven't read it in full depth).
>>>
>>> I was confused too since the datasheet and programmers manual differ a bit.
>>>>
>>>> The 5P49V6965 datasheet at page 17 clearly states capacitance can be
>>>> increased in 0.5 pF steps. The "VersaClock 6E Family Register
>>>> Descriptions and Programming Guide" at page 18 shows a table that allows
>>>> 0.43 pF. Can you clarify how the thing works?
>>>
>>> I used the Versaclock 6E doc which is based on the following:
>>>
>>> BIT 5 - Add 6.92pF
>>> BIT 4 - Add 3.46pF
>>> BIT 3 - Add 1.73pF
>>> BIT 2 - Add 0.86pF
>>> Bit 1 - Add 0.43pF
>>> Bit 0 - Add 0.43pF
>>>
>>> Because the Datasheet starts at 9pF, the math I used, assumes these
>>> numbers are added to 9pF.
>>> Because the datasheet shows the increments are in .5pF increments, the
>>> 430nF seems close.  The datasheet shows 9pF - 25pF and based on the
>>> programmer table, we could get close to 25pF by enabling all bits and
>>> adding 9pF, however the math doesn't quite hit 25pF.
>>>
>>> For what it's worth I needed around 11.5pF, and with this patch, the
>>> hardware engineer said our ppm went from around 70 ppm to around 4ppm.
>>
>> Did he measure what happens if you set the register according to the 0.5
>> pF interpretation? Does it improve? I understand the difference is
>> probably olwer than the noise, but who knows.
>>
>>>>> +
>>>>> +     /*
>>>>> +      * The datasheet states, the maximum capacitance is 25000,
>>>>> +      * but the programmer guide shows a max value is 22832,
>>>>> +      * so values higher values could overflow, so cap it.
>>>>> +      */
>>>>
>>>> The 22832 limit is if you assume 0.43 pF steps. Assuming 0.5 pF steps
>>>> leads to 25000. Now I am more confused than before.
>>>
>>> I agree.  It would be nice to get some clarification from Renesas.
>>
>> Definitely. Do you have access to some support from them?
> 
> Luca,
> 
> We reached out to  Renesas with the following questions:
> 
> 1)
> I'm seeing a discrepancy between the datasheet and programming guide
> we have for the Versaclock 6e in regard to the crystal load
> programming registers.  The datasheet for the 5P49V6965A000NLGI
> indicates a 9pF minimum with 0.5pF steps, while the programming guide
> says that the lower two register bits both add 0.43pF, which would
> make the equation:
> 
> Ci = 9pF + 0.43pF * XTAL[5:1] instead of
> Ci = 9pF + 0.5pF * XTAL[5:0] as is published in the datasheet.
> 
> 2)  The programming guide shows that the default setting is 01b, but
> the note says it's reserved, use D1 D0 = 00.  Can you confirm that we
> should set switch mode to 00 instead of the default 01?
> 
> And we got the following answers:
> 
> 1)
>      The first one with 0.43pF steps is the correct one. Ci = 9pF +
> 0.43pF * XTAL[5:1]
>      0.5pF steps was the design target.  When measuring actual
> silicon, we found 0.43pF steps.
> 
>      There are 6 bits reserved for the CL setting but bits 0 and 1
> have the same 0.43pF step.  So it is actually 5 bits with an extra LSB
> of 0.43pF.
> 
> 2)
>       Please use D1 D0 = 01.   The “00” is a typo…..

Great thing you got all those info from Renesas!

> 
> Based on the above response I think we should always assume XTAL bit 0
> is 0, and only use XTAL[5:1] which should make the math go easier,
> because the desired value in femtofarads would just be offset by 9000
> and divided by 430 and that value would be shifted 3 places instead fo
> two, and the  fixed-point math calculation can go away.
> 
> In addition to that, I would also need to make sure that D0 is set to
> 1, so instead of just writing the shifted XTAL value, I would also
> have to do a logic OR with 1 to set the low bit.
> 
> I talked with the hardware guys from work who also suggested that we
> always write the same value to X1 and X2, so I can remove the X1 and
> X2 references from the bindings.
> 
> Does that work for you?

Yes.

We are only losing the ability to set 9 + (0.43 * 32) pF using all bits.
I'm OK with that. Should it be needed in the future we can just add it
as a special case, maybe just add a comment saying that, like "XTAL[5:0]
= b111111 not supported".

-- 
Luca
