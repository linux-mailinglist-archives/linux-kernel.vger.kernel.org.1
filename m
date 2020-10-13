Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2FA28C732
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 04:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgJMCk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 22:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgJMCkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 22:40:55 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADC0C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 19:40:54 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id q26so15035345qtb.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8UzLNMJoHU8HSzYatq3OymQ886/xpnDCfNyxud2dbvg=;
        b=eDNDAtaIOkTrkCQT5OpVtvF/qz069+8PKCvChRgPbX0q2zn94GU9dI57OcV9OFdPc+
         PKKaZzoThmZ3SY6GiVriiThlVkeXZUrPaImmThvJaOVNc58AmthvDY2xgTonHrqWZhHc
         wL0i28ECHuGUdLwkZE2FYEsBuKtEhjogt0mqNkUDeXeiiYRl4LF60h8lWgeL6gIe/62I
         Oa96ZjQBOWpkChWL3sx87yDHfnLhR4EJNY4hmcHX+yYl9MbatCgY/H398cgd5jS1e6Lw
         F/fRIn9J/FuK/TVRhxOEAgioCRbMSz5g15qq5BUHjTOuql1O10EL0CFMGoh+fJ05wWbK
         k42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UzLNMJoHU8HSzYatq3OymQ886/xpnDCfNyxud2dbvg=;
        b=fnJDRsCGE7rRFTI7GqDycmuI19fHzDUr+LXyiN20SV1sjgr24haTKvFuD28J2AX8oy
         3PaA6NDhgmkYhmdiSS+21CUKqF4FcFv+4uOTgcQ/loC4Ne0NK68XE1jgjRA9Go1NjGO4
         luUjsfzv3FXOanr5eol6Mmkz7UEvnbTMEUjcgSfNVAM4b1RyeSBy3lPgjNEQh/9jDlco
         PcPcW/Tx5AgIkt8+XusloZYLcoXBkK/K3Isqwak0PAkffK5KfSAe9GSgN8mKXVUMh+Pl
         SrqJ/uSuvOOJPnJ4o4JY6F1i8Ooj5trRf+jnDgVsXUciUIL/EOQ/CsCz+gIJCSCHFAuV
         pQ5Q==
X-Gm-Message-State: AOAM532542+dsEoM9VcMz4nWxw9eEomuDXS1x2AYatOJ/qR2hSSlFaHf
        rS0SnJwql4QQZkAXFiMkT7bONPPugZFS2VMmHes=
X-Google-Smtp-Source: ABdhPJwfW64NzIqBo8ICVJEOXbPnwJlOFIecdiLN2hRGt6Q5FcUk484wbQ1KiNyXGY1QZyXo7SRVoZd1qDn9KXBCnwI=
X-Received: by 2002:ac8:4d03:: with SMTP id w3mr13279186qtv.360.1602556854073;
 Mon, 12 Oct 2020 19:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <1602492582-3558-1-git-send-email-shengjiu.wang@nxp.com> <20201012190037.GB17643@Asurada-Nvidia>
In-Reply-To: <20201012190037.GB17643@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 13 Oct 2020 10:40:43 +0800
Message-ID: <CAA+D8AP=c6p5_hdXP3uk5FaMPsW9cUif_gs9k-JQu48vifVvTw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for higher sample rates
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 3:09 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Mon, Oct 12, 2020 at 04:49:42PM +0800, Shengjiu Wang wrote:
> > Add 88200Hz and 176400Hz sample rates support for TX.
> > Add 88200Hz, 176400Hz, 192000Hz sample rates support for RX.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
>
> Probably should put your own Signed-off at the bottom?

will update in v2.

>
> Anyway:
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
