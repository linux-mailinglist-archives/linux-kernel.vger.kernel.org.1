Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA7227D826
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgI2UaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:30:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42650 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgI2UaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:30:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id x14so6943640oic.9;
        Tue, 29 Sep 2020 13:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I6lk5ddtUvJUDAiRO4BVqqX4rVcwqzUPcKWa0FPjTM8=;
        b=PwSNWZ/+Sn0oc52d+XajSQmh0D/eVvD8lQoOFSMNNyEfbXIZutD88KbBHJ5zYjzaap
         aeO3AC9AXU60Dr3dKpCkYTstiTC0ysMADH1npTwt6isBbxwSOSZ6juZboRxCvDquPq/s
         xjj1Jl+vCaTp9Iw3Ao4jbY+O0kxtcq71PLsdoIeC7j/218YBB4G4ufn8IgRiiWCcHdbN
         vDYZwKUovXd/KbJ3dFgMDaLypz6D6E2hMNVkPjsf+1MAWMYNTo16j9SWpFNqgr7JLK+L
         yjKqgl49Dwoxu9a0hL/aMN6GBTQPdoSaiEA9X9EWoPAf7F4pFTeeoUZbcuLBohJDJ1kk
         iBSA==
X-Gm-Message-State: AOAM533Zm2EBX0qk800BKLdv1DbWzsbTdoSPippzGCyDR16law2s9ByQ
        JyXt5gLyMqM2EHCHGU3t5g==
X-Google-Smtp-Source: ABdhPJwsd0fbtkX1yuYMWhXsJFRApShyunN8Xx7cmQriDAAkTdbaN6Y0MDPDasviFbV6L11wRF7xZQ==
X-Received: by 2002:a05:6808:3bb:: with SMTP id n27mr3580048oie.130.1601411415009;
        Tue, 29 Sep 2020 13:30:15 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m12sm1259283otq.8.2020.09.29.13.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:30:14 -0700 (PDT)
Received: (nullmailer pid 1115256 invoked by uid 1000);
        Tue, 29 Sep 2020 20:30:13 -0000
Date:   Tue, 29 Sep 2020 15:30:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Libin <huawei.libin@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 14/17] dt-bindings: arm: hisilicon: convert hisilicon,
 hip04-bootwrapper bindings to json-schema
Message-ID: <20200929203013.GA1115224@bogus>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-15-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929141454.2312-15-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 22:14:51 +0800, Zhen Lei wrote:
> Convert the Hisilicon Bootwrapper boot method binding to DT schema format
> using json-schema.
> 
> The property boot-method contains two groups of physical address range
> information: bootwrapper and relocation. The "uint32-array" type is not
> suitable for it, because the field "address" and "size" may occupy one or
> two cells respectively. Use "minItems: 1" and "maxItems: 2" to allow it
> can be written in "<addr size addr size>" or "<addr size>, <addr size>"
> format.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../hisilicon/controller/hip04-bootwrapper.yaml    | 34 ++++++++++++++++++++++
>  .../controller/hisilicon,hip04-bootwrapper.txt     |  9 ------
>  2 files changed, 34 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-bootwrapper.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
> 

Applied, thanks!
