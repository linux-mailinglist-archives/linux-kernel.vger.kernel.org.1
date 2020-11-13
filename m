Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA76F2B147F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 03:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgKMC70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 21:59:26 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35946 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKMC70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 21:59:26 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by linux.microsoft.com (Postfix) with ESMTPSA id B95FD20C2890
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 18:59:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B95FD20C2890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605236365;
        bh=d5Lc0YjAvi+/83s/MY3Hf9Z6pggitK4YIoSWpqH8sdQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q/1NFDtOk2u9zbJUN1M1mYI5R5INHgBu5HzXneeuiT9RweZsIpGAjD+H7iqVRF7lL
         0uau/Odc6v8ir4B/lY/vJDBSYVcxmb3N2n7C3mFm+GcBsiWeqoSgoqkecvGWZJdbCM
         I2Na0CwEgxd/J6sgU2u2MYr4DB4LfElr/eK+xsB8=
Received: by mail-qk1-f171.google.com with SMTP id v143so7697206qkb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 18:59:25 -0800 (PST)
X-Gm-Message-State: AOAM530Q+haLLFPVf+CHpwEN/EZx0I9Rz+rZimgIl4H1wSYxtxI0Kxyq
        9G+1XFmCB8nlFLPX8u78ky2F8Nc0XpqA9WFyit8=
X-Google-Smtp-Source: ABdhPJyisSHf/7iHOWNg9mhL9bo5HLigo3UyRMldYg64hQxb4nF9ArQE0p4IBE2DY8J54Qo4SZMn18JBwnWdTGuSLOo=
X-Received: by 2002:ae9:dcc1:: with SMTP id q184mr166427qkf.436.1605236364820;
 Thu, 12 Nov 2020 18:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20201110202746.9690-1-mcroce@linux.microsoft.com>
 <20201112035023.974748-1-natechancellor@gmail.com> <20201112151320.e0153ace2f2eb5b59eabbdcb@linux-foundation.org>
 <CAFnufp1j6ZzxLJA2x28BdxbTtnN_KtnXB49ibPcbze=B2ru3aA@mail.gmail.com>
 <20201112171826.0fa3c6158f3c2780f90faafe@linux-foundation.org>
 <CAFnufp1OrGeGgUn9_2V9HMtfb-7GwuEwz4+Co_W8ehcVOQVscw@mail.gmail.com> <20201112184637.de44afedf0ce0dcab36dd0ad@linux-foundation.org>
In-Reply-To: <20201112184637.de44afedf0ce0dcab36dd0ad@linux-foundation.org>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Fri, 13 Nov 2020 03:58:49 +0100
X-Gmail-Original-Message-ID: <CAFnufp31YO9yTXVqgKNZGR9XXRKfGKM4Y4NLk+4_uXdoWa+G4w@mail.gmail.com>
Message-ID: <CAFnufp31YO9yTXVqgKNZGR9XXRKfGKM4Y4NLk+4_uXdoWa+G4w@mail.gmail.com>
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

On Fri, Nov 13, 2020 at 3:46 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 13 Nov 2020 02:38:18 +0100 Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> > At this point, since 'pci' enables BOOT_CF9_FORCE type and
> > BOOT_CF9_SAFE is not user selectable, should I simply leave only
> > 'pci'?
> > This way, we'll have the same set of options for both sysfs and kernel cmdline.
>
> Well, you're the reboot expert ;)
>

So honored! :)

> But my $0.02 is yes, let's keep the command-line and sysfs interfaces
> in sync and cover it all in documentation.  It would of course be
> problematic to change the existing reboot= interface.
>
> I assume that means doing this?
>
> - #define BOOT_CF9_FORCE_STR     "cf9_force"
> + #define BOOT_CF9_FORCE_STR     "pci"
> - #define BOOT_CF9_SAFE_STR      "cf9_safe"

Either BOOT_PCI_STR or BOOT_CF9_FORCE_STR, I have no strong preference.

The syntax is 'pci' while the enum BOOT_CF9_FORCE, so we can't please both.

Regards,
-- 
per aspera ad upstream
