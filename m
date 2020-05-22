Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347C01DEBCF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 17:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbgEVP2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 11:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgEVP2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:28:39 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 591C12065F;
        Fri, 22 May 2020 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590161318;
        bh=Ox/F/uTILUggVdWUF5b7dh7aKthW0tyQh3y10bEA//o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qlDTwmn8WbDwMfEY82NiY/DqezQ/e8kltiN2fOalN0ndCr9ZlCMCh6A+togt9w3YT
         YLs6RjoLl7hyDcBP9Tme6YRFpwZxhw7KbbvJPFBaLeE0dtlE1orKk/l1p8UYssB1Ir
         bcC28no4Lsn/I9hZJniDqEchfGWcRozr48/wOVd0=
Received: by mail-lj1-f170.google.com with SMTP id q2so13074794ljm.10;
        Fri, 22 May 2020 08:28:38 -0700 (PDT)
X-Gm-Message-State: AOAM533HhnYc/mFxw/MM2zp2UNw4CbQ9xZqZ029+9bAT3Dxge+0pSAO+
        tXa4Dp0wa0DVldiuMIiRWKvar8RrJU3o/1/9N2Y=
X-Google-Smtp-Source: ABdhPJx2wKtkkmqBLAcmLIP88RBTLdCKWVhCicXpN4tD/4IQ5Bf3r2Zf0AB5PBk82Ia7VD9ZS328WdrQ8o6t6K3IcuQ=
X-Received: by 2002:a05:651c:1183:: with SMTP id w3mr8248642ljo.265.1590161316505;
 Fri, 22 May 2020 08:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200517175220.GA48379@roeck-us.net> <D93AFA5B-3BF1-4E11-B278-22E980C3EE36@c-sky.com>
 <45e1a784-f8fe-5f17-45ca-3eb5453d4bb4@roeck-us.net>
In-Reply-To: <45e1a784-f8fe-5f17-45ca-3eb5453d4bb4@roeck-us.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 22 May 2020 23:28:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQj+FzDMM7YNX=iwjpJL3zfuDDua34o+m4pK0rdRYFPwg@mail.gmail.com>
Message-ID: <CAJF2gTQj+FzDMM7YNX=iwjpJL3zfuDDua34o+m4pK0rdRYFPwg@mail.gmail.com>
Subject: Re: [PATCH] csky: Fixup calltrace panic
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Guo Ren <ren_guo@c-sky.com>,
        =?UTF-8?B?556/5LuZ5re8?= <xianmiao_qu@c-sky.com>,
        =?UTF-8?B?5bCa5LqR5rW3?= <yunhai_shang@c-sky.com>,
        Guo Ren <guoren@linux.alibaba.com>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 21, 2020 at 10:46 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > We tested it with https://github.com/c-sky/gcc (gcc-6.3)
> >
>
> That won't work for me. You really might want to consider
> supporting upstream gcc. I'll try disabling CONFIG_STACKTRACE
> for csky build tests. If that doesn't work, I may have to
> disable affected csky build tests for the time being.
>
> Guenter

Not only CONFIG_STACKTRACE,
Disable FRAME_POINTER (Kernel hacking -> Compile the kernel with frame pointers)

because in Makefile:
ifdef CONFIG_FRAME_POINTER
KBUILD_CFLAGS += -mbacktrace
endif

We'll upstream -mbacktrace to gcc 9 soon, sorry for the confusion. Thx
for your work on maintaining.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
