Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB72F54DA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 23:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbhAMWMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 17:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbhAMWJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:09:11 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02590C061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:08:30 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b26so5051100lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qpRsvWTUoPBimP/fo2jeNBuh57czhavnYXwy3EGUNQ=;
        b=O5tD7VX8Mw1Uqj4pHOrzf+txpuEcvVOqvDrs/kAgC+/pePEkQty3XvzGM/Ge6lKAam
         BwY186f3pvtuJS1Tk+stRMAPL1/LYVfS49sZoBf3yWAtCywFqXwngOIPsxeNQwW6PgGw
         9noPxfBNWI0yfKSt50EuHP4VdFSbA9pwM4ixw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qpRsvWTUoPBimP/fo2jeNBuh57czhavnYXwy3EGUNQ=;
        b=pIFl3FXf8uTuRpUvDs/8fSDLjaZaqwWJwDxTAl0n/A2CGR2+q8b0iAh9HGUaBiQuKt
         fOgkJ9fDdeDCp9CBKVIQkxXPMrAJPLzPLk/F7hAYUfJ093SPzQLl8GEp/hqaZm2G7GFD
         5cMFtZ3CqOxhemQ/rPU7lBNhARe741e1dqKaqFeAkN8odmdvb3rgg5VPcQZzWYOt3HtY
         980mkmW7oq911MfSjjoNq5LJL+HsBA3CwQbgt3lcrhl7TD0O7UrNHdUrikTtuToxBXmS
         /MXekNpE4CC3ptAxVk7uuluDlYApi72CKiRpaMrlQbIBzwuSb3ixkY4m6vv8oysI6aD8
         tUkg==
X-Gm-Message-State: AOAM532p32K5KXDv+tgpwL7THE0HJPPhi/+iDPOBXFi2ZLYvqSrcYdR5
        puKagc/Fv1cNJifNN7xZia+rGwkOxv/rlg==
X-Google-Smtp-Source: ABdhPJx0p13K5ivKeqhtolNtmA45BpTLl2HxUeAz7YjjxLAdysLEeWOHrrpLsvONuKz9roAzbSRugw==
X-Received: by 2002:ac2:5c08:: with SMTP id r8mr1718922lfp.12.1610575707875;
        Wed, 13 Jan 2021 14:08:27 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v7sm335015lfg.9.2021.01.13.14.08.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 14:08:26 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id f17so4268546ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:08:26 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr1742942ljc.411.1610575705754;
 Wed, 13 Jan 2021 14:08:25 -0800 (PST)
MIME-Version: 1.0
References: <20210112224832.10980-1-will@kernel.org> <161055398865.21762.12236232732054213928.b4-ty@arm.com>
 <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
 <CAHk-=wiQ_tp8NmKV8PJ-6WMo3dTEZwDo3a0hYjcUFqMdviNTYw@mail.gmail.com> <20210113214436.GL1551@shell.armlinux.org.uk>
In-Reply-To: <20210113214436.GL1551@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jan 2021 14:08:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjqGRXUp6KOdx-eHYEotGvY=a5tSY1mF-BkAcX2YAuBYw@mail.gmail.com>
Message-ID: <CAHk-=wjqGRXUp6KOdx-eHYEotGvY=a5tSY1mF-BkAcX2YAuBYw@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 1:44 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> So, maybe the Sparc issue was just a similar but different bug in gcc
> 4.9.x.

Good catch. And I know this bug has happened independently on
different architectures several times (I remember this on x86-64 as
well), so I started looking around.

And in fact, 4.9 was buggy on x86-64 too:

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61904

And yeah, _that_ gcc bug wasn't actually x86-64 specific, but
apparently a generic instruction scheduling bug.

So it's an independent bug, but I do have to admit that the arguments
against 4.9 are piling up (even if that particular fix apparently got
fixed in the gcc branches and apparently backported to distro
compilers too).

         Linus
