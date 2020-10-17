Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D82F290FFA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 08:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437011AbgJQGDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 02:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411696AbgJQGBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 02:01:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E832C0613A9;
        Fri, 16 Oct 2020 18:26:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 10so2473875pfp.5;
        Fri, 16 Oct 2020 18:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rRFRUFeNNAwvjKBB1fE6qSaSpbNzd7iDj3KBBS9Wi24=;
        b=BuFPK4FJjOiSIUHGD7OM2XveIj3tBrf87q24Lrgnu+LjUUrdp0wG5I19CPCKob/guJ
         QXBtQDPHZww3sdBO+hjkhHdXWlS5OU9k267rzwmKaimvsbAOxucxxH7QGyCEzB3ZX3VO
         BybuTUFk371oC5XZ5aWLrKvy9Jt54/AUpZ8zUn8QTLQC5dVnUEWnl1gzwuAA+FM1VS1S
         Ju6udc81wtlOMR4ePVzJxyBW2HVQk3pQWEh4OmAgMprXg9DC2XnLrFhrOyV2ydCcy/n4
         aaEOpLgKmBi4cUE0DrCVQPXScPJlAtozf/1k6csHO9se9Q4th86LiiHgqedREdDtz7G0
         ycOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rRFRUFeNNAwvjKBB1fE6qSaSpbNzd7iDj3KBBS9Wi24=;
        b=ck1GwynPwgpEnjb46aNUeRVxHhwUL60zlpO9QCWxjZtAiiRTxvPaXOx+RCXPchpwqz
         tz694kNbXA7HYXjQKwKuOf/ep6VcsoNja9ag6fF8XcDHhI0PhdGVoCqSIZLeCccPpylB
         3PY/W8cfeR+FDJFZAc2t+7GC9dyA7MzqZNAzU/9fDJovV+gthiaDgFFJlfb81X/JsZWq
         rf7cwZyjafhDANgOnqt2HrjVsrsA8NxAIje2WGL419sGsYhe2Z23db+q+HF9uv9B7Svr
         91EK96OnOyI2CmB7iEt+ruvteNi6hCTlbIDKn3GfVBN4nd94JvpkRLG0g48s6trTAWUf
         lidA==
X-Gm-Message-State: AOAM532djRFF1JgeyK4z8MxgBMI0mC+YqiFQoUKRDG746JVEWW9+uQWB
        yjfqQ9Gkw/TBDxMqc6Nour4=
X-Google-Smtp-Source: ABdhPJxDcmWpg0O4z3LieL6I8S03PlsvcZQSH/YCpoH4Q7Ghg9XaHg0XS98S2kNrz+YFd1mvx/cu+Q==
X-Received: by 2002:a63:5b03:: with SMTP id p3mr5366880pgb.154.1602897963819;
        Fri, 16 Oct 2020 18:26:03 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i7sm3868098pfo.208.2020.10.16.18.26.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Oct 2020 18:26:03 -0700 (PDT)
Date:   Fri, 16 Oct 2020 18:17:32 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] ASoC: fsl_xcvr: Add XCVR ASoC CPU DAI driver
Message-ID: <20201017011731.GA7203@Asurada-Nvidia>
References: <20201013121733.83684-1-viorel.suman@oss.nxp.com>
 <20201013121733.83684-2-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013121733.83684-2-viorel.suman@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 03:17:32PM +0300, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> XCVR (Audio Transceiver) is a on-chip functional module found
> on i.MX8MP. It support HDMI2.1 eARC, HDMI1.4 ARC and SPDIF.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
