Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D042B8B26
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 06:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgKSFyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 00:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSFyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 00:54:08 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D8CC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 21:54:08 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id q28so3253672pgk.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 21:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W+/WJCvab/Hgugh+VunRbyQx3J7VABdiIFZZOJfo1TY=;
        b=jcTSHx7ixnOfDz+kuB8ZRPKp/lqdE5UHKP+d8CVEEqI93FNGKZLVph7FLYgD1JN+pv
         /DdJEYApwcXEIZLUeqkVkaHdbZbUOH0B1Gs3ytKpcYvoa/uCILTYC9BtvWPUyEX3sb9G
         07LvFQyVqUQXlZJwa/HQlnkMjFKIYsmwn6vxvq1p4DOlfS8bGa9fWYitBwjGBwIwEAx3
         +uHf0UhsMiop63FjT2nQ0dQX0SB9YvtOfZdIiGy1vc8lTLzHBQ9BL/1trJJNVtnqOuf0
         7eX9aDm4eZYAhwR9NyC5dgDiOaEAqnSa/L/+aT7UnlWsbc6m+pzzStA2bcoYYRUe9ee0
         yhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W+/WJCvab/Hgugh+VunRbyQx3J7VABdiIFZZOJfo1TY=;
        b=Rp5dnyOoXuWpUanaFho+VPaTHVH41ajmYJLJqXk0qwi8AS7jDE9waDJRW71ljyBNCz
         80Z6oMAlF+2YOLBJiX6Bi3hLPJsE295X7+lxPdpm7ZFO5Qukuwoxhtw8hb6r9EywuBWN
         bN6Fofx6jq36JdTT6tNyP0tHspCZKSnk0mKzm+Fhb8hu8Xp6HEsZplzBjvn21D4ZtrOE
         qSZYbdY7agRqnt8oOZWegvZxSEdSnLrBigE7KtOCkcnCkbp+3zKTinrwJ3hBxLjo8tu8
         i6N2dNOuzqUdRGUYAa7SobXSuqsdcaa+1uH44aqARmWCxKhH7N/T1I83n6P1b56CbjfX
         Z9cg==
X-Gm-Message-State: AOAM530xIiJVxWSncpoWzGbCYwl9ppyHKfAzZnNEXLGYcbwwRC54YPVd
        aSlTy6O3obcJdPC/rJhHu7U=
X-Google-Smtp-Source: ABdhPJynlE37JqiWB11KpgkMSim1NZ0+qLh6TpiXRD+r+aYGCY8JpQYcvhso0TeNNN7BWmAZ7yAP8g==
X-Received: by 2002:aa7:8c16:0:b029:196:33d2:721f with SMTP id c22-20020aa78c160000b029019633d2721fmr7465723pfd.70.1605765248175;
        Wed, 18 Nov 2020 21:54:08 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id t9sm4682874pjq.46.2020.11.18.21.54.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Nov 2020 21:54:07 -0800 (PST)
Date:   Wed, 18 Nov 2020 21:53:41 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_sai: Correct the clock source for mclk0
Message-ID: <20201119055340.GA1666@Asurada-Nvidia>
References: <1605752956-17397-1-git-send-email-shengjiu.wang@nxp.com>
 <20201119050120.GA7124@Asurada-Nvidia>
 <CAA+D8AOuaeZCnvY0h2stzkiMnNCe7zvK_D4M2irT7y7NC+iZFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AOuaeZCnvY0h2stzkiMnNCe7zvK_D4M2irT7y7NC+iZFg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 01:28:32PM +0800, Shengjiu Wang wrote:
> On Thu, Nov 19, 2020 at 1:02 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Thu, Nov 19, 2020 at 10:29:16AM +0800, Shengjiu Wang wrote:
> > > On VF610, mclk0 = bus_clk;
> > > On i.MX6SX/6UL/6ULL/7D, mclk0 = mclk1;
> > > On i.MX7ULP, mclk0 = bus_clk;
> > > On i.MX8QM/8QXP, mclk0 = bus_clk;
> > > On i.MX8MQ/8MN/8MM/8MP, mclk0 = bus_clk;
> > >
> > > So add variable mclk0_mclk1_match in fsl_sai_soc_data To
> >
> > Not in favor of "mclk0_mclk1_match" as it doesn't sound explicit
> > to me. Instead, "mclk0_is_bus_clk" or "mclk0_is_mclk1" might be
> > better. Or in case that you foresee some other implementation:
> >
> > enum {
> >         MCLK0_IS_BUS_CLK,
> >         MCLK0_IS_MCLK1,
> > };
> >
> > static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
> > +       .mclk0_alias = MCLK0_IS_BUS_CLK,
> > };
> 
> No problem.
> 
> But I just find this patch doesn't consider the mqs case.
> MCLK0 can't be used for mqs, it needs MCLK1, even
> the MCLK0 is same as MCLK1,  MCLK1 need to be
> selected for mqs case.
> 
> Is there a decent way for this case?

Is there any use case that we have to use MCLK0 instead of MCLK1
on SoCs where MCLK0=MCLK1? If no, how about skip MCLK0 at all in
the for-loop at fsl_sai_set_bclk?

	/*
	 * There is no point in polling MCLK0 if it is identical to MCLK1.
	 * And given that MQS use case has to use MCLK1 though two clocks
	 * are the same, we simply skip MCLK0 and start to find from MCLK1.
	 */
	id = mclk0_is_mclk1 ? 1 : 0;

	for (; id < FSL_SAI_MCLK_MAX; id++) {
