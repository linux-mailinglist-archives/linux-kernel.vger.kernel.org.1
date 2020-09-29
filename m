Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F9C27D802
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgI2UZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:25:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38675 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2UZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:25:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id 26so6946661ois.5;
        Tue, 29 Sep 2020 13:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bi9uLKYfvAgxWH5frQ9mn0nObt44TNPAWTHhaI7wsSk=;
        b=IuSh3lXjDyUV6hO+oPapUo1WIkrpWoa1kvmSeYIJCLOjR3GRtlbIyzy6lbPjWzFGVG
         bpVYV+s/syFDQdgDr4jvEG2hN5Ow0DAi/4vofoF4KosaQr9OB2XJ8PkUoysGQrnogbJC
         6Agr5JTKogWcIwWx9l06+hzgNkvpVc8wzYwWHEGWa2/a6dbRzqdTa/81FPI71KJZy7i7
         fulZQA1ZRZwsOs46syWfw28wlBXxAoLxPmHi6xTIk9/ggpmLOwIR6IBlXJKUQOkIeLtB
         KCyuH0ldAUyJbBXfQ2y/Exf5Xy/CwBiz4TF81fkarX4/gKrPpFnUGUPEZI9pg2JmXEye
         DD9A==
X-Gm-Message-State: AOAM531UXKdv96e/aT87/wg/3LO/FbHbvHkyA8ytPbG8eh6npzAlVhj+
        7WV+Sq1vIeBey9rGW3c5Uz5kwykzyTEmDjI=
X-Google-Smtp-Source: ABdhPJyCulYclpAMW0oNVlTlJMoBFTR0li3drZN0AjEuoIpR6x7kmCEAq/Yp64gcJjOynW3iO3qqVw==
X-Received: by 2002:aca:aa84:: with SMTP id t126mr3762879oie.5.1601411099923;
        Tue, 29 Sep 2020 13:24:59 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k135sm1250402oih.16.2020.09.29.13.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:24:59 -0700 (PDT)
Received: (nullmailer pid 1105892 invoked by uid 1000);
        Tue, 29 Sep 2020 20:24:58 -0000
Date:   Tue, 29 Sep 2020 15:24:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Libin <huawei.libin@huawei.com>, Wei Xu <xuwei5@hisilicon.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/17] dt-bindings: arm: hisilicon: delete the
 descriptions of HiP05/HiP06 controllers
Message-ID: <20200929202458.GA1105841@bogus>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929141454.2312-3-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 22:14:39 +0800, Zhen Lei wrote:
> The compatible strings of Hi6220 SRAM controller, HiP05/HiP06 PCIe-SAS
> subsystem controller, HiP05/HiP06 PERI subsystem controller and
> HiP05/HiP06 DSA subsystem controller is in syscon.yaml now.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../bindings/arm/hisilicon/hisilicon.txt           | 68 ----------------------
>  1 file changed, 68 deletions(-)
> 

Applied, thanks!
