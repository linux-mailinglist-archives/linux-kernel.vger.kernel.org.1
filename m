Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB592A06FF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgJ3NxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41893 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgJ3NxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id n15so5577052otl.8;
        Fri, 30 Oct 2020 06:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ggiAUaruNw1YhH2l2hRk36w59nO1Oq/R58cjSZ0WsS0=;
        b=NQE6B6Is7YpCRNAhftj2H74uBamRW+67DvSQtL+dIHoYsARDpaZMHRM1nrS3KUtJ1w
         5/p+B9b48PxrSSgxa+xe9uG0yPEyqWTKxJhCSRMrPpgqfM6Tqu8oGwmWQuQZpcV/WP/W
         iKL+n1j4zp6kZ0lltwhX8r/Q6pd1e23hnBEleCgijJzi/Dn93z0ppFzNII0SMOc6OWWE
         k2GOvrak9W99KSGT8k84Gz4sLwbchNTyOpcD1L0FQQxZK/tnq9dxXyVOLmwU0uYPBGxz
         8eqrVOMA3ZUUdLvyAJmepaI722FHJGwc7X5SZbdrrTBoPtq46IaCvPlNacTqc/m35Kxy
         XmgA==
X-Gm-Message-State: AOAM5339HoY/m7Glp0jCwASdOmJq7KunwwJHJ+M62qEmwwyU7pmSi8SN
        W5tVDcGYExCF8XH+26eSbA==
X-Google-Smtp-Source: ABdhPJxq/KhYrqN/T8NyxVmXEavGpBaGULf6IaWMFkIEntoJ3gOZgHkdXrgULkZisLkAOY1u63cuMg==
X-Received: by 2002:a9d:75d6:: with SMTP id c22mr1672627otl.213.1604065987144;
        Fri, 30 Oct 2020 06:53:07 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j184sm1386766oih.8.2020.10.30.06.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 06:53:06 -0700 (PDT)
Received: (nullmailer pid 3747758 invoked by uid 1000);
        Fri, 30 Oct 2020 13:53:05 -0000
Date:   Fri, 30 Oct 2020 08:53:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, srv_heupstream@mediatek.com,
        youlin.pei@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org, anan.sun@mediatek.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org, ming-fan.chen@mediatek.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: memory: mediatek: Convert SMI to DT
 schema
Message-ID: <20201030135305.GA3746616@bogus>
References: <20201030091254.26382-1-yong.wu@mediatek.com>
 <20201030091254.26382-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030091254.26382-2-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 17:12:52 +0800, Yong Wu wrote:
> Convert MediaTek SMI to DT schema.
> 
> CC: Fabien Parent <fparent@baylibre.com>
> CC: Ming-Fan Chen <ming-fan.chen@mediatek.com>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../mediatek,smi-common.txt                   |  50 -------
>  .../mediatek,smi-common.yaml                  | 140 ++++++++++++++++++
>  .../memory-controllers/mediatek,smi-larb.txt  |  50 -------
>  .../memory-controllers/mediatek,smi-larb.yaml | 129 ++++++++++++++++
>  4 files changed, 269 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml:84:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml:98:13: [warning] wrong indentation: expected 10 but found 12 (indentation)
./Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml:41:8: [warning] wrong indentation: expected 6 but found 7 (indentation)

dtschema/dtc warnings/errors:


See https://patchwork.ozlabs.org/patch/1390887

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

