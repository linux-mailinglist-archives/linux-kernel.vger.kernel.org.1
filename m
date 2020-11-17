Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1932B72C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgKQX6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgKQX6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:58:10 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9634CC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:58:08 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u18so330117lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DDTTTdwHCc1w1LQn9d18kS3gdpQLwepnpceiCNjIF5c=;
        b=rcGkBAJdPYVQMZHDJSkWZvKSeJ6HxKc3H8BAwdm8d6PklBENCwisqQJCIzC2yk+hd0
         k4LP0GudZ7IOem8wVnr5t0T5W71mKV5W/oHDi4FaQaZLpQsY7L4y7cxjpLrC/+/htiv+
         XdEpo9vw5EDGYbqc7P1APc8kOKSDT83PnDY/v8qSeYDZgXu1yu/3QDa+JqGp7pY7NtER
         8wZqxMZ+c0A3KoCnmKmTdvPOWuZx43g7jWn0LidaFdZXmrMMapdIBFmuuLBOXpcjK54t
         JEJlyimlODrDfd+IFcIOolOj9Ah7v/iIUDBemALVAUYelH54WYc+HEYB5+y6NGtX0KKA
         x+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDTTTdwHCc1w1LQn9d18kS3gdpQLwepnpceiCNjIF5c=;
        b=lfQ3XnaaZYSW6bKxsuykeT3aWpsCNQr2P5xeJMA+Jq7267hYMcnOPvRVLOSxvgcWxQ
         E5NkBHwp5tCnCnoCPEbO4rSVFdql7Fm9gLNYORhZnYLH88N9IT59Y5RAkB+bDALzBaeF
         cGzUMVZ0R2h/ockdS239CdgXWeyIBWq0WjtA+nxmNyA5BV/cZ8Mqc9TD8GQiaEzb9Lz+
         jNOqe3AkpcCKJoE79+tcVh59URdqYDZTEVRl3LxJ+QyeuMltlSbsNBp22i07bbBtD2X/
         FccDmO7emdKZIho3Qlbsltyd2dh3nS03otiDeMmFwUFASx2OXXIfKaeBH0Y/D19RNEg6
         Ymnw==
X-Gm-Message-State: AOAM5300BHNTZUWYy4nc9dV0s6fUAzkEWw2BqeZfchSfxYcc0gtf+39t
        QqcQ6Q/XiY/VlcjmItRvkqG7071nfpZ527uF6Tkcxg==
X-Google-Smtp-Source: ABdhPJzl7v4WoPOkTVcPzyibPZn61/XR9Cv/LuU2FZS5y89+0ItckbPb1gu2n4aru3xIHCAbIimUrfmFzDPM3B+RzB0=
X-Received: by 2002:a19:e08:: with SMTP id 8mr2436766lfo.441.1605657487028;
 Tue, 17 Nov 2020 15:58:07 -0800 (PST)
MIME-Version: 1.0
References: <1605201148-4508-1-git-send-email-srinivas.neeli@xilinx.com> <1605201148-4508-2-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1605201148-4508-2-git-send-email-srinivas.neeli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Nov 2020 00:57:56 +0100
Message-ID: <CACRpkdaUZejMj=rucoW0tnLykHo4vYu5Qj3rWq5x9YNiALu0ZQ@mail.gmail.com>
Subject: Re: [LINUX PATCH V3 1/9] gpio: gpio-xilinx: Arrange headers in
 sorting order
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

On Thu, Nov 12, 2020 at 6:12 PM Srinivas Neeli
<srinivas.neeli@xilinx.com> wrote:

> Arrange header files in sorted order.
>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> ---
> Changes in V3:
> -Created new patch for sorting header files.

Patch applied.

Yours,
Linus Walleij
