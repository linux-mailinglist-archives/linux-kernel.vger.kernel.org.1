Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6372CDC58
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbgLCR0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgLCR0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:26:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5801C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1ys3tD29yyXiFC0wdrbI9llPCLLvllG6Avtg8Riop2w=; b=Ktj16xIdTj3m+YMFkFDzvgkkc/
        BWsyux4yLGkgmExSv1HICil5cSWVbbPvIpJVFtlZftQBQGAne4ys3cbQ6QBTTmNfDMX7VRf0Ah5n9
        kTOs7rzItjdLzvl+sTP7n96dfUg10qQ8AG7WjHPjs0dU7z7kMArROSJmugAJ35vkE3izte/rz343g
        n0Z6YlZqOrchcI5LtdioiEZvrtIBvCs36g+qFUbzE4qlh9YHRgAWWgqor467dCPM1d2OnEXATMXnD
        UanaImtP8rYDQvmiPS78bVHf7xWNPJShHMCyZ8qXmt+WFQuZjNSp0i+wF7nnEPrDd8pg2L2hZ6XLR
        HoBL5ooA==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kksMh-00057z-0N; Thu, 03 Dec 2020 17:25:59 +0000
Subject: Re: [PATCH v3 19/19] vdpa: split vdpasim to core and net modules
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-20-sgarzare@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <920c4975-a3ae-b7f9-ac89-6444ca2e4c45@infradead.org>
Date:   Thu, 3 Dec 2020 09:25:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-20-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/3/20 9:05 AM, Stefano Garzarella wrote:
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 2c892e890b9e..b0f91ad8eb47 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -9,15 +9,20 @@ menuconfig VDPA
>  if VDPA
>  
>  config VDPA_SIM
> -	tristate "vDPA device simulator"
> +	tristate "vDPA device simulator core"
>  	depends on RUNTIME_TESTING_MENU && HAS_DMA
>  	select DMA_OPS
>  	select VHOST_RING
> +	help
> +	  Enable this module to support vDPA device simulators. These devices
> +	  are used for testing, prototyping and development of vDPA.
> +
> +config VDPA_SIM_NET
> +	tristate "vDPA simulator for networking device"
> +	depends on VDPA_SIM
>  	select GENERIC_NET_UTILS
>  	help
> -	  vDPA networking device simulator which loop TX traffic back
> -	  to RX. This device is used for testing, prototyping and
> -	  development of vDPA.
> +	  vDPA networking device simulator which loop TX traffic back to RX.

	                                         loops


thanks.
-- 
~Randy

