Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1C72B13EC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgKMBiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:38:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54262 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgKMBiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:38:55 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by linux.microsoft.com (Postfix) with ESMTPSA id F165C20C2893
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:38:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F165C20C2893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605231535;
        bh=LHDRWxltoY9Yzek2U2YM/IJ9PiLbIoLYK2g+Xufu3xQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dr1IhRvvLsfIyqIWK1fIETcbbO7LlYfMZfyabfpj1hO5obDpLmxbdGxrzxnwd3rOt
         lh7oJ5n6C3mUXboZ2WP5sSQCKYmVj5/yVFhJasVnGejEKSnM65ysMrlM/d9v2H1X2/
         yP+DLcmYema2ADSbK0lzBlulId5dKBOuVoNuwLvM=
Received: by mail-qk1-f175.google.com with SMTP id t191so7549087qka.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 17:38:54 -0800 (PST)
X-Gm-Message-State: AOAM530rPy1SuVZ2S5ZeUcLtKNWpHgrUN4AF3RJy6tH5lGGajyr96Fp6
        kDDvi5s/o5gLKn/eG7ybjdtwDhA/mirCxbBcu5E=
X-Google-Smtp-Source: ABdhPJzcYu0wQ1AlFdTYrzGLHQSHTIRKOYw1wlZRQ7lRvKH7I58kItfx/GiKuejOksHFuThJetq4/EumL3bl4eCg0NA=
X-Received: by 2002:a05:620a:2106:: with SMTP id l6mr2787457qkl.302.1605231533991;
 Thu, 12 Nov 2020 17:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
 <20201112035023.974748-1-natechancellor@gmail.com> <20201112151320.e0153ace2f2eb5b59eabbdcb@linux-foundation.org>
 <CAFnufp1j6ZzxLJA2x28BdxbTtnN_KtnXB49ibPcbze=B2ru3aA@mail.gmail.com> <20201112171826.0fa3c6158f3c2780f90faafe@linux-foundation.org>
In-Reply-To: <20201112171826.0fa3c6158f3c2780f90faafe@linux-foundation.org>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 13 Nov 2020 02:38:18 +0100
X-Gmail-Original-Message-ID: <CAFnufp1OrGeGgUn9_2V9HMtfb-7GwuEwz4+Co_W8ehcVOQVscw@mail.gmail.com>
Message-ID: <CAFnufp1OrGeGgUn9_2V9HMtfb-7GwuEwz4+Co_W8ehcVOQVscw@mail.gmail.com>
Subject: Re: [PATCH] reboot: Fix variable assignments in type_store
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Mladek <pmladek@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 2:18 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 13 Nov 2020 01:20:29 +0100 Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> > While writing the script I found that in the documentation I left for
> > 'type' the values from
> > Documentation/admin-guide/kernel-parameters.txt, which is 'pci' for
> > cf9_force reboot.
> > While at it, should we update the doc with the values 'cf9_force' and
> > 'cf9_safe', or rename to 'pci' and 'pci_safe' to be coherent with the
> > kernel cmdline?
>
> I looked at Documentation/admin-guide/kernel-parameters.txt's "reboot="
> section and decided that I don't understand your above words :( Can you
> please expand on all of this?  Simple akpm-compatible words ;)
>

Heh sorry :)

I misread the code, I thought that BOOT_CF9_SAFE was user selectable
because of the enum value:

enum reboot_type {
...
BOOT_CF9_FORCE = 'p',
BOOT_CF9_SAFE = 'q',
};

But when parsing the cmdline, 'q' is simply ignored, so it's just an
internal flag.
It's used only by arch/x86/kernel/reboot.c in the loop which tries to
reboot in different modes until it succeeds.

The doc is right, never mind.

At this point, since 'pci' enables BOOT_CF9_FORCE type and
BOOT_CF9_SAFE is not user selectable, should I simply leave only
'pci'?
This way, we'll have the same set of options for both sysfs and kernel cmdline.

-- 
per aspera ad upstream
