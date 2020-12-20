Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690C82DF8D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 06:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgLUFcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 00:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgLUFcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 00:32:18 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949EFC0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 21:31:31 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g24so8415591edw.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 21:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ca7rUI5Ecb/SMc2dTGElQOR5gmSgTNurObDQ8Frgncc=;
        b=EhadLxamBNMOSFZL4yIDYgkfFMpYoByNqcKHaCoaVTkwwuOoVHhM1ZcXqM9oEdU0u5
         GxS3ryZJV/2cQacFnCw7ZPYW0qzbFckG6Af/z704U4imH3ekk45RbJEJPMI0CYSiTDcW
         vZ9UOZtrk1dWKoCfTK07XtQPKw3AnvVzFn984=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ca7rUI5Ecb/SMc2dTGElQOR5gmSgTNurObDQ8Frgncc=;
        b=f/+4qAlWBic2sfNuxZVTGQZP77QUGFPjEesT4JNmwUMah1SFIiSBtbZoE6Oh2NyILF
         Ykp7ZGhjitF9AXhL5Newi+pFUwICDH6NiO7UHspciQZt4AX4JVBhsYPPBlGR2ne5ZBah
         IG+FrLqe+Hlo+Eugt7eUnTytgpNCPJEuLx7B4BtO0edxN1B7cOTAAGYrX22lrs50BsT6
         ZOLhbM/RACbpAMCctOXKfyt/4CFsl0AGygu7Gq/UcSLnw1nSm85V0cBnP3a0IqpDRIcp
         5vSa22q+y3QrOwy77dgfRXh2KJretT7Bh4aQpwFL0GfVkQ+v2XQRBgXhXBajQgJLY3SP
         DamQ==
X-Gm-Message-State: AOAM533cqRB+UoL3y1SZtO8IVF+APO0F/9/Ern94eKidsWm/H2HTYCaD
        1tX3jnr/7t8p70fk+onoqsxm8m+XQ3V7gg==
X-Google-Smtp-Source: ABdhPJyZln/waZ4PwxCO5aXVrO5k9IMTiudoq5eDS+A8gVkY7UgykLM9urYZZOzb7wKnZuhxlKslOg==
X-Received: by 2002:a05:6512:6d0:: with SMTP id u16mr5524118lff.497.1608498774147;
        Sun, 20 Dec 2020 13:12:54 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id z6sm723448ljz.71.2020.12.20.13.12.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Dec 2020 13:12:53 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id o13so19013529lfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 13:12:53 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr5172645lfd.201.1608498413631;
 Sun, 20 Dec 2020 13:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20201220095830.17843-1-hca@linux.ibm.com> <CAK8P3a1NPMbKnuZ7-b0qbVVtLHT2YG6eEtzKUOf4AZkcu5VO4g@mail.gmail.com>
 <CA+FuTSeKfSouk7SV0cfuZ122J3fAc_ddy_a9unyCRq4F7f6+pw@mail.gmail.com>
 <CAHk-=wjXFfeCHdhAwH8ciXhMJwAc3dOnCAug4G8=eb=+zFnkTQ@mail.gmail.com> <CAK8P3a37qym_RKvCcKn1o53qBuA1gEk4FwPJ644LcPSJW-DrfA@mail.gmail.com>
In-Reply-To: <CAK8P3a37qym_RKvCcKn1o53qBuA1gEk4FwPJ644LcPSJW-DrfA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Dec 2020 13:06:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wimOSd-41nDAYKfbUCNN=o22NOrGT6U38=KLqw5NBsZNg@mail.gmail.com>
Message-ID: <CAHk-=wimOSd-41nDAYKfbUCNN=o22NOrGT6U38=KLqw5NBsZNg@mail.gmail.com>
Subject: Re: [PATCH] epoll: fix compat syscall wire up of epoll_pwait2
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Anvin <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 12:14 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> The sigset_t argument is actually compatible between x86-32 and x86-64

Well, random high bits in size_t or the pointer value aren't. So it
still looks a bit iffy to me.

But it might end up working almost by accident.

          Linus
