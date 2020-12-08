Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C8B2D267F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgLHInH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbgLHInH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:43:07 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462C2C061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:42:21 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u18so21912026lfd.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymnCoQX1+UEnlfRUosY5UkqWz5Rl16ic4atnqAGgf1E=;
        b=TSzGAA5l5QLF43fxPLXCwVQ7edav0PgyWJzpkKM81cFxyi08uGwT4SY4R7Z4bWL0XV
         wFTFaoDtlnh+oYASBIDEKAq9W57r+GKVQhSKPn75ojafgU9J0Ulr1pOqE1kDa24abJyl
         Rowr8bfapuebK5wuz1PeQB2XY3lOl0yCrlq7rqiZXRI3AenjxPB1hyxkbsFyUrRy3dx8
         NgP2Jsv4HD5IsGy0RwCvW9PTT6yR2K98ZNp/e7E052wu1YEVqW3IHP9WxBzEKFEguwBi
         1liTeusR/i0QxXB5lomW8exauCdRK7Kzl3oZRxEJOJhNDlz0rstla8Aw+1HJW5BI5ZGE
         UZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymnCoQX1+UEnlfRUosY5UkqWz5Rl16ic4atnqAGgf1E=;
        b=dkrzSjVQPIkEZbZmUrDvpQGKmQSB4GDp+Ud8ebZKzdMCqMqALf2LHdS/cjYXoTYK4r
         BFN2ILiVu87hiycEQ25ncI0YxUlW9tkYxJ2tgFIi0lDRSj36btJY9hINhrnWU664XKtC
         cGLnMJTj334I9qbNHVSruBCnsx+0dputL82+xMaQuaWqRGW/N9CkGJ4m/PMdANtrgFyu
         wHkT6JKK35sL7leNhl99Ey/sJz6B/siIc5ewCZJ5dil+pZE2iacEt6ctnt/QCAsrILQq
         5aEuuRr+NbhGqLDdFgm/k4DTkauI2Oq/x9txhY6pm3FORwLcbuk3L/xmWlPyVDPoSrlh
         7KpA==
X-Gm-Message-State: AOAM531+kOJPGGtewkRa9R8lOtNcohZGoeELZ7R5wOymVUlScGdD1z+W
        UX/P9MQKrHiFXur72oi1yRnzHZkHHtLeasEWIZo1JA==
X-Google-Smtp-Source: ABdhPJxJH6WOiwnX0/Tp2sqcPodJNB8qgVejkevd8OIMmSe8HP3/a8RT4LZ5WXvCVLbktHHy+GWvSAkdamL7iDdA6yc=
X-Received: by 2002:ac2:4308:: with SMTP id l8mr9319905lfh.260.1607416939796;
 Tue, 08 Dec 2020 00:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20201203182423.5499-1-info@metux.net>
In-Reply-To: <20201203182423.5499-1-info@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Dec 2020 09:42:09 +0100
Message-ID: <CACRpkdZK2epvcxezVerW3TVdLgO5sz46J8VreaAANMYw=tq+-A@mail.gmail.com>
Subject: Re: [PATCH 1/3] drivers: gpio: bt8xx: prefer dev_err()/dev_warn()
 over of raw printk
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michael Buesch <m@bues.ch>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 7:24 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:

> For logging in device contexts, dev_*() functions are preferred over
> raw printk(), which also print out device name.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

All three patches applied.

Thanks for tidying this up Enrico!

Yours,
Linus Walleij
