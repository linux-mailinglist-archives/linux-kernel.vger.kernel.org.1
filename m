Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C902763BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIWWXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWWXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:23:09 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A7C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:23:09 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q13so1724019ejo.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vs1CgRh+1x/VMa8Ad2XpWLdKuYfuqf7ICMKNO18moDI=;
        b=Kf6HZ9nz2r48l+h554AZBKuZ2iTFFzEwbK3SaDaOCnpw+L/pB6hlE0KYKTuM8jmzAQ
         5r5YMMm819wonKF91i0OoMWFPd6Gp4TVBb/+n8rii/onVM+514s2hEZCY0YxauQDKdFZ
         f5KghXNn2AWt95c9n/Rb1ubsKHEa8vH6x7uL4Gek+NudEmgCPo9Yhi2j8jnPYxZAiIcD
         jaCIP1lgLtxcv+CZYr8JAV2uGPD38SPVbXnEw57cvS+42vznk2leI3j3rW0pkuF48Yqk
         wyGTZZyiyx+ux0+1egoL0qvPZFdCHlFJ1QVkGNDnz4KyV3EoqvbyaZslEjF8Lp2X7hyN
         jJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vs1CgRh+1x/VMa8Ad2XpWLdKuYfuqf7ICMKNO18moDI=;
        b=nCTLYrC6z387b6OeT+aQLes/+fzfEo3R3rD7Cp1i+ia9A5XwjWmuKXJ+s9JIN9PjSX
         2FiSBwLgg8xNfrNGJ/gWPVH2D7m9/l2dh1EmmsIlZWjpRhZDkxUxlA7JRW2taBTMQ4Ae
         DyFetMpBRWRTRTAwPo5VNpDSpwgmu3IxxMpIIbe3aWPY/XSxQQilxn4fZluxoF4+lL/+
         aGGYz0rTA58xdtdf3gBCHBapz1AVV9eoha+i5nqarMDZlDr4ipq5sy+RH4NS6RHuNSly
         EOh5a3XNDvQKfVcVhdDnolvOHw1FmwTcrIVq+NJqGd5V6WiGEbfuM2TboRgWjVLKLavk
         sxPg==
X-Gm-Message-State: AOAM530HIFUCG6+Q1AomQ7cZVxiZ25kleLv+Nl0vfm9iOUcjhoHcDRAi
        4IfsYiWF4YpjMoFSF/q0kHIdnF8vBVI=
X-Google-Smtp-Source: ABdhPJzKzIkZ2Rl6Oo5Euyhr1ZKaXKAgnYPj9w0Yz/bx5BC0r7HUuDVc72UZCHkd3vYB7hr1YqLYXA==
X-Received: by 2002:a17:906:cf9b:: with SMTP id um27mr1820756ejb.66.1600899787890;
        Wed, 23 Sep 2020 15:23:07 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id bt19sm891624ejb.44.2020.09.23.15.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 15:23:07 -0700 (PDT)
Subject: Re: [RFC PATCH 8/9] surface_aggregator: Add DebugFS interface
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastn?= =?UTF-8?Q?ik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-9-luzmaximilian@gmail.com>
 <CAK8P3a0=98pzgWwBKddy7BQ9g90ga8JEx=MtADW+aqTe0AVV6w@mail.gmail.com>
 <cfed1f74-653c-565b-ea91-877c4e1f63a0@gmail.com>
 <CAK8P3a0_i=wHnQmfbjCdMgFRSD0eGjEM2uMFft5FJ4M1GSUbHg@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <5d470a61-bf4d-7ea2-b41f-1163006b1956@gmail.com>
