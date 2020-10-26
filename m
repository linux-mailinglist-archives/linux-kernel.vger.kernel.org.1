Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AEC299733
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgJZTld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:41:33 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33253 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgJZTlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:41:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id x7so4875955ota.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5UMWGuOLcjC1cO+fKd8FsBCsk5aBoRgWF22+6G/UdwY=;
        b=g6RS9T7l8auC4GFcmim2BCZTWwq9F1LIqnl14iDbBdZwkoj/h5gzNZXmVgf0FoLqEd
         FwrZnEGkTtCTcmKZ90sAuaIiafOx63Vee2FqZitIQ78vjFc3fclWAJTzMcaayjMZwc8V
         /1SAKk8o3mMqBV/XzAgC16BjRscO0uq8NGH04ACOh/lU+rR2XNBQ46HNr0E1sniN6Von
         7LYyUFnGSs5wsFNyotHzIiePtJQxrsuc0Pv3NTpoZSmzSaZKyeJk6qQ61Mqu1ddgKiGy
         n/N8e+SqOc413tsbPQGV18m6kpipCYpIVuRlSMDbmC8Z9btmQDYSImF/PGqRlhD5NdC0
         0NfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5UMWGuOLcjC1cO+fKd8FsBCsk5aBoRgWF22+6G/UdwY=;
        b=WlYXrD9RSM3dxWPDKzD/gxjwzreYk2lX0at/PYlknoVT8CmT+xxKiklPpTQ4ZIoLrm
         GrEf6yOgNf9OTBbtQ2RZIq+BU9UJSpVADZlsg7RlWExCxtZbtVl5CKOdxfXda3NUOYGq
         9euYwj3e9o8IEs3gzxUY6d2phmaEyNYLM+tqk8zmFh5gdd2IVINiFinz6SMjomfnQ5WN
         AiCMO4IjCvrV0jaEZCTcRqW6ojzSsKQDkVA1QGnuNwmaEWmOjJ+aq2/Jiz7LT5O20Ebh
         7eljjR2ooLKkSAFnbkRIC6u/cBGB/umpWyG5s3aqcF9FuuwZVHs55aszjidXf7HVt977
         g6Uw==
X-Gm-Message-State: AOAM530aJX9PoSTtmJKpJf17COiMpJ4axx3aHraWmbsb+PKGpTKHMK6p
        UEmpr6CVGUNOZNJUZ3vl4E8=
X-Google-Smtp-Source: ABdhPJz/D7hWcfTIhSRMpGb6Pw553ZqCSWa2i8mdG5VESpK2OySkc+7wZ92Sz2i6nGBTuJ3wWTL+6A==
X-Received: by 2002:a9d:61:: with SMTP id 88mr12036238ota.109.1603741289548;
        Mon, 26 Oct 2020 12:41:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t5sm4032472otl.22.2020.10.26.12.41.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 12:41:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Oct 2020 12:41:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] treewide: Convert macro and uses of __section(foo) to
 __section("foo")
Message-ID: <20201026194127.GA106214@roeck-us.net>
References: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 07:36:07PM -0700, Joe Perches wrote:
> Use a more generic form for __section that requires quotes to avoid
> complications with clang and gcc differences.
> 
> Remove the quote operator # from compiler_attributes.h __section macro.
> 
> Convert all unquoted __section(foo) uses to quoted __section("foo").
> Also convert __attribute__((section("foo"))) uses to __section("foo")
> even if the __attribute__ has multiple list entry forms.
> 
> Conversion done using a script:
> 
> Link: https://lore.kernel.org/lkml/75393e5ddc272dc7403de74d645e6c6e0f4e70eb.camel@perches.com/2-convert_section.pl
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@gooogle.com>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> 
make ARCH=um SUBARCH=x86_64 defconfig:

Building um:defconfig ... failed
--------------
Error log:
arch/um/kernel/skas/clone.c:24:16: error: expected declaration specifiers or '...' before string constant
   24 | void __section(".__syscall_stub")
      |                ^~~~~~~~~~~~~~~~~
make[3]: *** [arch/um/kernel/skas/clone.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [arch/um/kernel/skas] Error 2
make[2]: *** Waiting for unfinished jobs....
arch/um/os-Linux/signal.c: In function 'sig_handler_common':
arch/um/os-Linux/signal.c:51:1: warning: the frame size of 2960 bytes is larger than 1024 bytes [-Wframe-larger-than=]
   51 | }
      | ^
arch/um/os-Linux/signal.c: In function 'timer_real_alarm_handler':
arch/um/os-Linux/signal.c:95:1: warning: the frame size of 2960 bytes is larger than 1024 bytes [-Wframe-larger-than=]
   95 | }
      | ^
make[1]: *** [arch/um/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
arch/x86/um/stub_segv.c:11:16: error: expected declaration specifiers or '...' before string constant
   11 | void __section(".__syscall_stub")
      |                ^~~~~~~~~~~~~~~~~
make[2]: *** [arch/x86/um/stub_segv.o] Error 1
make[1]: *** [arch/x86/um] Error 2
make: *** [__sub-make] Error 2

As with s390, reverting this patch fixes the problem.

Guenter
