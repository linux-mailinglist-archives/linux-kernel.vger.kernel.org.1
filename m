Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA93290A70
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbgJPRRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:17:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46824 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731820AbgJPRRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:17:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id s81so3181181oie.13;
        Fri, 16 Oct 2020 10:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ERbnFskVROyz/pusq0tPmpG01bF6U8YGRnegt7uD+BQ=;
        b=KOTIWHSGHtEX2rgPk+1FE7te3HKaXBeqKDTWdGxBCaaNKoyMFkKw1GVoQLd84lpokU
         sKYoy0avvpc8hg2u64TSYAEWHdW9fnOGPDoK3Sft3/G7YxdUFB1DS9EdjVxMF0cvuDfi
         4omsHd6mfWoQ7ZGtdWgpBUzgUYFmzM7kvJJaNxw3yQBzamUJTM4sjpniItWtyW/zKuJf
         nJKcGhMiRoZ/8nIjbYMF2PvxIHotMW8ycKhM8O59ktPyoHFXAn4LhZ6vvezvtjTy0Qf/
         QZ08IHuwl49202zPfdD8MvTjpbeCfPqR/klURboNhcE4sMNN3R1oxAFaKJOkuGCFYmPe
         MoaA==
X-Gm-Message-State: AOAM532LCdQkE3ZHh0sfY6+DiEIAi+uvv26I7UWrfhmZxQyCKuEIaOpJ
        0Fyg7TnslQ2vAE3I9yLGmw==
X-Google-Smtp-Source: ABdhPJzkHaNyeKJvhTFdbLO/y2u79BYQP6B4K5spT7qIr+MdGwla4Ht7FPubs9pHpSp9hmW7GPF0kQ==
X-Received: by 2002:aca:52c4:: with SMTP id g187mr2972481oib.101.1602868671744;
        Fri, 16 Oct 2020 10:17:51 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t29sm1138160otd.51.2020.10.16.10.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 10:17:51 -0700 (PDT)
Received: (nullmailer pid 1597850 invoked by uid 1000);
        Fri, 16 Oct 2020 17:17:50 -0000
Date:   Fri, 16 Oct 2020 12:17:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linuxppc-dev@lists.ozlabs.org,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/2] ASoC: dt-bindings: fsl_xcvr: Add document for XCVR
Message-ID: <20201016171750.GA1597815@bogus>
References: <20201013121733.83684-1-viorel.suman@oss.nxp.com>
 <20201013121733.83684-3-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013121733.83684-3-viorel.suman@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 15:17:33 +0300, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> XCVR (Audio Transceiver) is a new IP module found on i.MX8MP.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,xcvr.yaml   | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,xcvr.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
