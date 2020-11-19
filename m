Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7262B8BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgKSGvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgKSGvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:51:52 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169AFC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 22:51:51 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p6so46733plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 22:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YdZEJFrKMqOKwqEHM2SMsgDlq62AjmhaiDfpu3ifyuI=;
        b=jbuo9kaEqlrzfBtB8xdHG/ABifiR/DNQ/ty/tTE8v/3XGOFwJGEj60vaW7+EToRIS9
         j/RewspM2uK8jaGUgXUgItDPW/u3Ij5QNuzGqpfr8txs/pidD5qZttqcEngOy0Ra8j4z
         dhE7WiKNgaC7fmWqaZQtkcJWFqUoXcaJncuO1Caa9CoMttRmkN8aj0PRPEZnkKRNjp/j
         I11/RthsHxm68vtFm1Yypu7bfCsbTB++dBEDnqCu07cFwzJUCFCgPKuDyqZlmO46DAs4
         LIgM/1C9/xVIzBYYqYO8GsgaCW77wrx9aYrZxa8VKTLNSNpukiLYg36Oy9zVP5uSrMGt
         gbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YdZEJFrKMqOKwqEHM2SMsgDlq62AjmhaiDfpu3ifyuI=;
        b=T3MZtC4BhtQFmf8j4TPUV2FBB3TRhIKuDJk7X2Synbv0M69NwjTOdrAV7RjZiIZWe3
         CXry7ODt2wBt/p9woiJWeXCQLnx176mEF8AO+7566Heb5qgE5MSofagvr9uxGDY3CQwa
         GVQ468b6b1kMkUrMywUklalPhHwC5bAeMQxqgRb7vAd2i1qlE08S64YZtHXFl0N22X4O
         vk/RKKaCeGhMsGjlLz8F2p0MUeZN9th+ZD7y7ZKSmtJ2zZbofzWqSC3vhYufDT5npD+C
         hOzSQMLPE3cLB7bgnIIxHAtxPg2c+unI8nNkRobQUlKHK+sGByTprIkkotDguJ9swcKF
         IKJA==
X-Gm-Message-State: AOAM532MuO27t4Buw+Z1oJ9nm0DD9k7FinrH1S+LUIvoNOUcCGqbmY+k
        24c/IWyjB9qP1dsnd08mr5g=
X-Google-Smtp-Source: ABdhPJwNjcaPO4z56nqOXPwx8RuDahj5FRpIkqxLnLyLvLIbuMAUb/EcTDMnhRUfdl2utjiWINvCbA==
X-Received: by 2002:a17:902:401:b029:d7:d0af:f897 with SMTP id 1-20020a1709020401b02900d7d0aff897mr7828053ple.18.1605768710494;
        Wed, 18 Nov 2020 22:51:50 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j11sm23890863pgp.82.2020.11.18.22.51.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Nov 2020 22:51:50 -0800 (PST)
Date:   Wed, 18 Nov 2020 22:51:23 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl_sai: Correct the clock source for mclk0
Message-ID: <20201119065122.GA9858@Asurada-Nvidia>
References: <1605768038-4582-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605768038-4582-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 02:40:38PM +0800, Shengjiu Wang wrote:
> On VF610, mclk0 = bus_clk;
> On i.MX6SX/6UL/6ULL/7D, mclk0 = mclk1;
> On i.MX7ULP, mclk0 = bus_clk;
> On i.MX8QM/8QXP, mclk0 = bus_clk;
> On i.MX8MQ/8MN/8MM/8MP, mclk0 = bus_clk;
> 
> So add variable mclk0_is_mclk1 in fsl_sai_soc_data to
> distinguish these platforms.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
