Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4292EB36E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbhAETU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbhAETU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:20:56 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460A0C06179A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 11:20:15 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b5so224655pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S8zBcNrIkM7fcucNIrcdourXpW+BamaiYpRPGV5/7NI=;
        b=TLy+Uq5R/rJyWyfeD2vmOL0hODjlL0SI1BoZqNDugBlBBpGL38uGAvxQnNOyqrKKm5
         JLSuFJ/RIAzgCKB1JViP8BZb8XNbvS3lr3CXLyeb/HZQA0MKBxqozRGqN/8lLj6IDwQC
         kEX81BNtwA82lkhRpWPfg95P9uQqRCLuWEu6Ca+5rVmdL4sPpoN15Kcio2FWVk7jZltI
         4OYiYicXihCCFzbFXm92XNWyyiWp2clhZ7N6e0FXMSPe3OvkEOUJuTLo6w4AGJ3YDXIb
         JtfDbV3kC5U6hzdBfPBpJWZdtFZlIe/QiVmCSE/r36YOoLfvNnqQ4Gh+7FxbaI2eCTkd
         WYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8zBcNrIkM7fcucNIrcdourXpW+BamaiYpRPGV5/7NI=;
        b=bbby/SvxJDRchpzKpe5Oa5435wHOGsw7TH4ddt1ED0u3PbmG8jNvyjo/L9dqQP96B+
         iZWOL543MswwNLl17ZM1u2JwIqaerjhp1QVSe2MRWR0EAzsnUhY1Qh1Zm2H+xnXxoQI8
         CLLlT0mB6PHZvWIIn5gIVQEAlAmYPHyMMHpneQIvRJ/l1Iw1oheTq3oOH3CKKNQ2uD/t
         9XbLH59kUwkmL1JupjcN4smBA6xsRIDaiq4buIJu+4sq7uSGrUbjYNY+qt0+wxZrYHhn
         imt2CIcveVKGAs+qN55ckNtbQWUDT0cf5vzIpVA6shbAx9NwTkzdeoKRb7smorKC5Jo+
         KVaA==
X-Gm-Message-State: AOAM532Wx8cVxtnZkp533drR8QaCndx23A+3q6Yip9apbAEDPZ8YgkvD
        r2e9KjayY5GK5Wz++Nrxo5A/o2ToieWBD3hZBLJKoA==
X-Google-Smtp-Source: ABdhPJw1oF2cV6GahoVb9zhDkserKEP/ttFvqbslTUJNlulfyvHB2ZYENvF+O4ynZUgHQChVl43vI1jidcg3sxen1SE=
X-Received: by 2002:a17:902:8541:b029:da:fcd1:7bf with SMTP id
 d1-20020a1709028541b02900dafcd107bfmr678193plo.56.1609874414643; Tue, 05 Jan
 2021 11:20:14 -0800 (PST)
MIME-Version: 1.0
References: <20201203202737.7c4wrifqafszyd5y@google.com> <20201208054646.2913063-1-maskray@google.com>
 <CAD=FV=WWSniXCaC+vAKRa1fCZB4_dbaejwq+NCF56aZFYE-Xsg@mail.gmail.com>
In-Reply-To: <CAD=FV=WWSniXCaC+vAKRa1fCZB4_dbaejwq+NCF56aZFYE-Xsg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Jan 2021 11:20:07 -0800
Message-ID: <CAKwvOdkFpqEDvJ5b9wpwEhnOdh-YJ8GxCc33JcHXqNRDnO=RfQ@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: Align .builtin_fw to 8
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Fangrui Song <maskray@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 9:45 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Dec 7, 2020 at 9:49 PM Fangrui Song <maskray@google.com> wrote:
> >
> > arm64 references the start address of .builtin_fw (__start_builtin_fw)
> > with a pair of R_AARCH64_ADR_PREL_PG_HI21/R_AARCH64_LDST64_ABS_LO12_NC
> > relocations. The compiler is allowed to emit the
> > R_AARCH64_LDST64_ABS_LO12_NC relocation because struct builtin_fw in
> > include/linux/firmware.h is 8-byte aligned.
> >
> > The R_AARCH64_LDST64_ABS_LO12_NC relocation requires the address to be a
> > multiple of 8, which may not be the case if .builtin_fw is empty.
> > Unconditionally align .builtin_fw to fix the linker error. 32-bit
> > architectures could use ALIGN(4) but that would add unnecessary
> > complexity, so just use ALIGN(8).
> >
> > Fixes: 5658c76 ("firmware: allow firmware files to be built into kernel image")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1204
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > ---
> > Change in v2:
> > * Use output section alignment instead of inappropriate ALIGN_FUNCTION()
> > ---
> >  include/asm-generic/vmlinux.lds.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Tested-by: Douglas Anderson <dianders@chromium.org>
>
> For whatever reason this is hitting developers on Chrome OS a whole
> lot suddenly.  Any chance it could be landed?  Which tree should it go
> through?

Andrew,
Would you mind picking up this patch for us, please?
https://lore.kernel.org/lkml/20201208054646.2913063-1-maskray@google.com/

-- 
Thanks,
~Nick Desaulniers