Date:   Thu, 24 Sep 2020 00:23:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0_i=wHnQmfbjCdMgFRSD0eGjEM2uMFft5FJ4M1GSUbHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/20 8:51 PM, Arnd Bergmann wrote:
> On Wed, Sep 23, 2020 at 8:29 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>> On 9/23/20 6:48 PM, Arnd Bergmann wrote:
>>>> + * struct ssam_debug_request - Controller request IOCTL argument.
>>>> + * @target_category: Target category of the SAM request.
>>>> + * @target_id:       Target ID of the SAM request.
>>>> + * @command_id:      Command ID of the SAM request.
>>>> + * @instance_id:     Instance ID of the SAM request.
>>>> + * @flags:           SAM Request flags.
>>>> + * @status:          Request status (output).
>>>> + * @payload:         Request payload (input data).
>>>> + * @payload.data:    Pointer to request payload data.
>>>> + * @payload.length:  Length of request payload data (in bytes).
>>>> + * @response:        Request response (output data).
>>>> + * @response.data:   Pointer to response buffer.
>>>> + * @response.length: On input: Capacity of response buffer (in bytes).
>>>> + *                   On output: Length of request response (number of bytes
>>>> + *                   in the buffer that are actually used).
>>>> + */
>>>> +struct ssam_dbg_request {
>>>> +       __u8 target_category;
>>>> +       __u8 target_id;
>>>> +       __u8 command_id;
>>>> +       __u8 instance_id;
>>>> +       __u16 flags;
>>>> +       __s16 status;
>>>> +
>>>> +       struct {
>>>> +               const __u8 __user *data;
>>>> +               __u16 length;
>>>> +               __u8 __pad[6];
>>>> +       } payload;
>>>> +
>>>> +       struct {
>>>> +               __u8 __user *data;
>>>> +               __u16 length;
>>>> +               __u8 __pad[6];
>>>> +       } response;
>>>> +};
>>>
>>> Binary interfaces are hard. In this case the indirect pointers mean that
>>> 32-bit user space has an incompatible layout, which you should not do.
>>>
>>> Also, having an ioctl on a debugfs file is a bit odd. I wonder if you
>>> could have this as a transactional file that performs only read/write
>>> commands, i.e. you pass in a
>>>
>>> struct ssam_dbg_request {
>>>          __u8 target_category;
>>>          __u8 target_id;
>>>          __u8 command_id;
>>>          __u8 instance_id;
>>>          __u16 flags;
>>>         __u8 payload[]; /* variable-length */
>>> };
>>>
>>> and you get out a
>>>
>>> struct ssam_dbg_response {
>>>         __s16 status;
>>>        __u8 payload[];
>>> };
>>>
>>> and keep the rest unchanged. See fs/libfs.c for how this could be done
>>> with simple_transaction files.
>>
>> Thanks! Is there a way to make this compatible with a 32-bit user space?
> 
> The version I showed avoids the pointers and is compatible with
> 32-bit user space.

I'm not completely convinced yet that the read/write approach is the way
I want to do it, especially with Greg suggesting a misc device, but I'll
keep your solution in mind.
  
>>   From a quick search, compat_ptr and compat_uptr_t would be the right way
>> to transfer pointer?
> 
> If you end up needing an indirect pointer, the most portable way is to
> use a __u64 and read it using u64_to_user_ptr() in the kernel.

Thanks!

>> I've already laid out my main two rationales for using an IOCTL in the
>> reply to Greg, but here's an overview: First, IOCTLs allow me to execute
>> requests in parallel with only a single open file descriptor, and
>> without having to care about allocating buffers for the responses and
>> waiting until the buffer is read (yes, arguably I still have to manage
>> buffers, but only in the IOCTL function which I consider a bit more
>> manageable). I was previously unaware of the simple_transaction helpers
>> though, so thanks for that pointer! Second, I can easily expand that
>> interface to handle events sent by the EC, by having the user space
>> application read from that file. Although that could be moved to a
>> second file. I just felt having that option of keeping in one would
>> eventually result in a cleaner interface
> 
> The debugfs way is usually to just have additional files when you
> do more than one thing, or if you need a new variant of that interface,
> they are cheap.

Alright, thanks!

Regards,
Max
