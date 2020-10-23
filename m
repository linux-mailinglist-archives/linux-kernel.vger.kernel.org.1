Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86624297883
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 22:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755397AbgJWUzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 16:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755381AbgJWUzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:55:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F082C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 13:55:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c21so2981126ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAaxNcyAfDpJMNO6n11/nDG/bhYOtwnmWgK2bjUdkP0=;
        b=UAPMALOXf/byWclH19PJoWgK1gdA1jAiJsVhgESW90ZBHaYiffcgByVwzyFLeCCtZh
         7qBwYyud/jUnHqBh/xIBHqRLUxPrfYvVImuOhmuWIdcLnQi+cNyO9x0YZsAToskZbK6+
         T8nEMLlm+nj/zScwFb8eWZ1DwWTJHGB2qzs3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAaxNcyAfDpJMNO6n11/nDG/bhYOtwnmWgK2bjUdkP0=;
        b=IWxPKq93epg4wPnOU+hZbYbVsasI6rmHFTY01N8oxteUl8HpO6qi4QRumArgniBlZR
         deWoeNttwBNJisY9YCr4ALmsF3Sll+7IoEUNUBnzENm1mbIV4mRMmS7DpZ7L4rGPrhfH
         FKilRBBY57PA9SZ+RbjHrDdtHR2OzWIoMAshc9ItHJelq+pmyocdBfxFaOVtfhYUDpi7
         8c0/0YnD+QbiAMF6r2/fT8HXOD4HSCpHuS5hwNFB5Eg5+fS2oWZLvrNzHHnzQYGVRudL
         wnrKYkHUWmdijIqJXJ/Tgdl0lQocyRTW6mMz5EcZ3CeU7MZckCoAOXwT5MQAr+1WAQGD
         YrOw==
X-Gm-Message-State: AOAM533XJ09vF4PIUwgmLYblrR8mrFHyQ4Jh3yuo3xHxBauo1XP7qK75
        LgJZesV2gWSdOj015BMztEVb5cUHSpOmaA==
X-Google-Smtp-Source: ABdhPJy5mjz4HaqMMAIOowKHdyiBhKdlsa/O+erDOY4XkNnpj09Hymwh5dtD0Nf/1oqWDLt2lLTspg==
X-Received: by 2002:a2e:8108:: with SMTP id d8mr1631752ljg.96.1603486539983;
        Fri, 23 Oct 2020 13:55:39 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id z14sm276421lji.84.2020.10.23.13.55.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 13:55:38 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id j30so3679525lfp.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 13:55:38 -0700 (PDT)
X-Received: by 2002:a19:c703:: with SMTP id x3mr1243212lff.105.1603486538242;
 Fri, 23 Oct 2020 13:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201023203154.27335-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20201023203154.27335-1-linux@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Oct 2020 13:55:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1m3cvS-3dOYzNavYWLFu=9fwo0-6HTHJhG-X5B73gZg@mail.gmail.com>
Message-ID: <CAHk-=wj1m3cvS-3dOYzNavYWLFu=9fwo0-6HTHJhG-X5B73gZg@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: fix code generation in put_user()
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied.

On Fri, Oct 23, 2020 at 1:32 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> I'm wondering if one would also need to make __ptr_pu and __ret_pu
> explicitly "%"_ASM_CX".

No, the "c"/"0" thing is much better, and makes it properly atomic wrt
the actual asm.

As mentioned to Andy, the "register asm()" thing is not uncommon and
often useful, but when you can specify the register directly in asm,
that's certainly simpler and more straightforward and preferred.

              Linus
