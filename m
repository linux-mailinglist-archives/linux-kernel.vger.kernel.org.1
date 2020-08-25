Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47762251166
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 07:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgHYFQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 01:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYFQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 01:16:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045BBC061574;
        Mon, 24 Aug 2020 22:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=xhDgPX+EVP/VZeAa1RZSKBXxeYZKcsfe0/2ZFV2ql3M=; b=Vh5+Nkg0B/ScBSgyRNLtjkDoe9
        05pe7uvNv+5Zgg+0RDtoIlczwe1cH205wu3iCW/gl1W7AQlNX8QecNysRefz79Aub5wu+SZr2iTAd
        K322+B2VbO5iGcRng/ixbH1RyHmUSazZha9cbwwogyN3PJ4upGWmGpaibL6cPRz60jxV4WWRFsrSr
        0GLoC6C11IKFpoLaBCrAs3vCXJipschSIFpnFFmzFy4DksgbAamSVTn2S/vh854p5bWLV49ZP6Ajr
        M9YceCptUstR939a+3OERBc96wvqwRTAcQxeiwONpiPRJbIOewN9vTJ2CUPIGaLI1/yUj/n5ui42C
        8xZdxxrA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kARJh-000533-0e; Tue, 25 Aug 2020 05:16:17 +0000
Subject: Re: [PATCH 07/14 v1] usb: typec: tcpci_maxim: Chip level TCPC driver
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200825042210.300632-1-badhri@google.com>
 <20200825042210.300632-8-badhri@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fb1a7030-2649-c0cf-dd2a-651516333da7@infradead.org>
Date:   Mon, 24 Aug 2020 22:16:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825042210.300632-8-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/20 9:22 PM, Badhri Jagan Sridharan wrote:
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index fa3f39336246..7c9722b02afe 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -27,6 +27,12 @@ config TYPEC_RT1711H
>  	  Type-C Port Controller Manager to provide USB PD and USB
>  	  Type-C functionalities.
>  
> +config TYPEC_TCPCI_MAXIM
> +	tristate "Maxim TCPCI based Type-C chip driver"
> +	select USB_PSY

is that        USB_PHY
?

> +	help
> +	  MAXIM TCPCI based Type-C chip driver

end that with '.' please.

> +
>  endif # TYPEC_TCPCI
>  
>  config TYPEC_FUSB302


-- 
~Randy

