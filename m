Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A0327332E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgIUTzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgIUTzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:55:13 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC654C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:55:12 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so671174wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YnHM6Hb2y75zAmIL8oMRMNOuTr0UGFyFVBu7fGiSews=;
        b=p6FPH/bXd02fVePtnRBJz3I1Vs4o+uGl8AUxVqGp329LcXDKk3VCkOUKY3G/kkIwtm
         YUgnsCOjAv+E1XErdswu98/iRlqOni8BJyXmyFKLOSCAZuWbBvDo+nlrhcrdSju/el56
         KdNQPfu3WsQ7Iv6ki9szDXn51b1CU2ZJhA//wUd+jeaBb5URBSMRk3k/F3WEbX4c3cYA
         RYdXPuj87JW6/RPe0xxa+3sfNf+iHaGdPgqQUt86/QnRXzVFMX9DltQFNLgdM+byistd
         huKGd258rIEXAmf3fIuhrCtS34bcMMGf30hnGmAgqiYZo7/yyug5WUMH2r3EXvmi5Vhu
         +fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YnHM6Hb2y75zAmIL8oMRMNOuTr0UGFyFVBu7fGiSews=;
        b=sFZTaV0X9wIam0RnjPXn/wJPtObkX24hBLN4B3L3pPd8os/UCe3QI4PAg/FtlzcdkS
         UTTJ45C/E/ncG1ixXJb4Ya/vrXyaVPwp+zRAuT5dlBn7cGZBJSkERC10b9gcQELFSQM1
         NyP7+Ht4i6IKkkfwbagfyUY72VcGkICmcCJyVGnGj8/2jz4I3iyhBlx6Lb33rmMx+VQm
         eatixQRKm9YYE/P9eqUOziIgHjKU2DIPQUtkzTTEn75AN65WztR7U4SqIk1n4UrHjqb2
         F1PWx1wYqPqzaLynpV1NE9CAGABbky5IW/46epjNl68Ylq+/b98mKbb8qkkMGJD2RDz3
         dyqA==
X-Gm-Message-State: AOAM531cEu/IFb0nnxhiRNBqIZ8tRCUp/Eal2ysHg2AS/7+waTv/Opr5
        1X0ssHuk90wn7O1HR/8U6Lih9FaYAeTr8hg5lEg=
X-Google-Smtp-Source: ABdhPJwZgwV6vkAAjowteBj5ihZxbhwD17IBcHMtzvMBYdjNxn4Ob2SIcxa+cIei8JjO78UQaTrO9VPBs6T/VC7upMk=
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr912983wmc.73.1600718111467;
 Mon, 21 Sep 2020 12:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200915071820.76620-1-sudheesh.mavila@amd.com> <888285ed-62e9-53d7-7fde-e40ac64bc5a4@amd.com>
In-Reply-To: <888285ed-62e9-53d7-7fde-e40ac64bc5a4@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 21 Sep 2020 15:55:00 -0400
Message-ID: <CADnq5_NWnMraD_WPoms0G-bqmNxf7tN86h34Dm1Z+6ZTeqqzNg@mail.gmail.com>
Subject: Re: [PATCH v1 ] drm/amd/pm: Removed fixed clock in auto mode DPM
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Sudheesh Mavila <sudheesh.mavila@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        zhengbin <zhengbin13@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied with fixed up whitespace.

Thanks,

Alex

On Tue, Sep 15, 2020 at 3:45 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 15.09.20 um 09:18 schrieb Sudheesh Mavila:
> >      SMU10_UMD_PSTATE_PEAK_FCLK value should not be used to set the DPM=
.
> >
> >      Change  suggested by Evan.Quan@amd.com
>
> Can't say much about the change itself, but the Commit message is
> indented and the indentation in the code doesn't look consistent either.
>
> Christian.
>
> >
> > Signed-off-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
> > ---
> >   drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> > index c9cfe90a2947..081cb9b1b7c8 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> > @@ -566,6 +566,8 @@ static int smu10_dpm_force_dpm_level(struct pp_hwmg=
r *hwmgr,
> >       struct smu10_hwmgr *data =3D hwmgr->backend;
> >       uint32_t min_sclk =3D hwmgr->display_config->min_core_set_clock;
> >       uint32_t min_mclk =3D hwmgr->display_config->min_mem_set_clock/10=
0;
> > +     uint32_t index_fclk =3D data->clock_vol_info.vdd_dep_on_fclk->cou=
nt - 1;
> > +     uint32_t index_socclk =3D data->clock_vol_info.vdd_dep_on_socclk-=
>count - 1;
> >
> >       if (hwmgr->smu_version < 0x1E3700) {
> >               pr_info("smu firmware version too old, can not set dpm le=
vel\n");
> > @@ -679,13 +681,13 @@ static int smu10_dpm_force_dpm_level(struct pp_hw=
mgr *hwmgr,
> >               smum_send_msg_to_smc_with_parameter(hwmgr,
> >                                               PPSMC_MSG_SetHardMinFclkB=
yFreq,
> >                                               hwmgr->display_config->nu=
m_display > 3 ?
> > -                                             SMU10_UMD_PSTATE_PEAK_FCL=
K :
> > +                                     data->clock_vol_info.vdd_dep_on_f=
clk->entries[0].clk :
> >                                               min_mclk,
> >                                               NULL);
> >
> >               smum_send_msg_to_smc_with_parameter(hwmgr,
> >                                               PPSMC_MSG_SetHardMinSoccl=
kByFreq,
> > -                                             SMU10_UMD_PSTATE_MIN_SOCC=
LK,
> > +                                     data->clock_vol_info.vdd_dep_on_s=
occlk->entries[0].clk,
> >                                               NULL);
> >               smum_send_msg_to_smc_with_parameter(hwmgr,
> >                                               PPSMC_MSG_SetHardMinVcn,
> > @@ -698,11 +700,11 @@ static int smu10_dpm_force_dpm_level(struct pp_hw=
mgr *hwmgr,
> >                                               NULL);
> >               smum_send_msg_to_smc_with_parameter(hwmgr,
> >                                               PPSMC_MSG_SetSoftMaxFclkB=
yFreq,
> > -                                             SMU10_UMD_PSTATE_PEAK_FCL=
K,
> > +                             data->clock_vol_info.vdd_dep_on_fclk->ent=
ries[index_fclk].clk,
> >                                               NULL);
> >               smum_send_msg_to_smc_with_parameter(hwmgr,
> >                                               PPSMC_MSG_SetSoftMaxSoccl=
kByFreq,
> > -                                             SMU10_UMD_PSTATE_PEAK_SOC=
CLK,
> > +                             data->clock_vol_info.vdd_dep_on_socclk->e=
ntries[index_socclk].clk,
> >                                               NULL);
> >               smum_send_msg_to_smc_with_parameter(hwmgr,
> >                                               PPSMC_MSG_SetSoftMaxVcn,
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
