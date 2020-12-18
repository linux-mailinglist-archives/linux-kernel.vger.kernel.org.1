Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65FF2DE953
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 19:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgLRSvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 13:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgLRSvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:51:23 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5420C061282
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 10:50:42 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o17so8002798lfg.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 10:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=coh9w7doDzN2SUTLJgC4EqzQCeIM0AgHIOkw6bt7pfE=;
        b=V6nzflK6y6t4hh01cjW9DbbgUPRo6YXR5kHzr7brZJDhWnhRJP1LNmoXPoZQAChXQX
         xCyWpr3o2aYTZVcnB7FJ3LJYfcg1OXLtVmSIVmn7ztfptTyPU5Ad2dFVDKPP6YOjwVrM
         QNmpCDh1NHiX8D1GNMJREoB/Qsu0EMRTKFqek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coh9w7doDzN2SUTLJgC4EqzQCeIM0AgHIOkw6bt7pfE=;
        b=YXiUTEPtLW+p8rGFCHeGxxFuAMYx/CvrQUQFWcer/uvn0gtW16BhJJJH+2x6JxgOXy
         dg8zUru5setZJGN6QMUubFcZZN4bRgWVptF4h3LHKpOhqxtoePtlsl6ma3ZiLrwYagYb
         KVDzTKncg4Z6rITAlmo3CeWQ4fR5xXvcsinQ6tLUURWycHKyaf4Vw8EZAYsFLsBbuShM
         pey+M4V1BjHq6hWSWnnk3o7fdQCAJgA7sEr4+SEX5FMsqo8DEKkonszauutJwPFKdUQd
         4tM3NGp8cQMeISVaPwGw00SgRC7Z6yjtOVOxnUxoQqiQunTkQp+myPsKPmQKiutTPJYf
         b8qA==
X-Gm-Message-State: AOAM532d8oIiIHawh/rKBpsjaCCosSWipPsQTzOZTZJuWrDlgShubya0
        57+8HuyX6Nhrou18KbstM1G6Su2uNlvqYw==
X-Google-Smtp-Source: ABdhPJzBGWTic9unP+px99obSbmNrd0gPAwvJ19pCYRNPyo9mUvMr/MvBqTzCYWvXgh1A/26MZvudg==
X-Received: by 2002:a05:651c:48e:: with SMTP id s14mr2473751ljc.159.1608317440814;
        Fri, 18 Dec 2020 10:50:40 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id j21sm1004652lfe.83.2020.12.18.10.50.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 10:50:38 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id a9so8025971lfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 10:50:38 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr1894763lfd.201.1608317438415;
 Fri, 18 Dec 2020 10:50:38 -0800 (PST)
MIME-Version: 1.0
References: <202012151215.E7AA7D6@keescook> <CAHk-=wgg1-Cp=WmE2nGXfDuE8TLKDCQibRdhxbu9MnooLGDHWg@mail.gmail.com>
 <202012161221.18C0E3B5CC@keescook>
In-Reply-To: <202012161221.18C0E3B5CC@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Dec 2020 10:50:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wieoN5ttOy7SnsGwZv+Fni3R6m-Ut=oxih6bbZ28G+4dw@mail.gmail.com>
Message-ID: <CAHk-=wieoN5ttOy7SnsGwZv+Fni3R6m-Ut=oxih6bbZ28G+4dw@mail.gmail.com>
Subject: Re: [GIT PULL] gcc-plugins updates for v5.11-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 12:23 PM Kees Cook <keescook@chromium.org> wrote:
>
> Hmm. Yeah, that's a bug. I think that's an existing bug, though. I feel
> like I scratched my head on that too. I will see if there is a sensible
> way to have Kbuild "notice" that -- I hope there's an easier way to
> invalidate all object files instead of adding all the plugins as a dep
> to all .o builds. O_o

Side note, there's actually a more annoying issue with the gcc plugin
config code.

Namely that when I get a compiler update, the rest of the Kconfig
system is smart, and rebuilds all my files.

The gcc-plugins code? The code that *really* depends on the compiler
version even more? Yeah, not so much. It ends up instead causing a
build error like

   cc1: error: incompatible gcc/plugin versions
   cc1: error: failed to initialize plugin
./scripts/gcc-plugins/stackleak_plugin.so

because the plugins don't depend on the compiler version.

Again, this is not new, but it's another example of how fragile and
annoying the gcc-plugins code can be.

               Linus
