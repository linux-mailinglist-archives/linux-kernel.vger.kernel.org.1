Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEDF2E9C50
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 18:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbhADRoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 12:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbhADRoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:44:20 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5781DC061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 09:43:40 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id f132so32940625oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 09:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+LCXKPEB/hewuwkhbTWHVXw737PfQlWdNOWuhiAqpDA=;
        b=l7y12RonbWR2q1Qs7ztSpcP5LZZ0x8UwDulHQLiRTc3az219ExEDau/Mn2zaVha/Iw
         AOVDK1pU1/jAC1AKLZmjK2wI55qTltQ2F4N6+VytBa3a8EjO6WReDNKnujaOUBIJGlkl
         uS0/DgSQC0U+uQdHmGa1LPwKU79xkvKeWzLMr91CZxI4Hg0f28GMocag7MlKCM2VLB03
         UwhzzbpsCxzZSlE9IyR0YZNZTi7lKRouQOFAUGwuISSACnfSFpXl+/0jOit5pZXV02+M
         7HgwBcJ8u4qjzXDr+gvdDbNOof5gWfn72IIPSoto4z7XmOS6e2pEWctcN8ve3FD2ZpPZ
         PdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+LCXKPEB/hewuwkhbTWHVXw737PfQlWdNOWuhiAqpDA=;
        b=cEAdXdXxVtr0YF8ziYJYiA4KiPpSkI2sSEwLijA/MTW3e9GKvYceDv+0vWj43jl3Ca
         yNQu41diCC6CgBQz5QFtinLjttXU7oxa1fWgTq0+23/pB9p654rAja8PYey+xQmxomp7
         OeVOV5NEOkb0IX706x+UwzRURzkfTRcADioQopbYNfby4ndYuZsT/AtRMxSi+58iy0wK
         IqAGnm6x1kA3QuOW1ndEW4vhkqzpzm22OT+iTfHutf9oEj1rXR7KD5hw6dujFT9zf6j6
         AKqP+xrVaO3cNMDTKfyQ0uJ4CtaDbqPx7Uv9GGl9ehL65zE0gvyXpzcZ7w7ea010aXLm
         2oEQ==
X-Gm-Message-State: AOAM532j11fZAXpindULz5kCzeF6hJ0VobTPRoKAG2YHSV1EnxN3Css5
        XB8aUmQsTBVeRYrHVYbpDNK2ZGAV5HyW8rGBH8soBi98hJjYu+wx
X-Google-Smtp-Source: ABdhPJyZLPuzv5+r2HCT/0oWYyWV8Mp1n63c6IXTVAQEU/o1FUrnjCI6zAJLPn5xLIcW+OWcM+L2m0mnmlmy9H5FYj4=
X-Received: by 2002:aca:a9c8:: with SMTP id s191mr12129oie.11.1609782219730;
 Mon, 04 Jan 2021 09:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20210104155703.375788488@linuxfoundation.org>
In-Reply-To: <20210104155703.375788488@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 4 Jan 2021 11:43:28 -0600
Message-ID: <CAEUSe78+F1Q9LFjpf8SQzQa6+Ak4wcPiiNcUVxEcv+KPdrYvBw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/35] 4.19.165-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, 4 Jan 2021 at 09:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.19.165 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Jan 2021 15:56:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.165-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 4.19.165-rc1
[...]
> Peter Zijlstra <peterz@infradead.org>
>     mm/mmu_gather: invalidate TLB correctly on batch allocation failure a=
nd flush
[...]

This one fails to compile on the X15 (arm 32-bits) with:
| /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/mm/memo=
ry.c:
In function 'tlb_table_invalidate':
| /srv/oe/build/tmp-lkft-glibc/work-shared/am57xx-evm/kernel-source/mm/memo=
ry.c:342:6:
error: implicit declaration of function 'tlb_needs_table_invalidate';
did you mean 'tlb_table_invalidate'?
[-Werror=3Dimplicit-function-declaration]
|   if (tlb_needs_table_invalidate()) {
|       ^~~~~~~~~~~~~~~~~~~~~~~~~~
|       tlb_table_invalidate

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
