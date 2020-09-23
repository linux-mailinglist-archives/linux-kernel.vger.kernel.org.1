Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619A927622E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgIWUcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:32:54 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37718 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWUcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:32:54 -0400
Received: by mail-il1-f195.google.com with SMTP id q4so923198ils.4;
        Wed, 23 Sep 2020 13:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l38fUYlJKpk/9OHd8y2HNij7IP3dpcOLc/B2f1OuyZ8=;
        b=co1B9gXv9fiCIbHtb7gOwX3vgbQ4vU6/a3q2pd1C9uszsOY0nm2WRjGGri5017jf21
         NE+fWuecUbmfe7VN7RzuGAr/CyAirCTHIybOjnHHbbuFzzfIcbUKP1jtTyV4sfvlOvvC
         voHJXkUyw5BSQvSGFlBD0GSVRTOW/yxh3KK4zwk7KdAowKFYOgmBVdyoDqxoHAQa7c0y
         TWxJSoWK7kzPpHRhiURSWksgiIPaYlPnRpovgkmZkUabzC0EdZf6o026eHKfRlBY/nVB
         qiVNe0CNXO2ik904B7G5J/hQpKtPhzr82T2AOWpttXfcRXpfK0afR1kz1Pj8VYN9p/tj
         gjfw==
X-Gm-Message-State: AOAM533tzceYV9StXhdFG/qdPZt6/oGRpo6PPBGbfDmFQ8kUr8UIVdDT
        jvrRfL/aohov/wKhPVXBFw==
X-Google-Smtp-Source: ABdhPJwN8CdqdU2e1412/M0XJ8hCqZkNOAvpcALfwSyCtBluit3xw9UfNl0bSICZUVIxbIJ0AtqP4w==
X-Received: by 2002:a92:a194:: with SMTP id b20mr1297741ill.53.1600893173000;
        Wed, 23 Sep 2020 13:32:53 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id l10sm352957ilm.75.2020.09.23.13.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:32:52 -0700 (PDT)
Received: (nullmailer pid 1255351 invoked by uid 1000);
        Wed, 23 Sep 2020 20:32:51 -0000
Date:   Wed, 23 Sep 2020 14:32:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: mfd: rohm,bd71837-pmic: Add common
 properties
Message-ID: <20200923203251.GA1255317@bogus>
References: <20200917193754.542-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917193754.542-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 21:37:54 +0200, Krzysztof Kozlowski wrote:
> Add common properties appearing in DTSes (clock-names,
> clock-output-names) with the common values (actually used in DTSes) to
> fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml:
>     pmic@4b: 'clock-names', 'clock-output-names', do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Define the names, as used in existing DTS files.
> ---
>  .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
