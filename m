Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6794271043
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 21:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgISTcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 15:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgISTcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 15:32:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE05AC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 12:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=x1tOqIB0For5kamvW/pluk6hHkgLqmiVf8IT0i45J10=; b=DqTuzrYXhaUU22zdhMjXV4MZFC
        PXevadx82jNrABhO97TwgXcqBHOsTehGX1yxSlq9XV00lwLh9yWArlE/tccGhTI7DVD0GgLcVNH1T
        Rvs4q3s2PTGkLVd3NYRAK4qeopGmvvRNaxusiL7rOtZa8pQv8IrZZTOJEaYdYeJ53sCqqlfdebXx0
        8Oo8I1vQvQx87P+EqxJuQUvVjpHW8SQV9p7lrrBqvAaRJOceZTMh7vH7ACOBw++2E+pNhgqXTfiB6
        ywHQO0bmv2NUwDFiAyc/unh0A0tkH4+vy3ayDmuoBJEpz3lVUMyKHAzxHZRsvPATLOH0qxqjykgkV
        Z7sh+2qQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJiaW-0003vJ-Es; Sat, 19 Sep 2020 19:32:00 +0000
Subject: Re: [PATCH v3 2/2] mailbox: Add Broadcom STB mailbox driver
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200919192235.43872-1-james.quinlan@broadcom.com>
 <20200919192235.43872-3-james.quinlan@broadcom.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1cd9ed99-3392-f602-f351-b78edcfd1fc4@infradead.org>
Date:   Sat, 19 Sep 2020 12:31:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200919192235.43872-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

On 9/19/20 12:22 PM, Jim Quinlan wrote:
> ---
>  drivers/mailbox/Kconfig           |  12 +++
>  drivers/mailbox/Makefile          |   2 +
>  drivers/mailbox/brcmstb-mailbox.c | 173 ++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+)
>  create mode 100644 drivers/mailbox/brcmstb-mailbox.c
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 05b1009e2820..96faf1139cb9 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -254,4 +254,16 @@ config QCOM_IPCC
>  	  acts as an interrupt controller for receiving interrupts from clients.
>  	  Say Y here if you want to build this driver.
>  
> +config BRCMSTB_MBOX
> +	tristate "Broadcom STB Mailbox"
> +	depends on ARM64 || ARM
> +	depends on ARM_SCMI_PROTOCOL && ARCH_BRCMSTB
> +	default ARM_SCMI_PROTOCOL && ARCH_BRCMSTB
> +        help

"help" is still indented with spaces instead of one tab.
You probably should wait a bit to see if there are other comments on this patch
before doing a v4.

> +	  Mailbox implementation of the Broadcom STB for the sole purposes
> +	  of SCMI communication.  This is used by the SCMI drivers to
> +	  communicate with FW that runs in EL3.  This mailbox only implements
> +	  the agent-to-platform channgel of SCMI but may be augmented in
> +	  the future to add the platform-to-agent channel.
> +
>  endif
> diff --git a/drivers/mailbox/brcmstb-mailbox.c b/drivers/mailbox/brcmstb-mailbox.c
> new file mode 100644
> index 000000000000..27d87938b08c
> --- /dev/null
> +++ b/drivers/mailbox/brcmstb-mailbox.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2017, Broadcom */

2017 is a little surprising.


> +#if defined(CONFIG_ARM64) || defined(CONFIG_ARM)
> +static int announce_msg(unsigned int mbox_num, unsigned int ch)
> +{
> +	struct arm_smccc_res res;
> +
> +	if (ch >= NUM_CHAN)
> +		return -EIO;
> +	arm_smccc_smc(BRCM_FID(ch), mbox_num, 0, 0, 0, 0, 0, 0, &res);
> +	if (res.a0)
> +		return -EIO;
> +	return 0;
> +}
> +#else
> +#error Func announce_msg() not defined for the current ARCH
> +#endif

This is handled by the Kconfig depends on clause.
Why is it repeated here?



thanks.
-- 
~Randy

