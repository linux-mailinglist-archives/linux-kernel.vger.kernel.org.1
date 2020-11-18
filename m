Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE36D2B72EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 01:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgKRARf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 19:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKRARf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 19:17:35 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC229C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:17:34 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o24so363670ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itEmzLXgCFTsEMcLeMQFGTZ6eyauUN+nMLUP2RUCNQw=;
        b=SD/i7W8Kd1DZxajpdO0JE2KkHfMFm18jKRvy8zwWdTpalEBE7ZpzBRs1XmIW7LGQPG
         3iVv8Z4oDk8aEx6k1zhrBke5P9rkMv/V6Pxjo79Si+P6sqgF+YeTB60H9KIsp1IrLWyL
         Yrp8ztYnjz0jNZhGPmCauhvjj8BzXMtmOaN5xnX+GTVDR7MX/Je67hSgjBu387/17cYf
         o6gmolahdP7rpSzfATNttVCTR9kzjBbmXHMlz7SR1JyzY/INn5Ti1pC1Z4b4A0aJVspw
         T7tnQcdVCNwsXdaxsqQdfP0/xKEnpRPgHdLL+Z0S+SVXkLJGdmd3fBfoTbnPJKgXOret
         OrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itEmzLXgCFTsEMcLeMQFGTZ6eyauUN+nMLUP2RUCNQw=;
        b=E0q5tPU3YQgS39t3qxDKmO7HLg3VIa88ERxq8DbKhf7ezgjqZ6Lqaa70eFkTedd+mF
         Z5vbdvzckqkV9RAtGuqXbXoUAbmDwGO0e7ffjcoMwRzA1o+rb9FM64+TCD62uWeJCoyH
         s+kMlIbuIx1IqMzaaVSiul6w6PA/WuQbsQgOcTRvtubXn+b0h2UpikXFxQqsjP6JWbyy
         fas4FnWPLbJ73CgNtK41IaiKfK4+7oXdJcuyWWNQ4V9U/of1q+suOh/LOiDb2J+69XkF
         tOW9AxGQ0OB4e5ruBr+Y/u+YAzgmKPoYBr2Ukop6VTYFoPZfFDwO5LHyg804BoxDqmn8
         bgaw==
X-Gm-Message-State: AOAM532KN2JGdyNjG2UuRpY+spngWJjx1TUp8megEfuY3rGAmpep8N/i
        7U+DGJ+054zGI6WTTNnGV4OT6RZ6pz2tYtwppd4UKw==
X-Google-Smtp-Source: ABdhPJzqGBIETrUOwWe711WB62z05yQi+shXIPIXgRCLYa9CIu7//O4+TmZ+ma9DFYOKZzUOtjh17WD72SI2hv05Ieo=
X-Received: by 2002:a2e:7c03:: with SMTP id x3mr2581893ljc.338.1605658653361;
 Tue, 17 Nov 2020 16:17:33 -0800 (PST)
MIME-Version: 1.0
References: <1605201148-4508-1-git-send-email-srinivas.neeli@xilinx.com> <1605201148-4508-7-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1605201148-4508-7-git-send-email-srinivas.neeli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Nov 2020 01:17:22 +0100
Message-ID: <CACRpkdZpz3LtJ9W6R+AwLf7LAT6Bppzjkpqywn_GS-Wx=c0j_Q@mail.gmail.com>
Subject: Re: [LINUX PATCH V3 6/9] gpio: gpio-xilinx: Add remove function
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        sgoud@xilinx.com, Robert Hancock <hancock@sedsystems.ca>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 6:13 PM Srinivas Neeli
<srinivas.neeli@xilinx.com> wrote:

> Added remove function support.
>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
> Changes in V3:
> -Created new patch for remove function.

Patch applied despite not applying 4 or 5: this needs to go
in with the clock support.

Yours,
Linus Walleij
