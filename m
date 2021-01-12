Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346512F28CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391988AbhALHQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391849AbhALHP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:15:59 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F84C061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Mk0eAutEoJveyPAezF2JyS1WJDEYQjBMunxTqsLl6Qg=; b=I7K9rZ77CNRm4pjbqEvN2rH1MP
        TvAfN50lc4Oz5X6hOUtxwI/g9qJOc4/SLIdYKtthW7OvmgE39D70h1TRersPjNv+FIHld4hgS+Io5
        4KyPNj8ZsiEt5SII9hpIq2gPhIZUPCOXR84deiYoDr057XO1rlJSOgr0nAt1+4HcdBJ5R4b/9uYu8
        rFggsi4b1Y684ihHErhJeePQmQmyRNeFWSgjAGLPp9MBuKxY175niOwLG9T69PoPkno+8ceMuLR+g
        H0x+6JcKBuCjqkUm2wYlG8ICCs372gdMY3wyjADWxSWIIRpE33YcFwPoloxaF3JATz69JcED6zH8o
        s3t4wOig==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzDta-000573-QW; Tue, 12 Jan 2021 07:15:15 +0000
Subject: Re: [PATCH v2 29/34] Intel tsens i2c slave driver.
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-30-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fe1aad31-a536-4f0b-e817-b795890f4b45@infradead.org>
Date:   Mon, 11 Jan 2021 23:15:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210108212600.36850-30-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/21 1:25 PM, mgross@linux.intel.com wrote:
> diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
> index 8b263fdd80c3..c2138339bd89 100644
> --- a/drivers/misc/intel_tsens/Kconfig
> +++ b/drivers/misc/intel_tsens/Kconfig
> @@ -14,6 +14,20 @@ config INTEL_TSENS_LOCAL_HOST
>  	  Say Y if using a processor that includes the Intel VPU such as
>  	  Keem Bay.  If unsure, say N.
>  
> +config INTEL_TSENS_I2C_SLAVE
> +	bool "I2C slave driver for intel tsens"

Why bool instead of tristate?

> +	depends on INTEL_TSENS_LOCAL_HOST
> +	select I2C
> +	select I2C_SLAVE
> +	help
> +	  This option enables tsens i2c slave driver.

	                            I2C

> +
> +	  This driver is used for reporting thermal data via I2C
> +	  SMBUS to remote host.
> +	  Enable this option if you want to have support for thermal
> +	  management controller

	             controller.

> +	  Say Y if using a processor that includes the Intel VPU such as
> +	  Keem Bay.  If unsure, say N.


-- 
~Randy

