Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8446B27D7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgI2UXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:23:55 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:36446 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2UXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:23:54 -0400
Received: by mail-oo1-f66.google.com with SMTP id z1so1627315ooj.3;
        Tue, 29 Sep 2020 13:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jd1FxLymJc/YzHaAGx6NmU90BJBfukMsfxrohWVds+k=;
        b=BOjtaHet46Hg846CTgk7qH6HONirl67Kp/BVUStXaW/3+Rqwvs6u7omelmzgOiz32z
         Ir5GZRCrbIu0BNk/eY07yKm9aD5GqHQBV5tN4whL1ayqYtWzPACY+Fpj/pW9e3ypX0dJ
         w9r2gUlM+II6Gyr7arLlhZnGUAoMGi0ZSNQovGsWcE+GTgfDr9XLskREIVFZw3rIi7sg
         7JJ5HAdG5Ftey10UW39quJyar3TarA2jaoJ8UVvX0QBamQPbZA8UxcjO9vbGAuJYsuAi
         N+7/mDNistxkwkb35oqyx2ixMFauxRsQZ63CgZQydWHo3zrwe++AXBlWwWPS402pCoDN
         v/KQ==
X-Gm-Message-State: AOAM530DgOIzYig6tWBI0eFQAwa8Yl06DU2J9AL6iVmUVIJFq3TdXn1X
        lEqxPNWFf9IWtSbUvYE5vg==
X-Google-Smtp-Source: ABdhPJyB71E9htTRoafNEHMrFCnWNqpGg67eNiNsnVoDobbWFMSi08d5WwUMIwlDyFhgSJey1AZo2A==
X-Received: by 2002:a4a:864b:: with SMTP id w11mr5873590ooh.67.1601411032435;
        Tue, 29 Sep 2020 13:23:52 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f29sm3113599ook.44.2020.09.29.13.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:23:51 -0700 (PDT)
Received: (nullmailer pid 1103765 invoked by uid 1000);
        Tue, 29 Sep 2020 20:23:50 -0000
Date:   Tue, 29 Sep 2020 15:23:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Libin <huawei.libin@huawei.com>
Subject: Re: [PATCH v6 1/1] dt-bindings: dw-apb-ictl: convert to json-schema
Message-ID: <20200929202350.GA1103692@bogus>
References: <20200929024811.2245-1-thunder.leizhen@huawei.com>
 <20200929024811.2245-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929024811.2245-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 10:48:11 +0800, Zhen Lei wrote:
> Convert the Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
> binding to DT schema format using json-schema.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../interrupt-controller/snps,dw-apb-ictl.txt      | 43 --------------
>  .../interrupt-controller/snps,dw-apb-ictl.yaml     | 68 ++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
