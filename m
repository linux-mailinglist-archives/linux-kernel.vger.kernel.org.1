Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C0E2E0F62
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 21:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgLVUa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 15:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgLVUa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 15:30:28 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FFDC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 12:29:48 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v3so7984249plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 12:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1uYO5gb8l22kkJBNYBKF4BpoBbkwVbyfFkGg5GIkRf8=;
        b=tNmThOcEL3wKkZ/mser/opC9H2K0uIdWblQmaWHo8rNKGuNVPu8tXaPsuRFzmdKCrF
         a+izjHmcd+U1nb/pimozzgs5HERTz7g6Wr/7SUbQeJyOkXfuSOb4sDDSbfQ9UcjoOqN0
         7R+ohRlSK+d313ZwjIOUC2VIW8TPuzP2T57c3WSSs0VfoiZ6/U9dHiB5ok9SwAFQDsnM
         lJ31iul44tafXtXpPAZ8Hwo81i7r5EclBr4kOnRfCLeDQToIdU6uRFvLT5K+Rs6f6MC2
         WIalUN5TLkuC+QGy998xOucT0sMwnTYOyyU1Y2lxVHZRlIWP5dzO5Z8xfL+TaLZ3O+YG
         fDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1uYO5gb8l22kkJBNYBKF4BpoBbkwVbyfFkGg5GIkRf8=;
        b=ZgDZpAsNJXhmv4neP2aemnMkpEsnMVi1YXjpmvFVw/4qXbsKjRFnxHPdMUTRDhIfRH
         MihFBjfiggz3TI+9bDa6lmNl5HcLph6Qf8eeeNegt3CplMNd7wkYChdyl9T8bLFdtym6
         yKtmiFIKHCo90GQNStbZQIY6Pa1uYU5EfDNZQxGrgpnR9HdDeVydhpS8U3pt7Lfea0VN
         6v1Qecs8mzwcZ19wZkGKJdtMOMCigeSu3yzxIeYAXN2XGEycpjdvpEclgD54lbmNi4Z3
         V3Ync6UqqX0cHraUth5U2CoSH5GtQMn4tv69kzlm/pWXGU38AVqMLjKcXAd3j8VJC9ZD
         dWzg==
X-Gm-Message-State: AOAM5300OB6oBcwhPfguERj/NhxaSi2OoCAevRznu7sIb51lZmv83gP8
        3O7ClEGlR4+UzTGHf30rJ03embQe0cqezeiHNTFx2w==
X-Google-Smtp-Source: ABdhPJz9swd7VzUDCz8TW/NXCMcoXhe/xUMJYDX4nWy7LSE9Qfj3Td/x1Z2lL6L9RlJEcG+cRmpmGWG0OutDg8kxofo=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr22812796plc.10.1608668988122; Tue, 22
 Dec 2020 12:29:48 -0800 (PST)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 22 Dec 2020 12:29:37 -0800
Message-ID: <CAKwvOdmnhsPU0UA9uEd1HTQ_yoBO8h741+sKrtebcPsXpXn8_g@mail.gmail.com>
Subject: building csky with CC=clang
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-csky@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
I was playing with some of LLVM's experimental backends (m68k) and saw
there was a CSKY backend. I rebuilt LLVM to support CSKY, but I ran
into trouble building the kernel before even getting to the compiler
invocation:

$ ARCH=csky CROSS_COMPILE=csky-linux-gnu- make CC=clang -j71 defconfig
...
scripts/Kconfig.include:40: linker 'csky-linux-gnu-ld' not found

My distro doesn't package binutils-csky-linux-gnu, is there
documentation on how to build the kernel targeting CSKY, starting with
building GNU binutils configured with CSKY emulation?
-- 
Thanks,
~Nick Desaulniers
