Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1FA2CAAE4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgLASiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbgLASiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:38:18 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450CDC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:37:32 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id v8so1476124vso.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iu5TjqoWJ3gkf2PEgeff2P/qQp799lKBwlYclt90zJk=;
        b=V8+AXgDSV7jVjVpaX2qnvGEOdeN2OeMIByzsg71W1l+kfZ2s8ElljP46+U7t/DjViy
         t+Z4a9cYGCf6bjdjfe2MMpPUd41Pbl4H/I4wJtmwedgjDlyjt5P58x84d2jdBBzVxiFr
         LrPCRZFghGcHrp+YqJ51qYirfu861YIW/VAwWTtVc3yREEiRkGRr2MdWn1vi2IavHsgs
         S01Cyu5xEOAJKj8icno8bl0+BU88Z/EwMs5C5nrXPXPXcp1btoxCHQ1y+PUp2lBfRs1W
         mx/oE9VD5lpNemn0Udu6k0eh8RSpxc/ARbKeIEk8d9ZZNCrSQg9oUwbmhSF6QqYPT4MN
         oQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iu5TjqoWJ3gkf2PEgeff2P/qQp799lKBwlYclt90zJk=;
        b=AHq7tj8xchRjf2wQNJaRGW3Udlh/SPUVuvwWW8lLJDu63R8haa5zu0Wsm4bjhUD+GX
         IDomZ0LiSYI5D2VERLdR0+FCet/7GFfMidI2QT+RPf7D2O5x/u4c7KfyPzbgggBP31tL
         W2uzr4U02ukIWBUMiPHKFo1edy7dvNxWxS5fG6umZ9jEncdyAfUip5UkendeMvnQE36u
         eo1Y43zcSCM7Q3GqnPGWfEa840Mj4LDjdr3bhuduhxhHrw/pAaK8v2JyhpwIbsRyJ8iy
         SjxuZ3sW2mTbMw7H2E8zkNpbRG2UrBuwrK6AyIoSruGLhitA2e/3HCLuLuamanHSersw
         WwLQ==
X-Gm-Message-State: AOAM533/pFR0Z8uFIfY5H3TdVtBsWAt7LWAII08aPmSfELa7C3zqiIyd
        s6CYDvoq8QGmc+7SpJKB6Y7bLi/Oah/XB91IhQ4xVQ==
X-Google-Smtp-Source: ABdhPJw1XNEjRhPY9xb0UG8eM0AgCcoiLjP7Y098O/9nC0wSaX0ykGSeRPzCC+79+WD28pPylfxvWiaTdYGgaN/Hxbo=
X-Received: by 2002:a67:ec3:: with SMTP id 186mr4342764vso.14.1606847851269;
 Tue, 01 Dec 2020 10:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20201130233442.2562064-1-samitolvanen@google.com> <160681862873.1496993.150824561732453035.b4-ty@kernel.org>
In-Reply-To: <160681862873.1496993.150824561732453035.b4-ty@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 1 Dec 2020 10:37:19 -0800
Message-ID: <CABCJKue43YBrz7d3tYMiZxKJMPyyMku7TSUpcM2H+V6iTh+pfg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] scs: switch to vmapped shadow stacks
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 3:40 AM Will Deacon <will@kernel.org> wrote:
>
> On Mon, 30 Nov 2020 15:34:40 -0800, Sami Tolvanen wrote:
> > As discussed a few months ago [1][2], virtually mapped shadow call stacks
> > are better for safety and robustness. This series dusts off the VMAP
> > option from the original SCS patch series and switches the kernel to use
> > virtually mapped shadow stacks unconditionally when SCS is enabled.
> >
> >  [1] https://lore.kernel.org/lkml/20200515172355.GD23334@willie-the-truck/
> >  [2] https://lore.kernel.org/lkml/20200427220942.GB80713@google.com/
> >
> > [...]
>
> Applied to arm64 (for-next/scs), thanks!
>
> [1/2] scs: switch to vmapped shadow stacks
>       https://git.kernel.org/arm64/c/a2abe7cbd8fe
> [2/2] arm64: scs: use vmapped IRQ and SDEI shadow stacks
>       https://git.kernel.org/arm64/c/ac20ffbb0279
>
> I also threw a patch on top implementing the suggestion I made on v2, so
> please take a look if you get a chance.

Looks good to me, thanks for cleaning that up!

Sami
