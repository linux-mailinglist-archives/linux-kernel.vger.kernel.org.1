Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B31929E5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgJ2ICl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 04:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJ2IBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 04:01:21 -0400
Received: from coco.lan (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E88B82076E;
        Thu, 29 Oct 2020 08:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603958480;
        bh=77sBzSTdKcEaES23QgKUZcK7w9/O6X9Q2FoPmmzXtIA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CP4i2HT3ytdq3sgp9Sao96M61BjfFIJ0T5N3bJ085NjE1ezckkkENsRrqJROhYoSc
         qbMN5ftMtm833xtks8dnK6PrB9fv76+1CehOrPKJgIXKAr7a6yoffUpHmrHk6R1T96
         p+NCIGi+qlE1UkBnMqt/oHzPzU/m5cO43hraWohQ=
Date:   Thu, 29 Oct 2020 09:01:14 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Divya Bharathi <divya27392@gmail.com>
Cc:     dvhart@infradead.org, LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Divya Bharathi <divya.bharathi@dell.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        mark gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>
Subject: Re: [PATCH v7] Introduce support for Systems Management Driver over
 WMI for Dell Systems
Message-ID: <20201029090114.64daf4e3@coco.lan>
In-Reply-To: <20201027134944.316730-1-divya.bharathi@dell.com>
References: <20201027134944.316730-1-divya.bharathi@dell.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 27 Oct 2020 19:19:44 +0530
Divya Bharathi <divya27392@gmail.com> escreveu:

> The Dell WMI Systems Management Driver provides a sysfs
> interface for systems management to enable BIOS configuration
> capability on certain Dell Systems.
> 
> This driver allows user to configure Dell systems with a
> uniform common interface. To facilitate this, the patch
> introduces a generic way for driver to be able to create
> configurable BIOS Attributes available in Setup (F2) screen.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: mark gross <mgross@linux.intel.com>
> 
> Co-developed-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Co-developed-by: Prasanth KSR <prasanth.ksr@dell.com>
> Signed-off-by: Prasanth KSR <prasanth.ksr@dell.com>
> Signed-off-by: Divya Bharathi <divya.bharathi@dell.com>
> ---


> +What:		/sys/class/firmware-attributes/*/authentication/
> +Date:		February 2021
> +KernelVersion:	5.11
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +
> +		Devices support various authentication mechanisms which can be exposed
> +		as a separate configuration object.
> +
> +		For example a "BIOS Admin" password and "System" Password can be set,
> +		reset or cleared using these attributes.
> +		- An "Admin" password is used for preventing modification to the BIOS
> +		  settings.
> +		- A "System" password is required to boot a machine.
> +

This is adding a new warning:

	$ ./scripts/get_abi.pl validate
	Warning: file Documentation/ABI/testing/sysfs-class-firmware-attributes#172:
		What '/sys/class/firmware-attributes/*/authentication/' doesn't have a description

Because you forgot to add a Description: tag.

Feel free to either add the enclosed tag to the tree which added this into
linux-next, or to fold id with the original patch.

Thanks,
Mauro

ABI: docs: sysfs-class-firmware-attributes: add a missing tag
    
The Description:  tag is missing, causing this warning with
scripts/get_abi.pl:
    
	Warning: file Documentation/ABI/testing/sysfs-class-firmware-attributes#172:
		 What '/sys/class/firmware-attributes/*/authentication/' doesn't have a description
    
Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 04a15c72e883..ea1837f1f3c2 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -113,7 +113,7 @@ KernelVersion:	5.11
 Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
 		Mario Limonciello <mario.limonciello@dell.com>,
 		Prasanth KSR <prasanth.ksr@dell.com>
-
+Description:
 		Devices support various authentication mechanisms which can be exposed
 		as a separate configuration object.
 

