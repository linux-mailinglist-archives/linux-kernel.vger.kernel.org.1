Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89189284302
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 01:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgJEXiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 19:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgJEXiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 19:38:25 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25291C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 16:38:25 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id g7so11049935iov.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GLXZCuLe+nmBBNgX+3o5nAxSyxtIjEk0r9c1JO+fP3E=;
        b=aKgzasvrSmvYXs6eL3Tm2oSn3kRRZ0uN8NR7k72iqR9s2i7VvSkbvwK6xQ8hFYBJpF
         U6gxGHvLb5DUuc7VBMyh/1pIDrK0ga0+Q/mcO01dZehVTJEccuqjJF7qACxS8l1hc622
         lXX2q6fmdQJRnCfEXb5S1q1gCDNQmueyLKEZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GLXZCuLe+nmBBNgX+3o5nAxSyxtIjEk0r9c1JO+fP3E=;
        b=ChO32uwWrNbOscl2pTYRwZdZVd1jyS9W/neQIEnUEEP6tv/d1SqtU0uh9xoTZ1FzPG
         9ug4QKEZ6P6exX2XfSoCCE98e0lQ1/ye+WtA7W3LBwAyQ8SwBPxCJmQtBORU58KfRfDU
         07oLtNseAXlobN09TwNTpnWljVH4QeGsplof2oihHjPqbgpxKFV5/meGYUVSVNnwV9CG
         0yZSEEh40Uvp7cJfyE223LjO0REDhXmx8tuaxuR8RZizmZn/lansHhyN11xtYO1vE/wU
         ENuS5y5ZP1AdYeepp0xpt+8+Q3bju9bITy4WS0KLyoPWyW67alheGzVpUGjhui6cYy1d
         HhkQ==
X-Gm-Message-State: AOAM532euy9qcGD0rC3+RA/kk3iGpb6W3loMzFxITtJViBpl3Xi1ZAq+
        eiTPt7vylFZLF1O/dZAZw+X8/w==
X-Google-Smtp-Source: ABdhPJwb43Uu7PTgdAZX/VnxaSX2ze1KdURgOBXwWDW523Uy8OGus5B8eYD79Ou6MSbITAXX4kqghw==
X-Received: by 2002:a05:6638:4:: with SMTP id z4mr2085742jao.123.1601941104396;
        Mon, 05 Oct 2020 16:38:24 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t12sm758388ilh.18.2020.10.05.16.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 16:38:23 -0700 (PDT)
Subject: Re: Is usb_hcd_giveback_urb() allowed in task context?
To:     Alan Stern <stern@rowland.harvard.edu>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <CAAeHK+wb4k-LGTjK9F5YbJNviF_+yU+wE_=Vpo9Rn7KFN8vG6Q@mail.gmail.com>
 <20201005151857.GA2309511@kroah.com>
 <CAAeHK+zes2Y00+EJ6SVtOHj8YCADw5WSXUEFHWCRgxi=H42+4w@mail.gmail.com>
 <20201005152540.GG376584@rowland.harvard.edu>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <65b4ff62-f9c8-b9cf-50bb-c9b08cce7230@linuxfoundation.org>
Date:   Mon, 5 Oct 2020 17:38:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005152540.GG376584@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/20 9:25 AM, Alan Stern wrote:
> On Mon, Oct 05, 2020 at 05:21:30PM +0200, Andrey Konovalov wrote:
>> On Mon, Oct 5, 2020 at 5:18 PM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Mon, Oct 05, 2020 at 05:08:11PM +0200, Andrey Konovalov wrote:
>>>> Dear USB and USB/IP maintainers,
>>>>
>>>> While fuzzing the USB/IP stack with syzkaller we've stumbled upon an issue.
>>>>
>>>> Currently kcov (the subsystem that is used for coverage collection)
>>>> USB-related callbacks assume that usb_hcd_giveback_urb() can only be
>>>> called from interrupt context, as indicated by the comment before the
>>>> function definition. In the USB/IP code, however, it's called from the
>>>> task context (see the stack trace below).
>>>>
>>>> Is this something that is allowed and we need to fix kcov? Or is this
>>>> a bug in USB/IP?
>>>
>>> It's a bug in kcov, and is not true as you have found out :)
>>
>> OK, I see, I'll work on a fix, thanks!
>>
>> Should I also update the comment above usb_hcd_giveback_urb() to
>> mention that it can be called in_task()? Or is this redundant and is
>> assumed in general?
> 
> No, no -- it won't work right if it's called in process context.  Not
> only do the spinlock calls leave the interrupt flag unchanged, also the
> driver callback routines may expect to be invoked with interrupts
> disabled.  (We have tried to fix this, but I'm not at all certain that
> all the cases have been updated.)
> 

In the case of vhci case, usb_hcd_giveback_urb() is called from vhci's
urb_enqueue, when it determines it doesn't need to xmit the urb and can 
give it back. This path runs in task context.

Do you have any recommendation on how this case can be handled?

thanks,
-- Shuah
