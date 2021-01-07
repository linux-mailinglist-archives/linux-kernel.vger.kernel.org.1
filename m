Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1212ECE8F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbhAGLTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGLTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:19:10 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F255C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 03:18:30 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cm17so7407847edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 03:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=CXQiP4kDperqGE1TeM0C8PdXM9FLi69zGIULpttjNIw=;
        b=AI/IhqY9MRGIozFUQ/cSfIlKjMJUOmr10g5EoHcotUBK6LsFVwqceBGMwBcb8comb9
         z/I+HkKA7ScTTLOvr5Y6lZYlL4GvP7/1JM1ShukUYfA0jZP6ukF5qtX05s/wI+f4/Gm/
         MVG+YMKBZ9GGAk2WstS4r+dv/pbOkSCvU+BaMN2SQBbnm9gt9oovnnWYaf3d1KnVdKJg
         39jQN/9myoEAZXU8go0UjzldMwS3hYBryBZh3gVWoNyH8lIRVu9yUxiRJ2eyqU08TbvB
         mcQqyoPYX7m7g5oboV3tFx7htrh1pySeOd/6vxEqcjLhZiiHi2giGx9Kf+c7lSzw1nkk
         aAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=CXQiP4kDperqGE1TeM0C8PdXM9FLi69zGIULpttjNIw=;
        b=gIC1pZWITKpizLwc49Eefuv5xmT0laX+99pryl0DAJ8FXtUMk+wvzdkOVUsFesAQ/T
         m4cO9pwoUFZzWttOker9ZygqGjpbRBwJqQnBuhmvb+4RBis15XAfdVtmKy5rrZan240L
         tLTV9fc3XaqnubJihphjcLyPqnjxgGgdYAkozMrza/m4AfCo9tiLInGqCfIpn1VGXbWF
         b7EzGm+KC2Zor/hlNslkjq5BRB5grgiSWttLXNHZTAGxIFlK6AFQoI0qsRNwE0OUA/aJ
         b/keGLxCSDRKMvqhFlFBbrISdKHGMbUKWsA/cJ+LvTkSeOKDBD0K2zP7rCoqt1rapjgZ
         1DQA==
X-Gm-Message-State: AOAM530SfRidvacqdysC00IaSNjmRzCq7Rr05s03P8S43uOy6WYE60cx
        j5klyCT8rAyxKU2T0zzFyU0=
X-Google-Smtp-Source: ABdhPJzr/mwHM2MTsYPSEQDDryMnSpFHxUbbPzgqPZIVBRSd6YJwxuLRPHZN8KJPy+vChzhxx9QPyg==
X-Received: by 2002:aa7:cac2:: with SMTP id l2mr1302862edt.141.1610018308986;
        Thu, 07 Jan 2021 03:18:28 -0800 (PST)
Received: from [89.138.250.57] (89-138-250-57.bb.netvision.net.il. [89.138.250.57])
        by smtp.gmail.com with ESMTPSA id f8sm2561970eds.19.2021.01.07.03.18.27
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 07 Jan 2021 03:18:28 -0800 (PST)
Message-ID: <5FF6EDED.40408@gmail.com>
Date:   Thu, 07 Jan 2021 13:18:05 +0200
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: xillybus: Add driver for XillyUSB (Xillybus variant
 for USB)
References: <20201213170503.59017-1-eli.billauer@gmail.com> <X/Rt+bUJ9Hs2F8nF@kroah.com> <5FF5C31C.6050804@gmail.com> <X/XH5Q6APKKt4kRR@kroah.com>
In-Reply-To: <X/XH5Q6APKKt4kRR@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Greg.

I'm afraid we're not on the same page. As mentioned in the original 
patch description, XillyUSB and the existing Xillybus variant presents a 
nearly identical API. User space programs see no difference when using 
one or the other, except for different device file names. In that sense, 
it's exactly like tty devices. But unlike ttys, there are no ioctls or 
any other special API functions to export. Xillybus' API consists only 
of the basic file operations, which behave like you'd expect from a 
pipe, more or less.

So even though one would usually expect this API similarity to take the 
form of common core routines, as it did with xillybus_pcie and 
xillybus_of, there is very little of that regarding XillyUSB. This is 
what I tried to explain in my previous mail: Why this common core is 
very slim.

I can see the benefit of maintaining the formal structure of a single 
entry point for the fops for all Xillybus variants. However my 
understanding while writing the XillyUSB driver was that sticking to 
this structure would be quite artificial, and that it would mess up 
things more than anything else.

Or have I misunderstood your concern about this patch?

Thanks and regards,
    Eli

On 06/01/21 16:23, Greg KH wrote:
> On Wed, Jan 06, 2021 at 04:03:08PM +0200, Eli Billauer wrote:
>    
>> >  Hello Greg,
>> >  
>> >  Merging XillyUSB's driver into xillybus_core.c was of course the initial
>> >  idea. Practically, it turned out that this doesn't reduce the number of code
>> >  lines nor makes the code easier to understand: The XillyUSB driver is a
>> >  completely different deal internally, in almost every aspect of it.
>> >  
>> >  Indeed, the two drivers do basically the same thing: They create a pipe-like
>> >  API using a hardware interface that is based upon buffers. This is what most
>> >  of the code in both drivers is about. As this underlying hardware interface
>> >  is so fundamentally different, there is little in common between the
>> >  drivers.
>> >  
>> >  The existing xillybus_core.c driver is based upon direct memory register +
>> >  DMA interaction with the hardware. XillyUSB relies on the USB framework for
>> >  all communication. I'll try to demonstrate the practical differences with
>> >  two examples.
>> >  
>> >  (1) Sending commands to the hardware: The existing Xillybus driver just
>> >  writes to registers in memory space. Its XillyUSB counterpart calls
>> >  xillyusb_send_opcode() to prepare a little packet for transmission over USB,
>> >  and may possibly sleep if there's a (temporary) lack of resources to
>> >  complete that task.
>> >  
>> >  (2) Data handling: The existing Xillybus driver just copies user data to and
>> >  from DMA buffers. Its main business is to maintain and juggle these buffers
>> >  with the hardware. The XillyUSB driver, on the other hand, manages a pool of
>> >  URBs to efficiently shuffle the data to and from the hardware. The main
>> >  challenge is to keep the data flowing at 400 MB/s.
>> >  
>> >  This goes on for every single aspect of the two drivers: They do the same
>> >  things essentially, but the actual actions are completely different, as they
>> >  have different means to do get the job done. And completely different
>> >  challenges.
>>      
> That's fine, but I'm talking about the userspace api.  You should not be
> creating two different userspace apis just because the bus transport
> changed for the hardware.
>
> We don't do that for things like tty devices, right?  :)
>
> So please, share the same core code that exports the api to userspace to
> be common, do not create a new one, like you did here.
>
>    

