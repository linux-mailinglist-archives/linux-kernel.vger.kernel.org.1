Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE002E202C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgLWRsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:48:47 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:40593 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgLWRsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:48:47 -0500
Received: by mail-oi1-f169.google.com with SMTP id p5so1227434oif.7;
        Wed, 23 Dec 2020 09:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Rr0nFPN4p679DDLwTxYppXUC5EeCz59OFolArwEDGvA=;
        b=VviM23emv0bBgwyJd7ijwR1RYJXAD5uvRkuLlcKRiPmIVaac68HaoPxfVCwRDHuKkT
         OOp3lVvJWEoTJHh8uVh9mSVVGkcHqyA+hD6XbGSA4k/ev3bvVSQIuSdQdQ0gLk//RrX6
         L4JbqVogGTRohs8H17p7LAahFylB0MHXBZ+rMY15Le82y2ldJeVw46emDVilq5PECEI/
         Do8IKUILiio8lTd44SshZL8SvDGZyI5wCqoAQnptk7lnNr0SNnO/hRA8NSZFBufkixSx
         sTJM2hlCd3cTIepTPws+lldmNzCviuk2SxwpwwKkkwC+XOVY7aIe7VcIN54NhtpDV49v
         mgww==
X-Gm-Message-State: AOAM531BtnN6W6ZFQRGSCqTGSbAN92JQTt/BWEvYo0wsZyFPNXG6yoXA
        c0ycvzc8AjZkrACLpXl/0rf2Gj0p1A==
X-Google-Smtp-Source: ABdhPJzBfy3Rah3zT1dynIO7KbDETi5PrZXKk2R+7VmVrYFEp6Y3VNVAsZVTj3UpT9omPZJ8aEIW9Q==
X-Received: by 2002:a05:6808:1a:: with SMTP id u26mr624430oic.77.1608745686107;
        Wed, 23 Dec 2020 09:48:06 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id g21sm5656666otj.77.2020.12.23.09.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 09:48:05 -0800 (PST)
Received: (nullmailer pid 762428 invoked by uid 1000);
        Wed, 23 Dec 2020 17:47:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     srv_heupstream@mediatek.com, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <1608725624-30594-2-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1608725624-30594-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1608725624-30594-2-git-send-email-hsin-hsiung.wang@mediatek.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: regulator: document binding for MT6315 regulator
Date:   Wed, 23 Dec 2020 10:47:58 -0700
Message-Id: <1608745678.803844.762427.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 20:13:42 +0800, Hsin-Hsiung Wang wrote:
> Add device tree binding information for MT6315 regulator driver.
> Example bindings for MT6315 are added.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  .../bindings/regulator/mt6315-regulator.yaml  | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/regulator/mt6315-regulator.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/mt6315-regulator.example.dt.yaml: example-0: pmic@6:reg:0: [6, 0, 11, 1] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

See https://patchwork.ozlabs.org/patch/1420117

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

