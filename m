Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198B92F69CF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbhANSoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbhANSoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:44:08 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062B4C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:43:28 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u21so7653408lja.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSikxUCCmMuKlcIVNKMSQLXHoh+mKFmmNfXZP34ywo0=;
        b=P9qp87pav/O9NmAX8hvOtK6ylaKismTYgOWaQMdNoCTKbWdOpzqtQ5sUhYdXNSwHdI
         k+genNv1iPZxLYBL19FxOCzz9z5Kv0lkZh5yI4p1DIU70/NnoC5nstKgXQ2+Lqi43IdL
         qGQKNMfNYkFJ9OC3FsVPcemTj4NjdInXnw4hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSikxUCCmMuKlcIVNKMSQLXHoh+mKFmmNfXZP34ywo0=;
        b=AcY70t7z131MkPNRDPs/XYHyyYY7pFz/+UCZk3QFr3ZzxZI9i8V6Qu4MEU6xJCZkHj
         /f3nun8vhh5RJ03KdKt0uiOHivYITgKWOXlWVgCzSGjnuT+cHNm5j9nd+OoTu1dG5jpl
         Cgw7jbbWXH9AjHjDewE83qvcpmPOA74BYcem11jEU6wSqgYSc0C+jYgcos7cZt3hA2NY
         KZneDgRchqrH6dFYCRqirHAOoS0vdbJ8cLWZkOuC+QEdphM8J5v2cFG7jdZQRTViACrE
         H2X6U/Pre+DzoXHnATTUjHdR3mg75moaROIahqiiU4BdhJ4Fqxa4SXHKORiBaR/Y4scc
         sizQ==
X-Gm-Message-State: AOAM5328uD24B252plHBYXTOSKsf3OVLpZbD9rY867MoBo9oV1m41jHT
        Yv8WV+EEv3UGpElyQXThtWv/7KHjlMrQwg==
X-Google-Smtp-Source: ABdhPJzmnDJaqZ/JTcOPYkpdoIRqSl5GxwdCEGisl98Xs5vxj5uIkSRk9nr32hFYToVMh21ITU7YcA==
X-Received: by 2002:a2e:8714:: with SMTP id m20mr3519792lji.320.1610649805888;
        Thu, 14 Jan 2021 10:43:25 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id j5sm621560lfu.139.2021.01.14.10.43.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 10:43:24 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id n11so7637063lji.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:43:24 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr3568946lji.48.1610649803879;
 Thu, 14 Jan 2021 10:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20210112224832.10980-1-will@kernel.org> <161055398865.21762.12236232732054213928.b4-ty@arm.com>
 <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
 <CAHk-=wiQ_tp8NmKV8PJ-6WMo3dTEZwDo3a0hYjcUFqMdviNTYw@mail.gmail.com>
 <20210113214436.GL1551@shell.armlinux.org.uk> <CAHk-=wjqGRXUp6KOdx-eHYEotGvY=a5tSY1mF-BkAcX2YAuBYw@mail.gmail.com>
 <CAMj1kXFaDNRbDvr43VLEHFRHHS0sGGcF=iTfES4sxPg-rZ34NA@mail.gmail.com>
In-Reply-To: <CAMj1kXFaDNRbDvr43VLEHFRHHS0sGGcF=iTfES4sxPg-rZ34NA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jan 2021 10:43:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjHTpG+gMx9vqrZgo8Uw0NqA2kNjS87o63Zv3=WG2K3zA@mail.gmail.com>
Message-ID: <CAHk-=wjHTpG+gMx9vqrZgo8Uw0NqA2kNjS87o63Zv3=WG2K3zA@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 12:18 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> So if the arguments are piling up, what is holding us back, other than
> inertia?

I think we can most certainly just try increasing the minimum version
to 5.1 in the next merge window and see.

> Note that banning 4.9 for arm64 and banning it in general should be
> two different changes in any case, as the former will need to be
> backported to -stable kernels as well.

Yes. The arm64 issue is a clear and known bug, plus I suspect gcc-4.9
is ridiculously old in the arm64 ecosystem anyway.

So the arm64 issue is a bug-fix, the follow-up of just upgrading gcc
requirements in general would be a "keep up with the times, and allow
those variable declarations in loops".

            Linus
