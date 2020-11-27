Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67892C6CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 22:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbgK0VLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 16:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731180AbgK0VIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 16:08:39 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472DFC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 13:08:39 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id r24so8766029lfm.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 13:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vfZVmZni5y5pUNP8sVY5cN8ztemvM29CZjahGiwHqQ=;
        b=WqK8NyLZKb1SW4dOsSVDrG/QHynP06jRwhGvHeAfNjwz73taRzqZPpeDqq/jDuoTKm
         F4y+dEvEBYFKx9MkS1RO4Z+4qvMLnrri8AscPY9xgoFFJd4GcQlhoEug+Lpv/t+Ev2pk
         J8LjsgbV/e9n4r6R0HHBFBNZ+Kz9IrgiPyyqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vfZVmZni5y5pUNP8sVY5cN8ztemvM29CZjahGiwHqQ=;
        b=ti/QYrjlevPN45szzJQDgNwMrDscDIEDaL9YPYs+Y6TBlfPok0dHQGPOjwjpgGGYSr
         AmlX1slgXFgwJrrvXMo+GbXeyrlXglNogilqGH+Bg68Fy9OPdNS7tFzFHRTKKTKpN8bk
         TzAwgxeRm+9XxbpkQ+NC0ushpJYRGPdTzcSx42g+nZhF3Ph9AT5wJW72RVZWcv+etCGF
         s+wj1lGV+03OB2EEs0xOJCEViAKVAmOHT4a5nl0zWtqRGD16q425xZihiwpOehBOHhrr
         UeaJlFqfbfeI+5cH589Ynv6+M4r+55VJgBzUkoACEXEO6U6c4cmNQVycNuJ19qcIDzT2
         B6ng==
X-Gm-Message-State: AOAM531q6D205ofX+bTHmZImGhNqlXRGSHJcpPKo8dC4quGgUabB0J7N
        QMtlmKgW5B0G2OWi/8PtRdILkNduC6lyXg==
X-Google-Smtp-Source: ABdhPJywbXyq5yUp62tLLnKr441CdD0UNmsS1b2rlaet7ErsZFK5FSY5H2LW60U7LsSUECUTtJWKxA==
X-Received: by 2002:a19:8112:: with SMTP id c18mr4313408lfd.455.1606511317516;
        Fri, 27 Nov 2020 13:08:37 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id g6sm821709lfb.291.2020.11.27.13.08.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 13:08:36 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id f18so7279240ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 13:08:36 -0800 (PST)
X-Received: by 2002:a05:651c:339:: with SMTP id b25mr4749311ljp.285.1606511315967;
 Fri, 27 Nov 2020 13:08:35 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNASn4Si3=YhAPtc06wEqajpU0uBh46-4T10f=cHy=LY2iA@mail.gmail.com>
In-Reply-To: <CAK7LNASn4Si3=YhAPtc06wEqajpU0uBh46-4T10f=cHy=LY2iA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Nov 2020 13:08:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wihYvkKOcXWPjY7wN13DXbh3k2YX_6JxK_1cQ=krbi9kg@mail.gmail.com>
Message-ID: <CAHk-=wihYvkKOcXWPjY7wN13DXbh3k2YX_6JxK_1cQ=krbi9kg@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Kconfig updates for v5.10-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick note, because it's been a small annoyance for a while (I
don't think it has anything to do with the 5.10 pull, I'm just
responding to your latest pull request)..

I have "make allmodconfig" taking unnecessarily long, and I finally
started asking myself "what's so expensive here". I'd expect it to be
basically instantaneous on my machine, and it isn't.

And when I looked at it, I noticed that it re-compiled
scripts/kconfig/conf every single time.

For no obvious reason I can see.

Doing a

       make --trace allmodconfig

shows a series of

    scripts/Makefile.host:112: target 'scripts/kconfig/....o' does not exist

lines, which is silly and wrong (they definitely exist), and I suspect
it's due to some confusion about the build directory or similar.

It's probably obvious to you once you start looking at it.

And yeah, I realize I'm being silly. Doing a "time make allmodconfig"
shows that it takes 1.5s to do. Should I care? No. But I feel that's
an eternity for something that I think should just be instantaneous.

                Linus
