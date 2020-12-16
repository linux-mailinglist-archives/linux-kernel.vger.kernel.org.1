Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC632DC70F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 20:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbgLPTZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 14:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388265AbgLPTZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:25:04 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DACC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 11:24:24 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id h205so7718405lfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 11:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A5unv63hTW90lYarXreqDfKtY8TgaxsOtvfjiNaWmbA=;
        b=OW0QDcDnkHj1AWJrcP0n+bBngFcR3AdI0EttDOiKT9Gz4Jg+az99LILX0BNLAC2BRO
         ak/dskVtkdq1Kvh+n6BpI/v3lbLKY+IBCLpgaVdmHIXi6Oe5VsETLABAgq5JYLLHKVRq
         ND+Oa8Si0KJg6eci7zOnAewqYIYJGUFLNAASs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A5unv63hTW90lYarXreqDfKtY8TgaxsOtvfjiNaWmbA=;
        b=ENmh1QEzxmuT5zgJ8vit5/LO+yMUG3Wk42WOTh3GrizJl0nl/VpHP6EmriE74gZmtH
         Pnk+GTJm9pDiEO/pwxJcwTOmzu/h4rxLcpEvQ/rbpdQGp6Tq0X//YObXlVii7vPFjd4k
         3GE5sUVoM62pUPOn7Vlj8s2I3YWeDms8dS39AXAo1n3FhX/iBTkK1ZOMFOoH/td/PQo9
         1OIOtrYp6PpvmihWguokLOSrxJiOAc0ww3eGgpHbiBNanykyvhA3eEpMMmLa1RiTQwuw
         B8RwxTCpH9AckTDm/Sb2KBmdi3SC8cnPPJE6YZveHTM0ZkBwV+j5DGfP9sHSq85qEwll
         oSxg==
X-Gm-Message-State: AOAM532sh9muOhr+dGFYKeI8z10ECfaLbl5Pw/5LbsGxUQyE6U8x0/87
        XNyMpzINdAUDmYTEdbg4co6xzeb38TcUjA==
X-Google-Smtp-Source: ABdhPJxq5xVpY/cnL1QI3Etuer4coyb9bn+AhkZWcG6x100z3JTSeq/Le9jFj9+ZRwj+LaKUl5/Kjw==
X-Received: by 2002:a2e:9ac1:: with SMTP id p1mr8587019ljj.389.1608146661544;
        Wed, 16 Dec 2020 11:24:21 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id v11sm381035ljg.128.2020.12.16.11.24.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 11:24:20 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id x20so31696297lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 11:24:20 -0800 (PST)
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr12638043lfi.377.1608146660209;
 Wed, 16 Dec 2020 11:24:20 -0800 (PST)
MIME-Version: 1.0
References: <202012151215.E7AA7D6@keescook>
In-Reply-To: <202012151215.E7AA7D6@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Dec 2020 11:24:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgg1-Cp=WmE2nGXfDuE8TLKDCQibRdhxbu9MnooLGDHWg@mail.gmail.com>
Message-ID: <CAHk-=wgg1-Cp=WmE2nGXfDuE8TLKDCQibRdhxbu9MnooLGDHWg@mail.gmail.com>
Subject: Re: [GIT PULL] gcc-plugins updates for v5.11-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 12:15 PM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull these gcc-plugins updates for v5.11-rc1.

Hmm, I pulled this and then did an allmodconfig build.

I expected that to be a full rebuild, since the plugins got
recompiled, but it turned out to just take 16 seconds because it only
compiled the plugins, not any of the object files.

I'm doing a _proper_ full build with this after doing a

   git clean -dqfx

to actually clean everything out, but it did make me go "Umm".

Maybe we don't care. I guess the plugins are all supposed to be stable
in the sense that any updates don't change the generated code. But it
does strike me as a honking big hole for verification of plugin
changes.

So I don't think this necessarily requires any changes to our Kbuild
infrastructure, but I thought I'd mention it since this clearly didn't
match my naive expectations.

              Linus
