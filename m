Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0112708E4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 00:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgIRWVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 18:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgIRWVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 18:21:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFCDC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=PqvHxi/n9UeCx7bTguzRqlxe1c3uOeKkU1wYT5hF7Ak=; b=QZr/xhZLJdNB8lyJvudUXFMO2j
        b3BjHI0aLX//sPoeoFwEtk7bmE/uicwQ/0lhpQYS3/s9QeYfCCb1bCKVXoPdVgb/9+ZePmCulw0ju
        LXmQv4oM52BwL46Kx8CrKqbVkbAxA0KfJ5L1nzL5jConS6CWlY2MlPzupZGXUNbxXsRaozAY0uvwl
        t4cxjtRDGwc0JHl+9M3dH0sLEGs7x70GbThEB7DoQjr/evDwYwH4IAE7vSGlkCpMCLpndkoNwr6EZ
        RPERnhtTz6NXjkPbnbZF3x4YRHU20AO1vpLY4upeXqNZ6KSJ9BIfzmZHEJGIWcZZUPgPFVay6Ux0h
        1XX8FhUw==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJOl0-00053L-Dm; Fri, 18 Sep 2020 22:21:30 +0000
Subject: Re: [PATCH v2 2/2] mailbox: Add Broadcom STB mailbox driver
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200918221520.21999-1-james.quinlan@broadcom.com>
 <20200918221520.21999-3-james.quinlan@broadcom.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a45018a6-c250-bdd4-fc88-8b09464f71d8@infradead.org>
Date:   Fri, 18 Sep 2020 15:21:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918221520.21999-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/18/20 3:15 PM, Jim Quinlan wrote:
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 05b1009e2820..378ebd5a7933 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -254,4 +254,16 @@ config QCOM_IPCC
>  	  acts as an interrupt controller for receiving interrupts from clients.
>  	  Say Y here if you want to build this driver.
>  

coding-style.rst says:

Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.

so please fix up the "help" line and the next 2 lines under it.


> +config BRCMSTB_MBOX
> +	tristate "Broadcom STB Mailbox"
> +	depends on ARM64 || ARM
> +	depends on ARM_SCMI_PROTOCOL && ARCH_BRCMSTB
> +	default ARM_SCMI_PROTOCOL && ARCH_BRCMSTB
> +        help
> +          Mailbox implementation of the Broadcom STB for the sole purposes
> +          of SCMI communication.  This is used by the SCMI drivers to
> +	  communicate with FW that runs in EL3.  This mailbox only implements
> +	  the agent-to-platform channgel of SCMI but may be augmented in

	                        channel

> +	  the future to add the platform-to-agent channel.
> +
>  endif

thanks.
-- 
~Randy

