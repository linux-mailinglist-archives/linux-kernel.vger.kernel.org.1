Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA2B275FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 20:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgIWS3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 14:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgIWS3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:29:23 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68F4C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 11:29:22 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nw23so995823ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=psyP6agcvcAgogZWSpR/mtRDo3IOWEFN1C9PPanCPVU=;
        b=RcZAVIkAyrpvVxvC97knAFJFKQujWFTz0TCtTHRs6b5GfIH2T+qV1rEteOUXlOu7Y2
         2+BpCQz+NwdoBTBxoDIlysRyodKUvYmrj6ye6+ZVdQGNeDFP4a02PjLB/K/FZIunrU6S
         DKEvPVKnFp9Kcci5JfQoz5W9V6V+HE6fl8KukOZ0oWpW755yg0lzjel829r+2Mlhaubb
         f23UOtbwxE7OYG0Gmso9TQsR12IwRguMOLdjR3SnRGAiapnCu7Riv4HEX/+bQrvTujDP
         uIbMFtzYMjOJwR6jMX6n0SFhbvkxuu1op3XjgiNcR/p6aJuct3RGLIrxkpXyrdbLYy0q
         L0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=psyP6agcvcAgogZWSpR/mtRDo3IOWEFN1C9PPanCPVU=;
        b=H0pMtUaNUMU4rqH1PoSDyKokvwohMYaT4Inof3z0yhdO+mvKorZtomNzWQd/nB+rSB
         /cQ0BGML4YGGEEyhvwNoWJgSsP12FOwYZlkHWb2cohV5hThXS7zYkp0+3UStn/rr5uSO
         oP72HwDw04qgt6reMW7jyQ9t5HMUDqjxK64KA/KHZQToyBOXKqDj4ecpM0e3TMCDAaN5
         3mW264rF3DYwwOnrP8VAhne8HR/gc17HAAtau6hxLtHBecy3maFMYJiOJMe3fBt8/sSY
         vmtvmGMW25agvWXkUIg9Z95FoKVcGf0G3BzgXwyry7aO7z8Lcp86fHpfZVVi3NZRMrnG
         c4XA==
X-Gm-Message-State: AOAM533Ywre9iqWEGHQun8Nt79nWvCppaDeelPfkIsJ354lMEaqr3UVk
        Z4JFzfALTgUiafRpUthRYhhpZipM9kg=
X-Google-Smtp-Source: ABdhPJyAGnOcJYFZOuwgAvNHjlfH/VmJpTv2Bv+Sa48eB8lth7O8jowikutpqB3OEzxyzMX9VbCJxQ==
X-Received: by 2002:a17:906:7c4c:: with SMTP id g12mr975093ejp.306.1600885761388;
        Wed, 23 Sep 2020 11:29:21 -0700 (PDT)
Received: from [192.168.2.202] (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id f4sm461494edm.76.2020.09.23.11.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 11:29:20 -0700 (PDT)
Subject: Re: [RFC PATCH 8/9] surface_aggregator: Add DebugFS interface
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastn?= =?UTF-8?Q?ik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-9-luzmaximilian@gmail.com>
 <CAK8P3a0=98pzgWwBKddy7BQ9g90ga8JEx=MtADW+aqTe0AVV6w@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <cfed1f74-653c-565b-ea91-877c4e1f63a0@gmail.com>
Date:   Wed, 23 Sep 2020 20:29:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0=98pzgWwBKddy7BQ9g90ga8JEx=MtADW+aqTe0AVV6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/20 6:48 PM, Arnd Bergmann wrote:
> Versioned interfaces are basically always a mess, try to avoid them. I'd much
> rather see this done in one of two ways:
> 
> a) make it a proper documented interface, in this case probably a misc
> character device, and then maintain the interface forever, without
> breaking compatibility with existing users.
> 
> b) keep it as a debugfs file, but don't even pretend for it
> to be a documented interface. Anything using it should know
> what they are doing and have a matching user space.

I'll drop the version. I'd still very much like to keep the
documentation as well as keeping this a debugfs file. I hope that I've
made it clear enough in the documentation that it's not intended for use
by anything other than debugging, reverse-engineering, prototyping and
the likes. Especially as having that in debugfs should IMHO give the
impression: "If you rely on it and it breaks, it's not my fault", which
is very much what I want to stick by for now.

Thus I'm not really in favor of making it a "public" device, at least
not yet. This may make sense in case we ever have a concrete need for
user space applications communicating with the EC directly, although I'd
like to structure and commit to that interface once there is such.

>> +/**
>> + * struct ssam_debug_request - Controller request IOCTL argument.
>> + * @target_category: Target category of the SAM request.
>> + * @target_id:       Target ID of the SAM request.
>> + * @command_id:      Command ID of the SAM request.
>> + * @instance_id:     Instance ID of the SAM request.
>> + * @flags:           SAM Request flags.
>> + * @status:          Request status (output).
>> + * @payload:         Request payload (input data).
>> + * @payload.data:    Pointer to request payload data.
>> + * @payload.length:  Length of request payload data (in bytes).
>> + * @response:        Request response (output data).
>> + * @response.data:   Pointer to response buffer.
>> + * @response.length: On input: Capacity of response buffer (in bytes).
>> + *                   On output: Length of request response (number of bytes
>> + *                   in the buffer that are actually used).
>> + */
>> +struct ssam_dbg_request {
>> +       __u8 target_category;
>> +       __u8 target_id;
>> +       __u8 command_id;
>> +       __u8 instance_id;
>> +       __u16 flags;
>> +       __s16 status;
>> +
>> +       struct {
>> +               const __u8 __user *data;
>> +               __u16 length;
>> +               __u8 __pad[6];
>> +       } payload;
>> +
>> +       struct {
>> +               __u8 __user *data;
>> +               __u16 length;
>> +               __u8 __pad[6];
>> +       } response;
>> +};
> 
> Binary interfaces are hard. In this case the indirect pointers mean that
> 32-bit user space has an incompatible layout, which you should not do.
> 
> Also, having an ioctl on a debugfs file is a bit odd. I wonder if you
> could have this as a transactional file that performs only read/write
> commands, i.e. you pass in a
> 
> struct ssam_dbg_request {
>         __u8 target_category;
>         __u8 target_id;
>         __u8 command_id;
>         __u8 instance_id;
>         __u16 flags;
>        __u8 payload[]; /* variable-length */
> };
> 
> and you get out a
> 
> struct ssam_dbg_response {
>        __s16 status;
>       __u8 payload[];
> };
> 
> and keep the rest unchanged. See fs/libfs.c for how this could be done
> with simple_transaction files.

Thanks! Is there a way to make this compatible with a 32-bit user space?
 From a quick search, compat_ptr and compat_uptr_t would be the right way
to transfer pointer?

I've already laid out my main two rationales for using an IOCTL in the
reply to Greg, but here's an overview: First, IOCTLs allow me to execute
requests in parallel with only a single open file descriptor, and
without having to care about allocating buffers for the responses and
waiting until the buffer is read (yes, arguably I still have to manage
buffers, but only in the IOCTL function which I consider a bit more
manageable). I was previously unaware of the simple_transaction helpers
though, so thanks for that pointer! Second, I can easily expand that
interface to handle events sent by the EC, by having the user space
application read from that file. Although that could be moved to a
second file. I just felt having that option of keeping in one would
eventually result in a cleaner interface.

Thanks,
Max
