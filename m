Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09652D6350
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404212AbgLJRR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404130AbgLJRQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:16:52 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A3DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:16:11 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id x16so6534211oic.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=1DhGc1yNSVnvbflwjjTm6H7Ift8ftskK41SQF5YbY8M=;
        b=mFuC2IViDM2sP6c1KSdjWfBMV/YHz8XR4kcAnOxpcRJ5lul3INm6pwWUmq/i04lIEm
         FhGagnQNBno/U6t9cbBSCE4n9x+Mzyz5irGL0ULbD7vF/ZsJVbiKWxN6KfnJ54yLvpA5
         vyJeopdI7LG4GS+ooRMqGh2/cMDRgVHD1hP3pCSGg1ftKbMhntcOMIhc3jWnmxuZEghh
         SvCbkuLR5Y5ssLNjWETwQpUrAVbTN6cAFLXQ9xdJ9zpk+afv6Xgv6hS5OkTlAf4/MlM1
         56UQ/0HGrlyL9vY9qtweiObH82RsHDndfGFWVdQWP3hl2AUXcmx5vW8kcs9gEQ4d2Jnn
         iqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=1DhGc1yNSVnvbflwjjTm6H7Ift8ftskK41SQF5YbY8M=;
        b=Z53TAbEZMDeyCKr7XB5+HlDTI/ZmWXH+QbMfmftoRp0ukye4//6Ov9LDW6UeILARrw
         KlOrq+IHDsZjB6xpYeRKMpRoJ/1+Aj/LJsgJ7xNMSjYteOvaiz5xxk7Cm0RKIFUVoGbv
         bu+JRQlc20KtF7hrK2aOZJtGBsX1Lx8pU1S4U9Aru66xsT+sDwzyr7G0wn0fWtT2hlSZ
         Cf5spPrdPZ3rCMLpJrH5JrXc3kZvzdpLYiIq6HKU9lPnffncwqDX5zNGIE9Ab1AkMnxE
         tv6Ijp8rqldRELcbX+chwdY9BAdCLl8oWW8BscRJkiGRj53fue6y0DPWk7bRS1vSAjqK
         rCJw==
X-Gm-Message-State: AOAM5334xMqJoEEkaLbb6og+vWBJ6E+48x5sEHrseQnyuDsTYIXnJmAJ
        KuTXPDVdYoiBpxon3PL9ntTdvDpnQwugIBGtmaw=
X-Received: by 2002:aca:dfc2:: with SMTP id w185mt7112250oig.50.1607620571499;
 Thu, 10 Dec 2020 09:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20201208195223.424753-1-conmanx360@gmail.com> <20201208195223.424753-3-conmanx360@gmail.com>
In-Reply-To: <20201208195223.424753-3-conmanx360@gmail.com>
From:   Connor McAdams <conmanx360@gmail.com>
Date:   Thu, 10 Dec 2020 12:16:00 -0500
Message-ID: <CAM8Agx3ttO_RDgjQAxLYpVMVRhz+xgmg80f4iefXZNVrGcd0-g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ALSA: hda/ca0132 - Unmute surround when speaker
 output is selected.
Cc:     stable@kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Woops, sent previous email on the first version of this patch.

This patch is a mistake. Not sure why I did this.

On Tue, Dec 8, 2020 at 2:52 PM Connor McAdams <conmanx360@gmail.com> wrote:
>
> Make sure GPIO pin for surround channel mute is set to 0 when speaker
> output is selected.
>
> Fixes: def3f0a5c7007 ("ALSA: hda/ca0132 - Add quirk output selection structures.")
> Cc: <stable@kernel.org>
> Signed-off-by: Connor McAdams <conmanx360@gmail.com>
> ---
>  sound/pci/hda/patch_ca0132.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index 793dc5d501a5..6d647d461eab 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -1390,7 +1390,7 @@ static const struct ca0132_alt_out_set_quirk_data quirk_out_set_data[] = {
>                   .has_hda_gpio     = false,
>                   .mmio_gpio_count  = 3,
>                   .mmio_gpio_pin    = { 2, 3, 5 },
> -                 .mmio_gpio_set    = { 1, 1, 0 },
> +                 .mmio_gpio_set    = { 1, 0, 0 },
>                   .scp_cmds_count   = 0,
>                   .has_chipio_write = false,
>                 },
> --
> 2.25.1
>
