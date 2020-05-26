Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FADE1BBAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 12:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgD1KRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 06:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726932AbgD1KRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 06:17:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0194FC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:17:37 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so2089748wmk.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eV+Th5BniRPcPDXkhwyuSN3cWP7lFrktIHIPo7qrlrI=;
        b=XW1GVGsXY80vV9DGRufEmge0H/eu4FI2dVz4xVST2VJPpwHCI+o+ddaLSy2ba5Hdkb
         iuzJp9SdjDDShZQbQuoBoLj0oJsrsqCBxY6Muw7u+ucBbcK5xBtYMI8M8Ai1CZNYSaOk
         C+bOa6xklbijjdm1mTD/XE2UyPcEXhuKTmAzFTr6zFYpo3ApuM5+g/dZB7qhS8P2gQiw
         2o//7/l9Vl8nr2/BQyOW4z0QDI6NIx6F1w1MiLc1Xg3zkl++9G1nezfF6luc8TSi9mXu
         BJLFzjvv4Y+rer9w6mmFQ+0vrLQxmpNOBepAvsq1Rsip66ShlAcn6dURnGimeTrE9yS8
         hljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eV+Th5BniRPcPDXkhwyuSN3cWP7lFrktIHIPo7qrlrI=;
        b=oudJoPQyg60AnsDV27gitehlF+ADb54G12hmXMZI7UcRLQ5GmOABxoQy/oRCB2oDnf
         8MVDGzyaLO92h26PhFTV8b/YqLFnOINzldeRqfkH4fVbjc0KAEvsuQ+a0hsZ1cI72vgh
         7kQ9Nhj8Xj/vxJZFZn6sGvXvC3XvWqp8+4j2lVw45S9ffJ02H8Jtav8HgpOtyrMtnKhh
         YY0u1LsAoY5m4HjNmo/ojay7LY1IA1not3DdIO4tgxO2OMvYBFpvnLCTm4zlnkkaKxzj
         CcNNCkWVz+2bthzZU6ugts1FdUlPmhjuVxFARpo85oW8Pnho4dwPAYkYq79oJ4V3BnKF
         f6tQ==
X-Gm-Message-State: AGi0PuaPX3RyvknBLuwi5XP5jkxo/orFvj7v7jzUug2SnR7EJNboo+nF
        AGrtMXeN9JmTzdPWk32UzYj4CA==
X-Google-Smtp-Source: APiQypIhzI9nKz44SYFmbAjDlx51uIBdA+B/YRligLSbLzuaLGU6jAYkbx4GpfVkznPLFTaFXUJ2kA==
X-Received: by 2002:a05:600c:220c:: with SMTP id z12mr3706794wml.84.1588069055751;
        Tue, 28 Apr 2020 03:17:35 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id 185sm3055694wmc.32.2020.04.28.03.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:17:35 -0700 (PDT)
Date:   Tue, 28 Apr 2020 11:17:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        robh@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>, linux-arm-msm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH V6 3/4] backlight: qcom-wled: Add WLED5 bindings
Message-ID: <20200428101733.GO3559@dell>
References: <1587656017-27911-1-git-send-email-kgunda@codeaurora.org>
 <1587656017-27911-4-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1587656017-27911-4-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020, Kiran Gunda wrote:

> Add WLED5 specific bindings.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  .../bindings/leds/backlight/qcom-wled.yaml         | 59 ++++++++++++++++++++--
>  1 file changed, 56 insertions(+), 3 deletions(-)

Needs a DT Ack.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
