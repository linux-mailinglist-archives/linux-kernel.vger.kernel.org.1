Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692862DE760
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgLRQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgLRQWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:22:36 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD020C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:21:55 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id h205so6837005lfd.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDLpU6fmO9Dc1x1t61R7OfUqiugdNOS6K3qFKa97G3M=;
        b=RNcrom89+00TLhoqKq5HSfBMQiTcLhLTVqleKDUtotyAUgS9d/nMNw/jGeiCQhM4jS
         x9MkXG284bkHM8TnLfe9lsXoj0/J8isD4M9/eIiE02ofukBEqa6pmGSp6NUWXjWtfUUI
         alAsm7chyGHjGOzMufNh4+niTbrfwWDZr1qAr/DCKiF+g1NK1GsVwDuzfUpQyxLvLfDt
         bw81/eYelpMbjt92ZWTBzWGsI3ceWAxFY5un9rLm8PjM4rF/UJ1gc8WA6udpHCHg/Rtg
         gIXyFNweAuSiawcTLQjmTNWA4MS0DEWEgZ+64SBtudrKJZpb3IJ7sgzPTlrf679bxakB
         6WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDLpU6fmO9Dc1x1t61R7OfUqiugdNOS6K3qFKa97G3M=;
        b=f0JQB4Pl4UsXmkkTxcayoFMhEz1x3aXjaz5kYrgwqVdbKjdNN8ty8wXZKtkgJ7eo/M
         In7MiFsxG4qnVFptgDRC5pLOvwW3o4wSLlzQUrssgr4Giw6KS06AdJ4GQVo3uTa6jwL5
         9YXKskP0g/uWpeoxhxeyXjyCSt99ROl/ky+qHzBl7vd7/6e7xqcPMVSkhKNmgvT4H1wo
         LeDeEWWdeDl4S8J4oxTZzsYUn5ec+tX6OJIJpR61EexEOrQRk7mAA3Z6PJwp2Q3T7qP7
         yBE3HGkNwQ+byEINxmLv+OvoC1oDWoArknFV+1Q8wu/xD6lmv7V76HZRPHv38bQG6BX7
         C5Eg==
X-Gm-Message-State: AOAM530AL0VxtI2hvyWVpL4FUYHElbEaJ7U+QfvAo3g650TZz3k+g81S
        uMtI0+L9Ye6mx5tyrChnZCAiFI6MLo4Fgp2Ov6OMprmroZE=
X-Google-Smtp-Source: ABdhPJyaI5j2YELD3txTYS+jzFJKX/484b8gFBA7GJ+WBgF/OzCBTjjZXSRym+OOTn9VZPe80LIn4ZlRTbk8tMpwEF0=
X-Received: by 2002:a2e:586:: with SMTP id 128mr2273552ljf.273.1608308514133;
 Fri, 18 Dec 2020 08:21:54 -0800 (PST)
MIME-Version: 1.0
References: <20201214210121.22042-1-aaro.koskinen@iki.fi>
In-Reply-To: <20201214210121.22042-1-aaro.koskinen@iki.fi>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 18 Dec 2020 17:21:42 +0100
Message-ID: <CACRpkdbayocHXEgvfs9d1YCj2TN=nMpEkpXiF4T95MVuBwHUSw@mail.gmail.com>
Subject: Re: [PATCH] ARM: OMAP1: OSK: fix ohci-omap breakage
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Tony Lindgren <tony@atomide.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 10:01 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> Commit 45c5775460f3 ("usb: ohci-omap: Fix descriptor conversion") tried to
> fix all issues related to ohci-omap descriptor conversion, but a wrong
> patch was applied, and one needed change to the OSK board file is still
> missing. Fix that.
>
> Fixes: 45c5775460f3 ("usb: ohci-omap: Fix descriptor conversion")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> [aaro.koskinen@iki.fi: rebased and updated the changelog]
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for sweeping up the mistakes, much appreciated!

I am vaguely feeling it might be lower effort for me to convert
the OSK board to device tree than fixing all GPIO consumers
one by one, but I don't think I could procure the hardware :P

Yours,
Linus Walleij
