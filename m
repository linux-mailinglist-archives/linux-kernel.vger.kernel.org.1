Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D0F2EBC32
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbhAFKOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbhAFKOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:14:19 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AEAC061358
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 02:13:28 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cw27so3907052edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 02:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u9+zWz1kXRm/cG2cWAgMkQ3WnJC2Q0wvNPxDG1IsJRY=;
        b=t0i1tE0VsgVWdosywvgtuPJTw8ZFzWEFB563jvDU1p+PQAzzjCn6kSbLa8DCY9lfVa
         MtX5wlfGKFEnx6zXlF5k02QFLgLFL/tvtous90FlA1Uxk1QgdvHg6PV+pJFwKwUKYWmf
         bWbPzkMJucAWMH3x2i499LokFG5k5nPFo6OWluYr/OPQJrLMPhbjXJPvJJgGaXK684f1
         Xt67vZNGlIb2zfnFuw5TdYTfsbBuUe/xTKmCKLtBISpqUmSxb119vfBEvCHpHFyLmKLJ
         lv/uqze5LePeLQG36N/wyzjqKkW4HKhCcL2tcxaUNJEi0AE5A2HeHeQmMbKzIbNoPsns
         j9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9+zWz1kXRm/cG2cWAgMkQ3WnJC2Q0wvNPxDG1IsJRY=;
        b=T4Qv8E93GQjpfBEoajMv2sPuJAOJoM1MnUQkH1TrHwEZtlRDcBZJVYvJVtxeVENJ7b
         KhwE7K1lqE/7ZPp68yxewusnhaWsX7E7b9EjxOTjNOMT+xGaXp1a2z1n8tPJOfrM24aW
         1adXgpoOnhIqEw0bHoEQT4Nc/w7u4TjOZxIY1rdkzo4JSMyk/w02fTBqfwxJGqWuZrss
         Y1+ARbWUgp6dfxpjOXmUCxv2R1FmFjOW6df6M3zAUUOy3+wLYwhmN2MWUdYk8D31saDd
         W2zUe5dD0mVZybZLdDpKnTyU+ax5X5/Yid5vAnBKVoUoYpLnwpZVa2yO6s0bbOYzhoCI
         4UwA==
X-Gm-Message-State: AOAM53175QaUEz1NdD23j5uPMWP1RMulAFZPwifBK5ZLintZTJAAwXhh
        SPFlNgkk5ZHwExS/0Ll+xT6yvDvwCYWRTpzZfX/AqQ==
X-Google-Smtp-Source: ABdhPJy9vQU5trn9/gA9F9gMhDlU7Llm1TbqOosLtrOozkoW63EjRjx7GOmQkTWN8hpszTJK2fWQ6766sBY+W/AT+kg=
X-Received: by 2002:aa7:cc15:: with SMTP id q21mr3484642edt.213.1609928007198;
 Wed, 06 Jan 2021 02:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20201217144338.3129140-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20201217144338.3129140-3-nobuhiro1.iwamatsu@toshiba.co.jp> <CACRpkdZeqqH_tev3USrC5BzX_w1rsjFQA=uGDZLPXZDG6jooKg@mail.gmail.com>
In-Reply-To: <CACRpkdZeqqH_tev3USrC5BzX_w1rsjFQA=uGDZLPXZDG6jooKg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 6 Jan 2021 11:13:16 +0100
Message-ID: <CAMpxmJUuby1ujg6WeO=4A483_GbyCSGL3aQ6m==oUFxSykQ+0w@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] gpio: visconti: Add Toshiba Visconti GPIO support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        yuji2.ishikawa@toshiba.co.jp,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 3:58 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Thu, Dec 17, 2020 at 6:45 AM Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> > Add the GPIO driver for Toshiba Visconti ARM SoCs.
> >
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Reviewed-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>
> This version is perfect!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Bartosz: this hits pinctrl but it's fine to merge to the GPIO tree, should
> not cause any problems.
>
> Yours,
> Linus Walleij

I would have seen this series before had I not been ignored by the author... :(

Bart
