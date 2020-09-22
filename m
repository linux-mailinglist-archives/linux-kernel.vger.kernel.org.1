Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7065C274875
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgIVSpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIVSpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:45:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5511AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:45:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b12so17126247edz.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8c6EeUGA2JVkso4IqlL2CrFeDrbUm7OKTRmu5kZhlsc=;
        b=Me7B1W3OkL9a9k06+kK2W63aYlIIuMxl0iqyNohzY/tocACgvnxvoGcmA7rdU+MLsn
         3xhq1hxlqnEu4Dpfr3BWE3xpj+R6ROCobHWOkYNTd35ydhNUmXp04rfxPPRoMhP0yo6H
         auwc+dejMt8j1SaxmdEKtJE+1qHcbrMHYwb46BcrcrcPn7yewEksNXfqmtDXwley9j0/
         TKzWYNoh2hmViMi7uIxY381wpO8dQqxaR+sHjZdzuqquuQ5f87XMFgfA780T8OYW0zHF
         V50sLMyM3Heau2h5NGeseGV0FgUJgt7yoOI22FZEw4hBZPAzJ7+wMrzF9E7ey3Ajk9ly
         /yqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8c6EeUGA2JVkso4IqlL2CrFeDrbUm7OKTRmu5kZhlsc=;
        b=Kz9GRff4p52GHFTr/tXnwhcJhNg4V+l7iyNkmNhsVcaYXve7o0WQrBLjUquDu/2Jt1
         Koluln7QzLjmfbRYJ+2JQvbUMP0cWByJeI3KldZYY3s5Y9Mk9u9Br0rpqFnJLvlkMVnM
         igK64S3uZrqkhMzxcapxGD6/JpEs6YCJAioXKZ4/BGkLDDZVJR2oRZcgbomi21311M7s
         HKaWY+0hos3IYawXKY3tNJQYY28q+r7FaY0bDGuN6CHqztTpCDEOwHDpmNFsX8F38z5P
         +DydOp/HmZKCMrgMuUoWgJCYHKVbFZInoBb74FQt1eFHmFbAw0IlygBfJW3YcCXaLp1w
         1NUw==
X-Gm-Message-State: AOAM530HWBU0HKpWwqTirFWD1JEmyCjoU7b31KZVz82hc+bHfTyY4p7H
        ZH5PdxX4Li30XqbE527IuAh9ZMSCMo5EmiEN+8HJOciRa1NKmydE
X-Google-Smtp-Source: ABdhPJyk0BVSyYJapMFDle5dL3DsWiDP4I50lIkjosb7nliMNfC8qnZXKpMm63k6rUZV9l4bxYcH5qlxFFTELjF5qKE=
X-Received: by 2002:aa7:c0d3:: with SMTP id j19mr5606292edp.40.1600800329142;
 Tue, 22 Sep 2020 11:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <87pn6eb5tv.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87pn6eb5tv.fsf@nanos.tec.linutronix.de>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 22 Sep 2020 11:45:18 -0700
Message-ID: <CABCJKufWOkWqhsUNwuNPkYRAZaAnaBH8XWdcRBO29C23QzdyHw@mail.gmail.com>
Subject: Re: x86/irq: Make run_on_irqstack_cond() typesafe
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Sep 22, 2020 at 12:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Sami reported that run_on_irqstack_cond() requires the caller to cast
> functions to mismatching types, which trips indirect call Control-Flow
> Integrity (CFI) in Clang.
>
> Instead of disabling CFI on that function, provide proper helpers for
> the three call variants. The actual ASM code stays the same as that is
> out of reach.
>
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Fixes: 931b94145981 ("x86/entry: Provide helpers for executing on the irqstack")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Thank you for the patch! I confirmed that this fixes the type mismatch
issue with CFI for me:

Tested-by: Sami Tolvanen <samitolvanen@google.com>

Also, please note that this was first reported by Nathan in this GitHub issue:
https://github.com/ClangBuiltLinux/linux/issues/1052

Sami
