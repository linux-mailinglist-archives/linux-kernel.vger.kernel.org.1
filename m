Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ABD2D07C7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 23:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgLFW4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 17:56:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbgLFW4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 17:56:53 -0500
X-Gm-Message-State: AOAM530dzde3Sfpqr3XKXOoHEum8msrgeyHJ++bHwzx/X4mBWT7kf2iZ
        ROBKTs76QQIbJuTxz0q29rnTDDPqbS11zIrNskJvmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607295373;
        bh=Lf3R0IwNblcISQlng1SODYvWkpnfT30/KaKWaMY2KcE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HdpRFQ7W9dR9g2ZH8Ym48AuuC3T08TAFeVDBvNUEAobAAnZo9QaEmo+s+rFMUrvE5
         8aWopol8805CwlflScO1/wKth+efYA5snCtqYMHJ+XWajzgqanoBayD8e3fYpfNXup
         54N6MwAJMRn4y+lIm0z7fne781AqCK7khQShmzpF/ivoJDbA3V2fNVUXegvRz2odY/
         m7FD9+R0kkhKzNwbEs+NzlFqLZ1TNpnlOHyXhLVBcKwkjfMPX2bz0FIl+tjBSHru6e
         bOKNFcG9xnd5yI7geRhYRkFQato3bMvMncfW+KveNvvFfHx+93ECn+bUCVzGLurGXJ
         TKuNJd2rdcomQ==
X-Google-Smtp-Source: ABdhPJyH7qnxaly/DNwvxKw4EkgZNSsOGmfeTFTWMM7SEGf44GXtkVBy7W0LHnUIMDQ7A+Ok+f/Z4hEJ3b+fkDdpzFU=
X-Received: by 2002:a1c:1d85:: with SMTP id d127mr15875230wmd.49.1607295371740;
 Sun, 06 Dec 2020 14:56:11 -0800 (PST)
MIME-Version: 1.0
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
 <20201012134444.1905-1-jrtc27@jrtc27.com> <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
 <20201101012202.GM534@brightrain.aerifal.cx> <7842A462-0ADB-4EE3-B4CB-AE6DCD70CE1C@jrtc27.com>
 <20201101015013.GN534@brightrain.aerifal.cx> <CALCETrUuBR3Pt_9NhRZTLzjZzwdsS2OPW4U2r31_1Uq-=poRDw@mail.gmail.com>
 <04832096-ED7F-4754-993D-F578D4A90843@jrtc27.com> <EEC90B2F-E972-475F-B058-918CDE401618@jrtc27.com>
 <20201101210102.GO534@brightrain.aerifal.cx> <29423184-A433-42D4-B635-CDEFE7271B40@jrtc27.com>
 <2AC632C0-EC00-4C4E-92DC-B7F238897C4C@jrtc27.com>
In-Reply-To: <2AC632C0-EC00-4C4E-92DC-B7F238897C4C@jrtc27.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 6 Dec 2020 14:55:59 -0800
X-Gmail-Original-Message-ID: <CALCETrWWcVhYoVuvovo558sXpA7X75jNpf8LA+w+k-dzyRiUcg@mail.gmail.com>
Message-ID: <CALCETrWWcVhYoVuvovo558sXpA7X75jNpf8LA+w+k-dzyRiUcg@mail.gmail.com>
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Rich Felker <dalias@libc.org>, Andy Lutomirski <luto@kernel.org>,
        linux-x86_64@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 5, 2020 at 4:01 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>

> Ping?

Can you submit patches implementing my proposal?  One is your existing
patch plus fixing struct msghdr, with Cc: stable@vger.kernel.org at
the bottom.  The second is a removal of struct msghdr from uapi,
moving it into include/inux (no uapi) if needed.  The second should
not cc stable.


--Andy
