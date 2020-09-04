Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B21825D903
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgIDMxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 08:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbgIDMxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:53:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0DCC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 05:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=XyADDbWub8q+RugxMKXaWIKp8gy8G3WLyWqZgRFJ6N0=; b=SCJRqVFMV6xq5oK62ZSBS2K16B
        0M4rx9nXvo2QjrEbxl5oklw53k5HytS8tujXVTOQqxAPGekh7WXwX3/3zDt1v2dXteaZBIkEjL94g
        WbVyyBFWhTjPz7jbkUyDFPylmtlpRwGD8MuNMjmRFHoAz4CxWtEQjQJ286vtdG75iW7M5Va5APGAP
        N46NgXJDtG/zeu7ILQsh3dv8wz4/QSssUqm425xcSNvbkv8XVPMnfy+xLw2ofzcFuBzdL0wF0Up3H
        uiC8myUw9C4NQN7rdLgap15e0x0DMH5YLj7//qxCuR53suaXjNF12lFcFpPyGae2BVCFYFcRTgsqe
        wjwVcKRw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEBDf-0001id-EH; Fri, 04 Sep 2020 12:53:31 +0000
Subject: Re: [RFC 08/10] misc: hisi_hikey_usb: Driver to support onboard USB
 gpio hub on Hikey960
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
 <ef9f06eb56e1580d146fc639dc2a037205cc843f.1599214329.git.mchehab+huawei@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b8e7b15f-757c-29b9-6984-ac0a49efd6c9@infradead.org>
Date:   Fri, 4 Sep 2020 05:53:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ef9f06eb56e1580d146fc639dc2a037205cc843f.1599214329.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 3:23 AM, Mauro Carvalho Chehab wrote:
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index e1b1ba5e2b92..8ceba6153ecc 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -456,6 +456,15 @@ config PVPANIC
>  	  a paravirtualized device provided by QEMU; it lets a virtual machine
>  	  (guest) communicate panic events to the host.
>  
> +config HISI_HIKEY_USB
> +	tristate "USB GPIO Hub on HiSilicon Hikey960 Platform"
> +	depends on OF && GPIOLIB

	depends on (OF && GPIOLIB) || COMPILE_TEST
?
Both of those have stubs if they are not enabled IIRC.

> +	help
> +	  If you say yes here this adds support for the on-board USB gpio hub

	                                                             GPIO

> +	  found on the HiKey960, which is necssary to support switching between

	                                  necessary

> +	  the dual-role USB-C port and the USB-A host ports using only one USB
> +	  controller.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"


thanks.
-- 
~Randy

