Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FC62E7DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 04:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgLaDGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 22:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgLaDGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 22:06:17 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773CAC061573
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 19:05:37 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u26so13543928iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 19:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eh0LYyioy3C3UVC9bwYubsDJdeJ6pKMdFF5bTDt6YkI=;
        b=TdwHg7F/YVh3cN8PVMIQ+oWuBWKeEigWj/hFDBYkaxozMfZ7KRhZV8NB24QPpMxZVK
         xP3TNC2izS62C735GRSAXt/qTtQMNg7nBjEHOWTRKP1X5oZMcq3dMRgdbzQrH/TzGBQ+
         SHM5HmfZirh22LlNPpXWW5PHSmqTU1/ts1e8j4qndJlm0ZcHX7mtgmz7VmvebMzPeZ5E
         ftVVCPZJmNM8NzK+7HhYtl/TCiTuP/yl52CogDcqU7OrPzzEDGipEEGYXYxi23MHUGpc
         Q4tu2j8nNkWSBI30ztNyCm8ZY7Uq4FW8S3wpY0Td3GVO1U4XtfLJ+Bu/4Y3gS5VhOuX6
         108w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eh0LYyioy3C3UVC9bwYubsDJdeJ6pKMdFF5bTDt6YkI=;
        b=m7V+q7cDocBTS9qDnUcecR2u1hOsXiUsDtuoyYTq1ltp6YUcf2f7dqC1UncLlvDXxv
         UweUo6C/7NV6fzW4xGPI1kHHsLY2YKSTvUvENkIt8xzjzbSag/gLEcJrI4H6BClfIL2E
         i3TCnvle87ZjtVzqoXsBGAG6Iv5oPnTa0qquc6qubq23GUwP7TIII7f7VWYgZNrnVHZR
         T5asZFPpUR6/H/JLc7Qv9dMyJLZZnk46yqIJekZ4o4dqpDnMWxscg/PqEGmkqxuP2DOV
         4IrMmW5OnltnOOXLxHeBlyXifkZbED4wVIGcWqiV4nmJTaY41eycQOAMU8h48CCS4KMX
         YtqA==
X-Gm-Message-State: AOAM532OstpA3Eibru55Ruu3XY9ogwzcKNCEK8fnzZdGeP/unAFXWv8S
        xM2zbDl+F0jBcomSv7TeGDlnSIcLqAgtkz/wJ74tXQ==
X-Google-Smtp-Source: ABdhPJxN3b3LpOts6FmTvL8wbWxbWHHukhWKA4JsuemgJC0/GdUY8dN5ynrejN4PSioTS9QR8vw0smV+ayjN/GeXNak=
X-Received: by 2002:a05:6638:1202:: with SMTP id n2mr48302031jas.85.1609383936067;
 Wed, 30 Dec 2020 19:05:36 -0800 (PST)
MIME-Version: 1.0
References: <20201230154345.639122-1-arnd@kernel.org>
In-Reply-To: <20201230154345.639122-1-arnd@kernel.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 31 Dec 2020 11:05:25 +0800
Message-ID: <CA+Px+wXEjm+yb+8g2qdv8+WUWXJf+MPKpLL7ovS_08f0ch_Wnw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: add MTK_PMIC_WRAP dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 11:43 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Randconfig builds often show harmless warnings like
>
> WARNING: unmet direct dependencies detected for SND_SOC_MT6359
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && MTK_PMIC_WRAP [=n]
>   Selected by [y]:
>   - SND_SOC_MT8192_MT6359_RT1015_RT5682 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8192 [=y]
>
> Add a dependency to avoid that.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tzung-Bi Shih <tzungbi@google.com>
