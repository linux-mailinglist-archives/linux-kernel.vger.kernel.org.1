Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CA82BB4D4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgKTTFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbgKTTFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:05:19 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DCFC061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:05:19 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id g7so8775389pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3Bmew0C/D5K97IExHd3EoC8MNcYOfW4VVOD/xnstgp8=;
        b=Fvt3FUNTwcfianIlHY8FDHttBLRHFXN7OpiGxVUXnH4cJP8pmW9qvUgXD+P52+5JCe
         9a5yIEkifERc4cHO2FjYpW4CCSGlDw0gaBwRzg3a0w4dq/ttLNqabpNJP9MekyTerfcJ
         S89416klVyyvCDTQIo112sNYuI2J35sD2qmWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3Bmew0C/D5K97IExHd3EoC8MNcYOfW4VVOD/xnstgp8=;
        b=dIVHTmRTJyla5WSn2PmKkuqubdwdMQPkyswCw+Ze1aBqkQQDYitmJWZVZmwjrxpA4n
         6RcbuYBru64DCbi7Mg4vR9TovOYWsJ9VJ0qwKWRiL8O2lr0kbqHxQXczknNzf/T33YAk
         z/CuuNDsiD5IYYIk8e3IX310PDhnaumNNlqU7KuSyhMEGrrs8faajovePDhwSDdR4SPH
         zlk+gLxO9re4EwqHSdiIPofe+uk+Bg88cMSH7xw5Nq48hbijKjeBrcFNKCfXatF4BIHf
         GWWbKHj1fzKrI1/DziZPzZCZNM/eg9sbqg2PbWvVDRYyCDeG6/P2+3IX+AI9axVNI+Sh
         kdmw==
X-Gm-Message-State: AOAM531a72ZLuWlScNPcFunizVZJKS05ism8S1Au+YpoJEtK8SIaFhQN
        aSv83AQpvYWVHIwVolH6peEbdg==
X-Google-Smtp-Source: ABdhPJwXvxV0tfzhjC5F9A9XqQH7OYBwbojGv83Dzu3MuKlukHplmLg9rXDXsYGc7TA6/JVDkLwa8w==
X-Received: by 2002:a63:c053:: with SMTP id z19mr17860852pgi.418.1605899118672;
        Fri, 20 Nov 2020 11:05:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w63sm4995209pjj.12.2020.11.20.11.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:05:17 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:05:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: sh: Fix register names
Message-ID: <202011201103.50B8F89C2@keescook>
References: <20201117205656.1000223-1-keescook@chromium.org>
 <a36d7b48-6598-1642-e403-0c77a86f416d@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a36d7b48-6598-1642-e403-0c77a86f416d@physik.fu-berlin.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:57:20PM +0100, John Paul Adrian Glaubitz wrote:
> On 11/17/20 9:56 PM, Kees Cook wrote:
> > It looks like the seccomp selftests were never actually built for sh.
> > This fixes it, though I don't have an environment to do a runtime test
> > of it yet.
> > 
> > Fixes: 0bb605c2c7f2b4b3 ("sh: Add SECCOMP_FILTER")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > index 7f7ecfcd66db..26c72f2b61b1 100644
> > --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> > +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > @@ -1804,8 +1804,8 @@ TEST_F(TRACE_poke, getpid_runs_normally)
> >  #define SYSCALL_RET(_regs)	(_regs).a[(_regs).windowbase * 4 + 2]
> >  #elif defined(__sh__)
> >  # define ARCH_REGS		struct pt_regs
> > -# define SYSCALL_NUM(_regs)	(_regs).gpr[3]
> > -# define SYSCALL_RET(_regs)	(_regs).gpr[0]
> > +# define SYSCALL_NUM(_regs)	(_regs).regs[3]
> > +# define SYSCALL_RET(_regs)	(_regs).regs[0]
> >  #else
> >  # error "Do not know how to find your architecture's registers and syscalls"
> >  #endif
> 
> Yes, this fix is indeed necessary. However, there is another build issue that I ran into

Okay, thanks! (I'll add a Tested-by for you...)

> and I'm not sure why it happens, but commenting out "#include <linux/sched.h>" in
> ../clone3/clone3_selftests.h fixes it.
> 
> root@tirpitz:..selftests/seccomp> make
> gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_bpf.c /usr/src/linux-5.9.8/tools/testing/selftests/kselftest_harness.h /usr/src/linux-5.9.8/tools/testing/selftests/kselftest.h  -o /usr/src/linux-5.9.8/tools/testing/selftests/seccomp/seccomp_bpf
> In file included from seccomp_bpf.c:55:
> ../clone3/clone3_selftests.h:28:8: error: redefinition of ‘struct clone_args’
>    28 | struct clone_args {
>       |        ^~~~~~~~~~
> In file included from ../clone3/clone3_selftests.h:8,
>                  from seccomp_bpf.c:55:
> /usr/include/linux/sched.h:92:8: note: originally defined here
>    92 | struct clone_args {
>       |        ^~~~~~~~~~
> make: *** [../lib.mk:140: /usr/src/linux-5.9.8/tools/testing/selftests/seccomp/seccomp_bpf] Error 1

I think this was fixed separately:
https://lore.kernel.org/lkml/160464840151.97255.15344214064240834294.sendpatchset@MacBook-Pro.local/

-- 
Kees Cook
