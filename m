Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A312EBD92
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbhAFMTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFMTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:19:02 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7A9C06134C;
        Wed,  6 Jan 2021 04:18:21 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id b64so2602512ybg.7;
        Wed, 06 Jan 2021 04:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sibBVeHh74LvnWJQWkr84prRZRQ5lM50m6HP/J9pKiY=;
        b=KhztQhG4Nw7ZbO7tJMAfzwm1ExZQw469ltCblmy7LoNG4quSzF8HQWkChopnAnI2Ws
         dbehynM1IWD2+e/aI7oytdLa6rUemkXUHsNVQ+ndCRhTkwTg258e5ZY4g6MeVchmUYjo
         +2bWsrzeK3AOOMDIttoGqc8M5nRZG/aQrVAp8tTmcqVDt4n6AiQQRHSPMvyriOjx49H5
         mis5Sc95K31ReV/LOkYR/eC/UhDC6zG/js1GkT/5OpMoSXDuZ+JPCtU3aul7qc/4bIrs
         mBQOrmmliDwBzx77Zim+FuGXDt/soWS0mdru7mufQ+gVIHASC34Dqm5971QMOYRfpmp+
         vgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sibBVeHh74LvnWJQWkr84prRZRQ5lM50m6HP/J9pKiY=;
        b=nBLuFjtV9JRQ1PXxTfNOt2jX4qRFrpRvziGwJSa9lO4qq/eQ0UBFlL3oZEyt3BCfAu
         UOn6+al9LbQg6qKHLyFiHVwi8gDGYvjh0G8Z5N7hdEnYnYHYNKVpAyQA9Yzd7VyuW6jd
         YPMLg1s9ntxj5baoy2M/+GA6tx3LWqzNW0WHmFUjX6ORAtzNLWf6sfJEc9azArybmOM8
         gSjt9/pmN+eRBfvzuOdq9I1i8E1b2YLxTahCPgKZkbqs2qtuzOrfHkfMdgmMOklA3qby
         e/e6Q8OGJjLXubOlK4MWhxpMxp6ZYm1kSzXHr8O8Q6hp1dwOLyHVs0jSuKqOq8sPaIfj
         CL9w==
X-Gm-Message-State: AOAM533Z1D/wzaYJlOzHHWdI+lUZLl+frGXDsdTZyghMEf2OWhSPY0Xj
        rJVDtjYKTz3kQjIpgrxhqEwYSiXwuVdwLTgp0L0=
X-Google-Smtp-Source: ABdhPJxohbKqIczN3BU2r1zAqdfbYZ93Wieh7wKBxVTLL8CiYv9sWV++mc9FkIMyWkLlOwiT5XgRNSN9tY2CVEQSaVk=
X-Received: by 2002:a25:40d:: with SMTP id 13mr5919517ybe.422.1609935501381;
 Wed, 06 Jan 2021 04:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20210106113730.k5qveshjgcd57kgx@runtux.com> <20210106113929.fizyg6fcsmsntkiy@runtux.com>
In-Reply-To: <20210106113929.fizyg6fcsmsntkiy@runtux.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Jan 2021 13:18:10 +0100
Message-ID: <CANiq72=Cfv=Qo2fs+HDjUc8pV37mL326SDS5JpGotUfHLwK_rQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] auxdisplay: Add I2C gpio expander example
To:     Ralf Schlatterbeck <rsc@runtux.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 12:39 PM Ralf Schlatterbeck <rsc@runtux.com> wrote:
>
> The hd44780 displays are often used with pcf8574 based I/O expanders.
> Add example to documentation.
>
> Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>

Since Geert suggested it, it is customary to write Suggested-by: Geert
Uytterhoeven <geert@linux-m68k.org> above your signature.

Rob, if you are taking this on your tree:

    Acked-by: Miguel Ojeda <ojeda@kernel.org>

Otherwise, I will pick it up.

Cheers,
Miguel
