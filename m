Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B222A9F89
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgKFVvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgKFVvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:51:08 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFF1C0613CF;
        Fri,  6 Nov 2020 13:51:08 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c20so2601111pfr.8;
        Fri, 06 Nov 2020 13:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cCOSuspQFM76bwwc9KyVB4ygiOrAQrMSCa7jrT+WOiE=;
        b=fofen6cX59+NrDsXNP2Ikx/VA8W/q34luWai9k3YMyeCn+Iq80JuJ+hdDhMEmzVBiU
         DzqUnMDf/t9ouMeF5UBMoNklNSCLeaNflA6Dq5A/Gvjbsi0vSf/DnJHzwQlk/Zt6asZ1
         5eMTrEjzTLJedHDomM3i159NfKz0tg6AeyPJ602FdfxzIiVNIWdHppHAwgFyjIYkQwnP
         JcrolOhV4v2gF4RA+ODyZhyI3aJT6uqWl1PLX5Y4mNb8N+sI/xt6uXOQZPjISd83/nBu
         eUcHzb0cbGjpOaKQ63JFyqqsjIpSq5L6JnkQLJg8PO1m1XPPwX/DQkIQ5kGy6vgFKX2f
         H6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cCOSuspQFM76bwwc9KyVB4ygiOrAQrMSCa7jrT+WOiE=;
        b=q4iAOeA50hPm5i/pbqm30iO+vbiIhFTzWi2XI3Jvx88ZBDT62TMHgVf6fnG9k60GHU
         sw/ajF4tRmZ6ejzSccrWGxfTIXS/NWnDiSbH4nZGnsTBBRmpBcMnVHASEDpStCco/K1e
         DKXFNxgFr8+YxyzoehKEG+Z13bYai3IjZZJqYeLASAk4KnLHL3C0hSHovzpv4kjVlR0T
         YxjklT1STBqLvwtLHos1myp4yvicgFxP2HpREw7Y34nrTfbcSqYLbGtKNG5WNX6ezOOE
         ilCW8rA0DmJfAdNsLuArAueVELQyoYWIqMpu89tLgsn+O9ShXFuKCUlV7CM6Gq2QY48z
         5HjQ==
X-Gm-Message-State: AOAM531GGzZFa8gJ3ApIotH/ii0/hwHe/HHPBizjN9IwEoOKdPUN7yBW
        +UmV5mLK0dV0iVrg6DCGuA97lCVx8kkSqw==
X-Google-Smtp-Source: ABdhPJx5mzL06fdjlBBcKuJ33iLkGeOMrXk9Sm8CfjP+23T56yaZQTLdQP60v9qx3wxztk7dMHUDJg==
X-Received: by 2002:a17:90b:496:: with SMTP id bh22mr1721827pjb.120.1604699468015;
        Fri, 06 Nov 2020 13:51:08 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id q23sm3170599pfg.192.2020.11.06.13.51.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Nov 2020 13:51:07 -0800 (PST)
Date:   Fri, 6 Nov 2020 13:38:58 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: fsl_aud2htx: Add aud2htx module driver
Message-ID: <20201106213857.GB3927@Asurada-Nvidia>
References: <1604281947-26874-1-git-send-email-shengjiu.wang@nxp.com>
 <1604281947-26874-2-git-send-email-shengjiu.wang@nxp.com>
 <20201105013539.GA16459@Asurada-Nvidia>
 <CAA+D8ANrkgXR+8JGp4fPLvkKJ05EqQyShWTO+xWpPOycPT9Tyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8ANrkgXR+8JGp4fPLvkKJ05EqQyShWTO+xWpPOycPT9Tyw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:51:03AM +0800, Shengjiu Wang wrote:

> > > +static irqreturn_t fsl_aud2htx_isr(int irq, void *dev_id)
> > > +{
> > > +     return IRQ_HANDLED;
> >
> > Empty isr? Perhaps can drop the request_irq() at all?
> 
> I'd like to keep this for future enhancement, what do you think?

I believe that usually it will be a common practice that we add
when we use it -- exaggerating the situation, just like you will
not actually add an empty driver for future enhancement.

But I am not strongly against it, as it's small. Since Mark has
applied it, let's keep it then.
