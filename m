Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E701FA0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 21:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbgFOTvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 15:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgFOTvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:51:09 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC62C061A0E;
        Mon, 15 Jun 2020 12:51:08 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id m23so4250157vko.2;
        Mon, 15 Jun 2020 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8frMyV6iWiTG20peVSog6g/PzG1tE3Z1KTFpjyMuOE=;
        b=aBNl8F1yV0Kt0lNqG18J3Q1wOXi25U9Rf2Ac41hQ9KporKHlmJEJjztkldcrgpYn6n
         X/MA0yAXN7zo/sBLmNp6WdtkZTl3x/Ri+rxuTPqRMQ4NSMtfoRnwNDuIm9D/f9Ox7cyT
         KdYxGbl3FNmh7WvCWTd/4XTNT2SQTFLynAOaIQNeuoteTVOiwVo7tmEsv6shA92CdnLK
         nt/gcC6LJvHmAqj9Vyo3fHeWdSMQ+Y5jlLLV62WBTjdf2dIzdu9aj/EeDFBt3xzVlz+c
         ULgDtI03KR1fvyw4cB/1VLkoG68wC233nQqDshoS1W1sRlNnPTm7GTA3qpKDPJGaMDmr
         Y3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8frMyV6iWiTG20peVSog6g/PzG1tE3Z1KTFpjyMuOE=;
        b=UNwaOOPrkwzt/HAb3E4y23ozGesQXdtAXj+3Oifc4kp1myIor6HfSFMzpFuLV88JnN
         qUFhF0toO3YDbui8WJ/DhoWluuGyO5N2r0yyULyUOSwZjyubWfCT+KeT+vbTjuMCYB42
         10S0fmKE09fW+0cAdo15LBwMDB0gLYgvc5yFQ9C++iVbViK4ZzugvwBdd7q2p0YmaiYN
         0uRucUHE2PHqT7YMMXjpkED1TTMCAHmTZZ/qvymy3VZa3znmtg8CGgkAQ9nG8zjVJ25p
         1e9I1YfzIzaw6+NwZwfEE1bDmW5rOHTo+fKYZsHfGfkIe0Vnj1JyvVd+bR1dJ+0FiAZO
         IIaQ==
X-Gm-Message-State: AOAM531cC/Jo9CTB//GvT9y1mjDkgyn19gE3EbdhLHd9/R1JnnCOiVrX
        kYvV5wdWJasSlnZz6cQBG5UDNXhujv3np7tld+8=
X-Google-Smtp-Source: ABdhPJyflqHmNb9Z0V42wEN6xfs763BQyMhIycGYtZa9uUpcgTaLfUGjC4tdKIp9+rR3PVA4ZKs7VkJbkG4YEgVhK0E=
X-Received: by 2002:a1f:ee81:: with SMTP id m123mr19632262vkh.51.1592250667624;
 Mon, 15 Jun 2020 12:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200611091139.8525-1-joro@8bytes.org>
In-Reply-To: <20200611091139.8525-1-joro@8bytes.org>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 15 Jun 2020 20:47:27 +0100
Message-ID: <CACvgo526Kn5qSpmV_azf70UCYNaFbyo7LgXGQykzyQV7v=6ahg@mail.gmail.com>
Subject: Re: [PATCH] alpha: Fix build around srm_sysrq_reboot_op
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-alpha@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Thu, 11 Jun 2020 at 10:11, Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> The patch introducing the struct was probably never compile tested,
> because it sets a handler with a wrong function signature. Wrap the
> handler into a functions with the correct signature to fix the build.
>
> Fixes: 0f1c9688a194 ("tty/sysrq: alpha: export and use __sysrq_get_key_op()")
> Cc: Emil Velikov <emil.l.velikov@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Just coming back from 10 offline days and retracing my testing ...
Seems that I've copied the wrong .config.
So a follow-up `make arch/alpha/kernel/setup.o' did not build
anything... yet the command was _successful_.

This is something that should be fixed IMHO - doing the same for
drivers/ (for example drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.o)
results in an obvious audible error.

That said, apologies for the issue. I'll be more thorough and
carefully audit the build logs for future patches.

-Emil
