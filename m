Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5418E1E87EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 21:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgE2TfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 15:35:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39555 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2TfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:35:22 -0400
Received: by mail-io1-f66.google.com with SMTP id c8so576204iob.6;
        Fri, 29 May 2020 12:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K+8oODuIJJlgOYAdm3XpisFUzSxf3770j6ZePOvGk44=;
        b=XHXPzw9g4JrFd3amtk3y9T8vG1p/zhgwR2DNOrJV1o7s/nRu0tvSUWRqLx2Avz7ZWC
         iCtl+Jd9xATo2BL1OLpzWSKWyD5xIiDo2iTkqv+fjXwfn5L05cbYbFbaqD5GFQWQSU67
         S4RcY8c4VNgiF+3orPmVJ0EYartGhGlHFAsV7cl1DZlseoytHcmf1VEsvnrN0FU8N4H2
         s5aopERpQobipI1aNeRL9rc5kPJsfTB4Ud2KbFogebixscibMuT7a5BlMJMcd9CyPIeU
         TJlOWhDY9ayqsLhbc1DqYokdPty89EqOVw+yVPcedTXrwoef37UC43F8VorrIDLth3ub
         UAEQ==
X-Gm-Message-State: AOAM530yGRGH7NDU7Y9Dve7yyGhm/FTVH1Ffu5JU3oQQxSw1wIUIvhTn
        YrgPHU8BOmhkDw9qE/BZYQ==
X-Google-Smtp-Source: ABdhPJzlykGOMGA18ZHfJqZZdIz58+sAfzYAzgfIsUHbnQ68QvNYeae9MbD48Dl3iaZEXU/cOVRdAA==
X-Received: by 2002:a6b:4402:: with SMTP id r2mr7926855ioa.168.1590780921450;
        Fri, 29 May 2020 12:35:21 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f1sm5332697ilh.17.2020.05.29.12.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:35:20 -0700 (PDT)
Received: (nullmailer pid 2813064 invoked by uid 1000);
        Fri, 29 May 2020 19:35:19 -0000
Date:   Fri, 29 May 2020 13:35:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     paul.liu@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Linux-imx@nxp.com, broonie@kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH V2] dt-bindings: regulator: Convert anatop regulator to
 json-schema
Message-ID: <20200529193519.GA2812981@bogus>
References: <1590717551-20772-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590717551-20772-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 May 2020 09:59:11 +0800, Anson Huang wrote:
> Convert the anatop regulator binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- remove definition of "regulator-name" which is a standrad property;
> 	- add "unevaluatedProperties: false".
> ---
>  .../bindings/regulator/anatop-regulator.txt        | 40 ---------
>  .../bindings/regulator/anatop-regulator.yaml       | 94 ++++++++++++++++++++++
>  2 files changed, 94 insertions(+), 40 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/anatop-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/anatop-regulator.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
