Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C002D9490
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439520AbgLNJGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbgLNJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:06:29 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943ADC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:05:43 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id m12so28274399lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 01:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlI9U60AKYvHmp1KTQQI7KZ4Z29ya5uqZmgc/j6JRTE=;
        b=h3fiWphSR0lVOgqH6WdAdQtJZ40tiZCSm5Di3QByutSYJGNMywEzwUnohVCyJhty8z
         wSZ0kn65jI+r0g/vrSNs7lDZ6dPyMgxCaElGmU2CemEgWe6dravniuZwBsfJAShR7Pik
         DDGaGCF7X4o1hyQ9KtnCg/aT6rUDgmfYOzxXQ6bwWfSYkpxDwT+Lv6wfsaPKsLxeSORU
         IqJl+yhX5+HcV/n6HerWXTXeGJkDgKB6CiY3GnWFPEAJaA0uwmL35GJVi2I64v5K6uZ5
         zUfz2a8ue3hHLGHxD3YDtWZbzv+r1zlMQq9KZU4F7QYSZ+9K68jE4oC48eQRTHaRVdNc
         kO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlI9U60AKYvHmp1KTQQI7KZ4Z29ya5uqZmgc/j6JRTE=;
        b=KDqOmokzBgFRTvEJx0uk4o45OCcIptA09dm3mWR5sHCEvL8YXTZP3v1y5Z++5t7AQb
         HDj/BNeYac3/Ahcr4W13PtMpfRkMN93YSf4S/oT/h1yC4OvXPENK5851MEKfN/ePPhZO
         /3UHpcJTBtmBDf7sRiX5NV4MDBZeJ3glwfo5KW8LSU3kszb0S8tFgYi7j4jBa07cdeET
         3p/8E0Fp4byreMSdhbPishbSgQHIv1pwApdZungkd3eLNM4pf33YztnwRcoOs7ErrcM5
         D5bx8LJYAEDHQny8KftCl2JZXwkcBG67N6SUPOoPn6JrnVJCOjbVcH+D/9AEp+1jc5R5
         dYGw==
X-Gm-Message-State: AOAM532GO9Mte7QMdrzSbR/DFkAVCysIKd5JfkpVEGcIwYpDHglhAZp4
        DgGkPG12TV7bQOTfHQslQc8SW4/6i4dotcpy4gIMyw==
X-Google-Smtp-Source: ABdhPJxuC/HiXB5oQUYbXNmWik41MANQkc3dmRGLlJ/1P78W9vH8K3bGYA5XhkXv7tKmvig37Xav+8I0M4VtDiE+zNc=
X-Received: by 2002:a05:651c:1312:: with SMTP id u18mr9187933lja.200.1607936741984;
 Mon, 14 Dec 2020 01:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20201213235447.138271-1-paul@crapouillou.net>
In-Reply-To: <20201213235447.138271-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Dec 2020 10:05:30 +0100
Message-ID: <CACRpkdYautJ+aNrK+gqmAUzVCOgQH-WuXqEOn4FyW1hfeWa2zg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kconfig.h: Add IF_ENABLED() macro
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Arnd Bergmann <arnd@kernel.org>, od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 12:54 AM Paul Cercueil <paul@crapouillou.net> wrote:

> IF_ENABLED(CONFIG_FOO, ptr) evaluates to (ptr) if CONFIG_FOO is set to 'y'
> or 'm', NULL otherwise. The (ptr) argument must be a pointer.
>
> The IF_ENABLED() macro can be very useful to help GCC drop dead code.

I can apply this with the other patch to the pinctrl subsystem if Arnd or
someone else who is good at KConfig provides an ACK.

Yours,
Linus Walleij
