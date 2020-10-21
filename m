Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9197E29522D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504066AbgJUSZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438847AbgJUSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:25:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176A9C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:25:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d23so1641444pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 11:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oCwUPVHXmxnnY6aRxIA+8KH/dcLmV8uQmNFn9+gnWBg=;
        b=UmJVk476/O0Xg0DKRBUYzFFt771Uz8dJHtDqJllsoI2qQEeAMizzMrIl3pNa44P3dy
         eKh1tFtisfFTbqzJXroat1jTnC1CEic2THQTr83y5tcbUB1JfLlGWwIAlbcjE/rhVANc
         445NeUrU0BonSJZxuijqXT0ZXYXsay6mftSVDxyqWfSmVqeEOb/CFXdQ1gMveojHBP4S
         +I+ZwwtK6CwKwXTRUkVAAkFuyqafS45MvbG3kauaOj5Oo0z13Fv/DjH7W5FIpdhTNDBo
         s4mJVn0m0Rm5Cnzp7Cgugwy4h/Kx8m0IKOOzmY03tXT5VhX2P9m/VJATzz0xJdm0vDLX
         5Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oCwUPVHXmxnnY6aRxIA+8KH/dcLmV8uQmNFn9+gnWBg=;
        b=D5AJK4N5kb/cw5JUT49dyEbZsLsMxFZq3Eup4+wx2xBLZZ45dPT4W2Oe3PiWyuI4bt
         W2WO4RRx0aKTgPj9eFsT9i+UVE2SZ/SeZVNaLMfjKzOijXXXH8+mwzDRein9oqkLeyzL
         QxqeEjtZAHKQtJ2TPmncP0cHW+SclREDMrUmHqAH5Z24XL70oKzkUw1jXgQH7E5rRn9z
         Enhgg1c+kZcBTRiYL7q78DW3c8UbDa5ZjuP5C+InpkipMmWBSHIZ+93+9pMW3Ly9cYgh
         307X+aiU99AAOqOnYhUBR1ZZ9GgdvLYb77BxzTvWT4YQnRUSOVDVJY0k1m47bMBCyhnj
         Mm8A==
X-Gm-Message-State: AOAM530xIzJxB2JE+sN7ZkDsWx3SrvbmJ3RsxE0mg7VSnChKMq7/ZiUm
        bGHLUd3gSJZBpHEb+tcnCsE38H97trAddYdL
X-Google-Smtp-Source: ABdhPJxFuXX6DTdOw4GQKqXGhYilBNbPIWongr0A+i62lg+XkPqKelHRRp7ly1wZ1ODpGEo71umk/Q==
X-Received: by 2002:a17:90a:4481:: with SMTP id t1mr4642557pjg.216.1603304734524;
        Wed, 21 Oct 2020 11:25:34 -0700 (PDT)
Received: from ?IPv6:2402:3a80:431:7ac0:8cb2:c45f:197:35d9? ([2402:3a80:431:7ac0:8cb2:c45f:197:35d9])
        by smtp.gmail.com with ESMTPSA id d8sm1586978pjc.40.2020.10.21.11.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 11:25:34 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
References: <20201021150120.29920-1-yashsri421@gmail.com>
 <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
 <26647abf8cf14595a0dd22f10ec1c32e3dc2a8c0.camel@perches.com>
 <40ca3f0f9a960799ad0e534b77d778c90119e468.camel@perches.com>
 <c4f8aae0-d805-8d09-1a87-ba64bc01c29a@gmail.com>
 <d44e35ec1d923fd09ea6530ca5d1988cc8e59347.camel@perches.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <0871715a-e605-91c0-ffa5-389a313ec34d@gmail.com>
Date:   Wed, 21 Oct 2020 23:55:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d44e35ec1d923fd09ea6530ca5d1988cc8e59347.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/20 11:35 pm, Joe Perches wrote:
> On Wed, 2020-10-21 at 23:25 +0530, Aditya wrote:
>> Thanks for your feedback. I ran a manual check using this approach
>> over v5.6..v5.8.
>> The negatives occurring with this approach are for the word 'be'
>> (Frequency 5) and 'add'(Frequency 1). For eg.
>>
>> WARNING:REPEATED_WORD: Possible repeated word: 'be'
>> #278: FILE: drivers/net/ethernet/intel/ice/ice_flow.c:388:
>> + * @seg: index of packet segment whose raw fields are to be be extracted
>>
>> WARNING:REPEATED_WORD: Possible repeated word: 'add'
>> #21:
>> Let's also add add a note about using only the l3 access without l4
>>
>> Apart from these, it works as expected. It also takes into account the
>> cases for multiple occurrences of hex, as you mentioned. For eg.
>>
>> WARNING:REPEATED_WORD: Possible repeated word: 'ffff'
>> #15:
> []
>> I'll try to combine both methods and come up with a better approach.
> 
> Enjoy, but please consider:
> 
> If for over 30K patches, there are just a few false positives and
> a few false negatives, it likely doesn't need much improvement...
> 
> checkpatch works on patch contexts.
> 
> It's not intended to be perfect.
> 
> It's just a little tool that can help avoid some common defects.
> 
> 

Alright Sir. Then, we can proceed with the method you suggested, as it
is more or less perfect.
I'll re-send the patch with modified reduced warning figure.

Thanks
Aditya
