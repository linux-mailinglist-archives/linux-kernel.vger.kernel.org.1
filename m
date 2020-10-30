Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC622A036B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgJ3Kza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgJ3Kz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:55:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC30FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:55:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d25so6348452ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OrDPQCETMONsdP1Wo5HDq5W2Iv1t7cbpuMuL/V4LMYs=;
        b=cjplITYQXQCRVceOSq28/kTtGwdbqumx3pVwhPkbIPzBWV9e8DJ77sLhvzUVaUrySo
         br4uT+RnaqqI3JBrwn5G8MQXj9fJ/08Y/iqO17312PkfdI45gGGVEX+R1JhiuSGgACLt
         m9V6o3BEpPQ3SmnS20Wuog9+qrP+XfV4oZImU6SAJ78N4ksYTMljgAoYLk++PxTjig93
         0aaFLVJ1sT1cdQhkgosIDxv8tha554npZmsyjaapwvOI09iU0o0lolyeLfIzLMkj2KCF
         TgQB87wggPvnaUzn8d8Zdmm22xv5L/p3rL24aCGk4/YocDFQXK8iSkj3FXdM3Bz2/RAf
         mpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrDPQCETMONsdP1Wo5HDq5W2Iv1t7cbpuMuL/V4LMYs=;
        b=RsRbZh3XXgyuim9SnqB+nsNRWcv/K0NoWpDJlgUqxY84HudUeFGJdm25vGdnG/xnFP
         SvCIazR/uHmS4usrn27NNeHG1/pkcBECrRAbbMEezt9vLFURtWcKUoW2mvEMTiUexhPC
         x7w0rsqjRPdJUaSrosrja4klobiZuASUhVBHLrqmo9hvboP0wN5/FbAVoxTda+0sVLaZ
         HLnVnfoJ6C3PaSalBIwxIE3Oxc0rOt7wnt0vdvjazR2enTCklUotHbvvO1QkiCvHzf1H
         QyIw6wZAeZSL8FOWud6fEd/jsPVKzqVHXf3FxDW434uWIcC8rGUII75eUJ2Wx5gN4Ca2
         2PfQ==
X-Gm-Message-State: AOAM533pIldS8mWusphORJYqggGtvHbDMSzknVbG96mBTbB5AqnkV7gt
        JQrQmtB8ILOpGu6VE5qH49Siz/SAhjgDL6JLm3mR+Q==
X-Google-Smtp-Source: ABdhPJycAMjwXBhWulmIAxPPXg555+umIsvAMkLA9slwAM3OVfq3XW7rn4jgCP2nM9o7uwVxEWU34jDZIEEnl1YrXl4=
X-Received: by 2002:a2e:9449:: with SMTP id o9mr83255ljh.457.1604055327434;
 Fri, 30 Oct 2020 03:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201030075724.1616766-1-ajye_huang@compal.corp-partner.google.com>
 <20201030075724.1616766-3-ajye_huang@compal.corp-partner.google.com> <CA+Px+wXPRg7aDU5+vr6R_BxuFfhuDeG3iEQeAUKWNtX8YmVC1Q@mail.gmail.com>
In-Reply-To: <CA+Px+wXPRg7aDU5+vr6R_BxuFfhuDeG3iEQeAUKWNtX8YmVC1Q@mail.gmail.com>
From:   Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date:   Fri, 30 Oct 2020 18:55:16 +0800
Message-ID: <CALprXBZ+NmR8Y4sMkh4Y-N_FG+rGEOhUBVTKXRXNFp8H+f0btw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: qcom: sc7180: Modify machine driver for 2mic
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Ajye Huang <ajye.huang@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 5:23 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Fri, Oct 30, 2020 at 3:57 PM Ajye Huang <ajye.huang@gmail.com> wrote:
> > +static struct gpio_desc *dmic_sel;
> > +static int dmic_switch;
>
> If you really need them, you should put them in struct sc7180_snd_data.
>
Thank you, I will do it.
> > +static int dmic_set(struct snd_kcontrol *kcontrol,
> > +                   struct snd_ctl_elem_value *ucontrol)
> > +{
> > +       if (dmic_sel) {
>
> if (IS_ERR(dmic_sel))
> But I think you don't need to check dmic_sel.  Suppose your _probe()
> already returned error, the code here shouldn't be called.
>
OK, I will remove the discriminant if (dmic_sel) {
> > +               dmic_switch = ucontrol->value.integer.value[0];
>
> Looks like it can be a local variable.  You don't need to save dmic_switch.
But dmic_get() will need dmic_switch, should i keep dmic_switch?
static int dmic_get(struct snd_kcontrol *kcontrol,
    struct snd_ctl_elem_value *ucontrol)
{
ucontrol->value.integer.value[0] = dmic_switch;
return 0;
}
