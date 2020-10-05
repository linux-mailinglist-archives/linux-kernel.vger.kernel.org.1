Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45BE283DEB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgJER6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgJER6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:58:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D96C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 10:58:47 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 77so11986445lfj.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQapKerqEPOfWjuVkuWjhpBPHOAY0WMdQww5oZQ+egs=;
        b=OXKb2fbfDYHdc1AbGUIMBgMPVh7d7kxEbrnogtA7tkBCFR9wFHBTnbowM3BhSEljnh
         UEswPIgw4X463SChT4PQxD9A/LlhUfYNQWfSbDf+C8TBTKfDBnzK13OEqez3jPckrVjv
         qUxSB2BhkFOZGyy2nFmMHm6nnRfP1HV8q//vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQapKerqEPOfWjuVkuWjhpBPHOAY0WMdQww5oZQ+egs=;
        b=nuYMzq9Z7mPdzUrwcC3aUtplF1ah4mohHdtRnFVYWPs2OlJOJdica6z7Uhsvt65SHv
         UojetVV/QCPicZZwZ1PIVf8OIjUZh/eP5EaFt6WqsBGt/SGZpWjfFGaET+lrrOBodtGX
         GIDjpYPTkjsT4NxHtgeI1wtZ2Fwxe4hTkGKCbfAol7KRTVqcEg62Mv172p2ovgxS/tve
         R0RpE0j+PNNzlitFSxVD9akjGfrFvquAhDP8sQCNRU2usn9Zs56cg+XuFtya0Z+ekIQB
         4m8EL4vi/fXxkclozFFcuJOOP2VUKMOcxPXzbeunnJojep6qEl9G2xBgWMZtDGnenFbB
         juTQ==
X-Gm-Message-State: AOAM532MRw2OAXFcPyz7jy8LfDnRK6t+TBnKgF3m5yJ3agiPjuGxbdoS
        Xm70gYWi9nAYNXYeZUJtpSlEvdekw8ruXg==
X-Google-Smtp-Source: ABdhPJze70cMISp+udAGf5/0jzlWKdJEFDdPsi+OfCJEFPrQFh30Ax0Wq2HFzyy4mTi6LmlHPTUcMQ==
X-Received: by 2002:ac2:42d8:: with SMTP id n24mr191369lfl.502.1601920725283;
        Mon, 05 Oct 2020 10:58:45 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id u23sm125934lfq.173.2020.10.05.10.58.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 10:58:44 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y11so11956623lfl.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 10:58:43 -0700 (PDT)
X-Received: by 2002:a19:414b:: with SMTP id o72mr224618lfa.23.1601920723274;
 Mon, 05 Oct 2020 10:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201004131931.29782-1-trix@redhat.com>
In-Reply-To: <20201004131931.29782-1-trix@redhat.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 5 Oct 2020 10:58:31 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOrr7k73mOizNGxPxXQ=bHEMUbTtCnoEusj2vRAaRPufA@mail.gmail.com>
Message-ID: <CA+ASDXOrr7k73mOizNGxPxXQ=bHEMUbTtCnoEusj2vRAaRPufA@mail.gmail.com>
Subject: Re: [PATCH] wireless: mwifiex: fix double free
To:     trix@redhat.com
Cc:     amit karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        ndesaulniers@google.com, linville@tuxdriver.com,
        Nishant Sarmukadam <nishants@marvell.com>, rramesh@marvell.com,
        bzhao@marvell.com, Frank Huang <frankh@marvell.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 4, 2020 at 6:19 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis reports this problem:
>
> sdio.c:2403:3: warning: Attempt to free released memory
>         kfree(card->mpa_rx.buf);
>         ^~~~~~~~~~~~~~~~~~~~~~~

That's some interesting static analysis for a compiler.

> When mwifiex_init_sdio() fails in its first call to
> mwifiex_alloc_sdio_mpa_buffer, it falls back to calling it
> again.  If the second alloc of mpa_tx.buf fails, the error
> handler will try to free the old, previously freed mpa_rx.buf.
> Reviewing the code, it looks like a second double free would
> happen with mwifiex_cleanup_sdio().
>
> So set both pointers to NULL when they are freed.
>
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Signed-off-by: Tom Rix <trix@redhat.com>

For whatever it's worth:

Reviewed-by: Brian Norris <briannorris@chromium.org>
