Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B495F2B565C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 02:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgKQBmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 20:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgKQBmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 20:42:10 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E68C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 17:42:10 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id v12so15907947pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 17:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3Yj6MxC5crUK7IuES9DqL9WoDqZYYvodYdqIPte+C0=;
        b=XZGU9wBkaMlMXvLU1MUoF7I1s4G2CQxhNwgG7VdLHlH4m7vZboHFrmZeVgwGPNUCSi
         bap6mH6ogJ/m8tlDUZbm0PSwUSkFcS8j8wfglOvae2DotC+LT8Bp7mx4S5wiVopmN5jZ
         SRs7Hf8X/Y0dAVfVkeaHF/FZioUMpBBZHRPoV5Q8N1lnN4J7swehJq+k1RIupqO56yx7
         pzpbJI3v9q8IN6rRvsWTTpFcv7wnrpsmJPTFNnPuouGSquf882aTmYuAO6nnQk7wnEUF
         2go/unpaJDnT1xibRqEQqfmWcpfclJPOPgoA7oSIFiTVDdr5rFI3d7Q3jE51j9xbLcU7
         HTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3Yj6MxC5crUK7IuES9DqL9WoDqZYYvodYdqIPte+C0=;
        b=RGTgmFBcnYaFwTcUPFt8YZPQCbVHLFhya7hzcid8MW5xFgZFoUWlG8gNOXK8japyEU
         nxqvNNYu9d3dFcpIfr9ubYYkSddiYLK3xS0kROxusiUzF0nhoqdC4e+sjnH1z3gH1jFR
         oM4LLbi3gsyYTXDhfXzM1dUCTN4PvWts/wE6v2PPnm416T21gRfT3Brq6KSIPCOSn1XV
         +GMRmwgYQy30QeKC/Y7Wu6kT/zimwSJYBhALl5lHajvu+0LeHGRj7/2v007wdYq62XiN
         pavNkMshGkHPy/4zO2OFVh5MjW09ZXV2zgNp70OJRxa5aDWBQi41FCF4j9vBRL3G20JZ
         +7vg==
X-Gm-Message-State: AOAM530diyeumNZ7Qm/cD2arvFO/zS4vp+NRVIMDz5XJ2Nh2K8/VbXgR
        47SkzC3+1uWg4xfDRjcRS9wkbWQCSpjsFBfOgL2w6g==
X-Google-Smtp-Source: ABdhPJwNHpOk0+HRm1uU6Mqd2ce6rC9mlHOhKfPpWrAuZPmqw8IqSxCNfIY/p1NZ/9P4yrKoL2Yb00iZN311n6OaSzM=
X-Received: by 2002:a17:90a:6b04:: with SMTP id v4mr1945507pjj.101.1605577329449;
 Mon, 16 Nov 2020 17:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20201113195553.1487659-1-natechancellor@gmail.com>
In-Reply-To: <20201113195553.1487659-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Nov 2020 17:41:58 -0800
Message-ID: <CAKwvOdnf5WKJrLnwM9dDDniP0eG5gnFSMB0rapqWLUAZbVJZvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: Hoist '--orphan-handling' into Kconfig
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:56 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Currently, '--orphan-handling=warn' is spread out across four different
> architectures in their respective Makefiles, which makes it a little
> unruly to deal with in case it needs to be disabled for a specific
> linker version (in this case, ld.lld 10.0.1).

Hi Nathan,
This patch fails to apply for me via b4 on next-20201116 due to a
conflict in arch/Kconfig:1028. Would you mind sending a rebased V2?
-- 
Thanks,
~Nick Desaulniers
