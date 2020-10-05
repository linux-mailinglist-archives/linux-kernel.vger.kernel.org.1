Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1EC283190
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgJEILl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgJEILl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:11:41 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCFAC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 01:11:41 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y2so9742838lfy.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 01:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zq07zvPm8TL3mAn095YnT+7bL3Nhkmpk+9FC82NrYsY=;
        b=dOnpE3RwspcwAy9tHkRc4Z/Y5y2q4M6/1ilqAitquYJRky3uK8rw/iTiH0IrdzWxxg
         /HPmSvmDSoCY5W/jft2XfW67JpWtRc91l4RfKeN9Zq7VP0glcumgHfDlxQ0voePz2dqz
         f5c95MFAW8+oxtOA9PcKjtKAo/AVBu+qnmAN8NkLGQrao99g/C93iOi9CuvrP/X+Rc+H
         IapNgY1B/1ZLnyTqQ2gOWCPcuDNOxvUv5AVcv3uH4HdKI3sRGdIX0Zi49IbSHRxyfP4D
         i5uTlrl/RcEDdpCXGY87GsAobRMWPBtimnBvVJZMvaZxPqYdKbNpPD1dvzU7FMhDEa3q
         8nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zq07zvPm8TL3mAn095YnT+7bL3Nhkmpk+9FC82NrYsY=;
        b=npEJRPr7OPPi5teyoMGCCi4toSguT9ieVerrPOwJhPVxN9+jtL/8QXkkXG3RLRGPfj
         pmfs/MbFh5MoqJowCjx2pgqSEfaC/oZTdDx5o/QzoBXbvg+WfHgCbPTaI5/FvJfzHf/L
         zfPsKpaUbmdNy2ogPZ85KIlrl/Ch9BByEZ3NRMWCOYIeW0nwdcDsh0SHx3iz/DLlrqZu
         mi3d9xlFjzUbDSRFGlriQ7EzBTJhu00AIxYBfc0SvlVBwBmDaVWmyFVVDpLYGaMfz3Gv
         zkSLJN9MiDo3BOHDUU35sXmC5fi3vgyZ9x7O9oKdpVMi8591anDgtB3ouxWvHy/je27W
         GrfA==
X-Gm-Message-State: AOAM532DqUPvsrPk9jLXFl94sEirojy82LfDGaE1LmB50aXl/YU7iGlj
        O/I3WcwFtrdcfPFyuftjxO0eEaGkgm8=
X-Google-Smtp-Source: ABdhPJy58U+fEEdugMtCJjtZjUfaq6c54ExpD8yP23I3YhDm2WA9Ikv5HVo8EixCLj8iTbzv+zJdEQ==
X-Received: by 2002:a05:6512:211:: with SMTP id a17mr2049615lfo.217.1601885499144;
        Mon, 05 Oct 2020 01:11:39 -0700 (PDT)
Received: from [192.168.1.89] (88-114-211-119.elisa-laajakaista.fi. [88.114.211.119])
        by smtp.gmail.com with ESMTPSA id o8sm2589379lfi.213.2020.10.05.01.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 01:11:38 -0700 (PDT)
Subject: Re: [PATCH] mm: optionally disable brk()
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201002171921.3053-1-toiwoton@gmail.com>
 <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
 <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
 <20201005061248.GN4555@dhcp22.suse.cz>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <7d7b1ac5-d6a7-5e43-8fb8-12b844d7f501@gmail.com>
Date:   Mon, 5 Oct 2020 11:11:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005061248.GN4555@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.10.2020 9.12, Michal Hocko wrote:
> On Sat 03-10-20 00:44:09, Topi Miettinen wrote:
>> On 2.10.2020 20.52, David Hildenbrand wrote:
>>> On 02.10.20 19:19, Topi Miettinen wrote:
>>>> The brk() system call allows to change data segment size (heap). This
>>>> is mainly used by glibc for memory allocation, but it can use mmap()
>>>> and that results in more randomized memory mappings since the heap is
>>>> always located at fixed offset to program while mmap()ed memory is
>>>> randomized.
>>>
>>> Want to take more Unix out of Linux?
>>>
>>> Honestly, why care about disabling? User space can happily use mmap() if
>>> it prefers.
>>
>> brk() interface doesn't seem to be used much and glibc is happy to switch to
>> mmap() if brk() fails, so why not allow disabling it optionally? If you
>> don't care to disable, don't do it and this is even the default.
> 
> I do not think we want to have config per syscall, do we? There are many
> other syscalls which are rarely used. Your changelog is actually missing
> the most important part. Why do we care so much to increase the config
> space and make the kerneel even more tricky for users to configure?

Maybe, I didn't know this was an important priority since there are 
other similar config options. Can you suggest some other config option 
which could trigger this? This option is already buried under CONFIG_EXPERT.

> How
> do I know that something won't break? brk() is one of those syscalls
> that has been here for ever and a lot of userspace might depend on it.

1. brk() is used by glibc for malloc() as the primary choice, secondary 
to mmap(NULL, ...). But malloc() switches to using only mmap() as soon 
as brk() fails the first time, without breakage.

2. brk() also used for initializing glibc's internal thread structures. 
The only program I saw having problems was ldconfig which indeed 
segfaults due to an unsafe assumption that sbrk() will never fail. This 
is easily fixable by switching to an internal version of mmap().

3. The dynamic loader uses brk() but this is only done to help malloc() 
and nothing breaks there if brk() returns ENOSYS.

I've sent to glibc list RFC patches which switch to mmap() completely. 
This improves the randomization for malloc()ated memory and the location 
of the thread structures.

> I haven't checked but the code size is very unlikely to be shrunk much
> as this is mostly a tiny wrapper around mmap code. We are not going to
> get rid of any complexity.
> 
> So what is the point?

The point is not to shrink the kernel (it will shrink by one small 
function) or get rid of complexity. The point is to disable an inferior 
interface. Memory returned by mmap() is at a random location but with 
brk() it is located near the data segment, so the address is more easily 
predictable.

I think hardened, security oriented systems should disable brk() 
completely because it will increase the randomization of the process 
address space (ASLR). This wouldn't be a good option to enable for 
systems where maximum compatibility with legacy software is more 
important than any hardening.

-Topi
