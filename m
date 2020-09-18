Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF0027032B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgIRRXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:23:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44924 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgIRRXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:23:17 -0400
Received: by mail-io1-f68.google.com with SMTP id g128so7616052iof.11;
        Fri, 18 Sep 2020 10:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=saPAo/gkpaoA/GYSZXQC6We2mkx7qeNuAH87yYUAsJQ=;
        b=ef9lpySBF/XZ13OThE9Zl+7tcyTmxhuNVPj7KQ5fDQpb7z4m8mREM9SOwxu06PYFST
         8RZPARHJXzyV1COmvVhHflKxKfZ/umSOJTY/buKsAeWnliD7OqOyg6toB0urCPP2pFZh
         lpYoXtcW3buAGw7388MEIjKKSvit0JNwJIy+RYYUH1HCz9IiyE4OQQqephDXm4JeY0J4
         KtO2y3uKNmWeaRLA002bCQCGsafzt8vdDlzqFZhFnhwAhXya8Q2qci3RVtffspt/Nn/p
         l9XK76rxvUFm7jPuhlncg92/KEUuvUAO/hn+tx3arJ7V8P1GKKeqMD2y+RW9h1XuUNVc
         LAGg==
X-Gm-Message-State: AOAM533rC42DOzXxHVJyVh+XJnkhmoIg9Au55x637ZnWVdS1YjrZunKa
        uUzbHgEUcHO8+1UKGpGc9Bsj7LLGVdtC
X-Google-Smtp-Source: ABdhPJyQ+DL7qDKH3YsIUl8R6ZI+YVf+VlM/80iVcWJIL+opE0hCMTL+s+EECMXJ3hDnBHuyiPrigA==
X-Received: by 2002:a02:7fcf:: with SMTP id r198mr30732372jac.24.1600449796568;
        Fri, 18 Sep 2020 10:23:16 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z26sm1983844ilf.60.2020.09.18.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 10:23:15 -0700 (PDT)
Received: (nullmailer pid 3819029 invoked by uid 1000);
        Fri, 18 Sep 2020 17:23:13 -0000
Date:   Fri, 18 Sep 2020 11:23:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, devicetree@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Viorel Suman <viorel.suman@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: fsl_xcvr: Add document for XCVR
Message-ID: <20200918172313.GA3818893@bogus>
References: <1600247876-8013-1-git-send-email-viorel.suman@oss.nxp.com>
 <1600247876-8013-3-git-send-email-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600247876-8013-3-git-send-email-viorel.suman@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 12:17:56 +0300, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> XCVR (Audio Transceiver) is a new IP module found on i.MX8MP.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,xcvr.yaml        | 104 +++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Error: Documentation/devicetree/bindings/sound/fsl,xcvr.example.dts:29.30-31 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:342: Documentation/devicetree/bindings/sound/fsl,xcvr.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1366: dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1365072

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

