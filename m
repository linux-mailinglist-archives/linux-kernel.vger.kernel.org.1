Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1371F2E3386
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 02:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgL1Bzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 20:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgL1Bzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 20:55:33 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7103C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 17:54:52 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m25so20792928lfc.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 17:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1lRjsgoyhilZK+oNXD2wNhl23j+kp8k6kqf/g6+eOY=;
        b=OyMg5oCZz79wox7nowQJIpdsLexJGQfx63D+5ySlWUwH7Pkiy7xy3Ex+2Qfr54Fxrw
         B7ogNZi6NjP16Ujs2kphKgiS6jqmv7MeAksxip495bhvgr0ezvW2GQyMYjVPM+qXVDKa
         n/JWSzvL+cU9vv3gN1T5F4fiA8fvrEUnaM8vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1lRjsgoyhilZK+oNXD2wNhl23j+kp8k6kqf/g6+eOY=;
        b=KHWS7oqWoC4Qlcvmhy+0J7YcZGUCiLehWuB5PeIyxy0cIt/WYPC4v21UVO0VtH2Bdy
         bbxHv9l/nO+x/Xdtr7L97Yo+U8KklSWCeN70uQj9w8tVTGGu2HE7rg4OlO0j8VRpoOSq
         gZCaof1czwGonlIgy2r0cHe1qr/Lzx/42n3CqyIhrg9b+qyt+52RiuCQvHGjH8VKX/6V
         R44vi6/blbmitsU8UD3NKWsuIpTJb7S7tnQ8rH1xwDzfthJmC9iw8Muatpq4G2RUP039
         cdZJfWD8wQAb9zO+GVrNRT3UlOnq9jmFCcFZpv0wv/eGpZzU02jORVSBzP2xqcog+lY7
         VT0w==
X-Gm-Message-State: AOAM531eTv6gOjxNtiik3Uz7GYqjuTI5kpIrJeXLOdkhotizlEZjCEPQ
        AKSw6UD9EzigT5MwiwylD8bThQaDfg6tUw==
X-Google-Smtp-Source: ABdhPJx8oQo/ZVm9RxDbX2TIHvsVYkIXwEq5nRaPEEE0oXmFEJD5CQGWYLXGgKsf1GMwprh8A3ZtKA==
X-Received: by 2002:a2e:58f:: with SMTP id 137mr20290705ljf.469.1609120490748;
        Sun, 27 Dec 2020 17:54:50 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id r16sm6306937ljk.93.2020.12.27.17.54.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 17:54:49 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id b26so20827085lff.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 17:54:48 -0800 (PST)
X-Received: by 2002:a05:6512:3048:: with SMTP id b8mr18913675lfb.421.1609120488177;
 Sun, 27 Dec 2020 17:54:48 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2012231905300.5723@eggly.anvils>
 <20201225113157.e7hmluffh56fszfc@box> <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com>
 <20201226204335.dikqkrkezqet6oqf@box> <alpine.LSU.2.11.2012261246450.1629@eggly.anvils>
 <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
 <20201226224016.dxjmordcfj75xgte@box> <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
 <alpine.LSU.2.11.2012261816520.1071@eggly.anvils> <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
 <20201227234853.5mjyxcybucts3kbq@box>
In-Reply-To: <20201227234853.5mjyxcybucts3kbq@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Dec 2020 17:54:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiVrd4R2EVGCGtmybt6+u9LoGgMdnf12zc=sYL=QbvRWQ@mail.gmail.com>
Message-ID: <CAHk-=wiVrd4R2EVGCGtmybt6+u9LoGgMdnf12zc=sYL=QbvRWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 3:48 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> I did what Hugh proposed and it got clear to my eyes. It gets somewhat
> large, but take a look.

Ok, it's not that much bigger, and the end result is certainly much
clearer wrt locking.

So that last version of yours with the fix for the uninitialized 'ret'
variable looks good to me.

Of course, I've said that before, and have been wrong. So ...

             Linus
