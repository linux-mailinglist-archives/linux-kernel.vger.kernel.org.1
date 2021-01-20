Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D272FD50B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbhATPzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390998AbhATPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:49:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37564C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 07:49:17 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u4so2436748pjn.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 07:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W/v3Q1gR6haXAZwJYzyuelWfC+raxw6fkAKMseYCivY=;
        b=TlifsGuM3b7ZVREww0uhRgA1wb889kOry5EIxYhxpaOk1ajcJQavGVxczaQF6C3wLM
         bHAZv8JrxVozohsNBS1Uk7hbpjtfdCLf4LdRiSm/JIcuQJvlOVs3dkR5HCanHxeWT4jE
         yXUSf8pDsx+sBNePzm9WvJyi3/9ruv9mu8lD6HkRkBEnPv1QRGjH2BwFrXvogVdH+PDS
         XxnTmQE16A8lnplcAhR/yS3A3IpdNmMF34n7gFH1iY73gzmhoxFyVe8J1n+Sz1Jsyxpj
         +lFkN7CqeBzI58JLVJNP53LESg2ItPuVaiLH4Xy7CV6eKa+dBk8xasCpEfdAo/Pzo4r1
         GwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W/v3Q1gR6haXAZwJYzyuelWfC+raxw6fkAKMseYCivY=;
        b=DSXPu4v2YrWjTnySpkP/H7iLRMCo3cmodrzy5dgqEPvZb2cXk+3DSzD4bthfQN7MT7
         /1+PHguE6FB2M9Evo/zdRWocTm8MsULFI+nWmVof0lkfMfaRa72Q6YhZBTvIkXlBhSzI
         2xqIRkXmw+i5uM7GcMGObCMcPKWRGZ4s3D68CiVn314VJAJIRopDwGpxsNZ7ojUjTYl6
         CWmz3js+ZEgrnBIyJWZVezcTageh5xoN9/FBuvgoZsGtiE+q5ooURhMwsWkPqDQtScrV
         cdAYFVyvQf5NG5tNtDgfXOp9nvFJXckdBqpyn32n5qOIsrQaSmsUpIsrR6zepZAgRELd
         Gp6g==
X-Gm-Message-State: AOAM531flapV0iq/vljs3WtjKu7pZJUi/8t6KgVYEOSLx24etQfAaZGK
        tGwXzRq6GbXAc13rJBLNx0awYu57a2Ubmu/bmXQ/2a4FpcSOoQ==
X-Google-Smtp-Source: ABdhPJzmMovobGbSomzJhznA7/YaMj3HSwZCsNUkR//BrFcyoT6sKDmhT17DpKWrH74xISIMxxwpCyk0tHVfxae91Rw=
X-Received: by 2002:a17:90a:9483:: with SMTP id s3mr6293320pjo.85.1611157756495;
 Wed, 20 Jan 2021 07:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20201210121438.7718-1-lma@semihalf.com> <20201217130439.141943-1-lma@semihalf.com>
 <CAFJ_xbprw7UKREWgRAq3dDAA9oC_3cWoozn5pCY8w9By4dASag@mail.gmail.com>
In-Reply-To: <CAFJ_xbprw7UKREWgRAq3dDAA9oC_3cWoozn5pCY8w9By4dASag@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>
Date:   Wed, 20 Jan 2021 16:49:05 +0100
Message-ID: <CAFJ_xbrvr7jcCB57MPwzXf=oC5OYT5KUBkcqHYyOYH=a5njfSA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: Intel: Skylake: Check the kcontrol against NULL
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Marcin Wojtas <mw@semihalf.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mateusz Gorski <mateusz.gorski@linux.intel.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Alex Levin <levinale@google.com>,
        Guenter Roeck <groeck@google.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

Is there anything more to do to get the ACK for this patch?

Best regards,
Lukasz

wt., 12 sty 2021 o 12:34 =C5=81ukasz Majczak <lma@semihalf.com> napisa=C5=
=82(a):
>
> Hi,
>
> This is just a kind reminder. Is there anything more required to
> upstream this patch?
>
> Best regards,
> Lukasz
>
>
> czw., 17 gru 2020 o 14:06 Lukasz Majczak <lma@semihalf.com> napisa=C5=82(=
a):
> >
> > There is no check for the kcontrol against NULL and in some cases
> > it causes kernel to crash.
> >
> > Fixes: 2d744ecf2b984 ("ASoC: Intel: Skylake: Automatic DMIC format conf=
iguration according to information from NHLT")
> > Cc: <stable@vger.kernel.org> # 5.4+
> > Signed-off-by: Lukasz Majczak <lma@semihalf.com>
> > Reviewed-by: Mateusz Gorski <mateusz.gorski@linux.intel.com>
> > ---
> >  sound/soc/intel/skylake/skl-topology.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >  v1 -> v2: fixed coding style
> >
> > diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/s=
kylake/skl-topology.c
> > index ae466cd592922..8f0bfda7096a9 100644
> > --- a/sound/soc/intel/skylake/skl-topology.c
> > +++ b/sound/soc/intel/skylake/skl-topology.c
> > @@ -3618,12 +3618,18 @@ static void skl_tplg_complete(struct snd_soc_co=
mponent *component)
> >         int i;
> >
> >         list_for_each_entry(dobj, &component->dobj_list, list) {
> > -               struct snd_kcontrol *kcontrol =3D dobj->control.kcontro=
l;
> > -               struct soc_enum *se =3D
> > -                       (struct soc_enum *)kcontrol->private_value;
> > -               char **texts =3D dobj->control.dtexts;
> > +               struct snd_kcontrol *kcontrol;
> > +               struct soc_enum *se;
> > +               char **texts;
> >                 char chan_text[4];
> >
> > +               kcontrol =3D dobj->control.kcontrol;
> > +               if (!kcontrol)
> > +                       continue;
> > +
> > +               se =3D (struct soc_enum *)kcontrol->private_value;
> > +               texts =3D dobj->control.dtexts;
> > +
> >                 if (dobj->type !=3D SND_SOC_DOBJ_ENUM ||
> >                     dobj->control.kcontrol->put !=3D
> >                     skl_tplg_multi_config_set_dmic)
> > --
> > 2.25.1
> >
