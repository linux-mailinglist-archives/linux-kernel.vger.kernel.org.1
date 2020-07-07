Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B0F216C61
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 13:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgGGL7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 07:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgGGL7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:59:05 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BCFC08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:59:05 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id s16so19074552lfp.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HTPmD5Tv5dUMriTVMEYPSE4aq44oEkYldNJx6iUd92U=;
        b=HKDcobdwR59Fn4UPxGHRQ0tpAtbpLCJNsZlPMJ/sOiZyRbiNswsgF9jOe/BAk8id8l
         /5EDjFn+j7IrqQI7DBI2n7Uq2bBWEf1LX5BO0SlioDHGovjRN/+aYEtpFSj1onhKowwd
         Jyzt+IOCjBFb2xLwG5Ql2hJk4eWSyQElpoG1w08NxiRQ4BjeE4juggLuIqQZrxnUm4AW
         wxJ5rCZerV2AejOoEFy2/ofH5gJdnEUHklmMBmyEWjepQYIJFNJR4M9pxxd22+ChBxqi
         z7Y0JHiZJBtFRhUTWf6BA4ruLd/6iHkPnoKgZc0WXt+PJk9Ns+TyOPs2bDd4yFIVnyF9
         qKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HTPmD5Tv5dUMriTVMEYPSE4aq44oEkYldNJx6iUd92U=;
        b=Bjj5V8ZOY3IdpwD4UBMDaXKKr5UTNaPjiNlAq36hu0XWowopF5BW7smCoQN81JxD1f
         c/R3PskuLqQxo/ltrCC3EhRERQv8oxZnrBCzXMtgkF7FlLd1H/AX8gEUmV06Il5ICuX9
         hSw/kid5sFbI6JsMT3zdArAtMdIg2YvjfiVbN36x/IiQYFNTu1bClGBh6d/0Sfi38SAH
         1jcOjAotmaisoGu33SZtsKAja7HyF1+i9DgoasdYX/ECGqesiXca7oqKlF+qO7d446Nf
         Pf9d9WGR/sfFwCMqi9D1Oh7YmgcgLj/HZ56WezYRm4tpr5vorgRPCq1GlRYpNBpXpxYF
         uADQ==
X-Gm-Message-State: AOAM530LYoSm+Mftq7cvuXAYLUyRPBJUuWraN1mJhP0/82p/Eki8fzxX
        zqF20Ink0wdkNbGYwMIg0s0ZXUY5nENrcpGiqOWmlMNwq9E=
X-Google-Smtp-Source: ABdhPJy0TxaIe1Wz0GdlFd5FdxpVp2FOvGGrBFkEn0oi3CjP4qg2V304qTt6rBtZAznq91V/ed9yiUW+UN8gJyowQaY=
X-Received: by 2002:a19:e05d:: with SMTP id g29mr32404950lfj.217.1594123143709;
 Tue, 07 Jul 2020 04:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200615133242.24911-1-lars.povlsen@microchip.com> <20200615133242.24911-6-lars.povlsen@microchip.com>
In-Reply-To: <20200615133242.24911-6-lars.povlsen@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 13:58:52 +0200
Message-ID: <CACRpkdaSVRg3F5FLKi=sGCFQDXXkiz2e1pT3H9dcoaPDSYKrXQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] pinctrl: ocelot: Add Sparx5 SoC support
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Olof Johansson <olof@lixom.net>,
        Michael Turquette <mturquette@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 3:33 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:

> This add support for Sparx5 pinctrl, using the ocelot drives as
> basis. It adds pinconfig support as well, as supported by the
> platform.
>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>

This one patch applied to the pinctrl tree.

Yours,
Linus Walleij
