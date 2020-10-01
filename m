Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A165127F976
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgJAG2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:28:24 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:40013 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAG2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:28:23 -0400
Received: by mail-ej1-f66.google.com with SMTP id p15so6288932ejm.7;
        Wed, 30 Sep 2020 23:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sXjztgQs4OO0npzayoInTJMBK//CsB18DBIyfceLo3w=;
        b=TfFsEnNR2rNPWvvWrZU6nElcvgPjtf2/94izHlNi8pmidCNp4f10cVdAVZa6+KmvD2
         G9haV2VII+F1B+QNKnzWDNJyp6H//1Q3Rcok193/Z/Cqu+UzfZFGPwmfKzGCCe26tw7z
         4tON46zRd639+T/6YDZuwndMCx7IboyvTIIZC/gF7Rtr8MPsoLP2B2nPwnyj2x1+kSzi
         rjQC6QCRqOCWNMFyneHnPgTd7grPMyeuv/pC8j5KxtZDuKFyGpq9GypN4kMdEXMc2SxL
         0T/eqbJsjWdet+/U2sW+w3sTJjk/I5TpdKaRDSzGn23IXDNCjUvBAiQheXcS83rDy4uc
         oi7w==
X-Gm-Message-State: AOAM532v93vOKTXTJjBQBF5jrjl2205+45SE8Rq7n3JpOEPU3QYAgdAL
        TmFGNp84gO/RaUQx8jXh47qJk2FmCVM=
X-Google-Smtp-Source: ABdhPJyvPBYgRRfyktawPt6elyV0sOb/6UtF5uiqyBNwFaH0jq3z5jWzqHRKi6ge8PVtzz+9DB3HTA==
X-Received: by 2002:a17:906:9389:: with SMTP id l9mr6681372ejx.537.1601533701792;
        Wed, 30 Sep 2020 23:28:21 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id e9sm3265779edu.49.2020.09.30.23.28.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 23:28:20 -0700 (PDT)
Date:   Thu, 1 Oct 2020 08:28:18 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v6 02/17] dt-bindings: arm: hisilicon: delete the
 descriptions of HiP05/HiP06 controllers
Message-ID: <20201001062818.GA3018@kozik-lap>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
 <20200930031712.2365-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930031712.2365-3-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:16:57AM +0800, Zhen Lei wrote:
> The compatible strings of Hi6220 SRAM controller, HiP05/HiP06 PCIe-SAS
> subsystem controller, HiP05/HiP06 PERI subsystem controller and
> HiP05/HiP06 DSA subsystem controller is in syscon.yaml now.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../bindings/arm/hisilicon/hisilicon.txt           | 68 ----------------------
>  1 file changed, 68 deletions(-)

This should be squashed with the patch moving them to syscon YAML.

Best regards,
Krzysztof
