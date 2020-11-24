Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950FB2C24EE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbgKXLsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:48:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbgKXLsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:48:23 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B91772076B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606218502;
        bh=VtHnWqVsQY2zwTyHbRZ7D1AiucgUkwK4eZw7+jkTLg0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uww3mbhqruJFZvzQnbcVTBG7t1nlVZxO3f7zSx2YtSpPudoHpYNfo4iWcXlH+pI2P
         +Fv/gkpwgs0q4QTO6vQtbQWzvu6L4HnhnclPxRBD2KTM8U8FZDpJIIjhEO+Eza6AOz
         TUhMp/8wpsmMr1q0TgkHBhRP/mhkS3JbWb/EkH44=
Received: by mail-oi1-f169.google.com with SMTP id f11so23487800oij.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 03:48:21 -0800 (PST)
X-Gm-Message-State: AOAM533FnE1i0tukQze9H5f5gH+vhSolRIkwDXnM7TNkAGMyTewpiCaI
        f32GQwrYcK4Y57c+xPaMm1wQHqhQYmdGCjbxiHs=
X-Google-Smtp-Source: ABdhPJwSp4pxmPIGdITj7ZDZBjRjeX/NL61DDQ8fxoOGOexZQp+xCRkq/kBgmjEO7xED4YszByT1oSwHtw1foy0sZxM=
X-Received: by 2002:aca:3c54:: with SMTP id j81mr2464381oia.11.1606218500976;
 Tue, 24 Nov 2020 03:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20201124103242.2971199-1-u.kleine-koenig@pengutronix.de> <20201124103242.2971199-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20201124103242.2971199-3-u.kleine-koenig@pengutronix.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 24 Nov 2020 12:48:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0xz8Yf37GVntdyP-npKJ5N7jKH16JdcYL-a214KsXaEg@mail.gmail.com>
Message-ID: <CAK8P3a0xz8Yf37GVntdyP-npKJ5N7jKH16JdcYL-a214KsXaEg@mail.gmail.com>
Subject: Re: [PATCH 3/4] amba: Make the remove callback return void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:32 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Most amba drivers return 0 in their remove callback. Together with the
> driver core ignoring the return value anyhow, it doesn't make sense to
> return a value here.
>
> So add a warning to the only driver that could return an error code and
> change the remove prototype to return void, which makes it explicit that
> returning an error value doesn't work as expected. This simplifies changi=
ng
> the core remove callback to return void, too.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Makes sense, I checked that the vfio driver cannot actually return an error
either, the 'if (vdev)' check seems to be done out of unnecessary caution,
as the probe would never have succeeded if that was NULL.

         Arnd
