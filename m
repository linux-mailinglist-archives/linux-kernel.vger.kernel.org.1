Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A742B8AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 06:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgKSF2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 00:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSF2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 00:28:44 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FC9C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 21:28:44 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id f15so68460qto.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 21:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b7W8v88zLtr+ka2IPAyj56iTGAS8nCyLHMM+2VUflmo=;
        b=qZF2YgaoXYq0nmLnEFZikoLEWobBAv2ePC78d840jV8fVBGlhwa9cPS53PSvu/xHNN
         Xqqpc5mi8jp/wBM58SIMpqTJjRowXWQPf1GLHXRWf4LAJ8Wn7XPDBtYy4Jtvpq/Rz6bm
         LU7/yZrTjFBu93tCO84TwEFiJfha687R8ecfczX9rbZ7ab9QupindBJgfn3i7+J2iTwm
         mP7Y6rwWR3nITm+rmgWXkK/KQbnhB2YhDhCCSdxV67U9QgxzAiPzMZJMuSjmoLQfeGg/
         ADv0cjpR4/VioRFC0SMi0XyDlJ+oDitPmwv1+8wjgCRdXVcuMp5oMd81S6jCQPQeSf6k
         8UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b7W8v88zLtr+ka2IPAyj56iTGAS8nCyLHMM+2VUflmo=;
        b=ng2yiyhNv001//ZM7MSj1uh9LzWMrwQyMQHrmI8+uKJ1c36wjnAQKw8QWiOm/6miWB
         Ok8BSWkWPDvkvPfyVPqzpD2lRe/FvjOArFIMVUqEb3xou48bT26pM8jobUrPIEOIskZD
         sZdyTeDCGNdCz5Ji19L1rWRqJglp4BGIBA/tHntttOyFE5cA4awkPI2aaknvnqTUCEHh
         HdBZY6vMkgSWz0cORQ+VdGEhoszrYvyy45M3sTUxRUaoJrqqhk8cOQqSYijP/r6nUAZI
         gtwAD07mDysuv/CUs5hvMCwd1/a7giFI7wCKeInYNqWbq3NUi5UJ29xziFochg4eH+I+
         wCSg==
X-Gm-Message-State: AOAM532Ic22Brk5vXk0Sw4wSknJWLF3IaAZDorCRPT8E7+cmnqIEPhm4
        ar73h4LtWe1/HGqVKeymP4jipRvrJyR182KjfCI=
X-Google-Smtp-Source: ABdhPJyP01zyLRekqz3HSZ/yOdRNlpFC3KuuNZYSluSSNckhGFZkRWKxMffUcBHvJTq4iZbFHpbs1CpAK1V2ccLnnRo=
X-Received: by 2002:ac8:5806:: with SMTP id g6mr9224533qtg.292.1605763723217;
 Wed, 18 Nov 2020 21:28:43 -0800 (PST)
MIME-Version: 1.0
References: <1605752956-17397-1-git-send-email-shengjiu.wang@nxp.com> <20201119050120.GA7124@Asurada-Nvidia>
In-Reply-To: <20201119050120.GA7124@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 19 Nov 2020 13:28:32 +0800
Message-ID: <CAA+D8AOuaeZCnvY0h2stzkiMnNCe7zvK_D4M2irT7y7NC+iZFg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Correct the clock source for mclk0
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

On Thu, Nov 19, 2020 at 1:02 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Thu, Nov 19, 2020 at 10:29:16AM +0800, Shengjiu Wang wrote:
> > On VF610, mclk0 = bus_clk;
> > On i.MX6SX/6UL/6ULL/7D, mclk0 = mclk1;
> > On i.MX7ULP, mclk0 = bus_clk;
> > On i.MX8QM/8QXP, mclk0 = bus_clk;
> > On i.MX8MQ/8MN/8MM/8MP, mclk0 = bus_clk;
> >
> > So add variable mclk0_mclk1_match in fsl_sai_soc_data To
>
> Not in favor of "mclk0_mclk1_match" as it doesn't sound explicit
> to me. Instead, "mclk0_is_bus_clk" or "mclk0_is_mclk1" might be
> better. Or in case that you foresee some other implementation:
>
> enum {
>         MCLK0_IS_BUS_CLK,
>         MCLK0_IS_MCLK1,
> };
>
> static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
> +       .mclk0_alias = MCLK0_IS_BUS_CLK,
> };

No problem.

But I just find this patch doesn't consider the mqs case.
MCLK0 can't be used for mqs, it needs MCLK1, even
the MCLK0 is same as MCLK1,  MCLK1 need to be
selected for mqs case.

Is there a decent way for this case?

best regards
wang shengjiu
