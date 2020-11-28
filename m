Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B802C73E9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbgK1Vtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733237AbgK1SAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606586361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4oHr7RZ6Qkbar7LjprzctLhseTfmkP0PXD4abO+7grA=;
        b=faTVOUeGozeTI1Ilnhhn5qFG8Jlm57V95vuDmpiyLWNec4IxDi05stbvBwy1VI3tE/Zbsd
        OTbX2x2r9NmLP17S2maLqiJKRfQvD1YY4IFI+A3LQ3kRkmyxKPFR3KBZaV8iejYXxi6B5v
        cl1wbRhkFGfHIKFUh85Z2OyOaq7huZg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-1xIO6yeqPWO75xCzYO82yQ-1; Sat, 28 Nov 2020 05:57:40 -0500
X-MC-Unique: 1xIO6yeqPWO75xCzYO82yQ-1
Received: by mail-ed1-f70.google.com with SMTP id dc6so1537695edb.14
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 02:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4oHr7RZ6Qkbar7LjprzctLhseTfmkP0PXD4abO+7grA=;
        b=JmgLIxFvs3EnhjA1wtyHTaie3s0urmGMfx5cSbcuQLQ+DpgAEMeNEMJ1IDFhL/7RGs
         B1S67thNcm6we0gVSCM+wEGRudIYQAsO2CCrtnPTDI+KmUpGaSl43eiarFvPN7hNiktR
         5sIXNzaXADdPrHAlFkisl03xy/5BhIpLOZE3/WaH1Oc8Ye24TgwMPfHl95KTACk2pOv+
         oxPBeQynE+dSqa1CCv4JGrffhEDgwiw2c20wUUuy/dSNJ+x8z4X9mLu63EZBWR1kBQly
         k9IDAYu1G3EBcqni1LVr6nypem4ospt7POJm2dFzomhU2KGlPYBnp/D7zIgnI2XMEe+G
         iDIQ==
X-Gm-Message-State: AOAM532qGvStk72uGq4UgXj76drS7RcBTZAquv8FhYDuHH9t/5qkLJ3d
        eFbk2xQuMiTFFwV63iEZ8IcE5wFePqkvYg7V6Zzt1a1wftpIWqqZbSQ7zTBo3ZNVDV5iGIL/Uhl
        WgQaA3Vcyq3BMLhc4MAV+XNMI
X-Received: by 2002:a17:906:b307:: with SMTP id n7mr3971816ejz.102.1606561059094;
        Sat, 28 Nov 2020 02:57:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzuaaElZg+ATz7E5Mi3VYv9reMaB21XlwiQVOH4OwqCWatvZlbmY3Z/gU10f3MwTBNehUnKtA==
X-Received: by 2002:a17:906:b307:: with SMTP id n7mr3971808ejz.102.1606561058891;
        Sat, 28 Nov 2020 02:57:38 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id u23sm6034802ejc.46.2020.11.28.02.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 02:57:38 -0800 (PST)
Subject: Re: [PATCH v2 0/5] x86/platform/uv: Move UV procfs leaves to sysfs
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
References: <20201128034227.120869-1-mike.travis@hpe.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0d13eea0-c74d-4686-6eca-b5f4d012dc74@redhat.com>
Date:   Sat, 28 Nov 2020 11:57:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128034227.120869-1-mike.travis@hpe.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/28/20 4:42 AM, Mike Travis wrote:
> 
> Duplicate the current UV procfs leaves to the uv_sysfs driver so they show
> up under /sys/firmware/sgi_uv.  Show a 'deprecated' warning message if
> any of the old /proc/sgi_uv leaves are used.
> 
> These patches depend on the prior v3 patchset sent by Justin Ernst <justin.ernst@hpe.com>
> 	x86/platform/uv: Remove existing /sys/firmware/sgi_uv/ interface
> 	x86/platform/uv: Add and export uv_bios_* functions
> 	x86/platform/uv: Add new uv_sysfs platform driver
> 	x86/platform/uv: Update ABI documentation of /sys/firmware/sgi_uv/
> 	x86/platform/uv: Update MAINTAINERS for uv_sysfs driver

AS with the previous series this series touches files under both
x86/platform and drivers/platform/x86. Like last time this is best merged
in its entirety through the x86/tip tree (which also has the previous set).
Here is my ack for the drivers/platform/x86 bits being merged through the
x86/tip tree:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> 
> v2: Updated to apply to v3 of dependency patch set listed above.
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
>  arch/x86/kernel/apic/x2apic_uv_x.c            | 26 ++++++-
>  drivers/platform/x86/uv_sysfs.c               | 70 ++++++++++++++++++-
>  4 files changed, 111 insertions(+), 3 deletions(-)
> 

