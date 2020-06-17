Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC061FD0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgFQPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 11:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgFQPZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:25:36 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3ABC061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:25:36 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so1555822lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6nIuDWwcfkNRxXhFGKJnyws0bUwaKcz08/Ho8g5tJI=;
        b=Ojk5dxH9+DvMUGom64AEv7XfBLXa9lBuwrzwGTnlOsPxiMkrbDSwj3LZ3zSHPWkGyz
         9ToRm9j64HKaH0C201cTSBPfUeD4L0jyv5gL+/6/qmIuqmzEXURqwTgpPiQXDB2VaGwF
         qZGvTCrWNr19Q9uHIQ+fcZ1aHaKDOq/bAgerWk0+0yn6/A9lDR5bDmAYvM4uNp9prxVZ
         6DKX/iKAs8nUP3ny4EOtz7D3j7wO3sIdHgCvXEeJ9MwLbCjJEVdGxS6Z/XsWBmYs70uj
         wm5KADMa/2iKCqFHgyU/T9kpJ7tGuHoa9yFAJtaAAvyHQEClmKdmqy0zBbSl7zmeo1PX
         BUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6nIuDWwcfkNRxXhFGKJnyws0bUwaKcz08/Ho8g5tJI=;
        b=Wd6Kupg5B1btY0m9BGAHwVAYgRCAksH+Dt+735HQHJIC2PRH+lkbv7ufBal0+L2noN
         UXFYaE78VVPsFCh+fb2FjUinTkgpt3XUwQ5guVTuLsn9WGuVWuBgIBsiZKG+vkHX3lia
         HJuNhg0XMtwxmdAaAUsnY2cB/3af3s99ekSZIbeEF+58tBjaQAziEffuFWwNhtIf96BX
         fmH5aMnIlZ+vgcLUniywXTssWMbFL4FWUPPx5prJoc++dP+a2rvACpl5Y9CEkpAYvHM/
         l9inJ5KTrRZr5vXL5EWd3aYlwqTF/FZLVuNTihtGnp6B4MnY2wwyqMrTuMsbCB2QBeQn
         BxnA==
X-Gm-Message-State: AOAM531l/EEPt8q9UrgkkEbLTHz0N+6E5b+LR/dozf4xaRS0cLmyjCYl
        G7ZihzD685nNDL3R3gVLnsujf3/5ybKbjYTuSE3A3Q==
X-Google-Smtp-Source: ABdhPJxW0KcrhfVMM8iiEPssL/hOtSCDm+eXlggQ0rLGtwI+PEd2JAjBdOK9N11hcJ5LAh8Ytoew3jtobcblKdwkZyE=
X-Received: by 2002:ac2:544b:: with SMTP id d11mr4879243lfn.157.1592407533670;
 Wed, 17 Jun 2020 08:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200616074934.1600036-1-keescook@chromium.org> <20200616074934.1600036-4-keescook@chromium.org>
In-Reply-To: <20200616074934.1600036-4-keescook@chromium.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 17 Jun 2020 17:25:07 +0200
Message-ID: <CAG48ez0-jSSaw85=ku35UM3vMe98Vz97B68LsUoNd8ftwpunkQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] seccomp: Introduce SECCOMP_PIN_ARCHITECTURE
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 9:49 AM Kees Cook <keescook@chromium.org> wrote:
> For systems that provide multiple syscall maps based on architectures
> (e.g. AUDIT_ARCH_X86_64 and AUDIT_ARCH_I386 via CONFIG_COMPAT), allow
> a fast way to pin the process to a specific syscall mapping, instead of
> needing to generate all filters with an architecture check as the first
> filter action.

This seems reasonable; but can we maybe also add X86-specific handling
for that X32 mess? AFAIK there are four ways to do syscalls with
AUDIT_ARCH_X86_64:

1. normal x86-64 syscall, X32 bit unset (native case)
2. normal x86-64 syscall, X32 bit set (for X32 code calling syscalls
with no special X32 version)
3. x32-specific syscall, X32 bit unset (never happens legitimately)
4. x32-specific syscall, X32 bit set (for X32 code calling syscalls
with special X32 version)

(I got this wrong when I wrote the notes on x32 in the seccomp manpage...)

Can we add a flag for AUDIT_ARCH_X86_64 that says either "I want
native x64-64" (enforcing case 1) or "I want X32" (enforcing case 2 or
4, and in case 2 checking that the syscall has no X32 equivalent)? (Of
course, if the kernel is built without X32 support, we can leave out
these extra checks.)

> +static long seccomp_pin_architecture(void)
> +{
> +#ifdef CONFIG_COMPAT
> +       u32 arch = syscall_get_arch(current);
> +
> +       /* How did you even get here? */
> +       if (current->seccomp.arch && current->seccomp.arch != arch)
> +               return -EBUSY;
> +
> +       current->seccomp.arch = arch;
> +#endif
> +       return 0;
> +}

Are you intentionally writing this such that SECCOMP_PIN_ARCHITECTURE
only has an effect once you've installed a filter, and propagation to
other threads happens when a filter is installed with TSYNC? I guess
that is a possible way to design the API, but it seems like something
that should at least be pointed out explicitly.
