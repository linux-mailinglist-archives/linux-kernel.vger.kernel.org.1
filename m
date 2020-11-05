Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E8C2A802E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730933AbgKEN55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgKEN54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:57:56 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41710C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 05:57:56 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u18so2401941lfd.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 05:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hI0UzcPlzM3Z+TT8BLCsTb4B4PaVfW/TF8pw2jZ+3SI=;
        b=rI4ESeXM81khgcgR6VhCZFZCkhrDyz3SIB12oAg7aevlhKQnfwxm9DRbitflnAvySF
         b1+dCx0m83TOzFMQGZwu7zNhPOmY3mmvUQhzRTdKxLNkVT7kcXUsbga9iaNUP94wqONn
         HcOpAPayUbys/sx7e+1QFzx1rG6ppvxwBQnsLb8WXkR0i+wuTc6bKp4xVgOzX+k4uMox
         gcQMpeuLqq5aD/5FfogyW5ppol6/4UXTiW39v/24AqNx2otBT+thZL6nOfGhJDC7YXLT
         6XF/Eu4jZQ0GCf4aMXgOyA6B19+xP20CWGHGAj6oyWL+z5BNUpKQK26HmLXEAsMDKFOp
         Z46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hI0UzcPlzM3Z+TT8BLCsTb4B4PaVfW/TF8pw2jZ+3SI=;
        b=aRVafxpKrnBHQD/qqKz573JtY9Tn9xuMyUhjTRgW6956GygiZnhF9yDSwmgReYbhc0
         BpNe4RzgdQwn/3vKLWgBejuyilZbM/Bj6RO1EPiabJmirH6oz1Y7Ek9JlFlRbsBOdtJr
         ds/oa9ssotcLwGr0KNi1CwpwDy+nnxr6u2I9OzjY8NhLQ0EY/6CePinReA9cf0h+BEF4
         mVfaFdqZAdtnCxM8EcFGlqK+SOaugvJFpBRrfkR2bx7U0bu7GQo18nDqnGdzBNghyt7w
         yYSAjpCcmLM+WE6Cs98I/4W2dlcxt6+5BGmVUtx55eMLABwxHQxM/aSzpuRFEbeWYb3b
         iDBw==
X-Gm-Message-State: AOAM5320gWj7o5LoNsEztW8Ig4ab8QCH59gQkniNzD0DHH1gOGF7tCt7
        GG4VeLrFkJVwEbiQ3ZN6Ic69lg0sVSBzVN0a5RQ/I0ZDnaanwQ==
X-Google-Smtp-Source: ABdhPJylKuZVTDjj0TM1vn3dfgBS2xLU+0Zy/JEB0e0mx8z3Xl+Cke+L0nZBl0FCSalSQ25Ca/7WB9cpgUs4vwTFDQg=
X-Received: by 2002:ac2:50c1:: with SMTP id h1mr983249lfm.333.1604584674765;
 Thu, 05 Nov 2020 05:57:54 -0800 (PST)
MIME-Version: 1.0
References: <20201028145117.1731876-1-geert+renesas@glider.be>
In-Reply-To: <20201028145117.1731876-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 14:57:44 +0100
Message-ID: <CACRpkdayhrcfyXEB4P+apjOyF=8DZgmu=_H8+aQEr4XEbB0NeQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Remove hole in pinctrl_gpio_range
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 3:51 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> On 64-bit platforms, pointer size and alignment are 64-bit, hence two
> 4-byte holes are present before the pins and gc members of the
> pinctrl_gpio_range structure.  Get rid of these holes by moving the
> pins pointer.
>
> This reduces kernel size of an arm64 Rockchip kernel by ca. 512 bytes.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Compile-tested only (arm/multi_v7_defconfig and arm64/defconfig).

Patch applied.

Do you think it'd be worth it to add a check to checkpatch to suggest
to move pointers toward the end of any struct?

Yours,
Linus Walleij
