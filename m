Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6A5284469
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 05:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgJFD6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 23:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgJFD6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 23:58:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EA4C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 20:58:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so7216213pgo.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 20:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rnIqJFtWSAyZ19daKyHf1KC1lAEPfa765t2Rk+is77o=;
        b=Gk510JYVA1XNNjuaIk1hZk72EbY9oWolshIm8DiF535rPbK3cqCfIFAChz4TNWeuHy
         jsjd4i5oA8fhzJBxHtQmaTjtEZW3LXhSgklS8npTKJGLhSTM1LMwmQKokqhklQ1+DHl/
         HpSS0EpQ+uMFilKRJb7/7Dxy2rhEmN3E042qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rnIqJFtWSAyZ19daKyHf1KC1lAEPfa765t2Rk+is77o=;
        b=RkjfBNs1Cs6+kF0IbDLaTSG0VVRugZXLU/ymo3uBYRqbagl6wwvF5u/xgHmoYE9YJx
         5QFdoa59Ad0mMc6d07qEgpEsCY3+VslxGd0J/Zog5p1wZL5OEqazPXb2rsSchdHlGpXY
         6726Giugyo5lMLHYMS3eEQh3WfchFiEcf/48zcD7XaA/3f7LRLQATAt6cpruHHjnuvdN
         FPhRCncjv5yAK2MW6MKAYiLpNuqAnrRhIEwWYiew9eEM7Z9j5UZ7ilRSt+eKAfyvusNK
         lA5xjc+CIaLpswL8BBf0zYB+ea+7bYGz9kP1njpNwhKM6eu2Uwd4WG9+BEMoQZSEiTOZ
         o++A==
X-Gm-Message-State: AOAM531Stcyh2YjdI00fzeHJy+0IBjPmPN9gutPBTc+/5M08qJbHJBLN
        9Gj0gURJt41MY0eXKHoDiJH6ISFF5S2PyhM3sqlorQ==
X-Google-Smtp-Source: ABdhPJw8U2DsmZ1SvcwiAoupqxOL2Z0ez8LCiyz+B8ChVfA7yfo6FNRqB4UyUH+zJYnUh68yeTEx8oml1jziH2NDkGA=
X-Received: by 2002:a63:e354:: with SMTP id o20mr2434905pgj.317.1601956688403;
 Mon, 05 Oct 2020 20:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201005225004.0d3b59a1@canb.auug.org.au>
In-Reply-To: <20201005225004.0d3b59a1@canb.auug.org.au>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 6 Oct 2020 11:57:57 +0800
Message-ID: <CAATdQgB6aN8-BXwTG7=u8c+Q7mPmU+A9=O=_7u_wbPkuVNhjvA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the battery tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 7:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   f9d293364b45 ("power: supply: sbs-battery: keep error code when get_property() fails")
>
> Fixes tag
>
>   Fixes: c4f382930145 (power: supply: sbs-battery: don't assume i2c errors as battery disconnect)
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: 395a7251dc2b ("power: supply: sbs-battery: don't assume i2c errors as battery disconnect")
>

Yes, you're right. I guess I made a mistake here.
I'll send a v2 patch.

Thank you!

> --
> Cheers,
> Stephen Rothwell
