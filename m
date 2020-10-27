Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF8329CC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 00:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506962AbgJ0XAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 19:00:21 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40223 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbgJ0XAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 19:00:20 -0400
Received: by mail-yb1-f194.google.com with SMTP id n142so2652732ybf.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26PWzubL1YWsWTQ1LcqPNE23u/zm8KmNBUxh8wlBGF0=;
        b=PtIIj7+EwDBfEpInuqVSv4PK+k2EU/wpKQhse90rVmfay74RTFTgJomeI7CD4lpsrE
         FLwiqUEHm1DG7mdCfVkS99woSg4NJDTNwd4gA40jNWJmEDmZzXUJOXh+DM/0hhvcFZvL
         rpTget4+kddUnjfwKfJjZmSHWI93AJh/ATroFM1OjqkVr6mHuQa71pUiTmtoDMDDe98j
         L90Rdp36KrgROdqLdSh2lkN/w/7JXfG0LvZGYIB9fx4Kik33PkLlPutTBifBbmE3JUqs
         rsWJ7MeXFB9JlZAk5e9C41RRECHTtnysjpkOu7rmiebuCx416xUVgfHeFL/YyVKY86PW
         BBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26PWzubL1YWsWTQ1LcqPNE23u/zm8KmNBUxh8wlBGF0=;
        b=cBefsO4Do9SLW6WAcaKmGOrWCVh1X4gOIDyd/CD8l0/VqFExAfj+p/zDx52AUGYkbL
         AMOU4lskPAeKJDs8hgizcphFI901zzJjk1iidpPRBD8bQECwsTeZh8q80ag6MjY3Hijz
         BeyyH7ryl/qlMztK7fRCxBiQ9kNE3AdPdJuOLuWZ2A2T+5Z58ml0Y66PMCNhRYBYcqM8
         F3MKQ1WWk85en76UatbrAq10igzASDjIW1MZo2PmloJEdCnMvUApcFNM10sdj/J2HBff
         wSy5XR6gtybb2so0T/il7rxGG9JD9yf/2u/WuxhZkYzfNOUyXWR1Lsmn3vE2tZ1UO9uV
         52YQ==
X-Gm-Message-State: AOAM533rj05Y3r9Re2KgU7SZTJzzFTFkyDLEnH1SL/hVD26kD23V6lfv
        QmZ3zoh1+75RfSOpuLw/It3qpJIDANktRI9wPQ8=
X-Google-Smtp-Source: ABdhPJzw8882n0EFvrxMrS/ZfWEkeznSVub8c3dw/5Qu2IOHhQHasYmgA02IvPpM3WMnENcgQnOtiu1BrkkeqYd4GGk=
X-Received: by 2002:a25:4102:: with SMTP id o2mr6422900yba.115.1603839619427;
 Tue, 27 Oct 2020 16:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201026192117.3811525-1-arnd@kernel.org> <CANiq72n72FMnNnWveSZOj_3_beXKX03CVL8=cQqqa8QyK-PKig@mail.gmail.com>
 <CAK8P3a269o2Dqm500MAtp5JZD3-Diaa3iaMecONeyLAuE7r7Rw@mail.gmail.com>
In-Reply-To: <CAK8P3a269o2Dqm500MAtp5JZD3-Diaa3iaMecONeyLAuE7r7Rw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 28 Oct 2020 00:00:08 +0100
Message-ID: <CANiq72k81xcGBvM2kbGnSmeJ6g+kfD2srh79DGgeWaVo9GGEbw@mail.gmail.com>
Subject: Re: [PATCH v2] ctype.h: remove duplicate isdigit() helper
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:37 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Sounds good, I'll take that. Are the clang and icc version numbers
> the actual ones we should list here, or is this just an example?

Actual ones -- well, the best approximation I could get from the
available versions in Compiler Explorer :-)

Cheers,
Miguel
