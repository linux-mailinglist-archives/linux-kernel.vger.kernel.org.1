Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236CF29AD01
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbgJ0NRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:17:30 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42458 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440805AbgJ0NR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:17:29 -0400
Received: by mail-qv1-f68.google.com with SMTP id b11so592582qvr.9;
        Tue, 27 Oct 2020 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sv4MSsdbMGxld4Lj23VTm9RmQoViIo/kKrPn4dkU/IY=;
        b=vNh8er+jimshlHNWTbr4gxIBpMpES1VfHM5fklA4+DGxjGBfFZMTBNrnWvRMDNzEfr
         aQrfRcyA0YRlMkbE4iRd8LQFdeArBZ9l5u2mKk4ecgqvSfxudOFqI5447qbLTrmxWVxu
         MZUs1sCVwjcKM77K7xR3A3fPqScf/wNvsOraon9HEj4uf5+0pOLLY0avW/tdBmuAFGze
         2wXlIiRzczDBzOQoZN6yxBFuW/tl1JJMxJ0b5qMqVRTQISZPadZgZF7ZJVsxohgOlICP
         hviF2mSA6Kpe8+FB0P5K1y+aiD2cqurYZzRe5yMm+ivlwi3k21Y19tDzHoSm1qOlOYil
         eUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sv4MSsdbMGxld4Lj23VTm9RmQoViIo/kKrPn4dkU/IY=;
        b=ipcpG7bQQ1lcpA5bFeaRfLPLfgm2jI/GcCbm/2izxq0r4t7vHnGCF+GLIFfknOL74R
         RabN5V25OPsQMkMrGpNNkCClgwggY4I/D/6Zh7HwmMsahF58kG0Ob/yc2hDChfLoizdD
         SBeQygE+jEB4HaF5WWo/6nG+VcnqibWwCGgVlD5SnhixSUPN+QCb2Sg8HNIizIZIekYc
         1kUglpajXZGN9vb++63gwcyvYyJ9eNXlNseJ94LtUhSgdsfhUqHimtHe2MEDh+vqvEQj
         M1WCvGsUOrMDXWP4zntz1Vzk9ZC8FAl3YLE0QUBaXGN47WsIFbwnfAareKAVuIS9m9I4
         I45A==
X-Gm-Message-State: AOAM530Noy8+4mvUVz4uKtIoC+O5erhiEQesvo3MAXB75jynvlGVvFe7
        ORu8My7o1TdLDV0pm9hVAC6EyKRy8G2us5BPcw4=
X-Google-Smtp-Source: ABdhPJw7WHxGGt0QI/QBYgwttvjYmNUbf+/rEv7bpW+TknJBJlrymRHrxafQb7NUmoIIP3EJGVRRlgEZT+IDAOuSO8A=
X-Received: by 2002:a0c:82c4:: with SMTP id i62mr2409110qva.28.1603804648818;
 Tue, 27 Oct 2020 06:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <1603708855-2663-1-git-send-email-shengjiu.wang@nxp.com>
 <1603708855-2663-2-git-send-email-shengjiu.wang@nxp.com> <20201026133003.GD7402@sirena.org.uk>
In-Reply-To: <20201026133003.GD7402@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 27 Oct 2020 21:17:17 +0800
Message-ID: <CAA+D8AMtFh_ZCPrxNDcMmLx2Uqxh9cRX=dX8=tJXt=O72baY5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl_aud2htx: Add aud2htx module driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 9:31 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Oct 26, 2020 at 06:40:55PM +0800, Shengjiu Wang wrote:
>
> > +static int fsl_aud2htx_hw_params(struct snd_pcm_substream *substream,
> > +                              struct snd_pcm_hw_params *params,
> > +                              struct snd_soc_dai *cpu_dai)
> > +{
> > +     struct fsl_aud2htx *aud2htx = snd_soc_dai_get_drvdata(cpu_dai);
> > +
> > +     /* DMA request when number of entries < WTMK_LOW */
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> > +                        AUD2HTX_CTRE_DT_MASK, 0);
> > +
> > +     /* Disable interrupts*/
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_IRQ_MASK,
> > +                        AUD2HTX_WM_HIGH_IRQ_MASK |
> > +                        AUD2HTX_WM_LOW_IRQ_MASK |
> > +                        AUD2HTX_OVF_MASK,
> > +                        AUD2HTX_WM_HIGH_IRQ_MASK |
> > +                        AUD2HTX_WM_LOW_IRQ_MASK |
> > +                        AUD2HTX_OVF_MASK);
> > +
> > +     /* Configur watermark */
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> > +                        AUD2HTX_CTRE_WL_MASK,
> > +                        AUD2HTX_WTMK_LOW << AUD2HTX_CTRE_WL_SHIFT);
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> > +                        AUD2HTX_CTRE_WH_MASK,
> > +                        AUD2HTX_WTMK_HIGH << AUD2HTX_CTRE_WH_SHIFT);
> > +     return 0;
> > +}
>
> This doesn't look like a hw_params operation - it doesn't appear to
> reference the params at all, or even containt any conditional
> statements.  Shouldn't this be configured just once at driver load?

Ok, I will update it.

best regards
wang shengjiu
