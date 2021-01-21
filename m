Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3EB2FF1B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388069AbhAURWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733184AbhAURTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:19:41 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F8DC061786
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:18:59 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id d81so5536263iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=3S5/DXeaDQ8qpjJtyiUfgqJbVPCCQbbQmxHzoiqKbfw=;
        b=eTIl8xYGkfIvNkn7JUsAULTn7yxxSb7ObKhbaSAxe6brnlC2bWZO64DeYv/ErJ5mMt
         U23KiOWt3QUHQ1pgEgUSvj0hZQM4vUL6fmcDhh/uNfDx8b5aVxO+fnDC8m+0lCIiBCJS
         AmOlGhOjNWoe56S3vdMhEDTKlb3Pxl5xdwVMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=3S5/DXeaDQ8qpjJtyiUfgqJbVPCCQbbQmxHzoiqKbfw=;
        b=dUFSFIsav4dDKYScecun4NjYeAHn0qnGocLrWJ5NLpKndYXUBZHoWeCxVoqHG5JB6e
         LWDNULFvCZ7N7ajs1QiAko1aWZguhfas450V/eYfHL2vJgaMCnrTobkUaKf1PQXYVm6l
         N8PyROfBWU0VjDddDftUlIKRjpaKzObX4I8uhekSO9LD8CMGuxZFXbeE1xcR6JvmaUvk
         e3ZnDlRgWdiAGI5jlfn84nMegFJMQ/YupvH1Y4sDpsHK1rhJksirmUL16yvJgx+SAe6o
         LdgUumLAA+jtpa8dagokkQhOUmYQqEK8QUNBmIFpqMCGx8BcsZBmohWIkSD/czvAcmPj
         A2JQ==
X-Gm-Message-State: AOAM531oJyu8wiJ44sZfBz0nFugMopCFyB99LsNbePPP/bdRFFKCBGHT
        2wvBbD9Vy/OnKC2CeX3uyL5GazFEjOT/lQ==
X-Google-Smtp-Source: ABdhPJzFvU3l2v+VBglpCpZ+oP6tPVaU9t27HQhkRh03+9cerEWhrBKv0maWXPvObkb/wNNLiMVwKw==
X-Received: by 2002:a92:d705:: with SMTP id m5mr662357iln.85.1611249537875;
        Thu, 21 Jan 2021 09:18:57 -0800 (PST)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id v2sm1174082ilj.19.2021.01.21.09.18.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 09:18:57 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id x21so5459489iog.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:18:56 -0800 (PST)
X-Received: by 2002:a05:6638:a1b:: with SMTP id 27mr157986jan.144.1611249536281;
 Thu, 21 Jan 2021 09:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20210121171644.131059-1-ribalda@chromium.org>
In-Reply-To: <20210121171644.131059-1-ribalda@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 21 Jan 2021 18:18:45 +0100
X-Gmail-Original-Message-ID: <CANiDSCuaB+7YwRG1uLMJjkOao7rsF6EB8rScDDiY8ynzQThFsw@mail.gmail.com>
Message-ID: <CANiDSCuaB+7YwRG1uLMJjkOao7rsF6EB8rScDDiY8ynzQThFsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: Intel: Skylake: skl-topology: Fix OOPs ib skl_tplg_complete
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mateusz Gorski <mateusz.gorski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Majczak <lma@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is just a v2 from my patch from December with the ={}: in a second patch.


Best regards!

On Thu, Jan 21, 2021 at 6:16 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> If dobj->control is not initialized we end up in an OOPs during
> skl_tplg_complete:
>
> [   26.553358] BUG: kernel NULL pointer dereference, address:
> 0000000000000078
> [   26.561151] #PF: supervisor read access in kernel mode
> [   26.566897] #PF: error_code(0x0000) - not-present page
> [   26.572642] PGD 0 P4D 0
> [   26.575479] Oops: 0000 [#1] PREEMPT SMP PTI
> [   26.580158] CPU: 2 PID: 2082 Comm: udevd Tainted: G         C
> 5.4.81 #4
> [   26.588232] Hardware name: HP Soraka/Soraka, BIOS
> Google_Soraka.10431.106.0 12/03/2019
> [   26.597082] RIP: 0010:skl_tplg_complete+0x70/0x144 [snd_soc_skl]
>
> Fixes: 2d744ecf2b98 ("ASoC: Intel: Skylake: Automatic DMIC format configuration according to information from NHL")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  sound/soc/intel/skylake/skl-topology.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index ae466cd59292..1ef30ca45410 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -3619,15 +3619,16 @@ static void skl_tplg_complete(struct snd_soc_component *component)
>
>         list_for_each_entry(dobj, &component->dobj_list, list) {
>                 struct snd_kcontrol *kcontrol = dobj->control.kcontrol;
> -               struct soc_enum *se =
> -                       (struct soc_enum *)kcontrol->private_value;
> -               char **texts = dobj->control.dtexts;
> +               struct soc_enum *se;
> +               char **texts;
>                 char chan_text[4];
>
> -               if (dobj->type != SND_SOC_DOBJ_ENUM ||
> -                   dobj->control.kcontrol->put !=
> -                   skl_tplg_multi_config_set_dmic)
> +               if (dobj->type != SND_SOC_DOBJ_ENUM || !kcontrol ||
> +                   kcontrol->put != skl_tplg_multi_config_set_dmic)
>                         continue;
> +
> +               se = (struct soc_enum *)kcontrol->private_value;
> +               texts = dobj->control.dtexts;
>                 sprintf(chan_text, "c%d", mach->mach_params.dmic_num);
>
>                 for (i = 0; i < se->items; i++) {
> --
> 2.30.0.296.g2bfb1c46d8-goog
>


-- 
Ricardo Ribalda
