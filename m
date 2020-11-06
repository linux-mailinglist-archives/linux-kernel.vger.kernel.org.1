Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C77B2A9F52
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgKFVqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:46:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgKFVqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:46:34 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF5CB20B80
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 21:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604699194;
        bh=cmbdh835euZ6MRyro/bOjB0JXaz65jG0LjMvDhVrKXI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=czGPx0mxCv66Vk0mluCPyUVSgbQw0KVL/HK0cHVJv1gazuSFxha/k/vtWnDN8TlT7
         ylUiMRgffxz0CBpfNqKB3lxeXMJKKx3cLYvejXPO6yYjWLkHuaIVGOciSDxL1ulkqz
         CILz1ORkreaxAc4t+JzI8CvtkfW1fZgggSNzYyto=
Received: by mail-wm1-f54.google.com with SMTP id 10so2067869wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:46:33 -0800 (PST)
X-Gm-Message-State: AOAM532u2Qt3vBLI69BsW+AuKzUuRnsVB27ZoG1L6Qv41r5yf8fG1Nmd
        5zIjW35i6BnKqq5Suent4+SsyPV7qxTMpeqqTDE=
X-Google-Smtp-Source: ABdhPJynVaC6cBqh5XR22/UECXo8r0cdOZOWm2K+Fw/ZB4dfigsR+Kl+yFSAM8IO6hXVMExR68nkofYg73A7Oq4QCPo=
X-Received: by 2002:a1c:b746:: with SMTP id h67mr1556341wmf.43.1604699192298;
 Fri, 06 Nov 2020 13:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-2-adrian.ratiu@collabora.com> <CAK8P3a0kXkoeAbNiPH5-7-73V2nAsnCMkQSrPZq4ysVYNyE-WQ@mail.gmail.com>
 <20201106180311.GC2959494@ubuntu-m3-large-x86>
In-Reply-To: <20201106180311.GC2959494@ubuntu-m3-large-x86>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 6 Nov 2020 22:46:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0FkF2y+N8rvoO0GbeCukzYX09q_PesUKqhJ=qczZs1gg@mail.gmail.com>
Message-ID: <CAK8P3a0FkF2y+N8rvoO0GbeCukzYX09q_PesUKqhJ=qczZs1gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 7:03 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Fri, Nov 06, 2020 at 03:46:36PM +0100, Arnd Bergmann wrote:
> >
> > If it is intentional that we now silently build this code with clang
> > without it working as intended, that should be mentioned in the
> > changelog.
>
> Maybe patch 2/2 should come before this one? With that patch, we are not
> even going to build this code so this patch purely becomes a "we do not
> support this GCC version anymore" cleanup patch.

No, I just need to read properly, I somehow missed the fact that there was
a second patch in the series.

      Arnd
