Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287CB283187
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJEIIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEIIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:08:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09139C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 01:08:30 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t17so7765315wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UCvVeSLKK559VO4ZB+QwjH9RWXmffaa+dxijfritaDY=;
        b=csq4/ueW8T9mVp6iz7fMWRFUokeuGS/44HWy7kRgQ9PXlgvMdWE11xdG7d1Pja6W89
         Ov38XwM/63PDGoqZJUEuY/GRpmqWBkC+yvomfmiIfyPurE0i78ucTUCBRUb/H+WtACv3
         YIa0fwJ6yAHbHkUvLjpTs7n3iErMhqRUadja9/TeA94BIwtuf9hqhZ/8YjfpGZUgXbZV
         zOz1ztCMXq3SbADwlW6fIA9IedcJjAJvIhqFciPkTE6InpjbzhWoDhdH8pNbE3GUyJ1q
         b2FbcnzA2vC4q7SDyW2vbbSzbZxt9X3k+mLOYtrdToPapug8pWW0McfJFuM7WkK8BHle
         iwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UCvVeSLKK559VO4ZB+QwjH9RWXmffaa+dxijfritaDY=;
        b=PoZYAWsweD3eiW6kJgnCNu8amGugoL80FfAMUM9DQxPjM4KbU9E+a96+TBJ+ngNXVN
         qJ5xIIcxXjhT5f4S8tdyUlolRoce0tvvdFH3lT1cZUX99x0kSbFEpp5hIbUMQqv+1ETw
         EnWlDzvgysL2h/VTCqXIaqhCSanGOPBw3pd3QbagkToeJ1wzQAc/+Dq8tyqNH9Wcaufz
         jisaoMSlRb9+kNeIb+YPTWRGJBI95Jvi3JsKLmxPs5h2ETh976y9KzwesAgiRjjGnOp7
         6N3CXIpi8aGvRd9WRyg+oDRfUktwEwjMVvp8om/f1MjJAAgyJKLr3Qh0KyhlwsWnKQP5
         +gUQ==
X-Gm-Message-State: AOAM531nlPgyW2spQZH1JNaN9xe107S9RwNMAoEZzwQNFWBi3zW9xRb4
        8wRZID7CNMWDT0MjRujLiZwBv4n7ovf73Q==
X-Google-Smtp-Source: ABdhPJyV5jLCEoDv4YUwDHeaUo0em0iKgJXzTx7AilzgUOf3OUbqBilo8mHXN6Iqk4MLuvi0eVu10w==
X-Received: by 2002:a7b:cf04:: with SMTP id l4mr6810566wmg.137.1601885308697;
        Mon, 05 Oct 2020 01:08:28 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id i14sm11940941wml.24.2020.10.05.01.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:08:28 -0700 (PDT)
Date:   Mon, 5 Oct 2020 09:08:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] dt-bindings: mfd: ti,j721e-system-controller: Fix
 incorrect pattern property
Message-ID: <20201005080826.GU6148@dell>
References: <20201002230606.3522954-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002230606.3522954-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Oct 2020, Rob Herring wrote:

> Pattern properties go under 'patternProperties', not 'properties'.
> Otherwise, the pattern is treated as a literal string.
> 
> A corresponding meta-schema check has been added to catch bad DT property
> names like this.
> 
> Fixes: e0f946915b23 ("dt-bindings: mfd: ti,j721e-system-controller.yaml: Add J721e system controller")
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mfd/ti,j721e-system-controller.yaml   | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
