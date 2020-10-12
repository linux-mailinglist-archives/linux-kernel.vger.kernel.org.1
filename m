Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2528428BFFF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgJLSsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:48:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32978 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgJLSsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:48:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id t15so16804746otk.0;
        Mon, 12 Oct 2020 11:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dy0et2g2Li12MxINiUAaq2MtzW6pLmb4E0tvWF+sMag=;
        b=gG9sLpSbfiSqCRcHWZ0Wlqh8DNPy1h2tCnVZsgrjoFnRrqfUK2JpNcrzjHbPnUJxYT
         x60o5JM+aj4j9T3nWNWw9bg9pGlYtvP+aSmu2JA9VxKIlj14tmNBBy0zrcepLBNejAMr
         8sPLCRNR4mCLyQ8CmekdaLzaPxs12AZTVxlv7prPeSsZN8yLWybzev6ncDWg9Fh9f4Kf
         XYsvi4Kub5ouN/CluqEP9K/4lhXOV7PSlgN6lQmjseu2C7hlg4GCPUuerbOyhZh+f86/
         sW9ZQs03TpzfYXJOTtPyx0oW+2pzmjaMK9EQsIgVnF/heasF2yTG1uWbeAwUNLWYSMPp
         S81A==
X-Gm-Message-State: AOAM530rL5Q2dgGXZlgLFZQfjP8gK1VfmKLWSHnceHHSmk3MgcVknbvr
        yVipxo/lSCL2PfUc8tiPUw==
X-Google-Smtp-Source: ABdhPJzfDKAJKdqJGI1Hao1PGffudlNAlotRjribWpqEzFkItrQ2iT/X/RQVqQl0fejOt0eaEsu7CQ==
X-Received: by 2002:a05:6830:94:: with SMTP id a20mr18491969oto.366.1602528515608;
        Mon, 12 Oct 2020 11:48:35 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h25sm8423409otj.41.2020.10.12.11.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 11:48:34 -0700 (PDT)
Received: (nullmailer pid 1895908 invoked by uid 1000);
        Mon, 12 Oct 2020 18:48:34 -0000
Date:   Mon, 12 Oct 2020 13:48:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 09/10] dt-bindings: arm: hisilicon: add missing
 properties into sysctrl.yaml
Message-ID: <20201012184834.GA1895835@bogus>
References: <20201012061225.1597-1-thunder.leizhen@huawei.com>
 <20201012061225.1597-10-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012061225.1597-10-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 14:12:24 +0800, Zhen Lei wrote:
> Add properties: #reset-cells, #address-cells, #size-cells and ranges. Due
> to the Hisilicon system controller node may contains child nodes, change
> the value of "additionalProperties" from "false" to "type: object". The
> examples have also been updated.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../bindings/arm/hisilicon/controller/sysctrl.yaml | 28 +++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 

Applied, thanks!
