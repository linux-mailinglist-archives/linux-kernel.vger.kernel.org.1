Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729B92B2487
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgKMTbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMTbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:31:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ED9C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=V15TCrSdvvl0eHQ2B5KeRVDPQVrQ+kR6/+KoOQhbZ/o=; b=h8iwUL9yiUS6zCfmZDBAT9LyMs
        7dhIDTRIGMkIjouCJ+HYUriz/t25CM3meKDmRWwcJMvrKE69YlN8qM36XUXpri1HDV4t1GxoMdjUt
        RnEPvQG5btbMaf2MBVBJRjgjYHE+/E/ZLPKIdi1w9u25rFSI6mFtyj6XbZ/NC3IpU3dY51TGo263y
        5ubwVc/SxN8kL5wErA4n1WLV/Vd8liqKZRjjgbvgx0rXzA2ulH3zMDKkbzNS06/TeCX6kXUxoqpro
        QhNnyDQX5kP928cPGXmBKC8p3+LWXncW64oXFvsEzSDJu24Y8fmukRV493xeD1HgWf6p2GZNmH97/
        cKgmby0g==;
Received: from [2601:1c0:6280:3f0::662d]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdemv-0006eS-BS; Fri, 13 Nov 2020 19:31:14 +0000
Subject: Re: [PATCH] vdpasim: fix "mac_pton" undefined error
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        kernel test robot <lkp@intel.com>
References: <20201113155706.599434-1-lvivier@redhat.com>
 <fdab06b3-039b-df4b-243e-9cb0e940cc15@infradead.org>
Message-ID: <1578a773-edef-4bbf-676f-cf8d52dc0a4e@infradead.org>
Date:   Fri, 13 Nov 2020 11:31:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <fdab06b3-039b-df4b-243e-9cb0e940cc15@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 10:49 AM, Randy Dunlap wrote:
> On 11/13/20 7:57 AM, Laurent Vivier wrote:
>>    ERROR: modpost: "mac_pton" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
>>
>> mac_pton() is defined in lib/net_utils.c and is not built if NET is not set.
>>
>> Select GENERIC_NET_UTILS as vdpasim doesn't depend on NET.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> On Nov. 2, 2020:
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> 
> https://lore.kernel.org/lkml/d3d50a94-cdc5-572b-e9ca-3ee5638d21ee@infradead.org/
> 
> 
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>  drivers/vdpa/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
>> index d7d32b656102..358f6048dd3c 100644
>> --- a/drivers/vdpa/Kconfig
>> +++ b/drivers/vdpa/Kconfig
>> @@ -13,6 +13,7 @@ config VDPA_SIM
>>  	depends on RUNTIME_TESTING_MENU && HAS_DMA
>>  	select DMA_OPS
>>  	select VHOST_RING
>> +	select GENERIC_NET_UTILS
>>  	default n
>>  	help
>>  	  vDPA networking device simulator which loop TX traffic back
>>
> 
> Thanks for the patch.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

-- 
~Randy
