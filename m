Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84BA2FF22D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388877AbhAURkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388880AbhAURkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:40:15 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF1BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:39:35 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b5so2143828pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 09:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j6ZxcTRqGjbCO8Rh76YdBV9tEuh4KlqlTS43ZgxAZos=;
        b=IuQLdlr46b4DmTb4HvYsGyufqalktrFc+E7umTNNQxdGPmuPIpdiPae6lstCpAZtgv
         Prz5Pe8tQtzhy+3q+00IHkCLut1D6bqKccyvtJAG7EnCYjQBG6y+Bc+7sT5HwmHm+sea
         PNfchInCN8P2946mZEwDjkMTH77FOMBJHBd0MNeK8Umum9PtD732UKlKl1W9u8yervbP
         KXvwHQVnCqFxxlDnlWXppcfwI1CLNCwiORJ6OcXbhDo0FP3CArxglgJCp8KYDDUCgsdZ
         x2U6HUb1qiRsmr9+z7kw2OkEV1TMceWbvxMPik1hd8150eA0bjAGs8c9dFXaYLjlzCEP
         75Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j6ZxcTRqGjbCO8Rh76YdBV9tEuh4KlqlTS43ZgxAZos=;
        b=Sw1IGNnYXH8alYtXqzt1M4dVQC+sjkKQHUsgg9zsuuBlLIXblo3U2f7Rq9vbZpGxNL
         UsnoWyOUv4/qiUeolcQjlZSKX6yKIDzEO0fvr+Vudj6JPOX0wcs9Yb5tVKz1cm21I8kl
         jNxe+OrmYv0/MQOBVhjwiAeYQ9cjvPw8j170uUc2RTfp8QXvfyT47Nt5AQFTXxIgn91v
         5Ysph1+tlc6qoTmkUiffdXSjiQiUTy+O91Tlh5ZITG/6Iab7zs5QovNq9f8SLllXJxph
         Xzyx72L6z7x+hPBBXs+13IhSmJju5O0SmSkShE1Kg7lCFXsk7Eq27TOk8O8P5CTv7oUe
         3fMw==
X-Gm-Message-State: AOAM530FGg/5fCqNQCbbQRSEDbgdh2TXu7n+r8TpDCyLklQ2el/BziGP
        1psmph4n06SHBAlOG8SW8WoysgnOZrYYYHMF8SxTNqmH7/frpplt
X-Google-Smtp-Source: ABdhPJy+c38Ko0Jal2+UKxBQhycCiPXQ9+bO+GaS7YTRFjIkrPTuac2RSOmcPsnq0BodC7Ls6J2G18vhVjH0HGC2BrU=
X-Received: by 2002:a17:90a:9483:: with SMTP id s3mr510418pjo.85.1611250775055;
 Thu, 21 Jan 2021 09:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20210121171644.131059-1-ribalda@chromium.org> <bb5edb634f69421a87143d3962e67d30@intel.com>
In-Reply-To: <bb5edb634f69421a87143d3962e67d30@intel.com>
From:   =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>
Date:   Thu, 21 Jan 2021 18:39:23 +0100
Message-ID: <CAFJ_xbrELkcLWc4-qni7GYn_TtQKGVjKqhZspE11pNJzGOOifg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: Intel: Skylake: skl-topology: Fix OOPs ib skl_tplg_complete
To:     "Rojewski, Cezary" <cezary.rojewski@intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mateusz Gorski <mateusz.gorski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ricardo - I have checked it on Eve/Google Pixelbook

Tested-by: Lukasz Majczak <lma@semihalf.com>

czw., 21 sty 2021 o 18:33 Rojewski, Cezary <cezary.rojewski@intel.com>
napisa=C5=82(a):
>
> On 2021-01-21 6:16 PM, Ricardo Ribalda wrote:
> > If dobj->control is not initialized we end up in an OOPs during
> > skl_tplg_complete:
> >
> > [   26.553358] BUG: kernel NULL pointer dereference, address:
> > 0000000000000078
> > [   26.561151] #PF: supervisor read access in kernel mode
> > [   26.566897] #PF: error_code(0x0000) - not-present page
> > [   26.572642] PGD 0 P4D 0
> > [   26.575479] Oops: 0000 [#1] PREEMPT SMP PTI
> > [   26.580158] CPU: 2 PID: 2082 Comm: udevd Tainted: G         C
> > 5.4.81 #4
> > [   26.588232] Hardware name: HP Soraka/Soraka, BIOS
> > Google_Soraka.10431.106.0 12/03/2019
> > [   26.597082] RIP: 0010:skl_tplg_complete+0x70/0x144 [snd_soc_skl]
> >
> > Fixes: 2d744ecf2b98 ("ASoC: Intel: Skylake: Automatic DMIC format confi=
guration according to information from NHL")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Thanks for the fix, Ricardo.
>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
>
