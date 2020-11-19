Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CF82B8B40
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgKSGFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSGFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:05:10 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3689EC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 22:05:09 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d9so4360237qke.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 22:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afgDn2umda6QgnA0T4nNfO0qOaQP4kyxzthFa3SdSFE=;
        b=GeHvjHAaXVWHe47UtcIRS4vrSBEdINyrcJ8wDFKIB70hQKrcBT4vdCSHWLHGPdHnDK
         /OLAYZm7nD/ldSC0YfZGtTGbgrMUxOHGNh5nCPHxT7A205g/KwJuag6SPrs5thp5Dbga
         zYoZMz2LzUBnDq2HeyPzro/Q6J2HyeKjhej5QlHs9OJITgS1BEDefIpjE9ST9P9k8/oJ
         idI1krkePOsHfIKHMsSxkTnp/I9NDY53hW1RTe5/Ejd7wsKyM/kppCa86DIs1kgYL9j3
         GHohFLV4MITqLk56Iw8ogdu+emoHOO01cce4PfJw9UObyGt7q+WHlj9A65gXYxm7lSSx
         SRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afgDn2umda6QgnA0T4nNfO0qOaQP4kyxzthFa3SdSFE=;
        b=nwIjex8ESUI8QllKnStwD5qdY36x/Yla/H9LpCNyVT9Jja4kzkKnPpaJw17EVkiVhw
         B6rLO3PjTqIi7aoaR7NXjCmMZGrUtF5m38mD9CdmEnEIXK7aPB90OuJr5FU3TBHELpso
         X3Z9DGSCyGQJe0puqgXaicYiqQNGY5LYWhT+9dcXD8woiPqRFfrsjHAiVkC+1qN5Z491
         a9sm8cfLB2h8IEVfumJ09cr3M21sW/5BMhcovZgK/kj6q8otyliZmfoMVW9ycWwSEBgN
         Ycy+Ees4Oc1nXaWAr5Q/WwpqZf1IBZPDQqrYlwGPl04r7yZo2t6JOg+chmY0e4kzwNbV
         SJJg==
X-Gm-Message-State: AOAM5319PU6PG/4tP32w1VuAtM+RPPjaDb6Ya8SXTySjXJdKQcBa6Oqg
        pPK2yKr7jAwDhdz9g5Ku30vqQOig+QVZhuSgPRc=
X-Google-Smtp-Source: ABdhPJw4ldiy0UOoaJKLIc/wQOv2QQLlKmJpH68m7Y/6USvRX1laUXgpAW85JgEWR6O1s71WFQ37KQdGxadYdcOaBdI=
X-Received: by 2002:ae9:e317:: with SMTP id v23mr9438913qkf.152.1605765908487;
 Wed, 18 Nov 2020 22:05:08 -0800 (PST)
MIME-Version: 1.0
References: <1605752956-17397-1-git-send-email-shengjiu.wang@nxp.com>
 <20201119050120.GA7124@Asurada-Nvidia> <CAA+D8AOuaeZCnvY0h2stzkiMnNCe7zvK_D4M2irT7y7NC+iZFg@mail.gmail.com>
 <20201119055340.GA1666@Asurada-Nvidia>
In-Reply-To: <20201119055340.GA1666@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 19 Nov 2020 14:04:57 +0800
Message-ID: <CAA+D8AOkios28X0n0cC4RbVnkkQ5U3fWaBNrp1AvN0rr_wbb-g@mail.gmail.com>
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

On Thu, Nov 19, 2020 at 1:54 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Thu, Nov 19, 2020 at 01:28:32PM +0800, Shengjiu Wang wrote:
> > On Thu, Nov 19, 2020 at 1:02 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > >
> > > On Thu, Nov 19, 2020 at 10:29:16AM +0800, Shengjiu Wang wrote:
> > > > On VF610, mclk0 = bus_clk;
> > > > On i.MX6SX/6UL/6ULL/7D, mclk0 = mclk1;
> > > > On i.MX7ULP, mclk0 = bus_clk;
> > > > On i.MX8QM/8QXP, mclk0 = bus_clk;
> > > > On i.MX8MQ/8MN/8MM/8MP, mclk0 = bus_clk;
> > > >
> > > > So add variable mclk0_mclk1_match in fsl_sai_soc_data To
> > >
> > > Not in favor of "mclk0_mclk1_match" as it doesn't sound explicit
> > > to me. Instead, "mclk0_is_bus_clk" or "mclk0_is_mclk1" might be
> > > better. Or in case that you foresee some other implementation:
> > >
> > > enum {
> > >         MCLK0_IS_BUS_CLK,
> > >         MCLK0_IS_MCLK1,
> > > };
> > >
> > > static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
> > > +       .mclk0_alias = MCLK0_IS_BUS_CLK,
> > > };
> >
> > No problem.
> >
> > But I just find this patch doesn't consider the mqs case.
> > MCLK0 can't be used for mqs, it needs MCLK1, even
> > the MCLK0 is same as MCLK1,  MCLK1 need to be
> > selected for mqs case.
> >
> > Is there a decent way for this case?
>
> Is there any use case that we have to use MCLK0 instead of MCLK1
> on SoCs where MCLK0=MCLK1? If no, how about skip MCLK0 at all in
> the for-loop at fsl_sai_set_bclk?
>
>         /*
>          * There is no point in polling MCLK0 if it is identical to MCLK1.
>          * And given that MQS use case has to use MCLK1 though two clocks
>          * are the same, we simply skip MCLK0 and start to find from MCLK1.
>          */
>         id = mclk0_is_mclk1 ? 1 : 0;
>
>         for (; id < FSL_SAI_MCLK_MAX; id++) {

Ok, thanks, will update the patch.

best regards
wang shengjiu
