Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA8C2B71D4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgKQWw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgKQWw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:52:27 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DDFC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:52:27 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id y17so26110900ejh.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVx7xlf34yZjkIMHRK5xAOJxJV8VtpY0oFLpdYwDAbc=;
        b=rzj4Q4IS6djGDkjbkMzeQDOTPA6a5zaVcvU0h6YZjLWf7NAeRVqZue5yUITLhaD8b1
         y/5AApCH2vauExvY5ERDzXkk5+IkhI0HudIZDStzt8/bK1bvk7BAc3d7FvKgJCr8Zbwa
         0vrhc9rJXkuOdzx1eT+aDoApQlUA90sQER5T8zNuPlydg99Rv7JpuK1WVLmn/FlbO4No
         Sqbay0z2Tng0iCTNv0jugHs7oHlsH5LrAAG6QnLENCYSkZL95D6Ld/y/JFxh/MKbY0iy
         Iq/Ndydt22GuTEHwAU7qOqo9R7aSAz1l3rmVbiw2bynSK1t8VhuYlxc17IpKRklbp052
         iQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVx7xlf34yZjkIMHRK5xAOJxJV8VtpY0oFLpdYwDAbc=;
        b=SlPzoLRnIqHQyq33kRTuvUjroAN56txdykFaZjDKVfC7wRMAO/107PSpuD5y+lVfcZ
         ZW1V+vI9GTSEnaaxKKljYnsXSImu7bS4IqnDq0l3vGTuofwLQ9VYnfD9kWGzVkrrWmiZ
         d3dQG3lB9gCNHM1vyrEA6xht0oucezICVVQfWK4HMxrkcbq9aKUJjqR9ZWZQLchsSZTx
         ZqHG5gMQ3SlFhGwLbM2BOeC61mANCeZD1Uq5OP/v0XwoGevvPFY8wiO0cITFe1c81U2Y
         pgI8nmP0Kspcdo/mNhWDzEXNge7yMJHHYSkkWgCEM6M8Zkb1Djsm5igJFfvsJ9dtLsYw
         a90A==
X-Gm-Message-State: AOAM531CNPApKSAe5hiRJF0yUDfb3Rk+RvU1oYkOrG7zL6zE9pmnS/vd
        MpGmwe1bDuelKqAiD9CC3b7ym1ia0pQr80wIlT4=
X-Google-Smtp-Source: ABdhPJz56NQ2nNIJmj2zdoXeFWF90XZonsa4b22vHPHgKrBDRXMS4PlMbHx9YKDJQzy4StI/XfWg6vVwK1xaJ3i+ikc=
X-Received: by 2002:a17:906:38db:: with SMTP id r27mr21769495ejd.328.1605653545896;
 Tue, 17 Nov 2020 14:52:25 -0800 (PST)
MIME-Version: 1.0
References: <1605592689-10108-1-git-send-email-yejune.deng@gmail.com>
In-Reply-To: <1605592689-10108-1-git-send-email-yejune.deng@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 17 Nov 2020 23:52:14 +0100
Message-ID: <CAFBinCCQTTAR9dTpf8pWb4D=+Hc2Tjxj1WE1KYqsyT-S-XPdtA@mail.gmail.com>
Subject: Re: [PATCH] phy: amlogic: Replace devm_reset_control_array_get()
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     kishon@ti.com, vkoul@kernel.org, khilman@baylibre.com,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        p.zabel@pengutronix.de, lorenzo.pieralisi@arm.com,
        repk@triplefau.lt, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yejune,

On Tue, Nov 17, 2020 at 6:58 AM Yejune Deng <yejune.deng@gmail.com> wrote:
>
> devm_reset_control_array_get_exclusive() looks more readable
>
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  drivers/phy/amlogic/phy-meson-axg-pcie.c       | 2 +-
>  drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c | 2 +-
>  drivers/soc/amlogic/meson-ee-pwrc.c            | 3 +--
>  drivers/soc/amlogic/meson-gx-pwrc-vpu.c        | 2 +-
what's the reason behind including PHY and SoC driver changes in one patch?
I think both main directories will be applied by different
maintainers, so I believe the patch should be split into:
- one drivers/phy patch
- another drivers/soc patch


Best regards,
Martin
