Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2CA1ABD60
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 11:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504389AbgDPJy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504354AbgDPJyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:54:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3F7C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:54:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h25so7094488lja.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmbTM85pXtLEnvZz1CqQLZJasM9rtSlADHL+rW8xlrw=;
        b=X0FwYuN8PxbnKfdFk1WRENwOJ5S/hI0XCnA9Oy2Lu3WB2kR3kCTK75cPlxqCiZPtnk
         pOJu6ikqPqEygo03Gt1k39EsS5FzXAJpr82cqxvwcBqyrH5vIHSvPQTUq42xRpUH2RUC
         YekYxdSDnrHHYqGcVZfUjFKNQlUTcNXbRacq63XWG8TuP24SpCcMEGzaPJrX5SzeGriR
         fHQz1tryaVkTKNDBK180Uj4sS488b35fMebmxJYsRTkxRqyP28iS4vxqvDNreb4pOdWx
         xCD4ThUu2HVHfLv1Aw6q0jX+0ZpybtQngclP5WG6YNMtX+c3Kf2NDLcVpB7qC6y4fPNU
         ATFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmbTM85pXtLEnvZz1CqQLZJasM9rtSlADHL+rW8xlrw=;
        b=Acw1gYLGxHs1skY452lnB0c52RcEQ5AJX1XvwrL4yhzjTGk4YAstctAYZ/XPioI4ru
         I8ZFzsyZ/BD2MCNZgvuY3QAM8kCC0SGftCYYir/iX14Rs+4rAe/my8srI211SBvICk7n
         zg6pSE9hhHqBYqYVX4x8eYV6eVbfKjYup7QVdhKXhyzZJHM/GAypbL39mdMCReWCP5/t
         TrocN9JTeOw+YZsgwEx8Z8SPixLau6HBv7sLH0h1d5DJh+rNWCYUrdN2wkUiZ5C/yNYF
         NypUHa4wuifksr9yusxaVA6h7ZyIxxPNG0Nuk/HYOWBcoLHAD5LbaPwb7yCDzUzf6wO3
         Ty5A==
X-Gm-Message-State: AGi0PuZM3RJcXjZZLpnPhkYLZujFV45QXoSkpgexrQDKAwwjhMFv28FF
        cqUlztgrsyahmwNbl+W6dGUjFBO2WzS0UPaOv+KW6g==
X-Google-Smtp-Source: APiQypLayQLGT/Ao9sW1llsHHkRFIz0OeK7rOpmFlYZ4pDnuYKa6o7Y6T15Uy20O8h92MJhp/gGAXS8WRrqWYC06AGs=
X-Received: by 2002:a2e:9605:: with SMTP id v5mr5752886ljh.258.1587030843273;
 Thu, 16 Apr 2020 02:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200407154245.2548-1-brgl@bgdev.pl>
In-Reply-To: <20200407154245.2548-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 11:53:52 +0200
Message-ID: <CACRpkdYUdRn7=ASQ0xkZ06sAzt4umA_ajg=pbcT5Hm3Tt7JjFA@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: disable regmap locking
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 5:42 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> This driver uses its own locking but regmap silently uses a mutex for
> all operations too. Add the option to disable locking to the regmap
> config struct.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please queued this in your next devel pull request for me, thanks!

Yours,
Linus Walleij
