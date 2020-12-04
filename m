Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4392CE63A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgLDC5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgLDC5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:57:45 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1DCC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 18:56:18 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id t8so4310699iov.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 18:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isfeZ3kfKrYZjXvIfFGvKabQ5iROwvaOtPW6IFcmmAs=;
        b=qX3Q4DkRG4IPc+DXuwx7/KQaCd5Nwuqfesx4SdKjhFwC4QymWb8VnQb6HO3gnDaWw0
         Xhh5RWi9G/5bzChEsQrukG8vcxujHoPG49w+0qhEYXgUxLb3tQfFJ6bCQ12FzUQ3Sibf
         4Vdjl48BpJGw2nV4VVdl+FVlReXKpHE3j82G0VNTw+hSfbFqtmfeQbDRJBmxaBVdmdBf
         akQ7m/3uQUVxY+EFvU4qy3Mn7QQaimgixdFoFy0ztsCG/sl6VNBPFwwk2RI1+moNT9fT
         zhocNE6DFpWeMR9LEbmUSQEo6e2PhzeomPDM0qmQ2QKNckOFoc97OZE2Uuwx/IMadF1W
         +L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isfeZ3kfKrYZjXvIfFGvKabQ5iROwvaOtPW6IFcmmAs=;
        b=e575R1CzpfWV/oGK9mR+esR6J9d59m947XxdeTHa9DJG+Qds5IR7rbl3w8t3lZH7Do
         U03VSVpGsUGv/HFWvZvgeZfO+VXJHkDac4QjrI7zZqr8wPEIgmN23Nniz65XkSWkHq2E
         Rd2HW1S4AiUOpp/rkdgdrUiycCbh/2F8vabV1V6JyPhMS/6EIg2xoQm02zwdt4lRRgJe
         TSvsHwwrtYOINuGRx4GEW9aYH8OWWLmsjArx8inf8wXzRz5BUdCyEBl/9wyiyYVygqof
         GXRGxMQoGNGTlV7KuumYVMwyNfcpsUoeT3kiKGp0zzgaWj8r1HcCE/8UXBIlg/RYxlN1
         7ACA==
X-Gm-Message-State: AOAM531oKX3UnD4TRJZryy6GCvhRCLUXQbpEAChk/RWzR0GyUp7JBQM4
        PxeoDzuFcK4Lo8jVnqe1pzS/2zosmURvOkA/o6F68w==
X-Google-Smtp-Source: ABdhPJxTr4JbkKHUEG1/9DIqVju9MZyNFzKYSjbwMrnw7cRRwoFQFlLrKA+Mn/8qkobkdeHunXJNXanaye0EQP+iUIo=
X-Received: by 2002:a02:c804:: with SMTP id p4mr3166234jao.110.1607050577866;
 Thu, 03 Dec 2020 18:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20201203225458.1477830-1-arnd@kernel.org>
In-Reply-To: <20201203225458.1477830-1-arnd@kernel.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 4 Dec 2020 10:56:06 +0800
Message-ID: <CA+Px+wWmJrS46TzWgKWiufJH7ryB+mOH7H4xfGZex2j=NutfLA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: cros_ec_codec: fix uninitialized memory read
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <groeck@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 6:55 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc points out a memory area that is copied to a device
> but not initialized:
>
> sound/soc/codecs/cros_ec_codec.c: In function 'i2s_rx_event':
> arch/x86/include/asm/string_32.h:83:20: error: '*((void *)&p+4)' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    83 |   *((int *)to + 1) = *((int *)from + 1);
>
> Initialize all the unused fields to zero.
>
> Fixes: 727f1c71c780 ("ASoC: cros_ec_codec: refactor I2S RX")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tzung-Bi Shih <tzungbi@google.com>

In the case in i2s_rx_event(), only the "cmd" member is used.  But it
is fine to please the compiler.

struct __ec_align4 ec_param_ec_codec_i2s_rx {
        uint8_t cmd; /* enum ec_codec_i2s_rx_subcmd */
        uint8_t reserved[3];

        union {
            ...
        };
};

I am a bit curious about, in other use cases of
ec_param_ec_codec_i2s_rx, why the compiler doesn't complain about
uninitialization of the "reserved" member?
