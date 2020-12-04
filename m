Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF17F2CE8D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 08:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgLDHuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:50:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbgLDHuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607068132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jGnG0b9M2ziZPf4CQZMAAFmJYUdUv5tCF4bWUtnXQ10=;
        b=L2tXDRR7pA0QOPeM9nE1exyrK9LbakHezT7QUg3gwtenH9xW0VZZERcoGPW5B2JaOlSAZS
        ttmrFeNhYs8d1yBVCgdHtak9cb5JcNzA/49RPeFnDSbvL9ZWsziuoaf0w3cMSz5GPsn9nv
        Wgr60UOn4ZdvOCVPVuzPt5IW5PLSOq4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-eOqH-N3oP1G4Jn71cHrXgw-1; Fri, 04 Dec 2020 02:48:50 -0500
X-MC-Unique: eOqH-N3oP1G4Jn71cHrXgw-1
Received: by mail-ej1-f72.google.com with SMTP id p18so1749603ejl.14
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 23:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jGnG0b9M2ziZPf4CQZMAAFmJYUdUv5tCF4bWUtnXQ10=;
        b=PNL9h3wQLwqEnJ5dLFyNFbOhmGnDgtVnKq7wJcjKocMxTDQFBgpDEr5JTL6zwS4upl
         k0HCArldDFlWZVWjC2azxvlugZ8/g+/6DOG27BPsL6TOfnI7u9a1ow/7uPqpFG/nd7Lh
         hVOfPGNh1txhNvkF+MmxQMVsF/USAOFFD6r9j9XZJ0lZz2fu7CzpdcPTn0b5GrXW5F7d
         wpx55S9XY6YNa8t0NrP+wKNS0/txY3L8dYT6u8oC4rHzgVbOiOzJds1YHP3WtpZsDgpx
         I5LLOtZLYtSX6iFZW7tTrKeDGxZFCfuUFiUWZ8M0VaABvO+pyHbUM5gQp4MLfpENagDa
         D0Jw==
X-Gm-Message-State: AOAM531pB0R0h6CrRZm7x+U/i7VJi1rzaYKW/NOZk8oVSQ7yKdfGbftj
        C1B2uFl/h8v1MRqIU3+m7j98AVIV1gmYeIvp192yemR/4fluBSH3ZQ/DFTTjNkPsFzNlpgSYCWL
        BnBQHxAQ7GuTf9wcLCrx7/+s8
X-Received: by 2002:a17:906:38d6:: with SMTP id r22mr5764513ejd.149.1607068129459;
        Thu, 03 Dec 2020 23:48:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxgz5jSx8FWg8x7FH/nJSosiNnfP6BLwk5LSwzDEq0BKHCrDA9JCLnDkHjIU910tkj1zf5xeA==
X-Received: by 2002:a17:906:38d6:: with SMTP id r22mr5764502ejd.149.1607068129247;
        Thu, 03 Dec 2020 23:48:49 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id b7sm2562998ejj.85.2020.12.03.23.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 23:48:48 -0800 (PST)
Date:   Fri, 4 Dec 2020 08:48:46 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v3 19/19] vdpa: split vdpasim to core and net modules
Message-ID: <20201204074846.s2nnyhlcsjxm673f@steredhat>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-20-sgarzare@redhat.com>
 <920c4975-a3ae-b7f9-ac89-6444ca2e4c45@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <920c4975-a3ae-b7f9-ac89-6444ca2e4c45@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 09:25:52AM -0800, Randy Dunlap wrote:
>Hi,
>
>On 12/3/20 9:05 AM, Stefano Garzarella wrote:
>> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
>> index 2c892e890b9e..b0f91ad8eb47 100644
>> --- a/drivers/vdpa/Kconfig
>> +++ b/drivers/vdpa/Kconfig
>> @@ -9,15 +9,20 @@ menuconfig VDPA
>>  if VDPA
>>
>>  config VDPA_SIM
>> -	tristate "vDPA device simulator"
>> +	tristate "vDPA device simulator core"
>>  	depends on RUNTIME_TESTING_MENU && HAS_DMA
>>  	select DMA_OPS
>>  	select VHOST_RING
>> +	help
>> +	  Enable this module to support vDPA device simulators. These devices
>> +	  are used for testing, prototyping and development of vDPA.
>> +
>> +config VDPA_SIM_NET
>> +	tristate "vDPA simulator for networking device"
>> +	depends on VDPA_SIM
>>  	select GENERIC_NET_UTILS
>>  	help
>> -	  vDPA networking device simulator which loop TX traffic back
>> -	  to RX. This device is used for testing, prototyping and
>> -	  development of vDPA.
>> +	  vDPA networking device simulator which loop TX traffic back to RX.
>
>	                                         loops

It was pre-existing, but since I'm there I'll fix it, thanks!

Stefano

