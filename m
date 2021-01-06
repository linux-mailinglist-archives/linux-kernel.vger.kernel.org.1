Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D572EBD87
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbhAFMNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFMNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:13:19 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C9FC06134C;
        Wed,  6 Jan 2021 04:12:39 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id f6so2547862ybq.13;
        Wed, 06 Jan 2021 04:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbmnpdtDMofYt9r9PreFEY+jECTRLDnRGKyuIas7p/U=;
        b=vQVMe4amxBe4sHm26L0WZFx8mDPo8zrOczpKhC1CSm/mYNkqOGqltMXFrEigDKfURG
         HItAnVB/gFV3jRcbg83Nc3wbvrL+GlAY9sZ3wYtga5Av6YsmZQE3DurYcleziZQ6PQ8h
         +HwzpCbP4x8lL7VkIc3Et5KqROwuQBoPyjsJVJKwtbnC6ahvJS8EwMlXqngH1xe+qafb
         hKiyOo9olaQxi2Fv5/ZKKeT0u1LhucTaPnAFsiSlHnYI1JTr0XcKx1HlIK8fQQSRcQ6m
         3581kDKGWADFkWEe6cDL2bhYqX9bqxU/HbNYT0I8WVru5idDW3i3mOLwpZFHCVm2jq/n
         Zr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbmnpdtDMofYt9r9PreFEY+jECTRLDnRGKyuIas7p/U=;
        b=Lc4GGNBGyROaaATF6NafNKs1nDbm7AHoGt/SQmD9/X652ejt5xP7hGiNblQe0OgaQ4
         IuyeymJHlh3Ng8Ww/8bocF/MBrfCwfrW0YlIDL8vsPcC6RF6305SDDTWt+TAnX/wkbwN
         L1i7eO6+o9+ezGkrKOyaVNDen6f1Px7C2kVffmNwOOXczhDJaUNJZG+YSj6pa5KzPHit
         BI7/B/9KVgOR+Quag9G/al6SaSPOIqyLEZfEahHjrSLlcw6EYeM+n4+7VSvwN0MtpUfO
         0IvCd78KKPf/LB2MgCbFqOKrnLtwJhDbDxVuWML7dwVzOBtUJQFWEzSRfUedb9/piTfV
         ZD1g==
X-Gm-Message-State: AOAM5331EZYg0FZbW6GqC2cm0HJr0xlJfrsIYW0hAHZhoa5pZEYTskdo
        VxiasVAakE7BoYuUx7juRzTGdz71nBSI9PCaHs4=
X-Google-Smtp-Source: ABdhPJyTPWduArhwO9IMGYwEaU3otOQlBQlMn9onmfFN6egdEBR/v4nIQ6FASgODPy5qHwA541JSk498BCrUuV0c4co=
X-Received: by 2002:a25:538a:: with SMTP id h132mr5393839ybb.247.1609935158689;
 Wed, 06 Jan 2021 04:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20210106113730.k5qveshjgcd57kgx@runtux.com>
In-Reply-To: <20210106113730.k5qveshjgcd57kgx@runtux.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Jan 2021 13:12:28 +0100
Message-ID: <CANiq72nTkw_6-5u4V8c9ZSGxjCSTZ1cM26xtJjZHrgJKCxcQ0w@mail.gmail.com>
Subject: Re: [PATCH 0/1] auxdisplay: Add I2C gpio expander example
To:     Ralf Schlatterbeck <rsc@runtux.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 12:37 PM Ralf Schlatterbeck <rsc@runtux.com> wrote:
>
> The Hitachi HD44780 is often used together with a PCF8574 based I2C
> I/O expander. It was non-obvious to me that the existing parallel
> connected version of the auxdisplay driver can already handle this
> configuration with appropriate device tree magic. This patch documents
> the necessary incantations in an example.
>
> That this is not only non-obvious to me is documented by at least two
> I2C kernel implementations for the display out there.
>
> Thanks to Geert Uytterhoeven for pointing out how this is done.
> Thanks to Miguel Ojeda for extensively commenting on my previous patch.

You're welcome!

A couple tips:
  - Normally, you will want to use scripts/get_maintainer.pl to know
to whom send a given change. In this case, I am Cc'ing Rob, Geert and
the devicetree mailing list which were missing.
  - Also, for single patches, typically you would want to send the
patch without a cover letter. If you want to put comments that
shouldn't go into the commit, you can write them just below the "---"
line.

Thank you for contributing to the kernel and welcome!

Cheers,
Miguel
