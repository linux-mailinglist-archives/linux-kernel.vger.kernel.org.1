Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5282ADF4C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbgKJT0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKJT0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:26:44 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7C6C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:26:44 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f27so7707875pgl.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBBuJtpHwASeAFOGSL1xcof2983thgwJRPuFxxMD4fA=;
        b=DUzhdqYm3KhlGOfDDfdWNAq31h0cV3GKAi2xP1cxlXyasR45DGVVyNY2ikd+sFOnCC
         UcEgk8PNi1GfqnrvPyftyBhyoH7fLVePjOhpZYvTwcLJe3JL/E7cTGQ3g5Co86AC9THK
         ZkK2t2FpZu06cOSY4mos4n//bjGjcZgA+g4NYcgmyfjFBNc2KuU6KyoRJR7wkssKFIs/
         boHgRBDBOgK7E8ypVPTdtEO1pXmN9XdlPc60xonKmfSZv1AQuPla8R4Vj+iPFOtpFHJw
         GYzX12WEReynbv168ZYu9knYhNEI/iZxZdm07x6I2Kmi3QjAX9mYOGgHC7iI+P/dZtCS
         nfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBBuJtpHwASeAFOGSL1xcof2983thgwJRPuFxxMD4fA=;
        b=VthemGAphPUgF6e66GtRyfq+D822zN3dBBF0qQHyccCYASiUpDvyhVbMsUUN5OFmHc
         lHOpifvDSH7KHoxIxrKWFxInWncmAS5XmiakzT6SZBi/5VBoh/ZBbx4I5NOdwtLgbub/
         NMnE96mbEkjTW/Yo/W+odcA9/JgLLOcu5XNBcUxmS02W8PUNrAv7Iw1pRxahN9fUkjUa
         UsCYurqiJZ4c68visZRrj3bjsySZ4Eg3DAmYIOb9gUWkc7MX44SuyRo0EiqgAgCA6VtM
         5VJtW6+sXCW6emddHW6Zn/1oEd/fjK/1Zi0twMD+sW/VW78gr1ua9a0xH1TznIH/b+F/
         nxhg==
X-Gm-Message-State: AOAM5319oRoRym6fQvWcXZYIBz1xUjhsEcsQ2vtbTD2a2JHvzamC+YK6
        V3a7j/C2VSaSZG/aYJDqNIW8/xeIqfO3BTzS5q6NIQ==
X-Google-Smtp-Source: ABdhPJznziVNXzwfwGEBwZjvtT8HADT4wcyMRySH+iyCi/S0L0hHj+O/J1edGm1ynfYqDAW21FR1vZnOsQ+O2bHEWIY=
X-Received: by 2002:a17:90a:6b04:: with SMTP id v4mr671795pjj.101.1605036404049;
 Tue, 10 Nov 2020 11:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <20201107001056.225807-1-jiancai@google.com>
 <CAMj1kXG+qb267Hig6zoO=y6_BVsKsqHikvbJ83YsBD8SBaZ1xw@mail.gmail.com>
 <CAKwvOd=pHgT3LsjYH10eXQjLPtiOKDj-8nJwjQ=NMSFLTG1xAg@mail.gmail.com> <CAMj1kXHDzj3Q-sCv1szseUC7g2bWRFeVP6WME-sMqDf+0wyU8Q@mail.gmail.com>
In-Reply-To: <CAMj1kXHDzj3Q-sCv1szseUC7g2bWRFeVP6WME-sMqDf+0wyU8Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 10 Nov 2020 11:26:32 -0800
Message-ID: <CAKwvOdkXz5wOwKQDsi5jt21ov3xETSByAqxGLQ=7U6Gsp46zcQ@mail.gmail.com>
Subject: Re: [PATCH v2] Make iwmmxt.S support Clang's integrated assembler
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jian Cai <jiancai@google.com>, Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 11:36 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> BE32 != BE8

Oh? Sorry, what does BE8 stand for?  arch/arm/mm/Kconfig says:

CONFIG_CPU_ENDIAN_BE8
Support for the BE-8 (big-endian) mode on ARMv6 and ARMv7 processors.

vs:
CPU_ENDIAN_BE32
Support for the BE-32 (big-endian) mode on pre-ARMv6 processors.

So BE8 seems newer?  It looks like in my tests, enabling
CPU_BIG_ENDIAN via menuconfig enabled CPU_ENDIAN_BE8.

>
> Please use, e.g., ixp4xx_defconfig with IWMMXT and BE enabled. It
> seems like .inst does the right thing here, i.e., the assembler knows
> that it should emit BE for BE32 and LE for BE8, but it needs to be
> confirmed.

Ah and ixp4xx_defconfig selects CPU_ENDIAN_BE32.  Yep, and the
disassemblies of those match, too.
-- 
Thanks,
~Nick Desaulniers
