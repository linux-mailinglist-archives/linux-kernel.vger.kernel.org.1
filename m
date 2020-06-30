Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB18C20F82F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 17:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbgF3PX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 11:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbgF3PX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:23:57 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC66C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 08:23:56 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k6so13900594oij.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMGZtwxkF42O7R8gjwHg1b14ZwEib7oNCbG3iTpGXj0=;
        b=o45pXRvjHRvW0UFuB6wLojg9daptSVYumx1f4auj39dNjWeVxhJqi37LNnc2cq7oZr
         1+ZCXkJsEL+5klTWXzLRuzs4Wv8p1L9VTe8v3PChV+xfmhr+G0OLBXczcUmIGRlVHs9M
         UIH0xr145kzINs5rkGVFPLfPVUJNaRFrPK/VHoqExb2RWIvUDuMvkQAL59wBdYIAlo1n
         60jwoMt4CmTjS904/+yG2CVRPIMZtzwONPdLCN2KkdlgSrbz231i4zCBGorx60OdtDEZ
         uPIe07Y5ejKOpYfRL5z2d4gXBujvSBrKW5rfGmxjz1fit91vx0ZdwqIzlQH7ZPT7fEBQ
         AmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMGZtwxkF42O7R8gjwHg1b14ZwEib7oNCbG3iTpGXj0=;
        b=Gs/f01/rV+ok6arO7KJ+LKq2NiyubsNrPzVKZ/zvtK2iKt4JlvMRtRPhKjHWUjTYh8
         tRzfSp1bnS+NCZQWHurtEwCTlRPxFn2DWjdpI0He5zTo7Lr4z6yZXrqHWGydG9Hi8nyZ
         +BoSB2GPlBgUiRxQECKz6oUb5p0kWF6Q5ARocKR2Ur8SkkyQUhyawpx2PNm4gfAv7VUt
         zle7NPkM4nz+AugTfDsgyQ76QtFrHZoa6XObhkIZhBdpb6LfJ8c8w+VudVdWr/dI/0f5
         /QIH6CvqMp6qsAJEvcrA7Eg3AFeQyhrJO8ir2yEJ/3T3eiruhw1+Mvc4qrbTm7A9vd+Y
         1AZQ==
X-Gm-Message-State: AOAM5325wMxoLi9DrDROWlo6snm0PZK73AYSNs0ndZ6PF/cEfk+vmfcA
        EPACD9/VtQfYk6qk38Fbw93HK4VlxoeqglT55cIRiw==
X-Google-Smtp-Source: ABdhPJzfivDWKv5LJXisIJc/Z1/VfhafE6yGHN6gbojpIuVf8F342/3tyBPUXzuQv7GMnAzrpGJhKvvlCLkP7yaXAPc=
X-Received: by 2002:a05:6808:194:: with SMTP id w20mr16775662oic.77.1593530636058;
 Tue, 30 Jun 2020 08:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200625140105.14999-1-TheSven73@gmail.com> <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
 <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
 <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com> <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 30 Jun 2020 11:23:45 -0400
Message-ID: <CAGngYiV9HqxSLV=PCPg10vqVC-SaayF5wakcWs2gBbXxgcUEPQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy, Fabio,

On Tue, Jun 30, 2020 at 2:36 AM Andy Duan <fugang.duan@nxp.com> wrote:
>
> Sven, no matter PHY supply 125Mhz clock to pad or not,  GPR5[9] is to select RGMII
> gtx clock source from:
> - 0 Clock from pad
> - 1 Clock from PLL
>
> Since i.MX6QP can internally supply clock to MAC, we can set GPR5[9] bit by default.

That's true. But on the sabresd I notice that the PHY's ref_clk output
is from CLK_25M.
The default ref_clk freq for that PHY is 25 MHz, and I don't see anyone change
the default in the devicetree. I also see that a 25 MHz crystal is fitted, which
also suggests 25 Mhz output.

On the imx6, the default ref_clk frequency from ANATOP is 50Mhz. I don't
see anyone change that default in the devicetree either.

So is it possible that, when we switch GPR5[9] on, the external 25MHz clock
is replaced by the internal 50MHz clock? If so, I'm not sure it'll work...?
