Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECFD2FE206
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbhAUFtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbhAUFs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:48:26 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9DFC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:47:35 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id i20so568100otl.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=So7n4CXW5rfKosTBs+wAYGz48ULvBM4ktYJXBciZ7Dc=;
        b=glVhYP4Hu5qOk9XNH1PetEtPf065rkp8x4wHsjwwkBo4jfTlVvwx0U706YM9o7PlR5
         jBrl2ZnGv2+mtCQkUqkUbXZF4jOYpgKTK2w7nMqOyAM8r6+C9uGiL6L7PejsYpWlskc2
         q7bRCXo5M6tg2AdAtkq3kPcJJlp5mg9D018HK5w39x3c5b2FQ+XvbzDfx2nhkaQKN8II
         9q5JFrFOlXnCOUl+EcPlaDaq8s3YIFMhhugXN/b6aDSNjT53LFqi2QKTJk0CSWfd6Sp+
         9bv7f5wxXfKVh3XEBLOxQskKVuqy6fLBVHSHXIblh64umV+rQT8/x5vdGUxi1rlE07DA
         +XSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=So7n4CXW5rfKosTBs+wAYGz48ULvBM4ktYJXBciZ7Dc=;
        b=gEiEqvKC7Pf9KkdIqJjZVFVNCUTbIOxEofTBu9cCiDOyEIN2wxdyj6GHhHGjABTr8b
         3kOXLG4VWKFxEHpYdXnUNt0t6T+a1986T57i0l5w9y8A5zwI9GTsBJ8+rD/4cv/D77Js
         x5a25HwpZeEfZYgZMTKh4fEpZ9SlFEtiyTU5oowk6D5XnZ0ZaNJW6BGhps+hW3CSzLnD
         mgWtbqjr0It1Kw92fR3tGazvThBz/QeOKHmHbM+Ren4kO3jbFv+kN8vkk00BnziBF/fx
         q9+gKwNn8Er4fdyE9DpTVzmnyJYTrNsqvWIMtG/gk4BMyQcBLpROx62I/cCzVgT8nCx9
         ozBA==
X-Gm-Message-State: AOAM531+0F3TFh0JPtpnquHRGeGA2nfFhcy6T4sd3vPTPhHONDJwC6MQ
        Nsp0LR3dXnICVkJR2K1n5L+YkA==
X-Google-Smtp-Source: ABdhPJysvLoMeu7qgenoO6uU13klsr+b3S9kAO++BSTs7ZLhpyiB2MkpLh7oktSJj0YYNOZnAM70Iw==
X-Received: by 2002:a9d:611b:: with SMTP id i27mr4298758otj.352.1611208054744;
        Wed, 20 Jan 2021 21:47:34 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 67sm79061ott.64.2021.01.20.21.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 21:47:33 -0800 (PST)
Date:   Wed, 20 Jan 2021 23:47:32 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: qcom: gcc: Add global clock controller driver
 for SC8180x
Message-ID: <YAkVdOmy0MTeRQhz@builder.lan>
References: <20210120223556.1610214-1-bjorn.andersson@linaro.org>
 <20210120223556.1610214-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120223556.1610214-2-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 Jan 16:35 CST 2021, Bjorn Andersson wrote:
> diff --git a/drivers/clk/qcom/gcc-sc8180x.c b/drivers/clk/qcom/gcc-sc8180x.c
[..]
> +static struct gdsc emac_gdsc = {
> +	.gdscr = 0x106004,

Seems like I missed squashing the fixup where I subtract the gcc base
address after migrating these from the downstream dts.

As written the platform doesn't boot.

Please let me know if there's any other feedback before I respin v2.

Regards,
Bjorn

> +	.pd = {
> +		.name = "emac_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = POLL_CFG_GDSCR,
> +};
