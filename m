Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7326ADB9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgIOTgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbgIOTd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:33:59 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B44FC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:33:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l191so2524757pgd.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ilVz9b6REPKrYKXGMSZDZJ/4PE1awctJVmiZRDvsYnM=;
        b=T7rHCHK0yazSYxhoaeaaQAUQX0wEWreFsk+vdLUAaIF9OT32QkScrYl9jeFQDyyyot
         FRTU55mhu00DYjkz+ay7xre1umF6i+TK5fLA42jOP6DXmvl+xpdoADeJ5AS8vjC4OY7D
         BZBc9v0KPA2iVChzpd+yln0egBare2E3ka2pBIAtj1qAlWY9llCXvf+Mm+a0pbW85AN7
         Iaz+RCoYUi92hv4Tk4E66SuTZGjDe+T6B9YNVdWgwCGXsm+mqj1s7PDj8XbydbB0Qhdn
         K+X5RKUKrSIP3iGKzaZAeAROmrjiFMlEaXrDKax/xzn5mPcWoX2DIto3pJ0O3cW2UmUN
         2itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ilVz9b6REPKrYKXGMSZDZJ/4PE1awctJVmiZRDvsYnM=;
        b=tAvjFt/6R72UWo8wnkXDZPtirVZg2GH8V+qsI3/IansmdTS0a5d6HRUbNUpw14Oo1/
         WKYirfId5TbDdIBTqmEV0Kn37dAk4UZxrRh88PF/EZk/JVPrfjUgRO9SpE9e9rssx2jr
         s4q17JW3L7LXEti3v/ve/vx+qr+mCeVsN/HGHh7LIwiC4UmpVSOqVy9e1/PVLucvv3/k
         wrc54hDPsHoSNDQnlMwf12hmTJj9ersbSJ4QZZPtdvrlyfDGqjuD8jr5ex1Ypf1vRsQS
         Cu3N7bVwr4VJwuMVPOjYCwuu1re3YRDpfW04hOuZPAlN4XKlb/wCmMaT21aN83srkKBy
         R4Dw==
X-Gm-Message-State: AOAM532/RIu5c4aU74+1cHpmcxlXBK8kVYPEAhW+N/2tbHU+JsowGW1x
        hqHdQWCjHm5Z9MFCSKRNNWU=
X-Google-Smtp-Source: ABdhPJznkwpNsB+sy8J0qXZ93Bl9U+K9ML5t3hG5Wx3ldlKKF3zqkhg3Z98T2b8VQn5WuCXwiK8rOQ==
X-Received: by 2002:a62:fc06:0:b029:142:2501:397d with SMTP id e6-20020a62fc060000b02901422501397dmr3255460pfh.66.1600198432651;
        Tue, 15 Sep 2020 12:33:52 -0700 (PDT)
Received: from [10.230.28.120] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g129sm2655042pfb.9.2020.09.15.12.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 12:33:51 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] mailbox: Add Broadcom STB mailbox driver
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200915193109.16034-1-james.quinlan@broadcom.com>
 <20200915193109.16034-2-james.quinlan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6924a28d-ceb6-6d96-b84a-9f8919de9866@gmail.com>
Date:   Tue, 15 Sep 2020 12:33:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200915193109.16034-2-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

On 9/15/2020 12:31 PM, Jim Quinlan wrote:
> This is a simple mailbox driver to be used by the SCMI protocol stack.  It
> only implements the agent-to-platform channel; we may implement the
> platform-to-agent channel in the future.  An unusual aspect of this driver
> is how the completion of an SCMI message is indicated.  An SCMI message is
> initiated with an ARM SMC call, but the return of this call does not
> indicate the execution or completion of the message.  Rather, the message's
> completion is signaled by an interrupt.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   drivers/mailbox/Kconfig           |  13 +++
>   drivers/mailbox/Makefile          |   2 +
>   drivers/mailbox/brcmstb-mailbox.c | 173 ++++++++++++++++++++++++++++++
>   3 files changed, 188 insertions(+)
>   create mode 100644 drivers/mailbox/brcmstb-mailbox.c
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 05b1009e2820..bebf7da778bc 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -254,4 +254,17 @@ config QCOM_IPCC
>   	  acts as an interrupt controller for receiving interrupts from clients.
>   	  Say Y here if you want to build this driver.
>   
> +config BRCMSTB_MBOX
> +	tristate "Broadcom STB Mailbox"
> +	depends on ARM64 || ARM
> +	depends on ARM_SCMI_PROTOCOL && ARCH_BRCMSTB
> +	depends on SMP

We can actually remove the SMP dependency cannot we? This was needed 
back when we used the hackish way of hooking to IPIs in the downstream 
kernel which we fortunately no longer do.
-- 
Florian
