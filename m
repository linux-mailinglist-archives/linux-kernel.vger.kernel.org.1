Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1203E2E333A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 00:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgL0Xlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 18:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgL0Xlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 18:41:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B8C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 15:40:56 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o19so20524932lfo.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 15:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2g/tw1CfRfSS28JS/E5UEQtXF4RogkgHtVGCAK+cqLg=;
        b=hmk+nXUKCLprIED87lepHbqNo9/5jDD/zPgpKqfdGUAfyt5eQN8IPSx+3kRgMMUEUo
         WENraXsqaYlObe0ODWSqZ3r0hKg3rOLnExPsZHKeesNCNNc0ihW35MuIOnqY4fkAS3BZ
         dhMQhiHVyIoLXszKYVzPhcMPZpMIyqz7BTmxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2g/tw1CfRfSS28JS/E5UEQtXF4RogkgHtVGCAK+cqLg=;
        b=E3JfffUfv9CMn6lS5WFUEzasa/uaWFCQzZoalZyQZnZutRtzFS8MHZK8s35Rdp6tjc
         dUxVqniO74pC47ONP1hMRnlI94qalzoeUf1Jnl5xJqHX9qmtBwBYLICxq0PItAjc8MAF
         vd+a/OXeYhnvm607iaHgbiUBwqZnTHWxnf16lMQaI5Oe7MyyEWVtnZujcN6dpw34YzyC
         XOgS6LKpeGEpD2wgLPp+h+oD1+dou5CtdDmcW1kxbn17E1MU5B1UXthS07KEmXGxLnOz
         cgZRf1qY9NyHX8EBT/tKuTQw0ejbONDfNh8HUp83dfEpx7otj1zwzGO+M+DZe9YGDQef
         faYw==
X-Gm-Message-State: AOAM533NR45whXk65F7Q2kdZGj3t1eQoCEYkm620ZfjFE8yqpnPRJQNO
        09/mOntHr0MSKzNT7vDBj0zWja0ikDeTKA==
X-Google-Smtp-Source: ABdhPJw5xn0+MKwDqAUrME+yR0dHR0L+PtJbFosr8HJHXTKHpahDCPGSu4wlAcVhhggU8bNeJYpWmQ==
X-Received: by 2002:a05:6512:3e6:: with SMTP id n6mr17346428lfq.262.1609112454075;
        Sun, 27 Dec 2020 15:40:54 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y13sm5161653lfg.189.2020.12.27.15.40.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 15:40:52 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id o17so20476312lfg.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 15:40:52 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr19677994ljj.465.1609112452213;
 Sun, 27 Dec 2020 15:40:52 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2012231905300.5723@eggly.anvils>
 <20201225113157.e7hmluffh56fszfc@box> <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com>
 <20201226204335.dikqkrkezqet6oqf@box> <alpine.LSU.2.11.2012261246450.1629@eggly.anvils>
 <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
 <20201226224016.dxjmordcfj75xgte@box> <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
 <alpine.LSU.2.11.2012261816520.1071@eggly.anvils> <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
 <X+jvZchuTptrxkCH@fedora.tometzki.de> <alpine.LSU.2.11.2012271418460.1091@eggly.anvils>
 <CAHk-=whykpz1RfBZ8Cqk=80_d6BWsppGYBJXoWuWB9n+uUKxVA@mail.gmail.com>
In-Reply-To: <CAHk-=whykpz1RfBZ8Cqk=80_d6BWsppGYBJXoWuWB9n+uUKxVA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Dec 2020 15:40:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvHxQDet0=DTkqmYni_fgDsG=2_-idECFxnd+ECKdg_g@mail.gmail.com>
Message-ID: <CAHk-=wjvHxQDet0=DTkqmYni_fgDsG=2_-idECFxnd+ECKdg_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Damian Tometzki <linux@tometzki.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 3:12 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, your fix for that folded in, and here's yet another version.

Still not good.

I don't know what happened, but the change of

-       vm_fault_t ret = 0;
+       vm_fault_t ret;

is very very wrong. The next user is

+       if (!(vma->vm_flags & VM_SHARED))
+               ret = check_stable_address_space(vma->vm_mm);
+       if (ret)
+               return ret;

so now 'ret' will potentially be used uninitialized (although this is
the kind of thing that a compiler might almost accidentally end up
fixing - with a single dominating assignment, I could imagine the
compiler moving the test to that assignment and thus "fixing" the code
without really even meaning to).

I think Kirill was intending to move the "if (ret)" up into the path
that sets it, IOW something like

+       if (!(vma->vm_flags & VM_SHARED)) {
+               ret = check_stable_address_space(vma->vm_mm);
+               if (ret)
+                       return ret;
+       }

instead. But that patch as-is is broken.

Kirill?

                 Linus
