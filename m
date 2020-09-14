Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8313B2690FE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgINQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgINQA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:00:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00F4C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 09:00:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so13011176pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 09:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J3qzQNXEKPitJbZnYSgSznC4VEr1dCfbjhaeGKfkj78=;
        b=TZ2oAOAhJlBmeifpZvQ/3DCynN/XFxVLLq9VsqytIptQTPvoIONACGQy9VzfABciGJ
         a0WV//Q/+DHD/+Cr/UoeTsyHjgvj2CFRneZgn8KqEBWtvNI8n45SrisEtvntXSL+MsnH
         utTNpLeG8d2pW4IsTe8A9/mJ8NdrmIjOj3/dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J3qzQNXEKPitJbZnYSgSznC4VEr1dCfbjhaeGKfkj78=;
        b=BjAZj2QLRdPzh998IzuN8cojTeaVEdrQD5+js5KA/ZOoW6WdFe44Iz+kOC+p1m95Fq
         kibLrmyXwxBd1Ye75Ea7WazpchCGae3HCXOft3HTyQS+pF2sWW0Herl9HcxTI9qpI+Z2
         vuQmYdBn1qUB4oBPlcFnS0frY2HWVR6uzah80b/kwGM4unaGWObK1n7YJRp6FL0jk9GK
         Ws4pQEvfUGk9zsL2A1hzqtNwYverSaA6BUI6Nr3fz1qzIdtJ9EyFre59mY4mYlTulIVS
         LXb8g/YKWpP0AqNaqqVzf0PcxTHIHjBjG0uZ7I4dJtYMNWYBtcOkuPUPDTXEtZMnbbzW
         PITA==
X-Gm-Message-State: AOAM53142znagP1cjFp9DBFQd2wLNO4vur/lWuYg+JRMTo/U71GOwPfC
        UzTCV0Q7uc2hCxkXOOgi7N/F/w==
X-Google-Smtp-Source: ABdhPJyK/bFQuCmEiSgXJWOG3fwKFYqjHULDTgfZZht5xuc/httEWmwBgaEYmug8R3XcTwHISfjQnA==
X-Received: by 2002:a17:902:9e08:b029:d0:8a6a:d5e8 with SMTP id d8-20020a1709029e08b02900d08a6ad5e8mr14961811plq.0.1600099228442;
        Mon, 14 Sep 2020 09:00:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id z1sm6333167pfq.102.2020.09.14.09.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 09:00:27 -0700 (PDT)
Date:   Mon, 14 Sep 2020 09:00:26 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        gregkh@linuxfoundation.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com,
        dianders@chromium.org
Subject: Re: [PATCH V6 3/4] arm64: dts: qcom: sc7180-trogdor: Add wakeup
 support for BT UART
Message-ID: <20200914160026.GB2022397@google.com>
References: <1600091917-7464-1-git-send-email-skakit@codeaurora.org>
 <1600091917-7464-4-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1600091917-7464-4-git-send-email-skakit@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 07:28:36PM +0530, satya priya wrote:
> Add the necessary pinctrl, interrupt property and a suitable sleep config
> to support Bluetooth wakeup feature.
> 
> GPIO mode is configured in sleep state to drive the RTS/RFR line low.
> If QUP function is selected in sleep state, UART RTS/RFR is pulled high
> during suspend and BT SoC not able to send wakeup bytes.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
