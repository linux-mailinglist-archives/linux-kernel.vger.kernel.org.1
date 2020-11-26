Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632192C523B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbgKZKov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 05:44:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730896AbgKZKov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 05:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606387489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f74I7B0oYWxV5Wlbe91BOc7t2kit6ZIk87Mc2GruqJ0=;
        b=CtQ3Up2Ypm+fNJg37OeQ4uJgJlERZvNOrCAGohgNibmAyxsxLufjPpCx6C44KBwC8sfKN6
        sX3wrXOwLchvcso9I2WK+5J75YPrO8bzlx+5c0FQLztQ0+hoTGuDg+HWn+g4y82pzTzvIy
        XH2AxRSouF9y8ZdXMrW1kr3n64Y6PPA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-PvRpeS51PiuDoxGumnBh9w-1; Thu, 26 Nov 2020 05:44:47 -0500
X-MC-Unique: PvRpeS51PiuDoxGumnBh9w-1
Received: by mail-ej1-f70.google.com with SMTP id k15so680577ejg.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 02:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f74I7B0oYWxV5Wlbe91BOc7t2kit6ZIk87Mc2GruqJ0=;
        b=o1hxiTdb8sJYMqWr+4UFhO298RFZosUMBjo6RBE66suMvF2STzLembKw8pPyxNaIrh
         6/EmUXm3I1C1vB/I7p1byDFKHyWYXSiYBkZWisjhGSSi/LST7g6cxGbneheHnRlSdv1A
         zGC1Upf88DBxRZbb9hk+8NIFIOpIGB/bu4EvIVeIsE8AjBR2wQb32kFyJNQHRfAJGCG3
         cHQwm2jFz5SC3PxMNCqyuVL9RXTfiXQapMmAdm0+Gc7PqRSTV95jGQZtSw2ED+UhvY2X
         XWuFfSKjRMkyaJ7zCdPm9JnaApzJi85WAJHfzHFtWmwDMyjL3VKDVspGUZ+k3BdYv0F2
         /vjA==
X-Gm-Message-State: AOAM533NY/Wv8D/MXtV7ORmr74o60CkOMU+OmpXWfTRULHRGpjlT2PAG
        kFCB87MC5vPslrKinU5E2LFwmM9A4jqlFvsXJ34P0g5MatDe0e4f/RYIpWEZqFpbcNT05BlFjTW
        EI7zLdjMNY3f3sn8aFmJ2K3KC
X-Received: by 2002:a17:907:94c6:: with SMTP id dn6mr2104455ejc.13.1606387486367;
        Thu, 26 Nov 2020 02:44:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPnOJBMgWd0HEVl9SUT3jmZ1HXa/sGHf5+sS9raCr0gVbh2sGuByEK0SG8QghzbMibd/LupA==
X-Received: by 2002:a17:907:94c6:: with SMTP id dn6mr2104441ejc.13.1606387486155;
        Thu, 26 Nov 2020 02:44:46 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id o17sm2939501edz.10.2020.11.26.02.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 02:44:45 -0800 (PST)
Subject: Re: [PATCH 0/5] x86/platform/uv: Move UV procfs leaves to sysfs
To:     Mike Travis <mike.travis@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Mark Gross <mgross@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20201125172907.240996-1-mike.travis@hpe.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <815f9d40-6c17-9bd3-f3c8-626d007b8597@redhat.com>
Date:   Thu, 26 Nov 2020 11:44:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201125172907.240996-1-mike.travis@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/25/20 6:29 PM, Mike Travis wrote:
> 
> Duplicate the current UV procfs leaves to the uv_sysfs driver so they show
> up under /sys/firmware/sgi_uv.  Show a 'deprecated' warning message if
> any of the old /proc/sgi_uv leaves are used.
> 
> These patches depend on the prior set sent by Justin Ernst <justin.ernst@hpe.com>
> 	x86/platform/uv: Remove existing /sys/firmware/sgi_uv/ interface
> 	x86/platform/uv: Add and export uv_bios_* functions
> 	x86/platform/uv: Add new uv_sysfs platform driver
> 	x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/
> 	x86/platform/uv: Update MAINTAINERS for uv_sysfs driver
> 
> Mike Travis (5):
>   x86/platform/uv: Add kernel interfaces for obtaining system info.
>   x86/platform/uv: Add sysfs leaves to replace those in procfs
>   x86/platform/uv: Add sysfs hubless leaves
>   x86/platform/uv: Add deprecated messages to /proc info leaves
>   x86/platform/uv: Update sysfs document file
> 
>  .../ABI/testing/sysfs-firmware-sgi_uv         | 16 +++++
>  arch/x86/include/asm/uv/bios.h                |  2 +
>  arch/x86/kernel/apic/x2apic_uv_x.c            | 38 +++++++++-
>  drivers/platform/x86/uv_sysfs.c               | 70 ++++++++++++++++++-
>  4 files changed, 123 insertions(+), 3 deletions(-)

This series depends on the:

[PATCH v3 0/5] x86/platform/uv: Add uv_sysfs platform driver

Series, next time when such a thing is the case, please add a note
about this to the cover letter.

Like with the "[PATCH v3 0/5] x86/platform/uv: Add uv_sysfs platform driver" series,
this series too should be merged in its entirety through the x86/tip tree (once the
other series is merged). Please also add this info to the cover letter.

I've one remark to patch 4 (which I send in a reply to that). So a v2 is going
to be necessary. Please include the above bits in the v2 cover-letter.

Regards,

Hans

