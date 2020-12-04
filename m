Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161902CEA2B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgLDIuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgLDIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:50:23 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AE9C061A52
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 00:49:37 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y16so5725753ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+M8zrbq6b1p8wlcXRVRPmBvCI2nb4z2DmdAj80G4yJY=;
        b=WdmUpBTMYIcMJSRVU1JOBuE7mf8hr8esrydhOy1Gzs7dnJja0RYck18VDWqZXWf4IQ
         6/QMs6QEHr70cEserUggAYNtEGvQSuz7OlFWn/h+jeLt9hg8tvwTCy7Osa+eu2fOHPAD
         nzPdWZnUKff8WxA5zaUASm031d28dSHlU4KRf5mwuoJBCd709azWoydVuKvsTGFryQHC
         /9GivUVguITQIGsbnrX5uXJvMnCR+MeMUZllGz/xa2dCFKBDqgznuz107Mn/3gr1aSXp
         whVJs3HWyQN8GuSCMzWvm/5kkpB0wppQ3FrBCY4mZACUP2ocEj0MaCJ8bTqvux+gzOOG
         D6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+M8zrbq6b1p8wlcXRVRPmBvCI2nb4z2DmdAj80G4yJY=;
        b=BHO6Hb66gyrPDKjFuUIqNu/hQyuwtXc2w7+mzttEggXjIGi9NTZVNYhqAYEBIGItnT
         vxAWM76H2wTXgO5tVjYBG9rqFgO2Kms+F1OpdFyWEI/8IfsU9Y9Pvu8t5D7d26rfOFQS
         69HKNL1vHuGzJ2gdGAazV2f9vSZxqmpothD55z2Gf7gviAkV/WbdDapg+pzEK294sa2h
         cAIhWNA0Uwm+e93vxwIvEPCwgwAEbGVCMTPnK7iXqKMSTaacCUSNrH0HV0UKJL4Ri05N
         qUiFo9v7+w2PNU/9PPPUfCFTrzGBX/v2pbYMIvu1+/dzKQjpy0v/p/Ry8yRrdtBIQ6bv
         Ur9w==
X-Gm-Message-State: AOAM53188uPJ+7qaI68zRU/1psi8sW2tqN+rBqCHPkOkL79S+CYNQdzG
        /PrB8IsnKGhXSOXTz82OHjffekoW9DZT6nc3HxBiww==
X-Google-Smtp-Source: ABdhPJxqn4nKKGnNWQ8ZGC/Q2XERh1TtexNG5hJfal8ZUnxdUO5LOaSCB57gt9jbaaXkbFoYOCBibJQ5/e5byYO5UGE=
X-Received: by 2002:a05:651c:111:: with SMTP id a17mr2861001ljb.286.1607071775878;
 Fri, 04 Dec 2020 00:49:35 -0800 (PST)
MIME-Version: 1.0
References: <20201122092548.61979-1-gnurou@gmail.com>
In-Reply-To: <20201122092548.61979-1-gnurou@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Dec 2020 09:49:25 +0100
Message-ID: <CACRpkdZzBxJMJknDL+bt8bGBSBCOO4mT3cbU+RDWL2W5Fpp5Zw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: fix typo and unclear legacy API section
To:     Alexandre Courbot <gnurou@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 10:26 AM Alexandre Courbot <gnurou@gmail.com> wrote:

> The "Interacting With the Legacy GPIO Subsystem" of the documentation
> was unclear at best, and even included a sentence that seems to say the
> opposite of what it should say about the lifetime of the return value of
> the conversion functions.
>
> Try to clarify things a bit and hopefully make that section more
> readable.
>
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>

Patch applied!

Thanks for fixing this up and thanks to Andy for coordinating with
the fine folks over at StackOverflow. I added the BugLink and
Andy's Reported-by.

Yours,
Linus Walleij
