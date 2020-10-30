Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018362A0E76
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgJ3TSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:18:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44534 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgJ3TRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:17:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id m26so6501951otk.11;
        Fri, 30 Oct 2020 12:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nxrkk9Iv2AWHaT0WKNIzblJXKtrPRJSPWGObFgk4jlk=;
        b=d8WRUW4Ab7RdSMun15JtaK0Suxw3v7XwRbbGGKCfeHfhGrbshWBFUAp8vp0rJj2Bzw
         FQ9pt1C/mEJhboFpEsyCnAYhplSaQuiri6pk/ossBpL+dX0trQQfxSP33QDXedtjLKf+
         p19wbLiZ7+ayFDZJkrrpshIwtHSqnG+aAPir6QT4VyU6CB04f5ougiMrijtmwYErNDoC
         BX6nOCEeZjdoTrBa2Va1DRFSqxp6qJlIkylogVynLWpGXRpYA1IaeP6wesckrfto2Jhq
         yTtQYpjZH874GwXUDnem9Vp/V40zIVIvMPicDilo1Bel4Zrkf1eVLOWTI6zUJDdy462G
         4KBw==
X-Gm-Message-State: AOAM530N+lBufkmMJRKOuWSVaG/rPfNJ5TPmCmR3NGu4F0jhPK2o6orI
        3KN8/Rn9MMkffM5XpdkWSg==
X-Google-Smtp-Source: ABdhPJygQrcQk8DOYwH2JCmsyvPO4Db+UAz26pVxZPE6H/WdMPDJmz4K5Wf5ocx97hzjSEuCVTz6xw==
X-Received: by 2002:a9d:da7:: with SMTP id 36mr2891601ots.288.1604085436239;
        Fri, 30 Oct 2020 12:17:16 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w25sm1437531otq.58.2020.10.30.12.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 12:17:15 -0700 (PDT)
Received: (nullmailer pid 4171668 invoked by uid 1000);
        Fri, 30 Oct 2020 19:17:14 -0000
Date:   Fri, 30 Oct 2020 14:17:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: mmsys: add mt1867 binding
Message-ID: <20201030191714.GA4171611@bogus>
References: <20201027160631.608503-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027160631.608503-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 17:06:29 +0100, Fabien Parent wrote:
> Add binding documentation for MT8167 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
