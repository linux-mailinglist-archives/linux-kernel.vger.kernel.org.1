Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35F628E3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbgJNPzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbgJNPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:55:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E67C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=JUCk38zQqoNw+Ur7QmwfWWDDWR8wzCEnf+omdO1iWrA=; b=K4EwvrPvCYolK8foOv7A7XEWTU
        IzeMHR1jMgqQ8ceVOgYlPYB1Wl4/zUCY5bjr49CW5Gw5s9j9KrqFDpf1D5OmmKk1Ed2Rbiik0Pief
        C8Vuw1WJKjzBF3yvLFrulf/Gs5zTybvQdjifNcbMHjWgESe7oNNv+98lDTqmfPE2dALlX9MV2c/Ie
        feIYILGnAV6H+pOTrGXN1CvMBkgJxoG02TxVCoFpqwS/xne9bYj3nqrY5U9WAUnF71k5/7pAl6403
        Z0Fqtal3Vz0zVqm1MArIW9C+uHnxyq/MmY0q/d21lUPkU4WGTPH0t1GFsUw6wDSXbaAvQTBgqFdSX
        HylQ+3Xw==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSj7Q-0007XU-S6; Wed, 14 Oct 2020 15:55:13 +0000
Subject: Re: [PATCH 09/11] [DEBUG] firmware: arm_scmi: add example SCMI driver
 for custom protocol
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
References: <20201014150545.44807-1-cristian.marussi@arm.com>
 <20201014150545.44807-10-cristian.marussi@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8f879e6b-8be2-1186-6620-f54762bd35e0@infradead.org>
Date:   Wed, 14 Oct 2020 08:55:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201014150545.44807-10-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/14/20 8:05 AM, Cristian Marussi wrote:
> Add an example SCMI driver using custom vendor protocol 0x99 and also
> registering for Performance protocol notifications.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/Kconfig                      |   7 +
>  drivers/firmware/arm_scmi/Makefile            |   2 +
>  drivers/firmware/arm_scmi/scmi_custom_dummy.c | 126 ++++++++++++++++++
>  3 files changed, 135 insertions(+)
>  create mode 100644 drivers/firmware/arm_scmi/scmi_custom_dummy.c
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 75e2668a6490..d209df6fd3ee 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -48,6 +48,13 @@ config ARM_SCMI_POWER_DOMAIN
>  	  will be called scmi_pm_domain. Note this may needed early in boot
>  	  before rootfs may be available.
>  
> +config ARM_SCMI_CUSTOM_DUMMY
> +	tristate "SCMI Custom Dummy driver"
> +	depends on ARM_SCMI_PROTOCOL_CUSTOM || (COMPILE_TEST && OF)

Just an info note here: <linux/of.h> has lots of stubs for when CONFIG_OF is not
set/enabled, so COMPILE_TEST is usually enough of a dependency without adding "OF".

> +	default n
> +	help
> +	  Custom Dummy driver


-- 
~Randy

