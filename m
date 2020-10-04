Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC380282C61
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 20:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgJDSId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 14:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgJDSId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 14:08:33 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1E4C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 11:08:31 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b12so8202268lfp.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPAa0PwCL+R/4m3eXjRBJhAhCv7o5/mqYPfRFjTLnGg=;
        b=M6RlgCZ5gbxyh0LuGCVU7rx08rpHawmOJPAeN6wnqB8RhOwogrcswDWcqaI+EGv4iK
         UD5br9uNzrHjxpMfY386lkrsJth+5txvK2FM3VsMWKLX6kWBoeb/iRV08pFFOyyWi3Am
         zMJLNiMgDG4x3awCC4zhCyxMQtrkF6oL0bNGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPAa0PwCL+R/4m3eXjRBJhAhCv7o5/mqYPfRFjTLnGg=;
        b=sHH7olojEu0BiYqtHZWCuM3zM/yqioX+wFwEMoFIXdh7xbvUInzop0JcmEYzYOCcUS
         6OlqknqyL8RC1t4mai+Uys/VR4P4UzYAIr+Xu/nmHbq9sgMrLi+ACVsAhn8mYFuaov2U
         VB5cB2YnURI957F/eVzr9qgHo4+I4U4XKq8tQj6HdTR69NDL5f4cfa9GbRajT2uGn260
         bQQ9nxprzEO6+090fkB+umlPVkjkOMKcen6OqmQoSkAVI32GckYAkLNf/Qmjz2kA0n4Z
         uul4v/TjvIWs1j2VCyWqNkm8sFw3NfrmKxeQiha7s2OyJUJ/Ho7K1FIGpOjf/e0q/JBg
         ZGEA==
X-Gm-Message-State: AOAM5311/l76VHYf68vMVit98iSIu992aZY6fajATVpEht0VzNqnpspC
        SJ3jw0F53+OLa5PfOsOE8ERFMtgL+iRvMg==
X-Google-Smtp-Source: ABdhPJy+MXVi2hrHZlYQ+5CJSRkKeZS+qSZOI6LaSxAl1i8uJbpUVW2JB6mUaOFBr7QV4GudT5LQSg==
X-Received: by 2002:ac2:4148:: with SMTP id c8mr3970785lfi.278.1601834909476;
        Sun, 04 Oct 2020 11:08:29 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id r19sm1094829lfm.301.2020.10.04.11.08.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:08:28 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id w3so5322063ljo.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Oct 2020 11:08:28 -0700 (PDT)
X-Received: by 2002:a2e:7819:: with SMTP id t25mr2979278ljc.371.1601834907754;
 Sun, 04 Oct 2020 11:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201004023608.GM3421308@ZenIV.linux.org.uk>
In-Reply-To: <20201004023608.GM3421308@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Oct 2020 11:08:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmrwNf65FZ7-S_3nJ3vEQYOruG4EoJ3Wcm2t-GvpVn4w@mail.gmail.com>
Message-ID: <CAHk-=wjmrwNf65FZ7-S_3nJ3vEQYOruG4EoJ3Wcm2t-GvpVn4w@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] epoll cleanups
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 3, 2020 at 7:36 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Locking and especially control flow in fs/eventpoll.c is
> overcomplicated.  As the result, the code has been hard to follow
> and easy to fuck up while modifying.

Scanning through the patches they all look superficially ok to me, but
I'm wondering how much test coverage you have (because I'm wondering
how much test coverage we have in general for epoll).

But I'm certainly not in the least against trying to make the epoll
code more straightforward and understandable.

                  Linus
