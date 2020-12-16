Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5A52DBF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgLPL1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgLPL1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:27:24 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F5C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 03:26:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x20so27894767lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 03:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1HTWkrMiCWdXjch8Wdo2LEnpiN677jiCEapc6u0XM0=;
        b=VubTArQyVKuBy9L0rcU2Q1ai7i/hMZSI0M3LocyMZkbn40L9Pa4IE3DCjUd3BePaJk
         HIPrW2ucNhY60O1nQ+wubUIaRpxry4wVQkGLP1LMST3busHi10lTW3pOvVWG13o5r6a6
         h+tU2Gxt3mbmvTTsnjz6MZkurzo93qEug9iioXyMdQ0jHJGUS/29ssxKUB0mzkx+aGYk
         QjGN5XJzxIlC5dc/tL/ZoaXGJMHkgpTYh3Gq1TKLPnJhAHoYNAqdWwweISe+/QbkUkZH
         4Y9H8NOwsLkfLLN7A/TBdlNmKUGweFK+vUwFI4z5ZwWoxObXUjq7aE62sRtn8VEvivD9
         kHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1HTWkrMiCWdXjch8Wdo2LEnpiN677jiCEapc6u0XM0=;
        b=j8J3bkTMNTwI74b6meBUjlH39eFHqdoeGOgT8bNw0ayFhXA+6HdSwPySO7I06Mg7oP
         yz/KQ0UtTjxBlz0BOQvwVPP+oqDFTHcS1pkDX9ZWU0Xu7EXtPr4gy8+wZYY0XR263Gv1
         5t8cvLMPZe92kD4tHUmCSsg8AJc7vp1UYq3J4RHkqk/pA6njCUw5a+iM++B1j0IZbWXK
         j6cymPcWXi0wro/mLI6B6BHembDMzO0t6H8lnk/3GaSNkbt19G4/SDRk/4JTiOnf6ehJ
         xsrYa5nEcZXml18ZX/op5HX13EpqAXmMzyjhYPHXav7++oegDZcVtjSq5r6+lJ+lKf2V
         Yg6Q==
X-Gm-Message-State: AOAM532uQwaea0el1uSmGashxhPRebY55O32fYFBzB2vDb4s1Zg2Tb01
        8OWP23UIB1nqvdjNh9psLTHyrvgKe29K5wGIZ0E=
X-Google-Smtp-Source: ABdhPJzk/F6xIDInXWPZPHeXBh5fRXip+E/mflmi6fxiAaY9HM5oFMwVy4lMd60HPoOAvl0PjA0S0EIA+xOtADyK5iA=
X-Received: by 2002:a2e:8416:: with SMTP id z22mr14917310ljg.347.1608118002624;
 Wed, 16 Dec 2020 03:26:42 -0800 (PST)
MIME-Version: 1.0
References: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 16 Dec 2020 08:26:31 -0300
Message-ID: <CAOMZO5AgZhJL-wPXwAt0J=fCt+RA-Toj56X6t9W+HaWuat5VMg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: imx-hdmi: Fix warning of the uninitialized variable ret
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

On Wed, Dec 16, 2020 at 7:52 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> From: shengjiu wang <shengjiu.wang@nxp.com>
>
> When condition ((hdmi_out && hdmi_in) || (!hdmi_out && !hdmi_in))
> is true, then goto fail, the uninitialized variable ret will be
> returned.
>
> Signed-off-by: shengjiu wang <shengjiu.wang@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>

Thanks for the fix.

This should have:

Fixes: 6a5f850aa83a ("ASoC: fsl: Add imx-hdmi machine driver")

Reviewed-by: Fabio Estevam <festevam@gmail.com>
