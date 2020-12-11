Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001BA2D7FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 20:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394392AbgLKTsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 14:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393903AbgLKTqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 14:46:21 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76B5C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 11:45:41 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 143so1726829pge.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 11:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GVocl/rVAcj1v7+L3CkLflCJiE2AVxirIhrJAn4j9I=;
        b=j6wtErheo/tU7Bgku48rFUp7+QuVUNnuFvm4+WHjLO+i9TITt6lIvVcYuCxCt0D5zr
         wt0AqGeFiL6zD1PZM6gCCXzvqZCmIa/mMNBAdqSFaN90xNjhJxBt3cPjAeI6aGZWyh2J
         aSzsfOJAyVUGu2N9CG5xyUzYwQPoojIjTlLew37TXG9fk7FBD8M0fyRV8SBlrBG4iDLp
         hdt3jr/PR7ND8Pwa0r0z9+teI3oKNpBxdk2hZHnlSZV5SJEzv1YMCqE4WeKDguhdwStR
         TJ0XBRW4A15pEotatZWXTxkVaTA1/Jbuzi5G/kRABz7yIjkZiKyc5NFC2//8p9RdXKpP
         t8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GVocl/rVAcj1v7+L3CkLflCJiE2AVxirIhrJAn4j9I=;
        b=EikDt/ccXUZ/8EvI0bOm2QFj05l7q8LMkRW1rg65A4be8gc2w6rz5+u6U1Sa2roHLO
         KQ5zyYC213AfjIBx7WNfUB0jb7eFlD7xpIppyA0VjiKNxlT4lpRQsZG3ZhTkBLFQYxh6
         VQ3BEzlxIYslx79lPkPlSG7pa8gQjXXJg4RlLwVJg0f+fWommZPYg+3OMz+pquHM6uWl
         PxcfSj4mj1TQro6rpdLAs6GBQ0r1KIal97/4pgJ6K7uKfviQu7vyy4HhTOr7MftmXYtp
         fthKhYsE4e52WVwAUaYCjrt0ZObdzfrDLdu2eUQp4bzfwZvjA9hpNivf0KdcvdQdVEJa
         6Igg==
X-Gm-Message-State: AOAM533I32YsGPEAg2xDnO60SRKJJTUtQln1acUvSBUKA/4olACgzLy1
        DgJmGJphsZjssDYh2k2FT/uy7GlqrG7CjjYOVJxzDg==
X-Google-Smtp-Source: ABdhPJyLi3u5pazCd7AZxoxIsGKooQfv8JjHoQ0mQ2RZg34nU+hpk7lseJFZlqEgqXK4lYT7c3zTsqncnUueyDqfmpM=
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id
 144-20020a6218960000b0290197491cbe38mr13208868pfy.15.1607715941064; Fri, 11
 Dec 2020 11:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <20201211184633.3213045-7-samitolvanen@google.com> <202012111131.E41AFFCDB@keescook>
 <CABCJKueCJhwRL1T1k6EYpUy_-Rj85K98iz5FO6K+dZLY25z8_Q@mail.gmail.com>
In-Reply-To: <CABCJKueCJhwRL1T1k6EYpUy_-Rj85K98iz5FO6K+dZLY25z8_Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 11 Dec 2020 11:45:30 -0800
Message-ID: <CAKwvOdnBQiUeXCH9U9Cc3_4-UtC+jepV_-yD6usJRSMYjpNFrQ@mail.gmail.com>
Subject: Re: [PATCH v9 06/16] kbuild: lto: add a default list of used symbols
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 11:40 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Fri, Dec 11, 2020 at 11:32 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Dec 11, 2020 at 10:46:23AM -0800, Sami Tolvanen wrote:
> > > --- /dev/null
> > > +++ b/scripts/lto-used-symbollist
> > > @@ -0,0 +1,5 @@
> > > +memcpy
> > > +memmove
> > > +memset
> > > +__stack_chk_fail
> > > +__stack_chk_guard
> > > --
> > > 2.29.2.576.ga3fc446d84-goog
> > >
> >
> > bikeshed: Should this filename use some kind of extension, like
> > lto-user-symbols.txt or .list, to make it more human-friendly?
>
> Sure, I can rename this in the next version. Does anyone have strong
> opinions about the name and/or extension?

.txt extension would be fine.

-- 
Thanks,
~Nick Desaulniers
