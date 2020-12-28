Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4570D2E6C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgL1Wzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgL1TlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:41:23 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7128C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:40:41 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id h22so26246999lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KC0IvukBXrMezsZLkepZEAdyw/KWhE6PVpb9k71bqjU=;
        b=B5N91RmLSyl9z2bK12UgU1zpbdLtQxsgPSz4HhqBb9TfajaOGwZrI8UJBfFq8CG5Jm
         tx1oGbxKN/CRscqeYPn3lRrzLrhMTi2xOebdgNBSM727I2YAEZNpDNrrg4X44B6SpCeM
         r4zaG0pelWFqnRT3uIdt5HGySYHoAWwJBezk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KC0IvukBXrMezsZLkepZEAdyw/KWhE6PVpb9k71bqjU=;
        b=uQpilGVndZCGrafw79qJ0//YfT5M7zH9jsWKm08CzC38h9RdYk3UpcgM0JkxzSTzR7
         Mm3WKV8MRq3ye2gYsqQ5mxAagfiMWzSRiSIW3gae00MYkGJ5X6oitA/2c8oKhQtqaZNm
         o2uyj6/r55igNqL0YzBDQcKmRd9V7TfrEjL4SGaL5Nd3x/LcTGl+0Bdxoua7PlOkpY/6
         E1+sKQhZYvJry7WoLX5Yyrzns0uPnACn1N0zi74GrMvJARwPWir0F99XGUV/xb8SGUyN
         5xtakKTq5qaG378jE0Zpr6Ke1Zd7SeUt7XOAIqgNxhXj6usdG8u5ovx/Fr1HLsy9EVH6
         ascA==
X-Gm-Message-State: AOAM531iIPwIR5b+Nqqtx191qMUBkm0z7coPaZywsTxQdhk0E2KlZ7sl
        mQva9vQdRCxqNykV/cdpviJ3excAO5L4AA==
X-Google-Smtp-Source: ABdhPJx2TykyGyuYa+NoMCepEEKifyZN3056HLBDwFrD7B7HdjI7YOYZ6r41vBtDX8iv0plNDsSmfQ==
X-Received: by 2002:ac2:4a75:: with SMTP id q21mr18790240lfp.119.1609184439903;
        Mon, 28 Dec 2020 11:40:39 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id c3sm6585448ljk.88.2020.12.28.11.40.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 11:40:39 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id s26so26150436lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:40:39 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr23617958ljc.411.1609184438626;
 Mon, 28 Dec 2020 11:40:38 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUQRKuZzN0ZbaG6vprRWcKPKYVYTryiMFac7q_PRcBvgA@mail.gmail.com>
 <CA+icZUWHiCu9=+80Z8OV+Q3r-TJ4Vm0t62P_Qgck5bRzjrtaWg@mail.gmail.com>
In-Reply-To: <CA+icZUWHiCu9=+80Z8OV+Q3r-TJ4Vm0t62P_Qgck5bRzjrtaWg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Dec 2020 11:40:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3AsdUVZ8GKNCdUmY0_nGmoiOVTwy7rR5QM7K31QiSqw@mail.gmail.com>
Message-ID: <CAHk-=wh3AsdUVZ8GKNCdUmY0_nGmoiOVTwy7rR5QM7K31QiSqw@mail.gmail.com>
Subject: Re: Linux 5.11-rc1
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 12:04 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> > $ dpkg -L kmod | grep bin | grep depmod
> > /sbin/depmod
> >
> > $ which depmod
> > [ empty ]
> >
> > $ echo $PATH
> > /opt/proxychains-ng/bin:/home/dileks/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

Ok, I think this is a broken setup that has a separate /sbin but does
not have it in the PATH.

As you noticed, you can fix it with

   DEPMOD=/sbin/depmod

or you could just make /sbin part of your PATH.

It looks like on your distro, /sbin is restricted to just the
super-user PATH, which is odd, but I guess there's at least _some_
logic to it.

I guess we could have some compatibility thing in scripts/depmod.sh,
something like

  diff --git a/scripts/depmod.sh b/scripts/depmod.sh
  index e083bcae343f..a93261207453 100755
  --- a/scripts/depmod.sh
  +++ b/scripts/depmod.sh
  @@ -15,6 +15,8 @@ if ! test -r System.map ; then
        exit 0
   fi

  +# legacy behavior: "depmod" in /sbin
  +PATH="$PATH:/sbin"
   if [ -z $(command -v $DEPMOD) ]; then
        echo "Warning: 'make modules_install' requires $DEPMOD. Please
install it." >&2
        echo "This is probably in the kmod package." >&2

or similar. Does that work for you?

                Linus
