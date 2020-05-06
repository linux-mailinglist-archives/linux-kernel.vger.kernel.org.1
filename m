Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B227B1C7A50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgEFTd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 15:33:57 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:39131 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgEFTd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:33:57 -0400
Received: by mail-oi1-f181.google.com with SMTP id b18so2832460oic.6;
        Wed, 06 May 2020 12:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RWW3FtYqRLY2smPmY8wcoeQaDQn8dGIqKzfuWpPg+Qw=;
        b=ZtLWKvFe7zanSA4nemjsUyUr8NEl9FOatv7r/w6zQPqcOkgKnKsMeA8CQFpLE5Crs6
         RnPVuXxqHdS/6X7csLn8Yt57uyQChuWEzRojiOTJEqn0VEdkO/oQg+T7UY1gGeVZ9rVl
         8GRDd3eQAloXgezIYoES1ZDJwVqAK3KZ/m/DvckkGPWI23/VHSJheU29QB/hbTcF+uen
         8e+XEdUPaOsSgWJfAZAC5Ac8QRwCpnl7t0fS2vu632xtHgF56i/HRGJCdR0CRZNE4M4q
         HSXSi80ja6HvtZbUOS2Hw7g0jlq8bhff/V6mVY/zCYPO79rso7wPtYsh9rhwLTy0SuaJ
         zX1A==
X-Gm-Message-State: AGi0Puai5A6ezcWmS3QZago43eD3z+/a00Lc9kYNiKyfGMV6Knd2vT0t
        h2VnNaQSGre9m4cvVbAX6Q==
X-Google-Smtp-Source: APiQypKd4kU6bak2GBtnfCbu10qGsReR/+gbrmh9MTOYL2MpcjvgUyCBKGJ90D8hW5VPYqweChgoAQ==
X-Received: by 2002:a05:6808:b36:: with SMTP id t22mr3954129oij.121.1588793635891;
        Wed, 06 May 2020 12:33:55 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f73sm738750otf.53.2020.05.06.12.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 12:33:55 -0700 (PDT)
Received: (nullmailer pid 13821 invoked by uid 1000);
        Wed, 06 May 2020 19:33:54 -0000
Date:   Wed, 6 May 2020 14:33:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, devicetree@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/4] dt-bindings: display: Add ilitek-9341 binding
Message-ID: <20200506193354.GA12607@bogus>
References: <1588746693-31078-1-git-send-email-dillon.minfei@gmail.com>
 <1588746693-31078-2-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588746693-31078-2-git-send-email-dillon.minfei@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 May 2020 14:31:33 +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> add ili9341 for stm32f429-disco board
> some hardware resources can be found here
> https://www.st.com/zh/evaluation-tools/32f429idiscovery.html
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>  .../bindings/display/panel/ilitek,ili9341.yaml     | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/panel/ilitek,ili9341.example.dts:21.13-23: Warning (reg_format): /example-0/display@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/display/panel/ilitek,ili9341.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/panel/ilitek,ili9341.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/panel/ilitek,ili9341.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/panel/ilitek,ili9341.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/display/panel/ilitek,ili9341.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.example.dt.yaml: display@0: 'spi-3wire', 'spi-max-frequency' do not match any of the regexes: 'pinctrl-[0-9]+'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.example.dt.yaml: display@0: compatible: Additional items are not allowed ('ilitek,ili9341' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.example.dt.yaml: display@0: compatible:0: 'ilitek,ili9341' was expected
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.example.dt.yaml: display@0: compatible: ['stm32f429-disco,ltdc-panel', 'ilitek,ili9341'] is too long

See https://patchwork.ozlabs.org/patch/1284139

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
