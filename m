Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AB92214DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 21:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgGOTHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 15:07:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35723 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgGOTG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 15:06:58 -0400
Received: by mail-io1-f66.google.com with SMTP id v8so3447449iox.2;
        Wed, 15 Jul 2020 12:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jno93+SekzksiRMw8XaCQpKWQNtPwJXK6kxizzByIZA=;
        b=bEk2EagMIMzaZM9v7+OWMb1ielzmnZjKavq/bViNC0giLsprCEx6PS2qETs/YC21Zb
         U37qkhCIssPGqaWbmC9dVAx1Rqyhy4k4uk/1v+dKkSfSXj/+V8AgHuU+gncisZm0DjZE
         KRJbJ7ifwehbN8r+abtah1pKU6LFa5Rf3hlb3vaoyirEOpEU12xXO0lwrvBwEGKrN9Z6
         yXlmrAbFQpR+JHQj7+rYpTHtNpVoMj+WbQLzpz5nkuKNXft3n3VlWT9ufZmvY488kCy/
         H7lUgK1Y3W50S/soaJK5bWcBA6kqdAu/Blo4PgAtnhfMtxK5+P4xNyUZcZZ+SQ7u3sbL
         E2XA==
X-Gm-Message-State: AOAM530mpXCc4q7Bid1A0kKTaNRB56MsimYL6W+5alLBGzt718mlQaTS
        pNWXJbITuzsA0VMOeBQmow==
X-Google-Smtp-Source: ABdhPJxaI60mevvS3ihbp2eUo+tIkZk2660IIqqpr0Dc8tHcZTbING24Cchf10COIM6sdj0TWrcbWg==
X-Received: by 2002:a02:a909:: with SMTP id n9mr952808jam.70.1594840018185;
        Wed, 15 Jul 2020 12:06:58 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id g1sm1477197ilk.51.2020.07.15.12.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 12:06:57 -0700 (PDT)
Received: (nullmailer pid 649392 invoked by uid 1000);
        Wed, 15 Jul 2020 19:06:56 -0000
Date:   Wed, 15 Jul 2020 13:06:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH] dt-bindings: mfd: Add bindings for the Mediatek MT6360
 PMIC
Message-ID: <20200715190656.GA647195@bogus>
References: <1592306876-3504-1-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592306876-3504-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 07:27:56PM +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add devicetree binding document support Mediatek MT6360 PMIC
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6360.txt | 53 ++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mt6360.txt

Bindings are in DT schema format now.

Rob
