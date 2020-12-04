Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692782CF5AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgLDUab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDUaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:30:30 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777EAC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 12:29:50 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id z13so1692255ooa.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHUsBSyMeZd1dobHZ32LUWZNrWUwT+9A3sZRTSG0ma8=;
        b=VookJG2jTRV5CfG+Ro9+Xc9jEQZ3tImLXRhUBJjdgERgA2CxBmueyBl37VjSPCYtsD
         tZrkK6MNq8o2WG2yD8Gj76luEb5Uahh6AuTMZch6trdl6CoynBrxc2yD6RtQ+LraClmp
         MNYhGr9i0ejw0+BIPiSXjNwS54ErSU0L+P1cEu+1jBQaS7O5SN//tvY3Aa54INuBiDWI
         9O7gn8XmJjw982npfBEtU8Vmpd7lgRoKJRL3TVdGamZw4Wd3tWfM/UQzy4jCel2+yLHA
         ZzTi2bD45v5+N5XwPg+Xuhu9mUpd4uZhPBjtJJFmM+HsjKQ8Z4mrl8B1sa2bFcG6v6xV
         2VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHUsBSyMeZd1dobHZ32LUWZNrWUwT+9A3sZRTSG0ma8=;
        b=bG2poFOn8kb7luS4E0uaGyRH1m5NXJl9/61daGFTYdLGyG+u79cuvobCf0sTcgfnQ2
         QHsbTUo7cE5IVWfRfbRXELFqLJsIQrmTgE1T2PbPEEWRubeipGFa+EguUyLorhFbJJ9N
         qDxpPr2s+9KFrFVLH7N8wyy/IgHaIDN836roGPn8XIROQAyufUKvLVgmzXJ699vpgB9k
         O0b0Q4iAv8LR+WnUZvIICd81oNYrZMa2rBpkMg0+ZYF3R3RGINDBAUPCeqSIhTZ3zDot
         WSnxOlge5qcBg9fP8JKUZKTVSTAyKMsVcVW687ti01Wv9jvwR2xjhXXvH0Ebm9DoWHT1
         AjTw==
X-Gm-Message-State: AOAM533zF4/LOGKjUPyLGQ3Gq7o2dGk5XbA0yGAcUiNgI7OkAkTJw/gs
        TwkA7rzVVwDrn0aR+qyoBLoNjNNXJMlSVz3MNihwLg==
X-Google-Smtp-Source: ABdhPJzORQkc71E+9K7hkeg9BXrI2+TdThYQC5q+J4Fndf/s26oe2iF+1zzDEGP91zmgqp6XV+1iWAsBPGfK8xs3u2A=
X-Received: by 2002:a4a:48c3:: with SMTP id p186mr4831961ooa.54.1607113789548;
 Fri, 04 Dec 2020 12:29:49 -0800 (PST)
MIME-Version: 1.0
References: <dc46ab93e6b08fa6168591c7f6345b9dc91a81bb.camel@rajagiritech.edu.in>
In-Reply-To: <dc46ab93e6b08fa6168591c7f6345b9dc91a81bb.camel@rajagiritech.edu.in>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Dec 2020 21:29:38 +0100
Message-ID: <CANpmjNMCiCf9w34duqGpQ90=qB4QGnRR8Xny+wOVf=2WG=JVoA@mail.gmail.com>
Subject: Re: BUG: KASAN lib/test_kasan.c
To:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 at 19:56, Jeffrin Jose T <jeffrin@rajagiritech.edu.in> wrote:
> hello,
>
>  detected   KASAN   BUG
>
> [ related information ]
>
> -------------------x-------------------x------------------------>
> [   43.616259] BUG: KASAN: vmalloc-out-of-bounds in
> vmalloc_oob+0x146/0x2c0
>
> (gdb) l *vmalloc_oob+0x146/0x2c0
> 0xffffffff81b8b0b0 is in vmalloc_oob (lib/test_kasan.c:764).

This is the KASAN test. It's a feature, not a bug. ;-)

> 759             kfree_sensitive(ptr);
> 760             KUNIT_EXPECT_KASAN_FAIL(test, kfree_sensitive(ptr));
> 761     }
> 762
> 763     static void vmalloc_oob(struct kunit *test)
> 764     {
> 765             void *area;
> 766
> 767             if (!IS_ENABLED(CONFIG_KASAN_VMALLOC)) {
> 768                     kunit_info(test, "CONFIG_KASAN_VMALLOC is not
> enabled.");
> (gdb) l *vmalloc_oob+0x146
> 0xffffffff81b8b1f6 is in vmalloc_oob (lib/test_kasan.c:779).
> 774              * The MMU will catch that and crash us.
> 775              */
> 776             area = vmalloc(3000);
> 777             KUNIT_ASSERT_NOT_ERR_OR_NULL(test, area);
> 778
> 779             KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char
> *)area)[3100]);
> 780             vfree(area);
> 781     }
> 782
> 783     static struct kunit_case kasan_kunit_test_cases[] = {
> ----------------x-----------------------------x-------------------->
>
> Reported by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

Which CI system is reporting these?

If you look, this is the KASAN test, and the report is very much
intended since it's testing KASAN. Please blacklist the KASAN test
(and any other tests testing debugging tools).

Thanks,
-- Marco
