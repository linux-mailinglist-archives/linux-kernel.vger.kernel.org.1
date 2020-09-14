Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DF42690D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgINP5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgINP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:57:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B9EC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:57:31 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so12993218pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t/D26Uwv3mW6oiSEVXVjGFj3LJMSulQUIHEdDLLHRoU=;
        b=gku1P5Hms+NOzxUdzlxx5ehaT95NUifp0BHFREgyr2MSeDS7+0Ep2LJYXMcBjmjFmX
         1JnOa1Y+zHG9rvZpLud1pOc1A8aJCUHlt9ir1AXSY1UX+D5MYVjgISmiiJIOOMSiEVSo
         ycTBU0XRRXmgy4JU+YTWFzP07XnhCk6dwUh+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t/D26Uwv3mW6oiSEVXVjGFj3LJMSulQUIHEdDLLHRoU=;
        b=WF/FJ27V3BemBvD7Mx1p5YmOvTmeNaaYW46h3R7tM2VvonnumdG4lWzT8zXydbEcND
         EI5MWDCzT3cAJrP4eHApX6hcUOtvXLFtuSkIxrLxZydHLYAHomgZyIabIA8ioyazM2cv
         rj1F5zUbicgmeTm9RfeovUdQZT78CHtWkDFbXa8a4oyOVE6jBmYzfvHAsaG+m2wXaCth
         MsfFC3CNVPhAsy3QYUzOq1kBr+qmezoG0uW5WcVxxUGCUduOeKFRpqQcK67/ZmfzcUZj
         YPSF5tX4t/bnWmG1sZ0CbVQmmeXVysGY3jdJWficjbVJDvN0czxGov/pB3HeJc+VaPR/
         EqFw==
X-Gm-Message-State: AOAM5338JDgXhBzUSNzfq72SW/7FiqUSLtzGU+BviWNJwl5t3iufqApq
        8364E1dYFGxZp2EgoM+IE7IVKw==
X-Google-Smtp-Source: ABdhPJxUNQD/sCAAM9ssTwD5uRORxFY6nnhO0vJvu+Bn3MUZzNB6losF8axc2v+45wzv1s+xK14fRg==
X-Received: by 2002:a62:82c8:: with SMTP id w191mr13497443pfd.147.1600099051296;
        Mon, 14 Sep 2020 08:57:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id w203sm10632684pfc.97.2020.09.14.08.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 08:57:30 -0700 (PDT)
Date:   Mon, 14 Sep 2020 08:57:29 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        gregkh@linuxfoundation.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com,
        dianders@chromium.org
Subject: Re: [PATCH V6 2/4] arm64: dts: qcom: sc7180: Add wakeup support for
 BT UART on sc7180-idp
Message-ID: <20200914155729.GA2022397@google.com>
References: <1600091917-7464-1-git-send-email-skakit@codeaurora.org>
 <1600091917-7464-3-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1600091917-7464-3-git-send-email-skakit@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 07:28:35PM +0530, satya priya wrote:
> Add the necessary pinctrl, interrupt property and a suitable sleep config
> to support Bluetooth wakeup feature.
> 
> GPIO mode is configured in sleep state to drive the RTS/RFR line low.
> If QUP function is selected in sleep state, UART RTS/RFR is pulled high
> during suspend and BT SoC not able to send wakeup bytes.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
