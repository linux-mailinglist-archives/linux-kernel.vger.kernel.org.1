Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AED2C8F13
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbgK3UXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388456AbgK3UXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:23:39 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F924C0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:22:53 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id v8so7051539vso.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 12:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/k+0vCI3Qz/KltzmyAOJLa3Er+O9wE4JtonfQieS+Dg=;
        b=o9Zl9XSyr5L5adD18Ck8oNJWbETsgBANou+YMAsPFXM3ibRkru80KOn8/yjcnm/Dfz
         R3N7clFcHS80CyQ8VZPCGl0xhEstbdGD2ePI24arGHzZdg6l/uQRwtXeHUZnj97RD1EK
         YCozm7TSLp/YskkZfajWRXxUBn80Mm3kQka+FtYYU34eZr5yn2i3fDaOiQL4D4wv8v75
         Sm/xUacrLYw+ZXgXbyAjCrHTU3cDaZaM2UgbcY4HMS7IAcv0usFxlJtRztcKi3bQ8E62
         2l5H8fleugIsGuTJ1Ij2qLOVKW8vK1c1VjityD2xfq1IGdkt4L7cyU5Bwr4p5sXDbQl7
         K3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/k+0vCI3Qz/KltzmyAOJLa3Er+O9wE4JtonfQieS+Dg=;
        b=jXy0Ri3PbN46bhcH25cfu0Ie1FUHK1szLUAxL7Ki8KJwsc30KC336lY09tUc5W8kJE
         ZHcllbKkMHSvpEjyiX57jG/gwFK5BZHLCPIr2oBBczA+6/9WjKQfkIoXlNbv2F2iMzC7
         olsl296zB1EBeM8pJ9be97BuHkO5i45kYKjMvuKYTGyD7ATqh3Y1Ft4RfG6xZNU7dsVB
         y0256DlyqomjAoAuUOzosKFYF38w0IYLbLkC6Ymk5BBRfVnEcb04dxB0T/2wmuuoWD77
         uSTUIn3Hqbu3dYru5KRNqRoSHh5RNTv6YUou8hwTNvE0xSFR1pL7w0BHagkbOxYPDmpq
         f3ZQ==
X-Gm-Message-State: AOAM531ZiJc8Ez+6Xcd8Su+p6a+oZgDhsinOprzCVJG33Eiosvo2vqB3
        OIJB/7yclMNDL0b64CGkgtgz20RLV9YxX2YTGkvn+5BoYmk=
X-Google-Smtp-Source: ABdhPJxRORMmIhsWDm/7V6DPcp4Hkingn2xcOq1pgRmTJebDQzS3wwj/Ny6Ei/YyJdQygfRuSmLkRIsnvD8FHE5aiDE=
X-Received: by 2002:a67:e43:: with SMTP id 64mr6092506vso.40.1606767772156;
 Mon, 30 Nov 2020 12:22:52 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
In-Reply-To: <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 30 Nov 2020 15:22:41 -0500
Message-ID: <CAGngYiUuihD5yK9tD6kvetrmwbTcC-cwoYASc5N5P2tct3B2DA@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And probably also:

@@ -226,8 +226,7 @@ static int spi_gpio_setup(struct spi_device *spi)
        if (spi_gpio->cs_gpios) {
                cs = spi_gpio->cs_gpios[spi->chip_select];
                if (!spi->controller_state && cs)
-                       status = gpiod_direction_output(cs,
-                                                 !(spi->mode & SPI_CS_HIGH));
+                       status = gpiod_direction_output(cs, false);
        }

        if (!status)
