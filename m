Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EE72DB7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgLPAes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLPAel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 19:34:41 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854D2C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:34:00 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id o19so18429711lfo.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zj2YPVQKRFQs32LNLuK0mWD4evn16vjxArTvNU8xCYE=;
        b=zmi7gRMEKq3pV/lgDugpVABkbjYGunfv3IE8jzEnAbsXbf+Ejg0wFe38PkWiNxIzat
         UcNrSUrSe1p2sIBdGyWDONBu3AH8Kbk0NiodFDicgrBdvK70sr0gakQF29ML95jAragV
         8N13doCOA/pfONzJVu9hq8B426nbEKWVwEaZb7OphLLkthsF5Ta4dsKZ5Ek4hjMnrraY
         DGHF1s2bdcFGIUxhc8PsQ4bFHAmzraOeLADbxbYfaGcYzobyIX+X8coA5ijWWy005Ds+
         wAdnfLQ7eT6rJMO+AIq+vVrl6HWY5W3uz0vRd5Gt6zRcBSNLXP04+FjmrPL01+CWxnu5
         qKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zj2YPVQKRFQs32LNLuK0mWD4evn16vjxArTvNU8xCYE=;
        b=hMetijCaK4MR4Ssc3wlpQyxx8t6apMwDwbkb7op2MWd2LtnDK8Q/BtMDxftx9PVmBa
         GQj3rMrEfH7SmHJVR1a9mL2LN/TBbPvA1tqQ1WTP1U/lJgfM9pzWgps0iY4RleCTysN0
         7Kzc8WjhgZFQJIEOC4C9bMDvZ7FEqXsiKyheaIVht4aQq6qKoNZjj+N5K7mYxtmZpnNf
         W7G/N6Xndzy1/pZMX2/51LPaArQGbtF0qOf47EV8h47LAnVbKeSBjd4qh67xjsDE89Mv
         Pzll5TUOAGazGBjrr7UAUFEc9KQioxwBktNgLcAzrOMYzAq5yIGMVZvV5ZOR3mLbp3OC
         Mdsw==
X-Gm-Message-State: AOAM531q5ejI/L4L5BqtUE1te3x/wCFsvxgbj3jVgQXzvMqCrnqvmV2g
        ESFQAnjxi1dscKliwjdiDAl9eI7l3RSuRlEbrCoCfQ==
X-Google-Smtp-Source: ABdhPJyOHjNYEs+MlipEezrk74D7gW0AbcHrqq8ll/2YJyrpydKCzWHi1oI7l8bwkRbDoPAAlJpvejRCo7btrJ0F78U=
X-Received: by 2002:a2e:8e38:: with SMTP id r24mr7092267ljk.333.1608078838907;
 Tue, 15 Dec 2020 16:33:58 -0800 (PST)
MIME-Version: 1.0
References: <20201121235002.69945-1-john.stultz@linaro.org>
 <20201121235002.69945-3-john.stultz@linaro.org> <20201215235334.GA227480@roeck-us.net>
In-Reply-To: <20201215235334.GA227480@roeck-us.net>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 15 Dec 2020 16:33:45 -0800
Message-ID: <CALAqxLXOnJPU5O5nZRnww6qNeA465syOmCPr9FY5cD_aijjzQA@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] dma-buf: heaps: Move heap-helper logic into the
 cma_heap implementation
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        Chris Goldsworthy <cgoldswo@codeaurora.org>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 3:53 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Sat, Nov 21, 2020 at 11:49:59PM +0000, John Stultz wrote:
> > Since the heap-helpers logic ended up not being as generic as
> > hoped, move the heap-helpers dma_buf_ops implementations into
> > the cma_heap directly.
> >
> > This will allow us to remove the heap_helpers code in a following
> > patch.
> >
>
> mips:allmodconfig:
>
> drivers/dma-buf/heaps/cma_heap.c: In function 'cma_heap_do_vmap':
> drivers/dma-buf/heaps/cma_heap.c:195:10: error: implicit declaration of function 'vmap'
>

Ah. Looks like we need to explicitly include linux/vmalloc.h.

Thanks for the report! I'll spin up a patch, validate it and send it
out here shortly.

thanks
-john
