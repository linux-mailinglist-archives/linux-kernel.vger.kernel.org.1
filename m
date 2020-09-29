Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83E27D31B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 17:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgI2Psu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 11:48:50 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33850 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgI2Pst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:48:49 -0400
Received: by mail-oi1-f178.google.com with SMTP id n2so5970910oij.1;
        Tue, 29 Sep 2020 08:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JVFwpNrq1SIlzGPYHpvVMOxGitI2JeKtHPxEZUWE+YU=;
        b=H7QHe+ceuw3wY6tAtxilDv4WcqvHlrdUvNskm92THs+LwziFrUrO4kn3T5lY1eslHY
         iE2kcL6BeS310Kev29bQmPnuHGyQuHDVooeJMGS32YTJrDCOUKXD0eDbSKBMMGe+jIzX
         HUPrAC8YBZ1vokeLgYg/xNtiWhvgCWoWJ7L5/0A49fdSKFTN9FmLWLn0KqQCXT0JtXyz
         bPpVwpSTf661J7OKvZH4RivNSPq695OfOfLqEnFTKy6Vcc2jE5hXWyvBNaAG7r0nAviH
         xfXe0C3khaa0cQZD6iIUkcFWlvffQYo3zhOONa3rF+pSRNZFwqPDg7da7smBdI4QMQq1
         youA==
X-Gm-Message-State: AOAM532k3fClKGBhmbUNcV+JXcCxn98pIh9bwrWsiRW1rmbFpqy6rrZo
        /nGXukUEVB8Eo6uzmJDJHBGIjpyXrwya
X-Google-Smtp-Source: ABdhPJzSNzJP5DPJRFA+qMMldts+IB6wvoeLlHF6lW8kriWq9WfG35nyDzUE8rvIg+GDmnAEqgPUug==
X-Received: by 2002:aca:d549:: with SMTP id m70mr2987760oig.49.1601394527334;
        Tue, 29 Sep 2020 08:48:47 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e22sm1140797oib.18.2020.09.29.08.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 08:48:46 -0700 (PDT)
Received: (nullmailer pid 662454 invoked by uid 1000);
        Tue, 29 Sep 2020 15:48:45 -0000
Date:   Tue, 29 Sep 2020 10:48:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Crystal Guo <crystal.guo@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, yingjoe.chen@mediatek.com,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        seiya.wang@mediatek.com, fan.chen@mediatek.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, stanley.chu@mediatek.com,
        robh+dt@kernel.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, yong.liang@mediatek.com
Subject: Re: [v5,1/3] dt-binding: reset-controller: mediatek: add YAML schemas
Message-ID: <20200929154845.GA662033@bogus>
References: <20200929134642.26561-1-crystal.guo@mediatek.com>
 <20200929134642.26561-2-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929134642.26561-2-crystal.guo@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 21:46:40 +0800, Crystal Guo wrote:
> Add a YAML documentation for Mediatek, which uses ti reset-controller
> driver directly. The TI reset controller provides a common reset management,
> and is suitable for Mediatek SoCs.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>  .../bindings/reset/mediatek-syscon-reset.yaml | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/mediatek-syscon-reset.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/reset/mediatek-syscon-reset.example.dt.yaml: example-0: infracfg@10001000:reg:0: [0, 268439552, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml


See https://patchwork.ozlabs.org/patch/1373428

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

