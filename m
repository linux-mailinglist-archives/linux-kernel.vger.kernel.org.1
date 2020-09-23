Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4887E2762AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgIWU7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:59:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36995 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIWU7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:59:07 -0400
Received: by mail-io1-f67.google.com with SMTP id y13so1015627iow.4;
        Wed, 23 Sep 2020 13:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jx+DRH+laqTempA43xvLH4y04r2W2rrlx1UKuCP5ZWA=;
        b=NhaMRhwCnpIwzwf7AjMbMWmVvym00ryx2YKwr8PFaOPr7gPV6AFGGTjWxLBTw3A4qY
         TTTQTWf/Ck/0LpJFVxNolukut/bUmGI30R+GFa9hNkZLhWMTPw80yzUvnJ5hEat3jQrP
         3OcTue+rs0kOLjIKcOIfP7Lu+SclsEYOj1oN5lr2Uup8gIfG1IUgEyM9iF+ApHJ74Yhi
         MnhRD+Dt74AweMlXjYMsrRrZYC9YyDjAh6jx4b/yrs0lAts/U8DhwXfusakqehCbHgcf
         C5eNa3yTwlfYTctZzVYa+MdtsXpELeUtjzHUW4749oL5WUJ3+f1HC11DiOXz1T4Y8HjA
         kBwA==
X-Gm-Message-State: AOAM5318R9E573UlnkBnmeLh9uMerHnShylFut0f3QUyq59cjsxIpp9n
        9SPU9njHdp7kzRm0SmH8xKG4GdBFqX3O6Kg=
X-Google-Smtp-Source: ABdhPJy0F4abhRQCPomOOYg2omQnHDmkDY0ev6cKjNKFxR4ckfnEsz1vTO2s2e8OIr3C8/mBzjqaQA==
X-Received: by 2002:a02:c8c8:: with SMTP id q8mr1068933jao.46.1600894746473;
        Wed, 23 Sep 2020 13:59:06 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t22sm447429ili.9.2020.09.23.13.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:59:05 -0700 (PDT)
Received: (nullmailer pid 1297453 invoked by uid 1000);
        Wed, 23 Sep 2020 20:59:05 -0000
Date:   Wed, 23 Sep 2020 14:59:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: hisilicon: add binding for
 SD5203 SoC
Message-ID: <20200923205905.GA1296543@bogus>
References: <20200919064555.3616-1-thunder.leizhen@huawei.com>
 <20200919064555.3616-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919064555.3616-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 02:45:52PM +0800, Zhen Lei wrote:
> Add devicetree binding for Hisilicon SD5203 SoC.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 5 +++++
>  1 file changed, 5 insertions(+)

Please convert this to DT schema format first.

> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> index a97f643e7d1c760..5d80070bfb13fc0 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> @@ -56,6 +56,11 @@ HiP07 D05 Board
>  Required root node properties:
>  	- compatible = "hisilicon,hip07-d05";
>  
> +SD5203 SoC
> +Required root node properties:
> +	- compatible = "hisilicon,sd5203";
> +
> +
>  Hisilicon system controller
>  
>  Required properties:
> -- 
> 1.8.3
> 
> 
