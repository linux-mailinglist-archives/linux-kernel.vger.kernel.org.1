Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5491DA031
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 21:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgESTAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 15:00:22 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33525 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgESTAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:00:22 -0400
Received: by mail-il1-f196.google.com with SMTP id o67so530265ila.0;
        Tue, 19 May 2020 12:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CigNBiFGguISDYdSjZo6JK7yGCkqs8bnsK3pMxkFnS0=;
        b=ojcGMfol9nZrOJ8OmLtOCHawTe1HR7OPOhcfHMSMLizSe0TCIVh2bQADn336hS4ADg
         HwM3/Rfhp42ZjJdvedLIiM6V1AOffWOfkUmaEWombBVEijjKxEXBQIgolAkNndLq/Tyc
         l4sQ1CHlZBH9QmkIKKYSlcS6EGGD6+UwWtldU8PBCB5JvZaqLm+K4BNE9GVB79HYXdBJ
         SDdgz7/olfgFc52D2rT+tSeHyyLx7Lgk+bYtyXu4OHg24C2UGbvpeLVNWcKcpiGQfEZU
         9UD+pfo+k6gXLN1YXFDN8G0cW+5wwB1823L4FBtIcJnJhC96AqsM1vtFHOGKRe56eXwC
         EPTQ==
X-Gm-Message-State: AOAM531FC+bZkWABEnlzldIj1nrut92/I2psg5AQIGRcfzU6XXcN13wv
        niS3TLbegDc1WvpMdw72dnXw/88=
X-Google-Smtp-Source: ABdhPJx7GM4OuG3FNL/RP90uFPgLl2sZetDsvHbDfXe9ifMm1+a3LfvTd1zFF24wU8jDuhFOpm62mA==
X-Received: by 2002:a05:6e02:cc5:: with SMTP id c5mr472948ilj.152.1589914820957;
        Tue, 19 May 2020 12:00:20 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b8sm130937iln.47.2020.05.19.12.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 12:00:20 -0700 (PDT)
Received: (nullmailer pid 478222 invoked by uid 1000);
        Tue, 19 May 2020 19:00:19 -0000
Date:   Tue, 19 May 2020 13:00:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        alexandre.torgue@st.com,
        Etienne Carriere <etienne.carriere@st.com>,
        srinivas.kandagatla@linaro.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: nvmem: stm32: new property for data
 access
Message-ID: <20200519190019.GA478168@bogus>
References: <20200512131334.1750-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512131334.1750-1-etienne.carriere@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 15:13:34 +0200, Etienne Carriere wrote:
> From: Etienne Carriere <etienne.carriere@st.com>
> 
> Introduce boolean property st,non-secure-otp for OTP data located
> in a factory programmed area that only secure firmware can access
> by default and that shall be reachable from the non-secure world.
> 
> This change also allows additional properties for NVMEM nodes that
> were forbidden prior this change.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> ---
> Changes since v1:
>   Change nvmem.yaml to allow additional properties in NVMEM nodes.
> 
> Link to v1:
>   https://lore.kernel.org/patchwork/patch/1239028/
> 
>  .../devicetree/bindings/nvmem/nvmem.yaml        |  2 --
>  .../bindings/nvmem/st,stm32-romem.yaml          | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 

Applied, thanks!
