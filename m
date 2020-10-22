Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D6E2960D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368057AbgJVOV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900805AbgJVOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:21:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D1C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:21:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh6so1036640plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OnP2kEC2pGnAemMKHI0Z0iChzTVVq05qRRezqWLWQ4Q=;
        b=ZB9/7y4eY/nWu8vtRp2Ie/+19H/mRAVnJ1XqjhVInskU6yfM9o+JbUo1aldRTMUwW2
         /b1jqE2fZSgp41UNkmvTcIeQkDMpWBLESuDx1NWmFOfL2D1oD4L3HfVOBM6bhY+KHlOu
         NlDjnkJSGVtP6ptDzzVkyqHAPZvQ99SAkLyzNWkxrIjoUTmPbRC8v5MBrptW8hFYij8f
         j23TUh73igr3X42q4SxoSTRgcQFf8g2iPPYGrTW6JS/JRUcUJ7aXmY8enQnvhN+BKlUI
         iG2UIxbQqd9T/WtGjX/hePLoPd6bun4tzT9uHGvnY5swL41yYE4+Z4A48nWsU7lDSNeu
         7GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OnP2kEC2pGnAemMKHI0Z0iChzTVVq05qRRezqWLWQ4Q=;
        b=qd6a0SFOP3zPd1OhCow7mR9SWK/MpKVstTCSBnrSf1tdH2vWCe+KpgaV0bebm9Gnlm
         og6LDHKrJaPC+WS9g9iJ7cIO4y6xPeG35aZ4XVhf8F6TBuKJVl4hvWuPoOvqkthGBUbE
         EQ1gA8lviXV32QHdavO36rsBp1Lx7a07LnOrvHVa3NR30mfl//4gUhQQq6p7MCKyWcd1
         QdIyHP8TzR7KEJIPr9cTToJVuPOOVu3bIKChN7/aMFW4WMWYiE3oF+SMmydFQOx6ORiN
         AS4tjVE6TxewH4wTWslty2fFJjr+mKkXDOqtc6J4Az9yXC2iBuSIyC9OPvVjn43Vzti+
         MzCw==
X-Gm-Message-State: AOAM532quK02VEqW+SG0kLejSQRsXm8+0pGIPbJ0ASeYSeY2/MceL+Vj
        VgBIut8wqdfq3LHVE8pToEM=
X-Google-Smtp-Source: ABdhPJz6O/b+eigp0eJ8/gCPq+wu5AmvTX6XelGv06jMrd5pKHfA4I/U+oKDyzcZi6WJzGsrb0mSCA==
X-Received: by 2002:a17:902:6a83:b029:d5:e98f:2437 with SMTP id n3-20020a1709026a83b02900d5e98f2437mr2576146plk.38.1603376486312;
        Thu, 22 Oct 2020 07:21:26 -0700 (PDT)
Received: from ?IPv6:2402:3a80:41a:7419:e1bd:6bc1:d06a:efd1? ([2402:3a80:41a:7419:e1bd:6bc1:d06a:efd1])
        by smtp.gmail.com with ESMTPSA id q6sm2549777pfn.10.2020.10.22.07.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 07:21:25 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
References: <20201021150120.29920-1-yashsri421@gmail.com>
 <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
 <26647abf8cf14595a0dd22f10ec1c32e3dc2a8c0.camel@perches.com>
 <40ca3f0f9a960799ad0e534b77d778c90119e468.camel@perches.com>
 <c4f8aae0-d805-8d09-1a87-ba64bc01c29a@gmail.com>
 <d44e35ec1d923fd09ea6530ca5d1988cc8e59347.camel@perches.com>
 <0871715a-e605-91c0-ffa5-389a313ec34d@gmail.com>
 <CAKXUXMzdjV8aPL=Paf2QJs1iWB5swxYXFJozyPi_JxJVXRArxQ@mail.gmail.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <cfa48542-4654-fe62-e7fa-c7d99c6ab4f5@gmail.com>
Date:   Thu, 22 Oct 2020 19:51:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMzdjV8aPL=Paf2QJs1iWB5swxYXFJozyPi_JxJVXRArxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/20 12:42 am, Lukas Bulwahn wrote:
> On Wed, Oct 21, 2020 at 8:25 PM Aditya <yashsri421@gmail.com> wrote:
>>
>> On 21/10/20 11:35 pm, Joe Perches wrote:
>>> On Wed, 2020-10-21 at 23:25 +0530, Aditya wrote:
>>>> Thanks for your feedback. I ran a manual check using this approach
>>>> over v5.6..v5.8.
>>>> The negatives occurring with this approach are for the word 'be'
>>>> (Frequency 5) and 'add'(Frequency 1). For eg.
>>>>
>>>> WARNING:REPEATED_WORD: Possible repeated word: 'be'
>>>> #278: FILE: drivers/net/ethernet/intel/ice/ice_flow.c:388:
>>>> + * @seg: index of packet segment whose raw fields are to be be extracted
>>>>
>>>> WARNING:REPEATED_WORD: Possible repeated word: 'add'
>>>> #21:
>>>> Let's also add add a note about using only the l3 access without l4
>>>>
>>>> Apart from these, it works as expected. It also takes into account the
>>>> cases for multiple occurrences of hex, as you mentioned. For eg.
>>>>
>>>> WARNING:REPEATED_WORD: Possible repeated word: 'ffff'
>>>> #15:
>>> []
>>>> I'll try to combine both methods and come up with a better approach.
>>>
>>> Enjoy, but please consider:
>>>
>>> If for over 30K patches, there are just a few false positives and
>>> a few false negatives, it likely doesn't need much improvement...
>>>
>>> checkpatch works on patch contexts.
>>>
>>> It's not intended to be perfect.
>>>
>>> It's just a little tool that can help avoid some common defects.
>>>
>>>
>>
>> Alright Sir. Then, we can proceed with the method you suggested, as it
>> is more or less perfect.
>> I'll re-send the patch with modified reduced warning figure.
>>
> 
> Aditya, you can also choose to implement your solution;
> yes, it is more work for you but it also seems to function better in
> the long run.
> 
> Clearly, Joe would settle for a simpler solution, but his TODO list of
> topics to engage in and work on is also much longer...
> 
> Lukas
> 

Hi Sir
I have implemented my solution. Should I send the patch in reply to
this mail or as a different mail? Also should I label it as v2? I have
also addressed the warnings out of list command output in it. for eg.

WARNING:REPEATED_WORD: Possible repeated word: 'root'
#18:
  drwxr-xr-x. 2 root root    0 Apr 17 10:53 .

WARNING:REPEATED_WORD: Possible repeated word: 'nobody'
#28:
drwxr-xr-x 5 nobody nobody    0 Jan 25 18:08 .

Sincerely
Aditya
