Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914932E86CB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 09:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbhABImR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 03:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbhABImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 03:42:16 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F65EC061573
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 00:41:36 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id j17so21239829ybt.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 00:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KsZJHC1rJQkszoKmWJn/R3n/LUJWrTiZKTjnjx0Jyvo=;
        b=L/he/qMW6MEfJzwnjGRL9GsT9cRGGmMSj6hcbuOIdobCjpTyqI0M6fC/nXe/3E7ukd
         3SZHbf30jBEBc5lTN2hmrcfTrUSr1BR7QLa4I2kjYQCVW0B2Hp2GJ3SLnBwRLcwIfbwx
         pkqVia14rvg25iGUR5CmeJ8V6lz5omM/wsAEEPGKoIwsDUhxCJX0IfkiF1DONc7Zi5cj
         FPnl40wmOKWA4wK40fKfRRWQWWxAS+iChHfo1atDyIy3rFZoHGiJKk5aAwHmKVK1/JzH
         CN/D6NfFTrR6CUIgGCscdQ5Ws6rCe/pH3vopfV/5dPL5M6bhdkJmKgG6nJGaPU4zvQTz
         jKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KsZJHC1rJQkszoKmWJn/R3n/LUJWrTiZKTjnjx0Jyvo=;
        b=f40Bu62LUdsn1ypKPJWAhUacbLPoYPRXtJsLzIglrI3liEbBVDHKDPMMJxqULiQlgS
         QRPI8/rLzKowzzcTz9L2tbJI+7WhCWsUw+hXvxCim+oDhvcPbHuVnSKJL28XZAfZ3J/x
         nSaDT9agllL2nWR2lpJqnoEpf1sw4mAhgnekOCjEmNhf6QCmyw9Ejit5WZ3J1zI6eLyX
         7mlcjFUindP6bDZa/nj5/1+vil9GsuTNJIlD8Ua77WXj2YBLv0e/3c98ph/fqA5BI9QZ
         0UOSLUziIQKWTcTQy48mltn8oosMNPUjtmqZBCILbYJ9EZ2JDl0Fo667xskfwi0zO0KC
         LIxQ==
X-Gm-Message-State: AOAM531ITCwrspGlHJyrQuvt8n0d3RGJ2k+RFXAzUfAGfLfxfwvGXY4a
        23+IuHxuhZBS540oV6vgxzMMMfG6OgTzSmMWGciCVg==
X-Google-Smtp-Source: ABdhPJwf5VD+H/iRDcwDxeXUOK//qPwjEqCMZB5sId8ijQ9EUeU5tAvaMymzeW1JpEPK/7rNfkwogYbY/agzFinO7Gs=
X-Received: by 2002:a25:aa87:: with SMTP id t7mr90503217ybi.233.1609576895442;
 Sat, 02 Jan 2021 00:41:35 -0800 (PST)
MIME-Version: 1.0
References: <CA+LSzgc+xy_HpLFYuSbg8XKfAxxwGm9957dAa__m_2FEiBFiyg@mail.gmail.com>
In-Reply-To: <CA+LSzgc+xy_HpLFYuSbg8XKfAxxwGm9957dAa__m_2FEiBFiyg@mail.gmail.com>
From:   Masami Hiramatsu <masami.hiramatsu@linaro.org>
Date:   Sat, 2 Jan 2021 17:41:24 +0900
Message-ID: <CAA93ih0RHbRGUc-wu6Mw4BG2aqoh-57RQip2diABO9dmQEAQ3A@mail.gmail.com>
Subject: Re: Unicode output with uprobe?
To:     Bar H <billy.san@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, at this point, uprobe-event doesn't support non-ascii strings.
If you are sure that
the length of the string, you can use an array of u8, e.g. u8[16], but
not sure it can print the string correctly.

Thank you!

2020=E5=B9=B412=E6=9C=8828=E6=97=A5(=E6=9C=88) 19:24 Bar H <billy.san@gmail=
.com>:

>
> Hey Masami,
>
> I found your email in github, I hope that's Okay I'm sending you this ema=
il regarding uprobe/kprobe as I couldn't find assistance anywhere else.
>
> In uprobe, I'm trying to print out function arguments that are none-ANSI,=
 that means there are trailing zeros after every character, so when I use t=
he +0(%x0):string notation, I get only the first character.
>
> Do you know if there's a way around this? maybe use another function in t=
he sysfs framework that I could use? I'm debugging a third-party, user-mode=
 *.so file.
>
> Best,
> Bar



--
Masami Hiramatsu
