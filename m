Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38302B9C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 21:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKSUyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 15:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgKSUyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 15:54:20 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC12C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 12:54:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id r9so10259877lfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 12:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FMMEzpPNkxE/sUTiAUIDB6gZjvg9JeBhZ9QI4aKgzac=;
        b=QhdMcDGoOZdOg/TNLmt8NXpaJn4dY+9lHB6R9q+cTdZX5b7k8A97yQGbeeVP5idg1b
         1i3Ds8oM0/XNIlti6z+vE1cVw/NqjtBn+pCQRPvgLg7BuhL/UCWefyDvV1+XqTPE1wBW
         jDUkPqtQvpMmPCdg72ETY9ikHdWDvYMZfepI+r4YUAEu8JRq+61KVBVENnCkR4FFwD78
         eXruLUSBOCp4OQkWrC/LdjoN7ozpCrBq08188fcnag0vWcZ/7lh8ZMnoOdGhVuCJPx4J
         QWJtYweuyrpoCxoBYQHLo4A9aXgDf4/BMLgrHS6n5H6oc5MDFdtFkrn+td8V3E7obSv9
         vD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FMMEzpPNkxE/sUTiAUIDB6gZjvg9JeBhZ9QI4aKgzac=;
        b=LjCJquve+d0AECg+7zaNvTAVgTHoSDa7+/UuDr/nAAhpStPuGwXRTNqhVTI4yEx7sO
         e/xLD2AdnHdtEcCko4jZ6ldGbVXDMew6B0Y4gjSNJXVwZEBg9bySUklgsI8OgvCkldY7
         dLdCQcJ2MiNiY0G5IA4SGEJfbBgEYuW12xkS/3sGABVEtFdu8pL7VK1/N2UuNthMoPD6
         kIwEOIlcOJEEIAvSYFP/axENzwKyQfY/qhSYMSHOVttzU6rpUPhPOhF+EloLY/mNA1Hh
         oWqgNCD3d+rVR+exaUR7MMvVhx2Ly21MD6WTqAPpacxUCVD7QsxAFw+HdCM5SLBX0Di8
         0ugA==
X-Gm-Message-State: AOAM5339Mmpgm1ENJn9WPmaRnunmFFkxbFQ+fzW29bbnPl6xoqc3cmsp
        VeEfHdXSfGUZXcz/PT7zHiDPY0/PO+Y=
X-Google-Smtp-Source: ABdhPJyH/l2YuUqsL3fAIDVEGJypW6xtew5rDr1QLCZddz2y/u3noNSzqh2svlNNRWNDybWjsGkkiQ==
X-Received: by 2002:a05:6512:528:: with SMTP id o8mr7049607lfc.374.1605819256493;
        Thu, 19 Nov 2020 12:54:16 -0800 (PST)
Received: from [192.168.1.62] (89-178-168-199.broadband.corbina.ru. [89.178.168.199])
        by smtp.gmail.com with ESMTPSA id q26sm89107lfa.104.2020.11.19.12.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 12:54:15 -0800 (PST)
Subject: Re: Kernel prctl feature for syscall interception and emulation
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
From:   Paul Gofman <gofmanp@gmail.com>
Message-ID: <bb81b1b7-8ee1-6ade-8d4b-23673e2d9f61@gmail.com>
Date:   Thu, 19 Nov 2020 23:54:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <d3734f734fbb4c3bacc8234be39f31be@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 20:57, David Laight wrote:
>>> The Windows code is not completely loaded at initialization time.  It
>>> also has dynamic libraries loaded later.  yes, wine knows the memory
>>> regions, but there is no guarantee there is a small number of segments
>>> or that the full picture is known at any given moment.
>> Yes, I didn't mean it was known statically at init time (although
>> maybe it can be; see below) just that all the code doing the loading
>> is under Wine's control (vs having system dynamic linker doing stuff
>> it can't reliably see, which is the case with host libraries).
> Since wine must itself make the mmap() system calls that make memory
> executable can't it arrange for windows code and linux code to be
> above/below some critical address?
>
> IIRC 32bit windows has the user/kernel split at 2G, so all the
> linux code could be shoe-horned into the top 1GB.
>
> A similar boundary could be picked for 64bit code.
>
> This would probably require flags to mmap() to map above/below
> the specified address (is there a flag for the 2G boundary
> these days - wine used to do very horrid things).
> It might also need a special elf interpreter to load the
> wine code itself high.
>
Wine does not control the loading of native libraries (which are subject
to ASLR and thus do not necessarily exactly follow mmap's top down
order). Wine is also not free to choose where to load the Windows
libraries. Some of Win libraries are relocatable, some are not. Even
those relocatable are still often assumed to be loaded at the base
address specified in PE, with assumption made either by library itself
or DRM or sandboxing / hotpatching / interception code from around.

Also, it is very common to DRMs to unpack the encrypted code to a newly
allocated segment (which gives no clue at the moment of allocation
whether it is going to be executable later), and then make it
executable. There are a lot of tricks about that and such code sometimes
assumes very specific (and Windows implementation dependent) things, in
particular, about the memory layout. Windows VirtualAlloc[Ex] gives the
way to request top down or bottom up allocation order, as well as
specific allocation address. The latter is not guaranteed to succeed of
course just like on Linux for obvious reasons, but if specific (high)
address ranges  always have some space available on Windows, then there
are the apps in the wild which depend of that, as far as our practice goes.

If we were given mmap flag for specifying memory allocation boundary,
and also a sort of process-wide dlopen() config option for specifying
that boundary for every host shared library load, the address space
separation could probably work... until we hit a tricky case when the
app wants to get a memory specifically high address range. I think we
can't do that cleanly as both Windows and Linux currently have the same
128TB limit for user address space on x64 and we've got no spare space
to safely put native code without potential interference with Windows code.

