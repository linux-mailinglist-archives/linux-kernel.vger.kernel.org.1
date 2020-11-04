Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D532A7096
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 23:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbgKDWem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 17:34:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39696 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgKDWem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 17:34:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id z16so290317otq.6;
        Wed, 04 Nov 2020 14:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=De/asBW+7ACsxJA0V0dI5OfXqmfuP7smHiv8mpwjXZ0=;
        b=X7yybQyZ6x2kvyi7EQ0eH1ZL3mvclkC1ezJY+ygugDZ2XqpsCAtRiWdNUOKk0+i5vE
         /ldaDZtJ+HZyKC0WOxcXDQ9iGVj1mFlqB5NyEJ1h7hAWPY5+0r8gqs2rLMLHyl7yBeH/
         up4U7Q0B2p376ovQv6ks8xkRoaq1GqUGa8vlo1wWy3B+hzmOmENLYNhf6xipayUw7j4p
         q1jXZAluJi3/T40BIarl+leh7dz/ThBngoKleFGZ1qNAssyuiqXcBJ/1pXpHMcxDPxld
         hqtfPZsDW6aGeydlP09SjSujTDBFaaru/S/ftrTlOMFXpKHk9U3I6Y+G6e97XAoVGlq0
         l7QQ==
X-Gm-Message-State: AOAM531K8qYXo8fov+t9YECB0+iaQ7kZ1PkOURNGLAzfg6VKYZ/yeYbq
        07HFyx9D3GF46wTjsEsqou7FOrvpHA==
X-Google-Smtp-Source: ABdhPJydVci5YTxHwBge3dnN274lTktXyAPo9XcUv0uObEVs8L/tBdqo/1r1n3NVYXAsKnCx7SfmbA==
X-Received: by 2002:a9d:6e81:: with SMTP id a1mr19441014otr.303.1604529281700;
        Wed, 04 Nov 2020 14:34:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t83sm789898oie.58.2020.11.04.14.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 14:34:41 -0800 (PST)
Received: (nullmailer pid 48871 invoked by uid 1000);
        Wed, 04 Nov 2020 22:34:40 -0000
Date:   Wed, 4 Nov 2020 16:34:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, Xiubo.Lee@gmail.com,
        alsa-devel@alsa-project.org, festevam@gmail.com,
        linuxppc-dev@lists.ozlabs.org, broonie@kernel.org, perex@perex.cz,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org, timur@kernel.org,
        devicetree@vger.kernel.org, nicoleotsuka@gmail.com
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc
 for aud2htx module
Message-ID: <20201104223440.GA48821@bogus>
References: <1604281947-26874-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604281947-26874-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020 09:52:26 +0800, Shengjiu Wang wrote:
> AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
> IP module found on i.MX8MP.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v3:
> - Add additionalProperties
> 
> changes in v2:
> - fix indentation issue
> - remove nodename
> 
>  .../bindings/sound/fsl,aud2htx.yaml           | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
