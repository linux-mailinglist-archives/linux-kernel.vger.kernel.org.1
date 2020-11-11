Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26B52AF8AE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgKKTHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:07:51 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44905 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKTHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:07:49 -0500
Received: by mail-oi1-f196.google.com with SMTP id t16so3352756oie.11;
        Wed, 11 Nov 2020 11:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m6KErXNzobTERmhFT46PCV9HWoZI2Xkicjs09eZ0AvI=;
        b=mV8FOmz8GO0KqSfDZjlI3rxEux3/I6bjUWeSdlunmR4Ggzbp3i/yq5c+7Ke6jhpCTB
         9vLMGPVMPzVP8JrPgjtFPRogWVw/SBtYZ4MoIixWsuXkN8hBXYBqhwEia3b4HvGJA/UV
         +M99oelkhNuSmAP7MYuMzBN3gtIhTW3k4nUQjYBASor4KPlBitBPo0hv0EaZD+Gwvhe1
         ny1ta/Exy8GzOc2C0OHbmbx9yx9eWfeWCqPVGcLXaqueH5OPlz9FxQyDfYP3LcPafEUT
         Rfxqg223cKs2yHQP9lHtiju/isdJMqBqjT6JbXr71WBcon4Uzc3V7xotO9O8wmkSsGai
         MmLA==
X-Gm-Message-State: AOAM531qD7iy66yMjmsTZMTINcTqyc53JDJj717ON0ezxBl5n+ln5jNV
        YIvjxX8sFnNMhHjxLn1uAg==
X-Google-Smtp-Source: ABdhPJyCH0YBz8aBVngT7atcobywWEXc7TxgwMyadnECjWQCuZrdWHONSiZmlKkk1aMjwqkVJzWkZA==
X-Received: by 2002:aca:62c3:: with SMTP id w186mr3113609oib.49.1605121668554;
        Wed, 11 Nov 2020 11:07:48 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l89sm686242otc.6.2020.11.11.11.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:07:47 -0800 (PST)
Received: (nullmailer pid 1844434 invoked by uid 1000);
        Wed, 11 Nov 2020 19:07:47 -0000
Date:   Wed, 11 Nov 2020 13:07:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Evan Nimmo <evan.nimmo@alliedtelesis.co.nz>
Cc:     linux-kernel@vger.kernel.org, frowand.list@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] of/address: Fix of_node memory leak in of_dma_is_coherent
Message-ID: <20201111190747.GA1844086@bogus>
References: <20201110022825.30895-1-evan.nimmo@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110022825.30895-1-evan.nimmo@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 15:28:25 +1300, Evan Nimmo wrote:
> Commit dabf6b36b83a ("of: Add OF_DMA_DEFAULT_COHERENT & select it on
> powerpc") added a check to of_dma_is_coherent which returns early
> if OF_DMA_DEFAULT_COHERENT is enabled. This results in the of_node_put()
> being skipped causing a memory leak. Moved the of_node_get() below this
> check so we now we only get the node if OF_DMA_DEFAULT_COHERENT is not
> enabled.
> 
> Fixes: dabf6b36b83a ("of: Add OF_DMA_DEFAULT_COHERENT & select it on
> powerpc")
> 
> Signed-off-by: Evan Nimmo <evan.nimmo@alliedtelesis.co.nz>
> ---
>  drivers/of/address.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Applied, thanks!
