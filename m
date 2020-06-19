Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F7E2019E7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 20:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733211AbgFSSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 14:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgFSSB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:01:57 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2CCA20DD4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592589717;
        bh=UyTCtBCD12S8qQ31WKdq7c0c6851T2vdAXGJawSvP40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vH/MSGLRjam8b+6OoJb4UcWnI/fYy8uI3+74KWYhhp6NndblhyjUvsA9+u9PZTD6k
         eED9/j6PeBgYOpIeahD8nMKgLvZ3iNA1CDb86vscZ/NR82/JH+kIt1blwXX7PksDW8
         CcokqrfBJNODN5IjxB3lrDCjId5FbkO2UfCmviHw=
Received: by mail-wm1-f51.google.com with SMTP id r15so9876134wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:01:56 -0700 (PDT)
X-Gm-Message-State: AOAM532gUmbleRbvDKKrVHjJRi6/1ZnmI4NY8wddOAcCefS/jrGW0Gyb
        HmFg8nXemRQybjp+TcuuX1qFxM9HDpePmu3CLaKj1Q==
X-Google-Smtp-Source: ABdhPJy6kMk3kS6ULESrgKKYgL58AqmTZg+UEozUHWLeYJikzK9mzj+KP7nb36fISJIgJSd7LttQ6jVNYz4fN9w+glQ=
X-Received: by 2002:a1c:a304:: with SMTP id m4mr5184678wme.49.1592589715431;
 Fri, 19 Jun 2020 11:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200619174127.22304-1-bp@alien8.de> <20200619174127.22304-2-bp@alien8.de>
In-Reply-To: <20200619174127.22304-2-bp@alien8.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 19 Jun 2020 11:01:44 -0700
X-Gmail-Original-Message-ID: <CALCETrXZhFJGJA2h4zP743KYTtni-rQSUME8mtSYUdk1-ZTauQ@mail.gmail.com>
Message-ID: <CALCETrXZhFJGJA2h4zP743KYTtni-rQSUME8mtSYUdk1-ZTauQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, jpa@kernelbug.mail.kapsi.fi,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 10:41 AM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Petteri Aimonen <jpa@git.mail.kapsi.fi>
>
> Previously, kernel floating point code would run with the MXCSR control
> register value last set by userland code by the thread that was active
> on the CPU core just before kernel call. This could affect calculation
> results if rounding mode was changed, or a crash if a FPU/SIMD exception
> was unmasked.
>
> Restore MXCSR to the kernel's default value.
>
>  [ bp: Carve out from a bigger patch by Petteri, add feature check, add
>    FNINIT call too (amluto). ]

Acked-by: Andy Lutomirski <luto@kernel.org>

but:

shouldn't kernel_fpu_begin() end with a barrier()?
