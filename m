Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA12B7305
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 01:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgKRAYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 19:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKRAYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 19:24:55 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45193C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:24:55 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 2so20675178ybc.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0huT1R6YxHvGQqjy0+YuKw2JldEAQJIjUv13qFD6dSE=;
        b=VUG0beWyUt8t9AI5oq/YFRQwecBElOINxFbPhyy/8GofdinFclo6zu1uIepaA67qsR
         Xdu5eTDwkSe5uUpSlKtgjK0VyUtV39YYZYRjJPR/Ziqj4fulhWJpDjOZbeX6TQzmeskI
         ZftGi1itFwsOncl+z7StJOtEbHfLX8dmPt8eYyM7NemrIloKmnKydQskGZPWKLInSCRR
         vCUSnjBQOKXtUZtdVrHnYHv2ViwsBR8FWZPBeYlvygsge5OiIzAPlV9r9qhHWGPDqO7e
         oOh8ad6TuwqklUzBXAwSkO15r5Mj6PecgJc0P2X+ckwTZOKQve3wW/tM/dbsi/VpsRhh
         zZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0huT1R6YxHvGQqjy0+YuKw2JldEAQJIjUv13qFD6dSE=;
        b=HwlnNzluH+YSXxE5WYrzaVlttHUpoFB6LMiEmGetVjqFtgd9HcPxL04lzjJETnXUHf
         0JXgi04cjEUtoewNj+1sYgBrNDdIonzn4JrzQU2vvNmpfM17OcCnhfQMi8eG7ZXa0LYb
         ZJ4eIYl24BhZFLU8pyEiV/2d7ibEJTh7GAt5WjPyqHz8AJjieCdrTxjU8NexLWO5OgnY
         VbORmH6QMUPmZU0mRWHHwODdmgkBF711iy7jvX6E505uFXYsHAFFzBjbUlUHgrrNdbr0
         uwf6i0OeXpf2GNjCkQ0uLfXc+eCXiGtKwwThoYNXxg1ZFgXqsDv/CukVL/8nmZ3+tqBH
         YdNA==
X-Gm-Message-State: AOAM532x/vywAFgucD2oT35w/ZEsX4WE1uvOtNL7wm3Kl1PncLVZIXaU
        +MtaGpC3WwZoMKZHu8iiMbTT5WNEChaXW9oW3V8=
X-Google-Smtp-Source: ABdhPJyrWC2hnz0a+YpjEc/pPbGRaoxoIvPVC89x34vc5rx9dRHAKUY+BD84V8Qa6YI/dCAH4D7960lOGz/NIsdgZDw=
X-Received: by 2002:a25:61c5:: with SMTP id v188mr3618112ybb.422.1605659094582;
 Tue, 17 Nov 2020 16:24:54 -0800 (PST)
MIME-Version: 1.0
References: <20201118000751.845172-1-ndesaulniers@google.com> <20201118000751.845172-2-ndesaulniers@google.com>
In-Reply-To: <20201118000751.845172-2-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 18 Nov 2020 01:24:43 +0100
Message-ID: <CANiq72=jEx5o_m72WoeRq9r74YGtedK4AE=4b=j2zS6M60ESaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] powerpc: boot: include compiler_attributes.h
To:     Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 1:08 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> It was also noted in 6a9dc5fd6170 that we could -D__KERNEL__ and
> -include compiler_types.h like the main kernel does, though testing that
> produces a whole sea of warnings to cleanup.

(Re; for Gustavo to consider since he took it now): I would add a
comment noting this as a reminder -- it also helps to entice a
cleanup.

Cheers,
Miguel
