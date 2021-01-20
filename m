Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7170B2FD378
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390804AbhATO5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:57:09 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:60660 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732216AbhATOqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:46:55 -0500
Received: from [90.222.153.26] (helo=[192.168.0.21])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1l2EkJ-0007l1-NJ; Wed, 20 Jan 2021 14:46:07 +0000
Subject: Re: [linux-safety] [PATCH] docs: Change reference that was to removed
 file
To:     Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        sudip.mukherjee@codethink.co.uk, linux-safety@lists.elisa.tech,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
References: <1611051980-3834-1-git-send-email-milan.lakhani@codethink.co.uk>
 <87y2gopjcx.fsf@meer.lwn.net>
 <CAL_Jsq+YW2K8YoLes8EAUy1WrFRzpYvtzvErOYbhw3zvZBoddQ@mail.gmail.com>
From:   Milan Lakhani <milan.lakhani@codethink.co.uk>
Message-ID: <e8534aeb-3fbb-ef40-4c50-aa306fada4d3@codethink.co.uk>
Date:   Wed, 20 Jan 2021 14:46:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+YW2K8YoLes8EAUy1WrFRzpYvtzvErOYbhw3zvZBoddQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob, Jon, I've submitted a new patch pointing the two broken 
links and also usage-model.rst all to 
https://www.devicetree.org.specifications/.

Milan

On 20/01/2021 01:07, Rob Herring wrote:
> On Tue, Jan 19, 2021 at 6:01 PM Jonathan Corbet <corbet@lwn.net> wrote:
>> Milan Lakhani <milan.lakhani@codethink.co.uk> writes:
>>
>> [CC += Rob]
>>
>>> There were two references to
>>> Documentation/devicetree/booting-without-of.rst for dtb format
>>> information. This file has been removed, so I have changed the links to
>>> Documentation/devicetree/usage-model.rst for this information, which
>>> itself points to https://elinux.org/Device_Tree_Usage for an overview of
>>> the device tree data format.
>>>
>>> Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>
>>> ---
>>>   Documentation/arm/booting.rst                | 2 +-
>>>   Documentation/translations/zh_CN/arm/Booting | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/arm/booting.rst b/Documentation/arm/booting.rst
>>> index a226345..5392d01 100644
>>> --- a/Documentation/arm/booting.rst
>>> +++ b/Documentation/arm/booting.rst
>>> @@ -128,7 +128,7 @@ it.  The recommended placement is in the first 16KiB of RAM.
>>>
>>>   The boot loader must load a device tree image (dtb) into system ram
>>>   at a 64bit aligned address and initialize it with the boot data.  The
>>> -dtb format is documented in Documentation/devicetree/booting-without-of.rst.
>>> +dtb format is documented in Documentation/devicetree/usage-model.rst.
>> Except that ... usage-model.rst doesn't actually document the DTB
>> format.  Perhaps we should instead substitute a link that does what's
>> promised here?
> Yes, it's in the DT spec. I'd point to
> 'https://www.devicetree.org/specifications/' so it's always going to
> show the latest. And that's the link we have elsewhere in the kernel.
>
> usage-model.rst is also something needing updating...
>
> Rob
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#235): https://lists.elisa.tech/g/linux-safety/message/235
> Mute This Topic: https://lists.elisa.tech/mt/79948363/4617862
> Group Owner: linux-safety+owner@lists.elisa.tech
> Unsubscribe: https://lists.elisa.tech/g/linux-safety/unsub [milan.lakhani@codethink.co.uk]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>
>
