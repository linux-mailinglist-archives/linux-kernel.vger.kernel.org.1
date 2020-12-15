Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8172DABFA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgLOLZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:25:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728652AbgLOLTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608031055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vaPBRIesr27IX6qkoAPHHZTgEVHDzEcMSMnvfR1oaMU=;
        b=HFUdYgGDTxW9fBAdgg9FKEEz5KBdsYU3XKXZC+wdDi7lg8NFC3QNLpeUT6cd72vrfkmNm6
        R2lEHuItX12Eeq/NKjxYrPBEDmKowVEh7C+RdEZhTO7rnXp7SRnl8xKTsXXazHsz8ozQFe
        NGPzfk1ifcVjl1q1UjjoMXCm9wGiDek=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-w4kd6cPbNCyGB_IfAUMzzg-1; Tue, 15 Dec 2020 06:17:33 -0500
X-MC-Unique: w4kd6cPbNCyGB_IfAUMzzg-1
Received: by mail-ej1-f72.google.com with SMTP id gs3so3480402ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 03:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vaPBRIesr27IX6qkoAPHHZTgEVHDzEcMSMnvfR1oaMU=;
        b=gbASfGFtBct9t3jOuNkeTcw/+CgSpn03UMhKO5uaAUze+CQvrASE7T89RfFa9maZr8
         ywd4waG/jnNCvA14ruhfzFfxer9pa3SNTgINZkjmXU72dCO6NfdsXiqekR12GYjveEXA
         zEbbARt6Ekdum0akEtmSXQkRl+Rb/rC9f+wIjJ4X3MeB7AoEClgxQgmZoDiaB2d14Whn
         54+ldplucv3j6aWcZLlFkkeTw4XVguCQO6GQo5c2t+ao9XTBUS8Cm7RUNmiBlMPmznS1
         AogUnAmcvHM3asy6mFhioXmFSQcLvsmPvxUuyc6SVvnIXGFz2pOMEZ98+HFudpYLIBn1
         +tow==
X-Gm-Message-State: AOAM530oLwu510eEVybflpahPQjF6IwIpwSlQG2KzLdcOx/tiBtyXmZ2
        MVWPEwrDH3cno3fEMrWqEahmR5hoYbMrDGd7ppp+r/+/Q0RIMs7D2sXYNCbPOUZLzdXUcRIvdSl
        nAFq09snN1Q7vOvMi2vw2ywsK
X-Received: by 2002:a50:8004:: with SMTP id 4mr14732617eda.329.1608031052570;
        Tue, 15 Dec 2020 03:17:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8Ukb3b5sC/L9ddJO9dEIvpLc1T192z0TMMRjb3sOdjbu8IPQRItEeSkmUrx5lh7khNRbdFw==
X-Received: by 2002:a50:8004:: with SMTP id 4mr14732609eda.329.1608031052383;
        Tue, 15 Dec 2020 03:17:32 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id d13sm4370782edx.27.2020.12.15.03.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 03:17:31 -0800 (PST)
Subject: Re: [RFT][PATCH v1 0/3] ACPI: scan: Defer enumeration of devices with
 significant dependencies
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1646930.v2jOOB1UEN@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <551a2185-bde5-3338-2d47-d2cf4b1c55f5@redhat.com>
Date:   Tue, 15 Dec 2020 12:17:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1646930.v2jOOB1UEN@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/14/20 9:23 PM, Rafael J. Wysocki wrote:
> Hi,
> 
> This series addresses some enumeration ordering issues by using information
> from _DEP to defer the enumeration of devices that are likely to depend on
> operation region (OpRegion) handlers supplied by the drivers of other
> devices.
> 
> This allows the OpRegion suppliers to be probed and start working before the
> devices depending on them are enumerated.
> 
> Please see the patch changelogs for details.
> 
> Hans, please test this series on the system with OpRegion dependencies in
> control methods used for device enumeration.

Thank you for you work on this!

I started with reviewing the series so that I would know what to
expect during testing. All 3 patches look good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

As is the series does not fix the Bluetooth HID misreporting on
the system with OpRegion dependencies in its BT ACPI node's _HID,
but ...

This is expected because that _HID has a _DEP on the GPO1 GPIO
controller, which in turn has a _DEP pointing to the
"Intel Baytrail Mailbox Device" ("INT33BD")

We (Linux) don't do anything with the INT33BD device, so it can
simply be added to the acpi_ignore_dep_ids list. With this done the
3 patches from this RFT fix the BT _HID issue. IOW everything works
as expected / as we want.

While at it I also booted the kernel with these patches on a
Lenovo Yoga X1 Carbon 8th gen. I'm not seeing any adverse side
effects there, so please add my tested-by to the entire series:

Tested-by: Hans de Goede <hdegoede@redhat.com>

I will send out a patch adding "INT33BD" to the
acpi_ignore_dep_ids list (to be applied on top of this series)
right away.

Regards,

Hans

