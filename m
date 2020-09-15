Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A0126AB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgIOSD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbgIOR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:57:30 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75D9C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:57:29 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w11so4095182lfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zC/SbxYzkjp6OcGCx+rUfTP966C1m59d2H5efDgrVWA=;
        b=gOM8yiiLag62BKZvBU1Ld3EaS+uEABdHMAHOQYXp4gYgK6MWnEoBDMAH46BUf5TmB+
         TeiK1flI2V9KV9iTOku256yuojEHjYQL/SAkqm8hwmwq348GzbP3X55WgpJgFyA65Dwa
         edcbkgZ7rYAClxokvf5Qgc9mIXDGstbDigyxRjuqO7KfNRieXo/v1P7K4TScxYmUoSs/
         P5aQPFH6A9jxovWESXl9bVN6Ub7fP+bQIlsS7BGzFm5YRBD0C9sMWEkCH4yqIaNadUgv
         YKZB3sxoc01LhnoKnY5chFTddDEGyKupJziTRTxccKqSUBlHJWEQp9W6um13MiR3jbSm
         I+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zC/SbxYzkjp6OcGCx+rUfTP966C1m59d2H5efDgrVWA=;
        b=lEq0039IU5il3/jt/LHgfk7oZYIYT/52KB4j3tLaCV3JSCyzYGfSzrUnI2TzF+jiGu
         v6mQ1OTlckC3WlU3pMiB7i4bAu/BDwq4GC7VdYuuYXCuEuRfq9TRdcGOItGWrU8kYp6E
         fS30OkFpg7QmRVhWWL8JxovVasnjVdSaXuOwOY4UyKyJJKdmCG8g8f98KqHVu+eZ06HG
         e0c3I84GMjxVx8P8Wlz/gG5cKuArAieijexK2vgVEFm5d0sqmbOa7opNmlz8uzx8bkU0
         JCsRwrFlNM+i0wN5uEThZiBaRtzP5vATN0qoJC/fya2z/KVdtEaNgOpWYD02jwqxPRmj
         WoGQ==
X-Gm-Message-State: AOAM532P21xgIYD9eXzxclAngZmcCJluqjxdADe4479hDb/x6BIRt7Fm
        F0G0L5zZlGh2aNCVKjjLx8u2o+cDbhM2RncdBcyE8Q==
X-Google-Smtp-Source: ABdhPJxiAfjaIb5OwsUu7wWgQQUH27aiEppISRg5ojFfZ2j3xreHT6y4fAfiPh/OE+XTn7Y+z1CPhpz3d5Jsez3n8n4=
X-Received: by 2002:ac2:511c:: with SMTP id q28mr6086175lfb.411.1600192647744;
 Tue, 15 Sep 2020 10:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200915172658.1432732-1-rkir@google.com> <20200915174643.GT14436@zn.tnic>
In-Reply-To: <20200915174643.GT14436@zn.tnic>
From:   Roman Kiryanov <rkir@google.com>
Date:   Tue, 15 Sep 2020 10:57:16 -0700
Message-ID: <CAOGAQepp_1QXrNAAXbLpW8qrujfdszfU2rMoh804wKK-Ja66Yw@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: power: cpu: init %gs before
 __restore_processor_state (clang)
To:     Borislav Petkov <bp@alien8.de>
Cc:     rjw@rjwysocki.net, pavel@ucw.cz,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alistair Delva <adelva@google.com>,
        Haitao Shan <hshan@google.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:46 AM Borislav Petkov <bp@alien8.de> wrote:

Hi Borislav, thank you for a quick response.

> Ok, google guys, pls make sure you Cc LKML too as this is where *all*
> patches and discussions are archived. Adding it now to Cc.

Thank you, I did not know this.

> Ok, so why is the kernel supposed to take yet another ugly workaround
> because there's a bug in the compiler?

I believe the kernel makes a questionable assumption on how clang
uses registers (gs will not be used if stack protection is disabled).
Both kernel and clang behaves unfortunate here.

> disable LTO

CFI depends on LTO.
