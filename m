Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269441B2462
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 12:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgDUKvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 06:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgDUKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:51:52 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1AFC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 03:51:51 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id q2so3295698qvd.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivbFUkwRL9S7N1wT7PKkBXOsZsaEcUNHKgJGMoPGLUE=;
        b=OOzRVb4RfJPdYn4zpXtOEhyi979GugRYT98eayitSgigmRN7GGovTmLYdlPS6gENC7
         eyJC1JWayXcESfs32HRksxLNTDphXS9fVFCMcfvS7Eyj/FDcpBXP+MMNhvt2Z9fbkmt4
         5nW+MavhMgBAqGwwB5gEee5Rep+J1L5gCEmyPW+TwaZneNL4L8fmrF74tNgClC80QnyO
         UylThTlptOWK3nNpMymBJopquDsk1lfiqU1lSyaOWdY0BomJdlfgugcZbcznAACmecku
         rPrFPph1m2QjfJqcuk6gORLIB1dVJJWvVUq28TRJjOVHbO3Pnlf1J1zX12M575sZGbbB
         NtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivbFUkwRL9S7N1wT7PKkBXOsZsaEcUNHKgJGMoPGLUE=;
        b=q3gpJksX9++1P5evNnb7P4KNNIrdgFldR+x4TqfiZWO9MHQ9zmCHitn9EJkVHEEJlb
         rRUbYgazFy3zhzI8Wj3NH9sh6z14DOeoJ9XYbtifLQtb3Dfg9Kzd7164IXkR/xcoEEvV
         TdsreEE6Es7C+hGbZoFzOolMHEUmrDrsEsd+R4XskSpym43TWltpWSy3JdVOho9+3I/+
         DL94X7z1N2yo7MlAz8uQ5qSYIAcWtPQtKX4lifPDb0cz5Nik5EdzaVzaOBrt/XDi9qqZ
         hzOWMT+lZrmEk2TuQ4AbGll/sJDoM7e5kOTeJUeg6PDn5hcJ3vt6Bmw+XOrBI2nHC3hk
         +wEg==
X-Gm-Message-State: AGi0Pua6wMnLxjqkoYPPKj4gcrr/8ozQ2jP3uzbfWluM2U4nulc9TggM
        BhYcm+G3ucmSzGoImNqrQI9TWvgL4ysqw/eQg0k=
X-Google-Smtp-Source: APiQypJwJ2uOOAPfmeM5nJfx+WsYkHo/Ya0/fvk6XSZOAthRD5GU8swYyAKAdYf6f9Qx1lIW0rGPP6tS1dPTrjZa4Ek=
X-Received: by 2002:ad4:4e65:: with SMTP id ec5mr10315478qvb.32.1587466310751;
 Tue, 21 Apr 2020 03:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <1587458483-2166-1-git-send-email-shengjiu.wang@nxp.com> <20200421095139.GA4540@sirena.org.uk>
In-Reply-To: <20200421095139.GA4540@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 21 Apr 2020 18:51:39 +0800
Message-ID: <CAA+D8APjn7FrOvYRiTorfSyswm7G5SMcegnJm9sKB8EQKDMgFg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Remove expensive print in irq handler
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Apr 21, 2020 at 5:53 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Apr 21, 2020 at 04:41:23PM +0800, Shengjiu Wang wrote:
> > Use dev_dbg instead of dev_err in irq handler, the dev_err
> > is expensive, we don't need the message to be printed everytime,
> > which is almost a debug option.
>
> >       if (esr & ESAI_ESR_RFF_MASK)
> > -             dev_warn(&pdev->dev, "isr: Receiving overrun\n");
> > +             dev_dbg(&pdev->dev, "isr: Receiving overrun\n");
> >
> >       if (esr & ESAI_ESR_TFE_MASK)
> > -             dev_warn(&pdev->dev, "isr: Transmission underrun\n");
> > +             dev_dbg(&pdev->dev, "isr: Transmission underrun\n");
>
> These are error messages which would suggest a problem that'd lead to
> data corruption, it seems bad not to try to flag that to the user -
> surely we've got bigger problems than performance if this happens?
> Perhaps convert to a ratelimited print if the issue is that when errors
> happen they happen a lot?

Thanks for review, I will rethink about this.

best regards
wang shengjiu
