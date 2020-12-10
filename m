Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E60D2D644E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392970AbgLJSB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:01:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732206AbgLJSBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 13:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607623186;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=miPlyEGKFxoGa24ryNqCASQdc5deGGtvievJU2IZNcA=;
        b=BxKDikVgZbm3D+OjVbvURdNbPBl/6NmA6aDgD6tPv2pTlEf2J72cQytLZfxGNoIqrI/KxN
        CvPYFs3cT9ovbFEcArUWSz9SO8hI7qeEPahRXy8xQ5QIBeVkfKwQKXwHISpR09WxDf30Nj
        M6M+cFUcMeUwlTAp6REovEyNZcQ4UjA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-yCGgErpqO1Oq_5WKStBKDQ-1; Thu, 10 Dec 2020 12:59:45 -0500
X-MC-Unique: yCGgErpqO1Oq_5WKStBKDQ-1
Received: by mail-qt1-f198.google.com with SMTP id i1so4529250qtw.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:59:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=miPlyEGKFxoGa24ryNqCASQdc5deGGtvievJU2IZNcA=;
        b=aMONLaQbFDzvrjoKAJffgmclQ8nGwReR6Wsp+4PrpOaCXCGJjQ0QRvnAXc8edOMjD8
         NWssY2XUe9Iemp8r8WjWnZoOD7Zm7tscWnifm0UHE+DY2KgNSJEd28c3xzfp5M1UUuBN
         nBojdm9w3wtVqrySx0UgeiEsWZt1dN2k2XyxbSH40NYkb8em15csX76ltAh3V/NnY3GA
         vFxvW0BQ26Ubs2F2O+BRRiUjmD8370jmHerz4NyQUm9Dz7Z3DyMEPZ3mDKGVrvd7WQdD
         QvDlupdnUPldZaJMV93URP0cko/P3RdPS4ile4BpGYrEu0mW3Ud0AaEjhfQBs62qSHkf
         qyiQ==
X-Gm-Message-State: AOAM532nls1Gwp4tr7w9Dcj/Okwpdl7GXCSJ38NhdL1PfK0vv7CfT0s+
        SGoEc293O3SdTgv3Ub/n55vxijuTDF3Q6NKC0IkyLmmAJDkc9kmTjtSmWpWVSe3+PAmNKbJNwuZ
        b9RU+y306bGXzTxCdEbPCfdWN
X-Received: by 2002:aed:3051:: with SMTP id 75mr10549146qte.64.1607623184850;
        Thu, 10 Dec 2020 09:59:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxejh2Gr5HYiB6KfMBmbtZVRZHA4dnV4LUHU7T3+dXsaBxb5lrxub5RIB9FoNV4l/s8tTX7w==
X-Received: by 2002:aed:3051:: with SMTP id 75mr10549123qte.64.1607623184645;
        Thu, 10 Dec 2020 09:59:44 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id z8sm3851407qti.22.2020.12.10.09.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:59:43 -0800 (PST)
Message-ID: <c4726b0adb72bbc9f740f05c22af1c6b9401a8e1.camel@redhat.com>
Subject: Re: [PATCH 2/7] Revert "ACPI / OSI: Add OEM _OSI string to enable
 NVidia HDMI audio"
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Cc:     Alex Hung <alex.hung@canonical.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Date:   Thu, 10 Dec 2020 12:59:42 -0500
In-Reply-To: <20190814213118.28473-3-kherbst@redhat.com>
References: <20190814213118.28473-1-kherbst@redhat.com>
         <20190814213118.28473-3-kherbst@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, bumping the discussion again here because we just ran into this again, as we
just had a laptop OEM try to fix another issue by adding an OSI check for these
strings instead of helping us fix the issue in nouveau. Note as  well the issue
I'm referring to is entirely independent of runtime D3, so we just got runtime
D3 broken again because of these hacks.

Why hasn't this patch been accepted into the kernel? These were added without
any sort of discussion with nouveau developers, and nouveau is the canonical
nvidia driver in the Linux kernel. These strings shouldn't be here without
discussion with the relevant driver maintainers, and need to be removed.

On Wed, 2019-08-14 at 23:31 +0200, Karol Herbst wrote:
> This reverts commit 887532ca7ca59fcf0547a79211756791128030a3.
> 
> We have a better solution for this: b516ea586d717
> 
> And same as with the last commit: "NVidia Linux driver" that's Nouveau, any
> out of tree driver does _not_ matter. And with Nouveau all of this works even
> though it required a proper fix first, but we have that now.
> 
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> CC: Alex Hung <alex.hung@canonical.com>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Dave Airlie <airlied@redhat.com>
> CC: Lyude Paul <lyude@redhat.com>
> CC: Ben Skeggs <bskeggs@redhat.com>
> ---
>  drivers/acpi/osi.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index 9b20ac4d79a0..56cc95b6b724 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -53,14 +53,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
>          * be removed if both new and old graphics cards are supported.
>          */
>         {"Linux-Dell-Video", true},
> -       /*
> -        * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's
> HDMI
> -        * audio device which is turned off for power-saving in Windows OS.
> -        * This power management feature observed on some Lenovo Thinkpad
> -        * systems which will not be able to output audio via HDMI without
> -        * a BIOS workaround.
> -        */
> -       {"Linux-Lenovo-NV-HDMI-Audio", true},
>  };
>  
>  static u32 acpi_osi_handler(acpi_string interface, u32 supported)

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

