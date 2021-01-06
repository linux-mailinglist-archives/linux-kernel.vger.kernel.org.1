Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0792EB832
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 03:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbhAFCnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 21:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbhAFCnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 21:43:14 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E219C061349
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 18:42:34 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id y4so1515950ybn.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 18:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hp8FK0aaIXaj59Xn0ABAjEAnnlCb8uBQEGP2gxsNET4=;
        b=A1sEx4U8uRgu0F0y/7IXlaUvelJL4fXb6pvv0570vH84rPOp3kXB7WVTsAwqv5mSUF
         nz0MKMX4NRRNjxH/+ayW3xnY1N2lI+JGnV+H4SLZACGLKwt8JWHxh2yv6YzxFEDrldgX
         Gt0TQHgBOt7/0rpu2oag/H5soVc+XxF8VcJt3zAn8faLVM76Uf5bFlwxUJBwvDtoPFfW
         7Dj43YnXPm8/PfwRL0u9Lviyaa1QpqZbhAMuvY4vbKARMgYzYGa1oDWaY+WoZgGnlXrl
         11NwF5lBVXMBYtnC5FKqSUify6XjO0yRVrmC2BGxtf1e7R6XRXYtFzhhetvrWi+BtZUg
         KUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hp8FK0aaIXaj59Xn0ABAjEAnnlCb8uBQEGP2gxsNET4=;
        b=jB3t4Xjh1PR7wyyrjcgt92nToNWKLQhXFcFTwtzo9u3jLHKTcY8l+55R5gim442874
         kXILvmL2T1NT/FT5R4W6HkUI7mU/eAnLBGby15r9ku7H5mtubsLmrMS646ndCnRi/fe5
         TqiwL4fhBEfdJfXHNqDq2FrUOfaOFyNoxorRrtD5moYhvg722JXQxrxU7DYavliA+nmT
         zA0M9yo7g2oDwnhEYoVOfMSpdXXyKaIvz32PUsbO/+W+ka1dkIQox08Gx0MS5hrd36ha
         juCshNz+2BKMj6M3y02dQ/oIVoJKbv+KmIjV939vZzntqcV7cd/JAS1rB7V//iuODAln
         6HQg==
X-Gm-Message-State: AOAM531q9Bh3zDU0UU6o+tD1iNqwTb+PtCVpDvmnoYrz9WnNHZXLK1L1
        IBjeOSK5UayPuqzXVk1RvZGGjNOQmOlliAV43po=
X-Google-Smtp-Source: ABdhPJwOnvf4w7OiFw4QDAO37ODMM1A+AZmUFbVBaJmrz5NaVa2vZHXi6sVzOeXKe4cJgrNa3tBxjQtKkYnJhGVJwtI=
X-Received: by 2002:a5b:949:: with SMTP id x9mr3655801ybq.33.1609900953303;
 Tue, 05 Jan 2021 18:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20210105150124.dvlochv3qrp4wpre@runtux.com> <20210105150400.j7hhxu5uextga5mz@runtux.com>
In-Reply-To: <20210105150400.j7hhxu5uextga5mz@runtux.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Jan 2021 03:42:22 +0100
Message-ID: <CANiq72mYUVvyJuv6pxeYvzQrOyRvp4Uy8AxF_WMDgQaKBndi-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] auxdisplay: HD44780 connected to I2C via PCF8574
To:     Ralf Schlatterbeck <rsc@runtux.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

On Tue, Jan 5, 2021 at 4:04 PM Ralf Schlatterbeck <rsc@runtux.com> wrote:
>
> Add HD44780 character display connected via I2C I/O expander.
> Re-uses the high-level interface of the existing HD44780 driver.
>
> Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>

Thanks for the driver! See a first quick review below.

Also, Cc'ing others related to hd44780/charlcd that may be interested
(there is another patch in the series, too).

> +config HD44780_PCF8574
> +       tristate "HD44780 Character LCD support, I2C-connection"

There is no hyphen in the "parallel connection" one, perhaps remove it?

> +#define DEBUG

Spurious line from development?

> +/*
> + * The display uses 4-bit mode (the I/O expander has only 8 bits)
> + * The control signals RS, R/W, E are on three bits and on many displays
> + * the backlight is on bit 3. The upper 4 bits are data.
> + */
> +#define HD44780_RS_SHIFT       0
> +#define HD44780_RW_SHIFT       1
> +#define HD44780_E_SHIFT                2
> +#define HD44780_BACKLIGHT_SHIFT        3

