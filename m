Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578802B9CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 22:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgKSVTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 16:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgKSVTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:19:19 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A96FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:19:18 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id y16so7840008ljh.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 13:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=J2ebOPK/pjLdgiTg0vxZYJ8uGSx8XkWHUakpbOJUXQ8=;
        b=hE24fukD9LQSN2wALWYLKJgs7ZDBWTAXE7xsaC5di9MVRLaYY3Kcv8/H9qiu1LqIz8
         MpvL8ee9fypfpEp2cNhLDUMHFKdHPZHGzt6AmZZ5a0eYbeqUR79Eh4sHIqVMJMgIfKMx
         9MZy04hEnE8UlWfvVdAmnCCSGXgUBJLLK1qHUZ3c4XCQxe0bmL8aJsSTUfzkrRIy8NUZ
         AEbZIbcPJ6I2aSkHOUxscD8/sw5s87xCzqJUGoYfmPh12yNzPsWL6TDq3KyRayY840VK
         ur2SHvVhl+zDa71crOfHkHe0KNLnk3gYaOPLdCFZlWIxGTxyGTeH92re7VyLFVnetmFy
         rIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=J2ebOPK/pjLdgiTg0vxZYJ8uGSx8XkWHUakpbOJUXQ8=;
        b=U/BMZHWE7l2mGzm3AzTwlV1oEotegyo4j7yuVKxDOFAiLP+lVXUcZHrkBlZ6hQkCba
         ip1uGi7R8INns9c6lDDOjMIWVR8Xt56EL+Yv7nnYJj8SSChjh3CvHdkbV5KZrzsebLzz
         X7PAxHmlo86qQ33sHNSUiRsYq6Qxj2wX1XTBc9DyrdGEg0LAMI9W68RTzLS735/I+6wq
         ptRChmAOl3QymAJ/SpqZwPDkUflBZJ+MnP0UlMMcwp7CaH1v1je4HKLlvZysY31maU5r
         gQrzegidFEZNo6+vevLCC3xa5QeBx/+bOlGhkCD6EWDlkfVQHrCfYdUmyMKkuQf2mlx0
         Crhg==
X-Gm-Message-State: AOAM531BeDs/Gs+5pGTsVjmp7P2LOhzFcVJMJcMlSjmX9JKVZnplUgqB
        Dr65ANorElZCgRRr+3sayQH5HFyWGuU=
X-Google-Smtp-Source: ABdhPJwGlX/61l8fIg1HOJOuhSfKID2KiXZQxMPa9BYz6kv3b9LTAwIDy1ucFrVG3+LcZLqSQ9Bq8w==
X-Received: by 2002:a2e:7a0d:: with SMTP id v13mr7001086ljc.348.1605820755479;
        Thu, 19 Nov 2020 13:19:15 -0800 (PST)
Received: from [192.168.1.62] (89-178-168-199.broadband.corbina.ru. [89.178.168.199])
        by smtp.gmail.com with ESMTPSA id w28sm94395lfk.202.2020.11.19.13.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 13:19:14 -0800 (PST)
Subject: Re: Kernel prctl feature for syscall interception and emulation
From:   Paul Gofman <gofmanp@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Rich Felker' <dalias@libc.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <873616v6g9.fsf@collabora.com>
 <20201119151317.GF534@brightrain.aerifal.cx> <87h7pltj9p.fsf@collabora.com>
 <20201119162801.GH534@brightrain.aerifal.cx> <87eekpmeux.fsf@collabora.com>
 <20201119173938.GJ534@brightrain.aerifal.cx>
 <d3734f734fbb4c3bacc8234be39f31be@AcuMS.aculab.com>
 <bb81b1b7-8ee1-6ade-8d4b-23673e2d9f61@gmail.com>
Message-ID: <d889cd13-b2b9-df9e-53ef-b054c4466182@gmail.com>
Date:   Fri, 20 Nov 2020 00:19:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <bb81b1b7-8ee1-6ade-8d4b-23673e2d9f61@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 23:54, Paul Gofman wrote:
> On 11/19/20 20:57, David Laight wrote:
>>>> The Windows code is not completely loaded at initialization time.  It
>>>> also has dynamic libraries loaded later.  yes, wine knows the memory
>>>> regions, but there is no guarantee there is a small number of segments
>>>> or that the full picture is known at any given moment.
>>> Yes, I didn't mean it was known statically at init time (although
>>> maybe it can be; see below) just that all the code doing the loading
>>> is under Wine's control (vs having system dynamic linker doing stuff
>>> it can't reliably see, which is the case with host libraries).
>> Since wine must itself make the mmap() system calls that make memory
>> executable can't it arrange for windows code and linux code to be
>> above/below some critical address?
>>
>> IIRC 32bit windows has the user/kernel split at 2G, so all the
>> linux code could be shoe-horned into the top 1GB.
>>
>> A similar boundary could be picked for 64bit code.
>>
>> This would probably require flags to mmap() to map above/below
>> the specified address (is there a flag for the 2G boundary
>> these days - wine used to do very horrid things).
>> It might also need a special elf interpreter to load the
>> wine code itself high.
>>
> Wine does not control the loading of native libraries (which are subject
> to ASLR and thus do not necessarily exactly follow mmap's top down
> order). Wine is also not free to choose where to load the Windows
> libraries. Some of Win libraries are relocatable, some are not. Even
> those relocatable are still often assumed to be loaded at the base
> address specified in PE, with assumption made either by library itself
> or DRM or sandboxing / hotpatching / interception code from around.
>
> Also, it is very common to DRMs to unpack the encrypted code to a newly
> allocated segment (which gives no clue at the moment of allocation
> whether it is going to be executable later), and then make it
> executable. There are a lot of tricks about that and such code sometimes
> assumes very specific (and Windows implementation dependent) things, in
> particular, about the memory layout. Windows VirtualAlloc[Ex] gives the
> way to request top down or bottom up allocation order, as well as
> specific allocation address. The latter is not guaranteed to succeed of
> course just like on Linux for obvious reasons, but if specific (high)
> address ranges  always have some space available on Windows, then there
> are the apps in the wild which depend of that, as far as our practice goes.
>
> If we were given mmap flag for specifying memory allocation boundary,
> and also a sort of process-wide dlopen() config option for specifying
> that boundary for every host shared library load, the address space
> separation could probably work... until we hit a tricky case when the
> app wants to get a memory specifically high address range. I think we
> can't do that cleanly as both Windows and Linux currently have the same
> 128TB limit for user address space on x64 and we've got no spare space
> to safely put native code without potential interference with Windows code.
>
Maybe it is also interesting to mention that the initial Gabriel's
patches version was introducing the emulation trigger by specifying a
flag for memory region through mprotect(), so we could mark the regions
calls from which should be trapped. That would be probably the easiest
possible solution in terms of using that in Wine (as no memory allocated
by Wine itself is supposed to contain native host syscalls) but that
idea was not accepted. Mainly because, as I understand, such a
functionality does not belong to VM management.

