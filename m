Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A516A28EA22
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbgJOBak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732253AbgJOB3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:29:38 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CC2C0613B5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 14:49:37 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c141so1158048lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 14:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HeA545JHkumJvp2vsCHk2yunYiCvO0ipKJnKrSnCtIA=;
        b=g+63cfS60C2BkSY+gwVeR7vMl97bsv1IQGRh6EJKNoeFEa6XKQGTfjY4KphKtzenwi
         fgv3PqPlIj0FA/ulDIEm+3G2Gferh1d68pORa8D1ERInDuhw+ymz7MsyEvN54yg39J26
         rG2Fwdtv8ESAe/MsPrELWQV6dHYKUvg88BNRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HeA545JHkumJvp2vsCHk2yunYiCvO0ipKJnKrSnCtIA=;
        b=O20p0S/kvv+JtIHyb04O3yzKNzI/3OFeJxfrYkQ/ryzZrIlC4GQ2qO/mY4d+u8aFQ/
         DxwrLNX+c4cKHZjnCGaR3Vb5Uh2HdrXoQdseZNKOhpfOV3+dLYLZK9XBKrp01A67Tsge
         VELb2oRnQNF50D1Dp21IYCtNboDkIEmVd0xl4Eh/YBppJ0qCBh10f5xvLtR1DsjUnNx0
         XkZBe/zmEKEKIobLM+2LfLnToEeyXtWDQqqdD5ogXKpDv3Ne3g+WdOWk3mTlY6N7vipd
         F38PocFcgC44Veh+Y2YOa6WrZTEffEyCFLjP/GWsq5RSseZYqFdvCFS4k91dGS4Cob6l
         sIbQ==
X-Gm-Message-State: AOAM533rCwnp6wWyPtrsu9AsQ/q4mRWtaUIHIPafZTVHUf87GgR5IgI+
        kboMcPxLtb8N1GL2boVe3d6/7zTy6IPQ4Q==
X-Google-Smtp-Source: ABdhPJzB/kWo83gPdGqA4PziAfX1HtDe1vN7cX2Wg2FIZDwLVQrbCL352Bp942/HhGFOJhhX0+TL7Q==
X-Received: by 2002:a19:589:: with SMTP id 131mr29631lff.229.1602712175432;
        Wed, 14 Oct 2020 14:49:35 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id i11sm363348ljn.119.2020.10.14.14.49.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 14:49:34 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 184so1141065lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 14:49:34 -0700 (PDT)
X-Received: by 2002:a19:9142:: with SMTP id y2mr31716lfj.352.1602712173956;
 Wed, 14 Oct 2020 14:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201014204529.934574-1-andrii@kernel.org>
In-Reply-To: <20201014204529.934574-1-andrii@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 14:49:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiE04vsfJmZ-AyWJHfNdGa=WmBYt4bP3aN+sTP05=QXXA@mail.gmail.com>
Message-ID: <CAHk-=wiE04vsfJmZ-AyWJHfNdGa=WmBYt4bP3aN+sTP05=QXXA@mail.gmail.com>
Subject: Re: [PATCH] fs: fix NULL dereference due to data race in prepend_path()
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-team@fb.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 2:40 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Fix data race in prepend_path() with re-reading mnt->mnt_ns twice without
> holding the lock. is_mounted() does check for NULL, but is_anon_ns(mnt->mnt_ns)
> might re-read the pointer again which could be NULL already, if in between
> reads one of kern_unmount()/kern_unmount_array()/umount_tree() sets mnt->mnt_ns
> to NULL.

This seems like the obviously correct fix, so I think I'll just apply
it directly.

Al? Holler if you have any issues with this..

             Linus
