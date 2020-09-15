Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27390269B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIOB3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIOB24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:28:56 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D74CC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:28:54 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z17so1279461lfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8g7vNyQA2/Pw0tWaZWsWIsCkIJV7KkgdjAjjJ3LiIA=;
        b=dKnH8ELsfJPyh3Zg9ToOYk9CfNz9CdtSk8KF08KfKGI0a52tNfsMYHsE2FAFTsHtMv
         cc1oYGKBLR4xu/hoijEWb2pMF2xovh4BBeQOin5/ugJ/2hx6bbJpzgxhxqxbCDteZtU1
         QaaWohpdPi5YCef37W/yqDq49kBUdeBelWIZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8g7vNyQA2/Pw0tWaZWsWIsCkIJV7KkgdjAjjJ3LiIA=;
        b=nBK+Vrkd7BXvC/34Y189c2+PoxICi59F8+gEBgCge9Vdurmlhu4XmSJ29sZEuT4m/l
         0+0fGdeNiHDWyRMsVo0wCTTGeIvr4zUbOnIEu2E+Xef7keGVPlPfYS2E//rgqoocYVbX
         fqUSxKkznKBiYXt2mn/WEi/9hpulBCKBazha92+1F9QrdsDowIavp2JTu5FptXOVWJTE
         mGpBs3gPm5ugszWEk96seMnYDqFCAVVA3HBX0yCs0MW5K9wGBwlJ5Jw66EEb0wiaKnNF
         kVnuSWO9CobeFqwWkHICuAYEmUyYYUsTGmyzz3X9FTXN/JicL41TTWTjjoGyQt9rE/gc
         IRzQ==
X-Gm-Message-State: AOAM5314dOPSsvbbzbnsvli/hZWGyXR7r8+N5loQ+oeSVaCKmQJjc1cJ
        DdTfzcT0xPImuIjjVlI7W9WYwG6VvBxKKA==
X-Google-Smtp-Source: ABdhPJzH3RSR9FB8pXci/gtort7qTKWb4r2NAcI/UJQO93FmQXYnN3dmhbLVYMbhnriU0NuREYlBuA==
X-Received: by 2002:a19:8c46:: with SMTP id i6mr2941111lfj.55.1600133332404;
        Mon, 14 Sep 2020 18:28:52 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id s20sm3659167lfs.135.2020.09.14.18.28.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 18:28:51 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w11so1352943lfn.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:28:51 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr4631661lfr.352.1600133330815;
 Mon, 14 Sep 2020 18:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <git-mailbomb-linux-master-50145474f6ef4a9c19205b173da6264a644c7489@kernel.org>
 <c9cd22ec-60dc-d761-b488-d3a1392708c0@infradead.org>
In-Reply-To: <c9cd22ec-60dc-d761-b488-d3a1392708c0@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Sep 2020 18:28:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNTWpqUF0HgzoyPGEaaAjxD-Bor+EE3DbJ52S30cfCWg@mail.gmail.com>
Message-ID: <CAHk-=wiNTWpqUF0HgzoyPGEaaAjxD-Bor+EE3DbJ52S30cfCWg@mail.gmail.com>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yuan Ming <yuanmingbuaa@gmail.com>, Willy Tarreau <w@1wt.eu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        NopNop Nop <nopitydays@gmail.com>,
        =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 6:19 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Now someone can remove the documentation for scrollback (and "no-scroll")...

Note that scrollback hasn't actually gone away entirely - the original
scrollback supported by _hardware_ still exists.

Of course, that's really just the old-fashioned text VGA console, but
that one actually scrolls not by moving any bytes around, but by
moving the screen start address. And the scrollback similarly isn't
about any software buffering, but about the ability of moving back
that screen start address.

Do people use that? Probably not. But it wasn't removed because it
didn't have any of the complexities and bitrot that all the software
buffering code had.

That said, I didn't check how much of the documentation is for the VGA
text console, and how much of it is for the actual software scrollback
for fbcon etc. So it is entirely possible that all the docs are about
the removed parts.

              Linus
