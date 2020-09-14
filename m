Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2012696A9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgINUbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:31:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38770 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgINUbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:31:18 -0400
Received: by mail-io1-f66.google.com with SMTP id h4so1586217ioe.5;
        Mon, 14 Sep 2020 13:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ertsEXNzBAqBMP0DR44vwXjpmpZeyhjOeESoguCTNWM=;
        b=NFZXXgdWIQ3uGOoIFNbuw4iJLWmtL7GwPHF0t28Gv6h1TEH6q34/UPdJ5nRE6Ne3yq
         mdkv9ndvxTTH30x6vAsj4rqeZSTzEc9qDKJ4YNR010CjRSylU/B7oMPqhi3X8y9uctKz
         pJpCa/BmYqj+EnB/dYlpRiVsKxUTkz+faBdep6/ZjAXXIEY0ynN10N/bVDUn9jw+F1+D
         0fUx+7ZRfzA14oDPALQn4uf1zy20IRiUgGcx8/Iaa3CvMBafm7E/13Bm5/v8wDEhpmX3
         LTOe2VhI9IknGWw1KYMfDyh6JTBvp2vSlPjhSRoJ4HJr9tjMkqNUKMhlYmWuwwNrT/8j
         doRg==
X-Gm-Message-State: AOAM533GHQ1HKNtX095ZADrYbOz5Wn6EkNYTVHmr8Oa0BR+Nn42RQVpj
        ml794AnEjFdUxTWXeZl5Yg==
X-Google-Smtp-Source: ABdhPJxJufdcERasZD1eQUMk0+yl6OsHc5GWVtQxStAhsjs6Dso/8xuXPgJ5BA0AjX/GgeKyjVrt7g==
X-Received: by 2002:a02:62c9:: with SMTP id d192mr15087711jac.59.1600115472878;
        Mon, 14 Sep 2020 13:31:12 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k16sm6428003ioc.15.2020.09.14.13.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:31:12 -0700 (PDT)
Received: (nullmailer pid 191374 invoked by uid 1000);
        Mon, 14 Sep 2020 20:31:10 -0000
Date:   Mon, 14 Sep 2020 14:31:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: add Hisilicon
 SD5203 vector interrupt controller
Message-ID: <20200914203110.GA185427@bogus>
References: <20200903120504.2308-1-thunder.leizhen@huawei.com>
 <20200903120504.2308-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903120504.2308-2-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 08:05:03PM +0800, Zhen Lei wrote:
> Add DT bindings for the Hisilicon SD5203 vector interrupt controller.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../hisilicon,sd5203-vic.txt                  | 27 +++++++++++++++++++

Bindings should be in DT schema format now.

>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,sd5203-vic.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,sd5203-vic.txt b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,sd5203-vic.txt
> new file mode 100644
> index 000000000000..a08292e868b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,sd5203-vic.txt
> @@ -0,0 +1,27 @@
> +Hisilicon SD5203 vector interrupt controller (VIC)
> +
> +Hisilicon SD5203 VIC based on Synopsys DesignWare APB interrupt controller, but
> +there's something special:
> +1. The maximum number of irqs supported is 32. The registers ENABLE, MASK and
> +   FINALSTATUS are 32 bits.
> +2. There is only one VIC, it's used as primary interrupt controller.
> +
> +Required properties:
> +- compatible: shall be "hisilicon,sd5203-vic"
> +- reg: physical base address of the controller and length of memory mapped
> +  region starting with ENABLE_LOW register
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: number of cells to encode an interrupt-specifier, shall be 1
> +
> +The interrupt sources map to the corresponding bits in the interrupt
> +registers, i.e.
> +- 0 maps to bit 0 of low interrupts,
> +- 1 maps to bit 1 of low interrupts,
> +
> +Example:
> +	vic: interrupt-controller@10130000 {
> +		compatible = "hisilicon,sd5203-vic";
> +		reg = <0x10130000 0x1000>;
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +	};
> -- 
> 2.26.0.106.g9fadedd
> 
> 
