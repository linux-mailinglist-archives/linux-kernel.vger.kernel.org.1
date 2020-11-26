Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AED2C5231
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbgKZKjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:39:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729906AbgKZKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606387149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yo9d18j2JYmcCVTus4QfEo0yCONfJHdLzX0h7oSMmXc=;
        b=UKl0Qs/UtT8sjWgA5uTNmNmch6b2k2BHNEpij3KtV9vGAHFapas+NQciYg7TBL1WI9V5xV
        LAQOn1ugUIUIOLm1W3gYdwmzIhwWaauFRlylbeTrg34UlB8ZNhPs/gCr6N6CzcutFWamYk
        b5+sLU9HGmKUVAUOzM2ytTF5sxLNlPw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-TM3oiWZ9MuSdT17ICcYm4g-1; Thu, 26 Nov 2020 05:39:07 -0500
X-MC-Unique: TM3oiWZ9MuSdT17ICcYm4g-1
Received: by mail-ej1-f71.google.com with SMTP id e7so659928eja.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 02:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yo9d18j2JYmcCVTus4QfEo0yCONfJHdLzX0h7oSMmXc=;
        b=gXFyZGR5VxTvlUDeZJKWVkmkcd6zDWlDZYtEruRz1iIGPggUS0MLOpaM6uVKc0NBPn
         f4eb/F48dbM3M5HDhT6ZdCTnp21k0IlfymUOQ6ITDF4FlMpQzmIScTaXhlxOv/KXZxBS
         dIFKj0TQ7hx59nW+vGC0IkH9q66oUieVAysF65avoejnYPN4Yn2ihJPaEeGK8c7/WqvC
         WvSAcYSopxfs7+l7xnHJMYLyasfp9PnGOy75gUM7v/lh8bb7yA7WObKJ8emMTD1bgLW7
         SwLwYSmR2WI0t5PmeQT7clZpvmNAngHFYExsJKmmxZepwwaPirdU9/CoTDuQTzQwWj3c
         Q7Cw==
X-Gm-Message-State: AOAM530LRCwLojq7GbQPSbDdY/bPjc5E1/HtcIP2+G47+Vw5x6sWOwDc
        7Zf5YvJYTJ8lgvbsL624VGXpjUxsbVZk+98DHSwR92Rz6d44kQyRmuHPRb4PTOixSyR6GtLDazZ
        Tzb6ygiPvdOzCp22BkhdyBQqs
X-Received: by 2002:a17:906:5396:: with SMTP id g22mr57514ejo.111.1606387146253;
        Thu, 26 Nov 2020 02:39:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNqyNPOsDiAGgbbM5IQoz3m9FelhIsADjjDJACM8vb6NtTGhRKPRR3xeOyoTkIcLDaA2Gjww==
X-Received: by 2002:a17:906:5396:: with SMTP id g22mr57496ejo.111.1606387146055;
        Thu, 26 Nov 2020 02:39:06 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id a26sm2961625edt.74.2020.11.26.02.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 02:39:05 -0800 (PST)
Subject: Re: [PATCH v3 0/5] x86/platform/uv: Add uv_sysfs platform driver
To:     Justin Ernst <justin.ernst@hpe.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Mike Travis <mike.travis@hpe.com>
References: <20201125175444.279074-1-justin.ernst@hpe.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ac3d704e-4403-2dfb-7fb5-a2c4cbaa1deb@redhat.com>
Date:   Thu, 26 Nov 2020 11:39:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125175444.279074-1-justin.ernst@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/25/20 6:54 PM, Justin Ernst wrote:
> Introduce a new platform driver to gather topology information from UV systems
> and expose that information via a sysfs interface at /sys/firmware/sgi_uv/.
> 
> This is version 3 with these changes since version 2:
> 
>  * Export sn_coherency_id to fix build failure when UV_SYSFS=m, caused by re-introduction
> 	of /sys/firmware/sgi_uv/coherence_id in v2.
> 
>  * Fix a null pointer dereference in drivers/platform/x86/uv_sysfs.c:uv_ports_exit()
> 	caused by calling kobject_put() on an out of range index value.
> 
> Version 2 included these changes since version 1:
> 
>  * Re-introduced /sys/firmware/sgi_uv/coherence_id file in the new driver after
> 	removing it in Patch 1/5. This keeps the userspace API unbroken.
> 
> Justin Ernst (5):
>   x86/platform/uv: Remove existing /sys/firmware/sgi_uv/ interface
>   x86/platform/uv: Add and export uv_bios_* functions
>   x86/platform/uv: Add new uv_sysfs platform driver
>   x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/
>   x86/platform/uv: Update MAINTAINERS for uv_sysfs driver
> 
>  .../ABI/testing/sysfs-firmware-sgi_uv         | 141 ++-
>  MAINTAINERS                                   |   6 +
>  arch/x86/include/asm/uv/bios.h                |  49 +
>  arch/x86/include/asm/uv/uv_geo.h              | 103 +++
>  arch/x86/platform/uv/Makefile                 |   2 +-
>  arch/x86/platform/uv/bios_uv.c                |  55 ++
>  arch/x86/platform/uv/uv_sysfs.c               |  63 --
>  drivers/platform/x86/Kconfig                  |  11 +
>  drivers/platform/x86/Makefile                 |   3 +
>  drivers/platform/x86/uv_sysfs.c               | 862 ++++++++++++++++++
>  10 files changed, 1217 insertions(+), 78 deletions(-)
>  create mode 100644 arch/x86/include/asm/uv/uv_geo.h
>  delete mode 100644 arch/x86/platform/uv/uv_sysfs.c
>  create mode 100644 drivers/platform/x86/uv_sysfs.c

My acked-by for merging the drivers/platform/x86 bits through the x86/tip
tree still stands:

Acked-by: Hans de Goede <hdegoede@redhat.com>

REgards,

Hans

