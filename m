Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF1E21D984
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgGMPHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 11:07:16 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37108 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMPHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:07:16 -0400
Received: by mail-il1-f195.google.com with SMTP id r12so11446881ilh.4;
        Mon, 13 Jul 2020 08:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pHpt5SwD6m1N55GTUmnbnoaiwxYgmOCvx0BMGHfX29g=;
        b=lmUXlNzbssze9B6Cp9tPI9aseWu7VlXeJCQ2D1OdIUrbizX/xgU7imGrD0KDbNNlOw
         S0+jRtrqw0X+KGyoqDthccXI8PPchwsRIlmO6Ez4sCMBcxcQaL8Uo5cVzdxkBa7FhhwN
         4YLKTc8AAoKt5m+sYWpQ1JYaU/9iY+VNIs3b+4gcLfSDPZjZfA0XKm/zj5+mIWoxBDZ3
         sKW/On7dbHs8rCVUk93ky0IobUPkhV/Xk09lkKv1gijN2AfdMhppW/2ULwnUwJ15ZdB9
         n+a3u61DOJiHHT1xaX2REY59H4w+EeR9wm+IjEjnQoKEJdly2MB6auX8G+QQ0UuNDTIi
         cdSg==
X-Gm-Message-State: AOAM530TKHm9jueWcC4q/37oi9plUhikc6+e7HDzjyx5oVxp57O/Qe3r
        zVWq+hUEJ2XjEcYj1zQqYNlyoiY4vw==
X-Google-Smtp-Source: ABdhPJx3j0pYrhCL9vSAPbhONYWnb2rPd5KKOByG7Kdys9V3v3aw3L2F6899E/w/ovzPl/XD+ukejg==
X-Received: by 2002:a92:290a:: with SMTP id l10mr134748ilg.204.1594652835351;
        Mon, 13 Jul 2020 08:07:15 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b6sm340318iow.35.2020.07.13.08.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 08:07:14 -0700 (PDT)
Received: (nullmailer pid 184933 invoked by uid 1000);
        Mon, 13 Jul 2020 15:07:13 -0000
Date:   Mon, 13 Jul 2020 09:07:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     robh+dt@kernel.org, balbi@kernel.org, cheol.yong.kim@intel.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        p.zabel@pengutronix.de, yin1.li@intel.com, kishon@ti.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: phy: Add USB PHY support for Intel
 LGM SoC
Message-ID: <20200713150713.GA184301@bogus>
References: <20200713085453.7353-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200713085453.7353-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713085453.7353-2-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 16:54:52 +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add the dt-schema to support USB PHY on Intel LGM SoC
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/phy/intel,lgm-usb-phy.yaml#


See https://patchwork.ozlabs.org/patch/1327785

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

