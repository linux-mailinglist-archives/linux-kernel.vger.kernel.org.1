Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825B524CEF2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 09:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgHUHUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 03:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgHUHUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:20:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB75C061385;
        Fri, 21 Aug 2020 00:20:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so498949plt.3;
        Fri, 21 Aug 2020 00:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+LGTq1mqvMSViuH9XCWlGLerVDHsR7IO+qqsPsb76uI=;
        b=mIeS9XimBJsE+R74E2h+kzAGFNmF9sHLZa++02iH7VXJs4TWPgfQWEmq0TIGn9dSuY
         bggAhy01WqgfXZAccaweCDv2yCrj7Fnv1w/Rtz2677vfJeT/ZuZK2P8FCehZ3aML7DVe
         JNbOQhn9Ad0YNMUBEeuu9wGHe09e8S/9ZsKJ5NL0xYcRezro27bAQZDb/sbiNb//gSzk
         UM+e3vqmi5mq+SOBGHJ/iF2j4ANUjlJGLyE1PbJkO5QYZsaLvf0RItyuCmcMAe4guCGY
         +3ZzoqR0umpZ59pMu5JRBp9ghz+eBwEHt0hixBuvSslIhPq5Km/6Zo07teG2lwub9bmA
         gYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+LGTq1mqvMSViuH9XCWlGLerVDHsR7IO+qqsPsb76uI=;
        b=ufsc7RRmdXWMWSKI1nMNshH6fpUnK/svwwM2dCvEctGXenylI+3lz3MRDqRWm0WZ8U
         da+nVQ8Iy0K3znSrC0b0F3LGjV/cVhIp6wDfcxMWwdsfZHh7S0Aiz7dBQY+R++M5pdOr
         KUb+mmF2LQzyqYv2CrSneLRusreXoOwCsV6lVbn3T90NBqTtGkrdw4DptUC3jxkuW5ug
         0ZknWI8CYtvuPFjR4rpUKyMUe4J3oe1tawdqG8TisbW5Wo6+OMGmmd5d0s2N5FVxdQyF
         41NRz6B4f1qLQmVo9qnl5RKJ5UYcwjV5TAYs+m3hNP69OFbvs5+wJ310LA15VMTEsrFK
         kLBA==
X-Gm-Message-State: AOAM530j9Y43NqDIkc2cQ9eWgArn/un2UdB0XkdbCQleMKhBpFoV426E
        +uK9QBozq7MVfoz5gMnLEp4=
X-Google-Smtp-Source: ABdhPJyY4LIUiQOEFw4qKKYRk/DqxT3xnarW2dvCwbV61Q9ZpHhPswII0/WPHdU5HxTecshuqMQ5vw==
X-Received: by 2002:a17:90b:4ac9:: with SMTP id mh9mr1424330pjb.40.1597994415561;
        Fri, 21 Aug 2020 00:20:15 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id y23sm1425650pfb.66.2020.08.21.00.20.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Aug 2020 00:20:15 -0700 (PDT)
Date:   Fri, 21 Aug 2020 00:20:03 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: bindings: fsl-asoc-card: add compatible string
 for TLV320AIC32x4 codec
Message-ID: <20200821072003.GB19890@Asurada-Nvidia>
References: <20200821071153.7317-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821071153.7317-1-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:11:52AM +0200, Matthias Schiffer wrote:
> The TLV320AIC32x4 is commonly used on TQ-Systems starterkit mainboards
> for i.MX-based SoMs (i.MX6Q/DL, i.MX6UL, i.MX7) and LS1021A.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
