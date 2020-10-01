Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC1827F981
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgJAGco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:32:44 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:33392 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAGcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:32:43 -0400
Received: by mail-ej1-f67.google.com with SMTP id j11so6389667ejk.0;
        Wed, 30 Sep 2020 23:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xmk7QqgzWHEf2kAzN/HwHzqm9lc4tGogyl6PVuD6LYk=;
        b=LbSeM2Yqk6ty3m5hpYKIk28x89IWR1x8aR0NEKDX992dGTriYCC1yue8lCg741BiU8
         UI/ujofoE3fu784IH46BrFQEhgEL9zKt/wfrd49b3O5SlfzZZZKRcQJxXccZzYoanPMi
         yF1zuSzHbOmR/OhmBh8x9DdXwQAF+uAg3pwOoaeEAe7kuoT+y5cbYxOtdB8eWb22TFll
         eUo+UePwvuHw7bP12krESTK8zzthiUaetGmHeSMwebR6w3ALUkWkGSQWQH4P93GkdmO0
         1ylhlNPPDyel33cBvGUf7MRheyFumQu4FnmXqwYiCjOg/3wuBGLeBPJujDGXFK3pb8Ss
         AHWg==
X-Gm-Message-State: AOAM531FB1n415VyRNqCEEPsP0t+6F8yVZU1PAy0/V0RsC3pyNWXAP41
        oQ7NIx5EF9m9cxteQLu9JPg=
X-Google-Smtp-Source: ABdhPJzfzsQUKG81+k7bBDBXYDfD+EqZ9SwVyG67JUcEXYVNy08TlY9pUSN/c/gtZ16GnNwLLap45w==
X-Received: by 2002:a17:906:e50:: with SMTP id q16mr6769749eji.544.1601533959674;
        Wed, 30 Sep 2020 23:32:39 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id d20sm156359edt.32.2020.09.30.23.32.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 23:32:38 -0700 (PDT)
Date:   Thu, 1 Oct 2020 08:32:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v6 03/17] dt-bindings: arm: hisilicon: split the
 dt-bindings of each controller into a separate file
Message-ID: <20201001063236.GB3018@kozik-lap>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
 <20200930031712.2365-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930031712.2365-4-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:16:58AM +0800, Zhen Lei wrote:
> Split the devicetree bindings of each Hisilicon controller from
> hisilicon.txt into a separate file, the file name is the compatible name
> attach the .txt file name extension.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../arm/hisilicon/controller/hisilicon,cpuctrl.txt |   8 +
>  .../controller/hisilicon,hi3798cv200-perictrl.txt  |  21 +++
>  .../controller/hisilicon,hi6220-aoctrl.txt         |  18 ++
>  .../controller/hisilicon,hi6220-mediactrl.txt      |  18 ++
>  .../controller/hisilicon,hi6220-pmctrl.txt         |  18 ++
>  .../controller/hisilicon,hi6220-sysctrl.txt        |  19 ++
>  .../controller/hisilicon,hip01-sysctrl.txt         |  19 ++
>  .../controller/hisilicon,hip04-bootwrapper.txt     |   9 +
>  .../controller/hisilicon,hip04-fabric.txt          |   5 +
>  .../arm/hisilicon/controller/hisilicon,pctrl.txt   |  13 ++
>  .../arm/hisilicon/controller/hisilicon,sysctrl.txt |  25 +++
>  .../bindings/arm/hisilicon/hisilicon.txt           | 194 ---------------------
>  12 files changed, 173 insertions(+), 194 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt

If I understand correctly, first you create multiple TXT bindings files
in this patch and then convert them one by one to JSON.

No, it does not make sense creating a temporary file.

Split out the bindings one by one from hisilicon.txt into JSON directly.

Best regards,
Krzysztof
