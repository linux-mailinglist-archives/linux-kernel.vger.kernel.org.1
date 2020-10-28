Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1488C29D9A9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389927AbgJ1XAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389628AbgJ1W7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:59:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255C0C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:59:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id p15so1008804ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xtVwlvaWZlHA4dJxYE3dokSjDugC3i0v20/tqR9kT28=;
        b=SKr2/Rrs/9HilxCVQka/YluN5gEkovGrqH85JG+SIy7DEWcMB+9pMO8WzdbzNhh3fJ
         c2pl8xFwM0GZcJ+KeY7CIvJmk3tgZ6dR2Ea10UzUhPTDrk7HYZPs492Nku9mMLVztjug
         0J1wtBL8VjVDvR9zrj+yuJw0pQuDi1B+XVJx9tlsJnD1D6lPx6aB85tobmyJ2otLjigo
         6yywpf6AtsbzlwjR4MdvyUXmynw5e6ofLc1/HtUaqvj1RwM70JQmYwXiPuASmW8QpvJd
         ZF3Dz5z3IP/MTBufdZwGJIH1ahgc4Uw5ev/jPNJChNJb6B6E7UACIoRKDqUMCYka3X4G
         gfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xtVwlvaWZlHA4dJxYE3dokSjDugC3i0v20/tqR9kT28=;
        b=I/KR/45QvXaYZbn1qlBOe0wNAYnSpCm8OrwLORTS6s9dji1HiES0myBS+/odWubRFX
         Sqg3cvVPZuUDrzDaMcIptm9qtPNJ29pg8FKmM4PiH4C/p1G0mfzCwo52Gz5GA3YlElyF
         0fgQPgl8pqZMqGt6bQJQYdvS8Bb9FZf+tUc/+DFSzVcZWGMtUWdarSh1gcmPp4LkUyrb
         FWNcsQD+HT84DekGQSEiz1Z0nQ/wMHTBghOak2igyrgYIU9XNCatP1znPxFLOLm4uZhG
         dt8Tz1pnvWgZpjKygoJI0DFsklQrS7FBbj3Z9VFrwFRi7toTcyYHdQQf9yPDZrwOd6Eb
         x4sw==
X-Gm-Message-State: AOAM530ETucp6Ymru9Z6xn+QnyIG4bnNWF+e7ogFGYhqP0NPo2zTAxy5
        pMg16AnFrcC371Q99lNBj7sMyq+7UfPc/Q30w4D4n1WB+WgA5w==
X-Google-Smtp-Source: ABdhPJx4logLjoFSvgZOZ7Au5M8nTXfH107v3sJvAOIOntuPqNy1JKkOGxGQcSTQ0MdSQaGiDVoz/fOzuqn8h557lh0=
X-Received: by 2002:a2e:a547:: with SMTP id e7mr3805831ljn.283.1603900516691;
 Wed, 28 Oct 2020 08:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201013063731.3618-1-jay.xu@rock-chips.com> <34840448.7XeAIBGaoL@diego>
In-Reply-To: <34840448.7XeAIBGaoL@diego>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Oct 2020 16:55:06 +0100
Message-ID: <CACRpkdY8kRVJptQxCQNzbumjj-H+t-atJdguF39stukmiTfYyA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] rockchip-pinctrl fixes
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Jianqun Xu <jay.xu@rock-chips.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 10:22 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:

> > Jianqun Xu (3):
> >   pinctrl: rockchip: make driver be tristate module
> >   pinctrl: rockchip: enable gpio pclk for rockchip_gpio_to_irq
> >   pinctrl: rockchip: create irq mapping in gpio_to_irq
>
> looks good to go as fixes.

I record that as Acked-by :)

Yours,
Linus Walleij
