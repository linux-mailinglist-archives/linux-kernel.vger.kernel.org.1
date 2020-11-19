Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00482B8ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 06:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgKSFBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 00:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSFBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 00:01:48 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1EEC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 21:01:48 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 62so3116694pgg.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 21:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8cz3enAL5Z5Hmb2tunw3mWVvo6ZiOq4lJnWnZV2/xu4=;
        b=duj4eOFRuuoRo/k2/GT7E5UP1NTqvVMJONO2EmKQx4JwzYhwNLBCLf2SokW5rrlgFI
         uhWxiVtmj9lqv35g4VinjX6jszgACQbXZN7duEVfuwdwZKKl4uV/B3IciP51RklxnBkG
         e9vDOnA4/0ctUOpISUygUux++JCmtPQi4KmCa4b8Ucr2SZw0XB6gshJRf1C+VCQtg5aD
         UOS1W+1wNa3L3RfyXaZhipBSoGV8Esfye1CRoe8MoySnHt8lvt7BmCT3nGmkSI21Uqf1
         s1HrD0GFOsedFunmHzmHcxOR9WA0mqTKLxXl+766u2ircarXMerAhy0XM0VrIG9CmxbF
         ZTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8cz3enAL5Z5Hmb2tunw3mWVvo6ZiOq4lJnWnZV2/xu4=;
        b=eCSHd31IhiVRM4dmTBevTapRL4tcmstGQoSDCYZQAGmgTfCxFrwGwDEFCSYTTJexC/
         mut298GUnrcWe98xoeRV+ZXd3+T7ahrGnHTbxWPagN7RztaXlnoiKNWv6e9/b5emUr7L
         muC+ZUxNmX/i/D6lDP17TK5vZ8jJXq0duKEMWKAgRRzMwAhReUvrFXeWmP2YbePH+wfT
         SQCiSu5TuLvMvhSMw6Rb5kJ38Br+7XQRPVmWlZA9EJge3w7MI8bY5MSGhlHNLbOvUP4F
         ISvDQh7ltRvATMG4hn2T93O/D86mNX/VSWGvxA7Apg43KM0Smhxgtb9W1agQGSAQYK1x
         lmbQ==
X-Gm-Message-State: AOAM530Ni9VtL4jZreMjbpm1g2pMoxf1eJ+6rSUT1PZZhpQjuUxNB6zl
        O+OvpBFEUGiVKXnC5zw4K20=
X-Google-Smtp-Source: ABdhPJwQdNXkT3Phmm+Z7AT/H+skvgWBxS2LYjl6sXgqQqAOZ7omgkkvUkEcBl/cAAspL+sft1r/UQ==
X-Received: by 2002:a63:380d:: with SMTP id f13mr11633900pga.105.1605762108046;
        Wed, 18 Nov 2020 21:01:48 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id k8sm27722420pfh.6.2020.11.18.21.01.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Nov 2020 21:01:47 -0800 (PST)
Date:   Wed, 18 Nov 2020 21:01:21 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_sai: Correct the clock source for mclk0
Message-ID: <20201119050120.GA7124@Asurada-Nvidia>
References: <1605752956-17397-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605752956-17397-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 10:29:16AM +0800, Shengjiu Wang wrote:
> On VF610, mclk0 = bus_clk;
> On i.MX6SX/6UL/6ULL/7D, mclk0 = mclk1;
> On i.MX7ULP, mclk0 = bus_clk;
> On i.MX8QM/8QXP, mclk0 = bus_clk;
> On i.MX8MQ/8MN/8MM/8MP, mclk0 = bus_clk;
> 
> So add variable mclk0_mclk1_match in fsl_sai_soc_data To

Not in favor of "mclk0_mclk1_match" as it doesn't sound explicit
to me. Instead, "mclk0_is_bus_clk" or "mclk0_is_mclk1" might be
better. Or in case that you foresee some other implementation:

enum {
	MCLK0_IS_BUS_CLK,
	MCLK0_IS_MCLK1,
};

static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
+	.mclk0_alias = MCLK0_IS_BUS_CLK,
};
