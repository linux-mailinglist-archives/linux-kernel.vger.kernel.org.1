Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64CE2E0C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgLVPIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgLVPIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:08:09 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DABC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:07:29 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id d9so12235647iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LSZe6kdgOB0LR7hxUYry4TSc2IqyZGUCr8x+rBs0II4=;
        b=stLyfZX9Skp5SLTWBml7TFa94b0bTpk5Ro8RzqZgC9zFYtCKD32c2oQqpG9VvBH3h/
         wXuBzMfbxr8mzVyKsb+gUDBMvJcqKIzXPRtNIB5/bTNmMVSrs91CVQPvKXHcmUrT2m45
         B8vNToRWL7cIAlqAg8oYtn5cI0sZdHgBcwW+UQQwhQ2HPdDUwdQ2ldXzWbptBMQQnQCa
         tueD22hG/kisdnGEYkgrPFd3iOxvP7Rs34jlh2+TlSoX6rbNFhJ6IWyLUlYRsWgB0qPI
         6Oq0ZXBdK33YCJppiDKXQTGmXU8Mb6RBToaK8DjY1Mha4hiJZ42q60iDys972RzI6rWM
         37Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSZe6kdgOB0LR7hxUYry4TSc2IqyZGUCr8x+rBs0II4=;
        b=KsNcP/3bv8VrC16afJkpuWSkPEGQ3iwZOCSDrnColjQjW6PAZQR4xHo68ZSQxkrbbp
         /poqGTX05hFqBiP1iFqhY4H0c2Pn1aRK2gd+Mc1bLJ4mKStL2Vv56vrGLYSFTRxm3XhE
         JOgzg9cqkxjFYAaTE55w2pFRqJrUj4iD0o3FulKiWx2R4dUNtn4ddqooix5FYK0prUe1
         uzv5UtflgTzJ3z0/j++MIBYnLye4vrWiLxEzj5GrJ6TLzSVIA3S9aTXuuH0MmdzoYyDL
         Vddf1QihKPJhJ7SafpirziCUf7GfMyldVlBLnSawQPjeQ/Xlvse9OSzGIVDyzyn3esPD
         jmqg==
X-Gm-Message-State: AOAM531OH8/ElonW1E4I/CcCvrqR738QQSlOMt1jvmQldzlBJgxvEiVT
        wGDVXnFaoED1aN4zZdlAKDC2FEqvshRiv3ULOUpSMCZEieg5ow==
X-Google-Smtp-Source: ABdhPJya2Rc2FuYnx7qQ8kNuOFwBx/CjbaZOp1sskB17DKL1QreHIAiw/9FVnptaAl45cj+IcGM9oYcwm3wnp22jkw0=
X-Received: by 2002:a02:8622:: with SMTP id e31mr19093651jai.88.1608649647844;
 Tue, 22 Dec 2020 07:07:27 -0800 (PST)
MIME-Version: 1.0
References: <20201216041601.5993-1-chiu@endlessos.org>
In-Reply-To: <20201216041601.5993-1-chiu@endlessos.org>
From:   Chris Chiu <chiu@endlessos.org>
Date:   Tue, 22 Dec 2020 23:07:17 +0800
Message-ID: <CAB4CAwcAbZYa7NS-Kxd60gN_Z1qv2C-SxMsTvgqWSfmcD=s3Kw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirks for DeeQ X5-Z8300
To:     cezary.rojewski@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        yang.jie@linux.intel.com
Cc:     alsa-devel@alsa-project.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 12:18 PM Chris Chiu <chiu@endlessos.org> wrote:
>
> DeeQ X5-Z8300 is a laptop empowered by Intel Atom Cherry Trail. Add
> quirks to select the correct input map, jack-detect options to enable
> jack sensing and internal/headset microphones.
>
> Signed-off-by: Chris Chiu <chiu@endlessos.org>
> ---
>  sound/soc/intel/boards/bytcr_rt5651.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index 688b5e0a49e3..9df09e26b05a 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -507,6 +507,14 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
>                                         BYT_RT5651_SSP0_AIF1 |
>                                         BYT_RT5651_MONO_SPEAKER),
>         },
> +       {
> +               .callback = byt_rt5651_quirk_cb,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "DeeQ"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "X5-Z8300"),
> +               },
> +               .driver_data = (void *)(BYT_RT5651_IN1_IN2_MAP | BYT_RT5651_JD1_1),
> +       },
>         {}
>  };
>
> --
> 2.20.1
>

Gentle ping. Cheers.

Chris
