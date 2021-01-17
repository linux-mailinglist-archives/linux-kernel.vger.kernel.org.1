Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857392F93AE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 16:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbhAQPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 10:46:53 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34640 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728700AbhAQPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:46:41 -0500
Received: by mail-ot1-f41.google.com with SMTP id a109so13875794otc.1;
        Sun, 17 Jan 2021 07:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=PTotAZhSSm438Bu/WUQLR5qH93sUEgjylw55X3hmUXw=;
        b=pD8XFF43aFzUA/rFTNCpDjMPsywTBplsROPVqVBnvkuX5m7tzyQ1ZDKHDdZUQLNUNc
         sAn87Z/XDOyhLcBYEg4mlYcVOFVdBJP+gaFfIRETu8kHlnZ4MPfI+F6rQG6AoguAFYv1
         8yOfsfEbktwJNLaEt8GTmKS9suq3B/w3Pc7rNm+U4/mmrDjj/+vSOnAvh6Yt/6zSpGT9
         hSqUSsgWO7WhKlBCftPYyaaIoErlNOxpop2yC9U4lZFBN36DCpd1RkKEXp3cfSdsTHzi
         /hLFKm2aZ6D106dtaG3cDkOk+PTqtZ7bJwJffnTUItAbokyBlN78noOPV38dY9P4/xmO
         4ukw==
X-Gm-Message-State: AOAM530hucImbwh6mRmN6WjMY5i7fXZpB2rHMVyEJy46RbBDzIo2mCIb
        eIc92E9bAj014LeC87Ktow==
X-Google-Smtp-Source: ABdhPJxii5/HuMzsbG4NX1Ab/sbfdB1KqtQW/Jhxrz3bTzKk40K1916fc9lOvEWz7PEcUYxqCrUjZQ==
X-Received: by 2002:a9d:8e7:: with SMTP id 94mr15156818otf.93.1610898359938;
        Sun, 17 Jan 2021 07:45:59 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w129sm2762307oig.23.2021.01.17.07.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 07:45:58 -0800 (PST)
Received: (nullmailer pid 1730307 invoked by uid 1000);
        Sun, 17 Jan 2021 15:45:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux@roeck-us.net,
        gregkh@linuxfoundation.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org, gene_chen@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com, heikki.krogerus@linux.intel.com,
        linux-usb@vger.kernel.org
In-Reply-To: <1610720001-15300-2-git-send-email-u0084500@gmail.com>
References: <1610720001-15300-1-git-send-email-u0084500@gmail.com> <1610720001-15300-2-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH 2/2] usb typec: tcpci: mt6360: Add vbus supply into dt-binding description
Date:   Sun, 17 Jan 2021 09:45:57 -0600
Message-Id: <1610898357.197444.1730305.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 22:13:21 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add external vbus source into dt-binding description.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml: properties:vbus-supply: 'maxItems' is not one of ['description', 'deprecated']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml: ignoring, error in schema: properties: vbus-supply
warning: no schema found in file: ./Documentation/devicetree/bindings/usb/mediatek,mt6360-tcpc.yaml

See https://patchwork.ozlabs.org/patch/1427073

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

