Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697EC2A993F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgKFQPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:15:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42515 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFQPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:15:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id w145so1836025oie.9;
        Fri, 06 Nov 2020 08:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JKTC9t6U56PdRSRllEeWLwbdLXcSPIAe13lQUZ7E930=;
        b=h0l/rECBx07Qu9q3Ucm2HMr4e6uC3PsP23sbW+kXJT8H2gh1R9TiDBPb5xJ5f+E012
         XLarOFE3UQYA31ec7l6ABq88iI3VHn675ILRz5rbn0wtfABAPTn6CTDeWcxnnbmBic1u
         wtu0i3QMRP8cAFju0JR41hKfGdQBkc0Ox/fdM5TqRuIfmTqtctevVYl6ySfy75fp50+M
         Qz7hCSsLSYsx9jf66BmDvrqo0MTHaUcWoRR8JhMCvtfGUUM5TBKh/Cfc27u0gHW3M3Oj
         0wvklJ8fGpbzZbjzXDSOC7J+FrCkmFD0bMFMOPcplHPU2KvhdE5/NbCVasln5qBxgLoA
         XiJQ==
X-Gm-Message-State: AOAM5335Zgd+Ws+t2QzHjlqFAhBuun+VhTQkji/IsnihPyyCxYJL7l6F
        Rdta4ZhULoIlwWuY7tOlMg==
X-Google-Smtp-Source: ABdhPJyrNJ22bUa+bEB3u2wV8J2lLCG70ySvIv54k7b/vpLloNjlu10MYF+8PMmPZQweX552ICB7lg==
X-Received: by 2002:aca:4454:: with SMTP id r81mr1481777oia.43.1604679341288;
        Fri, 06 Nov 2020 08:15:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u16sm402311ooj.8.2020.11.06.08.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 08:15:40 -0800 (PST)
Received: (nullmailer pid 3296044 invoked by uid 1000);
        Fri, 06 Nov 2020 16:15:39 -0000
Date:   Fri, 6 Nov 2020 10:15:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: dt-bindings: sun8i-codec: Increase
 #sound-dai-cells
Message-ID: <20201106161539.GA3295779@bogus>
References: <20201106041513.38481-1-samuel@sholland.org>
 <20201106041513.38481-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106041513.38481-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020 22:15:07 -0600, Samuel Holland wrote:
> Increase sound-dai-cells to 1 to allow using the DAIs in the codec
> corresponding to AIF2 and AIF3.
> 
> The generic ASoC OF code supports a #sound-dai-cells value of 0 or 1
> with no impact to the driver, so this is a backward-compatible change.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.example.dt.yaml: audio-codec@1c22e00: #sound-dai-cells:0:0: 1 was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml


See https://patchwork.ozlabs.org/patch/1395481

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

