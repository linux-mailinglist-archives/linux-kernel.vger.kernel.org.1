Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5209528C001
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbgJLSst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:48:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40854 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgJLSss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:48:48 -0400
Received: by mail-ot1-f66.google.com with SMTP id l4so16745418ota.7;
        Mon, 12 Oct 2020 11:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1sLcZTLFkH56KvYpfWG5m66q94FK0dokO+2P5ArWMFU=;
        b=WC9VrUrxpnjuZzCArBLLuVBDcf4gjTsGBAxK5peOa6WebgbuGe2x9PO7acUit0mrDh
         E1we45GWdEtutqCWoDPZIrEcJgD3J7zynV4xPpxOkiYRic+X24Z6sW+CiNiwuDK4HH07
         +UWrEX9ab70I+3jyL2cifwzXJlAQYwUYRZy0djCX9SyeRwAxoIQGtO6tkvSx41SfYHxX
         f5e1jYQBZMQOzhtmIyr3YZoOsqbDADTr9/HTLs6IEEMimNLfpVq76jPRiJbkVklU02Bd
         NtQmxjIlpg3zpb8w0KtHh0qSVJwmoentZ+qlviUI+xX3VV5dydz/YHSF9+rFHbmIJsIg
         Tn+Q==
X-Gm-Message-State: AOAM532+4HaRmjzYGeODHb4kFL6JDXJE2OEMv0ihU7BbbMD7MbOVIZU8
        ZywPvRNwC6cKwI6ArD5aHy9bzN/c6Vay
X-Google-Smtp-Source: ABdhPJwB/8hEVl5YwAe/ha2F+hpIXzx57B6+qwriVBooRdLq4ZFP7pFN84owPKRgXol/qmQx/kumcg==
X-Received: by 2002:a9d:875:: with SMTP id 108mr19451492oty.243.1602528526438;
        Mon, 12 Oct 2020 11:48:46 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b26sm2298791ooq.6.2020.10.12.11.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 11:48:45 -0700 (PDT)
Received: (nullmailer pid 1896304 invoked by uid 1000);
        Mon, 12 Oct 2020 18:48:44 -0000
Date:   Mon, 12 Oct 2020 13:48:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [PATCH v2 10/10] dt-bindings: arm: hisilicon: add missing
 properties into cpuctrl.yaml
Message-ID: <20201012184844.GA1896256@bogus>
References: <20201012061225.1597-1-thunder.leizhen@huawei.com>
 <20201012061225.1597-11-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012061225.1597-11-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 14:12:25 +0800, Zhen Lei wrote:
> Add properties: #address-cells, #size-cells and ranges. Due to the
> Hisilicon CPU controller node may contains child nodes, change the value
> of "additionalProperties" from "false" to "type: object".
> 
> The corresponding examples are also added.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../bindings/arm/hisilicon/controller/cpuctrl.yaml | 27 +++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 

Applied, thanks!
