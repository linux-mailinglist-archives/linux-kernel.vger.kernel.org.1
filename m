Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A0329F091
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgJ2Pwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbgJ2Pwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:52:40 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A0FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:52:40 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x7so3536242ili.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BWFhfe1yKAJFrkihtHLlDOumIQL4VCZozfdcYfARq2U=;
        b=Qkt+aten6payl/zGnAsxEwhGUzPYl++a31HpQZIcpiYiN0EM0oCf3HPGyJfsDXc/zj
         oeK/sajBpRKC8cSjYzkoFhAyRv4K2I4of2jVpFL1Ky7gaKeJMcT2GwNG3qVSG0olx1dc
         /CWyep+Eq+wuHiBfq2LCK+3xRKOCgCt9VGoDu8uSGho4QeIaFsaK3yd+RW+3oI9CE2Un
         Pf4t9hx3zSaeTfcTwuzS7y48iI5uNMBCIReCxTy5rcCQpkj6M8OGVhvYSca7iTo/cpXW
         lIBNfG/c394i+duyVd0j1xmmlrBhfx9hciGBAu6QZYMHwc7sszicTtgXurgRYBF8667s
         +aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BWFhfe1yKAJFrkihtHLlDOumIQL4VCZozfdcYfARq2U=;
        b=AJv3Mbo4lMVgVmfw/5tks6lmJWNtspgJ9B/Gi/R7Dy8GkzuISN/o3uDd/2mTjU1OPF
         ZhBpaBuVKt+xQm6bLrA5QaLymJrF5LFDw9mcGNPrV8yBePP448N4XT6oCTb86aQG/mS2
         4pxGHyd7IADdMc4nmNJkup9K0IYtl6nUgvktcYnqFAqkWG33DGiJYUJixdRNxClgkRZK
         YhATdi0Apw8pACJ20cyFEfgoDuZY/O9z14g339cHuxfRvPVNoqW5CzDXnzkrva7DnmXj
         MbC8+WWDYUYqO0HDGVAuh5IrYD9skPwivaYOF0qn6sFB+SFtXl88D0uaA+4xt46zYst7
         cR6g==
X-Gm-Message-State: AOAM53240LjQ7DW0D1sAfD83ydZDp8usL024Rexv+nDMJIZpjvxXLPNn
        x8AgaSIErdaBJDCk+kM95L5VGlL9ggo7vfV3wme1Kw==
X-Google-Smtp-Source: ABdhPJycSiHSPVPlCS969WgYsKktpY3aMPNsNMzhNf+ZE5ulCrPMs9kA0+KgPVDSQ15xa8E7bTWNJSuUdmOYE0phJLA=
X-Received: by 2002:a92:b610:: with SMTP id s16mr4067448ili.6.1603986759535;
 Thu, 29 Oct 2020 08:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201026151015.15527-1-brgl@bgdev.pl> <20201029151847.GB5042@sirena.org.uk>
 <CAMRc=MctRhVzmJwquO5pQDjnNP5HTXrG7qLN7r9Ky+aEuSCBDw@mail.gmail.com> <20201029154833.GD5042@sirena.org.uk>
In-Reply-To: <20201029154833.GD5042@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 29 Oct 2020 16:52:28 +0100
Message-ID: <CAMRc=MeMjpCRUWmKhfQJaEA=aAHQGVaE575bxsFCxQsO6mm9xQ@mail.gmail.com>
Subject: Re: [PATCH] regmap: provide regmap_assign_bits()
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 4:48 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Oct 29, 2020 at 04:44:16PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Oct 29, 2020 at 4:18 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Mon, Oct 26, 2020 at 04:10:15PM +0100, Bartosz Golaszewski wrote:
>
> > > > Add another bits helper to regmap API: this one sets given bits if value
> > > > is true and clears them if it's false.
>
> > > What's the use case?
>
> > Basically what the function does: set bits if a condition is true,
> > clear them if false. I think this is a common enough use-case to
> > warrant a helper.
>
> I can tell what the function does, I can't tell why you'd want it and
> simply stating that it's common isn't helping me here :(

Got it, I'll resend this together with the patches that need it then.

Bartosz
