Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9E3285BFB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 11:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgJGJn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 05:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgJGJn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 05:43:56 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEDDC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 02:43:54 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r127so1507423lff.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4hFktsPwEbTgb6XtsDRKma4HYkbhuyQkfc2EV/sEEq4=;
        b=PeJPY3t2subOODdcZjbaiew8E9wJphH5QHFWTqfxC6QtU6CxaljZFwUYEx4QPPjJ3e
         7JhFK63xaJLx+sEKCfV6i3e63IZyOW90iiF+5UcV8BPXaJOLL0LwzPMBamP9E94yuq2m
         BtZrSMd/o4q3S80lDZt49lc64W0pCWaNMAhopT3Fw6uLxBDxYZba3BOVUaE7/igggED9
         xWWs0dc6C3MgD+0SuWdGA43Lb2jumM0JN253IkT62eD65hwbgH5AdlFYHLdMzbQXG3jF
         HgIxt5c2FXyENDQGf5ieYWurEMIVIeynCnhR1U0x5o4KnctHUYQmBDZQb3aqEEK/kVSl
         XN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4hFktsPwEbTgb6XtsDRKma4HYkbhuyQkfc2EV/sEEq4=;
        b=onO2mO8r/Jm9oJRcHGgr/BfAKHwWW7UVQFsoP9Iy+LMda855vtNrWrPICwi9yIqrKy
         5Ler944/sR7DzoBtkzdCZOT82iZyKmgQscJOAFlrAB3TNe/fdnPMZSZnEhUX5BJrI3tz
         8/ze9x5EYJnYLdTCfWsvfwGpOtYDsak3oVkVNNJzUuRJuMJBmTdd97+00EepXxpJVoel
         CJuJcn277XhoHvyVXchnk5G3Np0PSmwsTFxuqDBiOtnW4eJIKk0kAHqF6naxYe6UcLwg
         nYf0VohSR7aHXBXelZqqWFV9IxSqY+u1vadauz1jxfIf0WVJW42Ung8+f3LjRI5NelDX
         87gg==
X-Gm-Message-State: AOAM5322G2eqVCpEPOEuDeZTbieVLU8ubrQiF7V+kz0ZiZ4CYTEdZVWQ
        A2URe8QP93cT5nciI1B6uwcXeJls0d4=
X-Google-Smtp-Source: ABdhPJwOsA6j+H5y6KLQz2Es7KBdsCm+M0aNhzRhTbleVU3ReVOQo2YeHiWCEYk6AMu6Y5aAFjL6Jg==
X-Received: by 2002:a05:6512:3692:: with SMTP id d18mr644960lfs.62.1602063832636;
        Wed, 07 Oct 2020 02:43:52 -0700 (PDT)
Received: from [192.168.1.112] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id o23sm95757lji.68.2020.10.07.02.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 02:43:52 -0700 (PDT)
Subject: Re: [PATCH] mm: optionally disable brk()
To:     David Laight <David.Laight@ACULAB.COM>,
        'David Hildenbrand' <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201002171921.3053-1-toiwoton@gmail.com>
 <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
 <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
 <20201005061248.GN4555@dhcp22.suse.cz>
 <888e62e0-3979-207b-c516-ddfc6b9f3345@redhat.com>
 <4d325e3e-3139-eded-6781-435fb04fb915@gmail.com>
 <9dc586f4-38f0-7956-0ab6-bd7921491606@redhat.com>
 <5fb32353b1964299809fce0c7579a092@AcuMS.aculab.com>
 <b6baf73e-35fd-fe12-bb5f-b9b4e334ae83@redhat.com>
 <23ca06acdfb44b76892857f9e9871241@AcuMS.aculab.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <b5c9bf5d-5857-8131-82af-6611d2b7d592@gmail.com>
Date:   Wed, 7 Oct 2020 12:43:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <23ca06acdfb44b76892857f9e9871241@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.10.2020 15.25, David Laight wrote:
> From: David Hildenbrand
>> Sent: 05 October 2020 13:19
>>
>> On 05.10.20 13:21, David Laight wrote:
>>> From: David Hildenbrand
>>>> Sent: 05 October 2020 10:55
>>> ...
>>>>> If hardening and compatibility are seen as tradeoffs, perhaps there
>>>>> could be a top level config choice (CONFIG_HARDENING_TRADEOFF) for this.
>>>>> It would have options
>>>>> - "compatibility" (default) to gear questions for maximum compatibility,
>>>>> deselecting any hardening options which reduce compatibility
>>>>> - "hardening" to gear questions for maximum hardening, deselecting any
>>>>> compatibility options which reduce hardening
>>>>> - "none/manual": ask all questions like before
>>>>
>>>> I think the general direction is to avoid an exploding set of config
>>>> options. So if there isn't a *real* demand, I guess gluing this to a
>>>> single option ("CONFIG_SECURITY_HARDENING") might be good enough.
>>>
>>> Wouldn't that be better achieved by run-time clobbering
>>> of the syscall vectors?
>>
>> You mean via something like a boot parameter? Possibly yes.
> 
> I was thinking of later.
> Some kind of restricted system might want the 'clobber'
> mount() after everything is running.

Perhaps suitably privileged tasks should be able to install global 
seccomp filters which would disregard any NoNewPrivileges requirements 
and would apply immediately to all tasks. The boot parameter would be 
also nice so that initrd and PID1 would be also restricted. Seccomp 
would also allow more specific filtering than messing with the syscall 
tables.

-Topi
