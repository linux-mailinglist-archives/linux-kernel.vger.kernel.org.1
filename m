Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61A42CF2D6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388598AbgLDRL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388575AbgLDRL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:11:26 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052ECC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=cevqeBvMiK1z4pR0QIc66JaWhXtth1Jyew3Q6xO1dss=; b=t28OvJoUPcHexu3oIKlK0Smmqn
        7TPhZg00E+sZks4pGWVh4Ghw4W2pbTDqjrv8XpZ2fHWj0+Xi5o4hRKp8OyfxNRJD8aTZgEsC38FVl
        q3QD6k1mL1vVz2abqJ45Raf/JzDzvDG70M2/16DZCXy/rEnn0HHwKFGJwcbLGZrN0gQUquA6CrOtJ
        NlIK4iqKo8XZu48rkDq53S+ky5DTtbhmra6Ssft55kD5FPw1r9YomudWY8idHgdbg+PD339YWFfr3
        b1qGfvSVg5fVKHjkbFG29TGUfarivyO4c2q2hwt0nMqeyV68Y/bLeYZ2BXWmXOe0oqBYHX9S1qTBt
        sVu4e/zw==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1klEbT-00032n-Mj; Fri, 04 Dec 2020 17:10:44 +0000
Subject: Re: [PATCH V2 16/19] virtio-pci: introduce modern device module
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
References: <20201204040353.21679-1-jasowang@redhat.com>
 <20201204040353.21679-17-jasowang@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a325b57b-817f-b96e-76fc-dba4415fe6b0@infradead.org>
Date:   Fri, 4 Dec 2020 09:10:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201204040353.21679-17-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason--

On 12/3/20 8:03 PM, Jason Wang wrote:
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 7b41130d3f35..d1a6bd2a975f 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -12,6 +12,14 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>  	  This option is selected if the architecture may need to enforce
>  	  VIRTIO_F_ACCESS_PLATFORM
>  
> +config VIRTIO_PCI_MODERN
> +	tristate "Modern Virtio PCI Device"
> +	depends on PCI
> +	help
> +	  Modern PCI device implementation. This module implement the

	                                                implements

> +	  basic probe and control for devices which is based on modern

	                                            are

> +	  PCI device with possible vendor specific extensions.

	      devices
> +


cheers.
-- 
~Randy