These are always used in BIT() from a quick look, so perhaps you can
directly define the bits themselves instead.

> +struct hd44780 {
> +       const struct i2c_client *i2c_client;
> +       int backlight;
> +};

Even though the struct is internal to the driver, I'd avoid calling it
the same as the one in hd44780.c. I guess hd44780_pcf8574 would be
best, following the name of the file and the CONFIG_ option.

Same for the #define names, the functions' names, etc.

> +static void hd44780_backlight(struct charlcd *lcd, int on)
> +{
> +       struct hd44780 *hd = lcd->drvdata;
> +       u8 b = BIT(HD44780_RW_SHIFT); /* Read-bit */
> +
> +       hd->backlight = on;

Newline here. In general, please add newlines to try to separate
blocks of related code, similar to paragraphs in text. (I will give
some examples below).

> +       (void)i2c_master_send(hd->i2c_client, &b, 1);

I wonder if we should make charlcd_ops' backlight return an int rather
than void, so that we can properly return the error here (similarly in
lcd2s etc.), even if we ignore it so far in charlcd.c... Thoughts Lars
et. al.?

> +static int hd44780_send_nibble(struct hd44780 *hd, u8 outbyte)
> +{
> +       const struct i2c_client *i2c_client = hd->i2c_client;
> +       u8 backlight = hd->backlight ? BIT(HD44780_BACKLIGHT_SHIFT) : 0;

const?

> +       u8 b = outbyte;
> +       int err;

Newline.

> +       /*
> +        * Transfers first send the output byte with the E-bit 0
> +        * Then the spec says to wait for 20us, then we set the E-bit to 1
> +        * and wait for 40us, then reset the E-bit again.
> +        * A max-speed (400kbit/s) I2C transfer for a single byte will
> +        * already take 25us. So the first delay of 20us can be skipped.
> +        * The second delay becomes 40us - 25us = 15us.
> +        */
> +       b = (outbyte & ~BIT(HD44780_E_SHIFT)) | backlight;
> +       dev_dbg(&i2c_client->dev, "I2C send: 0x%x", b);
> +       err = i2c_master_send(i2c_client, &b, 1);
> +       if (err < 0)
> +               goto errout;

Newline (same for the others).

> +       b = (outbyte |  BIT(HD44780_E_SHIFT)) | backlight;
> +       dev_dbg(&i2c_client->dev, "I2C send: 0x%x", b);
> +       err = i2c_master_send(i2c_client, &b, 1);
> +       if (err < 0)
> +               goto errout;
> +       udelay(15);
> +       b = (outbyte & ~BIT(HD44780_E_SHIFT)) | backlight;
> +       dev_dbg(&i2c_client->dev, "I2C send: 0x%x", b);
> +       err = i2c_master_send(i2c_client, &b, 1);
> +       if (err < 0)
> +               goto errout;
> +       return 0;

Newline.

> +errout:
> +       dev_err(&i2c_client->dev, "Error sending to display: %d", err);
> +       return err;
> +}
> +
> +static void hd44780_write_cmd_raw_nibble(struct charlcd *lcd, int cmd)
> +{
> +       struct hd44780 *hd = lcd->drvdata;
> +
> +       (void)hd44780_send_nibble(hd, (cmd & 0x0F) << 4);

Similarly, should we make hd44780_write_cmd_raw_nibble(),
hd44780_write_data() etc. return the error, even if ignored later on?

> +       ret = hd44780_send_nibble(hd, (cmd & 0xF0));

No parenthesis needed in the argument (I guess you wrote them for
consistency with the other send*()s, but they are far apart).

> +       if (ret)
> +               return;
> +       ret = hd44780_send_nibble(hd, (cmd << 4));

Ditto.

> +       if (ret)
> +               return;

Newline.

> +static int hd44780_i2c_remove(struct i2c_client *client)
> +{
> +       struct charlcd *lcd = i2c_get_clientdata(client);
> +
> +       charlcd_unregister(lcd);

charlcd_unregister() may fail (it doesn't right now in any path, but
it returns an int, so it should be checked and returned if so).

Cheers,
Miguel
