Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E053B2A1AC5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 22:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgJaVfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 17:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJaVfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 17:35:30 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC7AC0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:35:30 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h6so12421183lfj.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KaiHGiCKtnxQpCpgXWPUOJnW6vtzkfBDI6tUC1n/vOM=;
        b=HrvQ4f0JsBwaGJzQrwS6yyOH4HUhrsbcf7m5AkkEsXsxS7gXBn49P0WCHKQFD84kx2
         5MT5i4tn4GvPBq/8x/4kRvRRGtM1/g0ctERDXASQi4/Tjpa7VYux+xoUvjscyWJzlQrh
         EL+iiepz+YVCbx9CxFqM3VQqMYPbZ2E6FyfHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KaiHGiCKtnxQpCpgXWPUOJnW6vtzkfBDI6tUC1n/vOM=;
        b=j1NUa/i97QIMlJH2/XgvLvrF/QzZg5mEjrVI1nDU2HHE5mmm0vK4iOEfRaHFsmKInR
         lY/tb3wHFPYTMQA8WZpVLg83+LPKZkgT0+a4qZ0QO7drSYzTMWI5a1B0jg9+U9rgov6/
         pfkAIw1UtvYt2SMoFWVSXbapHI51V9ajoFXHNJu6fmXo+nwUb3amXKXKIgrJP+GFI3z8
         GM+wd8aZ/EULgRMXjAVSlYznJkyXtPYgDtZjDbEUxL/etfk86XbL89NGBlTqODvtyO37
         hA4tiNO/AhBLOE2Dl6r0vHXXBmPDiU6ZmqtJw5qMp90zR5NVO+gMHSbtQMiULpd53iNZ
         uA5Q==
X-Gm-Message-State: AOAM531N/rdgsRtTU8BNFmTsPq+KqnyqSWtEdRI5DtNYds8KNTDNHjF7
        q4Cbndi0bRP0BKDYs4sDap/3640+iPr5dg==
X-Google-Smtp-Source: ABdhPJzm3EefmkaXCUosgg7HKBOFeu4FnjyHHAf7XNl7KYL8Y1E3MvNfNYnLLdvlInHtW+60grgueQ==
X-Received: by 2002:ac2:5cc2:: with SMTP id f2mr3011661lfq.593.1604180128633;
        Sat, 31 Oct 2020 14:35:28 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 207sm1100835lfi.149.2020.10.31.14.35.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 14:35:27 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id x16so10850689ljh.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:35:27 -0700 (PDT)
X-Received: by 2002:a2e:8815:: with SMTP id x21mr3915670ljh.312.1604180127311;
 Sat, 31 Oct 2020 14:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201030221342.GA6183@embeddedor>
In-Reply-To: <20201030221342.GA6183@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 31 Oct 2020 14:35:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whF8-G2tHxnEo0XzmojWNKvKdH1BW5PG1P-OD=eZTFtHA@mail.gmail.com>
Message-ID: <CAHk-=whF8-G2tHxnEo0XzmojWNKvKdH1BW5PG1P-OD=eZTFtHA@mail.gmail.com>
Subject: Re: [GIT PULL] flexible array conversions for 5.10-rc2
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 4:14 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-conversions-5.10-rc2

So I really don't like getting these outside the merge window. These
kinds of patches _can_ introduce bugs, and I see noi real upside to
doing them outside the merge window once the initial "avoid lots of
possible merge conflicts" bulk was done.

I've taken this, but I don't want to see any more. This is very
clearly "development" not "fixes". It goes into the merge window, not
rc kernels.

                Linus
