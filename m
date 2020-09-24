Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06E627787D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgIXS2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbgIXS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:28:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7ACC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FEJKKUUh/Ot2fFnX5t8ZvtLSIAuUMLRSQUjaucbjKZA=; b=cI4G7XB4g3iEml7qjYoEKzy7k4
        wNL/N0/JzKlVoylM4Ls43Pyvy6ZH4GEy+hFmO0Onp1oTP1GZGorQ/HCLb8pQKclqhUQKJ0u8ysByS
        zMMHGnvhaPpT3v7OfVu8Nx4AwGHWwbDjphofETUI5TrCQ1mCCdhvFTY/77AgD7fM7NIJvDwEFxY/0
        nNUmzHiWEyTCmKSRIatuOkJpuUjq68IZoG6Ff1c5nAsAA4NQZ815ykDNQ/hoy5NXSokgl0pSVeODs
        yj7Edg2RAmOogYBUy3eVcu06yJvvJZpL40ATiLrwjdtazCTNjtuOoDQO7p1jbHydL0BOeuaP/G2cF
        klb4co8g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLVyV-0003VC-Ee; Thu, 24 Sep 2020 18:28:11 +0000
Subject: Re: [PATCH] staging: Initial driver submission for pureLiFi devices
To:     Srinivasan Raju <srini.raju@purelifi.com>
Cc:     "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Rob Herring <robh@kernel.org>,
        pureLiFi Ltd <info@purelifi.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        mostafa.afgani@purelifi.com,
        open list <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20200924151910.21693-1-srini.raju@purelifi.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a57f6bf1-2504-577b-4316-ed609dbb17ee@infradead.org>
Date:   Thu, 24 Sep 2020 11:28:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200924151910.21693-1-srini.raju@purelifi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/24/20 8:18 AM, Srinivasan Raju wrote:
> diff --git a/drivers/staging/purelifi/Kconfig b/drivers/staging/purelifi/Kconfig
> new file mode 100644
> index 000000000000..db24bdf884a3
> --- /dev/null
> +++ b/drivers/staging/purelifi/Kconfig
> @@ -0,0 +1,42 @@
> +config WLAN_VENDOR_PURELIFI
> +	bool "pureLiFi devices"
> +	default y
> +	help
> +	  If you have a pureLiFi device, say Y.
> +
> +	  Note that the answer to this question doesn't directly affect the
> +	  kernel: saying N will just cause the configurator to skip all the
> +	  questions about these cards. If you say Y, you will be asked for
> +	  your specific card in the following questions.
> +
> +if WLAN_VENDOR_PURELIFI
> +
> +config PURELIFI
> +
> +	tristate "pureLiFi device support"
> +	depends on CFG80211 && MAC80211 && USB
> +	help
> +	   Say Y if you want to use LiFi

	                            LiFi.
> +
> +	   This driver makes the adapter appear as a normal WLAN interface

	                                                         interface.

> +
> +	   The pureLiFi device requires external STA firmware to be loaded.
> +
> +	   To compile this driver as a module, choose M here: the
> +	   module will be called purelifi.
> +
> +config PURELIFI_AP
> +
> +	tristate "pureLiFi device Access Point support"
> +	depends on CFG80211 && MAC80211 && USB

From a brief look at the Makefile, it appears that the AP cannot be built alone;
i.e., I think that this needs:

	depends on PURELIFI

> +	help
> +	   Say Y if you want to use LiFi Access-Point

	                            LiFi as an Access Point.
or
	                            LiFi in Access Point mode.
or make something up. :)

> +
> +	   This driver makes the adapter appear as a normal WLAN interface

	                                                         interface.

> +
> +	   The pureLiFi device requires external AP firmware to be loaded.
> +
> +	   To compile this driver as a module, choose M here: the
> +	   module will be called purelifi.

Same module, not a separate one, right?

> +
> +endif # WLAN_VENDOR_PURELIFI
> diff --git a/drivers/staging/purelifi/Makefile b/drivers/staging/purelifi/Makefile
> new file mode 100644
> index 000000000000..a8483fbb966c
> --- /dev/null
> +++ b/drivers/staging/purelifi/Makefile
> @@ -0,0 +1,5 @@
> +obj-$(CONFIG_PURELIFI)		:= purelifi.o
> +purelifi-objs 		+= chip.o usb.o mac.o
> +ifeq ($(CONFIG_PURELIFI_AP),m)

Why does this check for CONFIG_PURELIFI_AP=m ?
How about if CONFIG_PURELIFI_AP=y ?

> +	ccflags-y += -DTYPE_AP
> +endif

It would be more common just to check for CONFIG_PURELIFI_AP in the source
file(s) instead of adding a synonym for it.

-- 
~Randy

