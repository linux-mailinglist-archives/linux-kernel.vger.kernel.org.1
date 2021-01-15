Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8293B2F866E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbhAOUOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbhAOUOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:14:46 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41EAC061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=IE4MAbc5BExZ5lhJ69oVQ1CIYy1AXCTv7sW0YbYZvPk=; b=LHCsF//Ks8fOXNsa605p/03dlB
        DamAIJxZmxFjGHn/CRcw1+p1/EMQLm1Nci7pqE1bWjnpJXBjR8vVFrPLQXrshwBvEPCcIGFChz+gK
        URZNWHD/Crke1T/3l3/5iD81ryyxmSmrs+8b7xVRTfqJ+TSgk9ijsePQzncgSHxzwwCoN6v0Dbp1j
        l+wX/zGHmkGlQMnjK0bvaUbnFAMU3v0h8EFYO6hNGgQ7x2AjPxqkuzYJan9aZfQy1M3D94V/rXMe7
        jeSv/czkp3qbl5acJsC6q3ENWg8zPuLxLMRQleJv0THg1UXpnf6maohWGbDUrEypaHWeaRbnUSD7o
        CtsEIJzw==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l0VTv-0006js-DO; Fri, 15 Jan 2021 20:14:03 +0000
Subject: Re: [PATCH] firmware: Kconfig: fix indentions
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
References: <20210115194234.6328-1-info@metux.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <38a148d8-8390-bd08-7caf-69d505387169@infradead.org>
Date:   Fri, 15 Jan 2021 12:13:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210115194234.6328-1-info@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/21 11:42 AM, Enrico Weigelt, metux IT consult wrote:
> Make the indentions consistent with everywhere else in the kernel.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

LGTM. Thanks.

But you need to send it To: or Cc: some maintainer(s).
They don't generally graze on lkml for patches.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/firmware/Kconfig | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 3f14dffb9669..490931b800ee 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -86,8 +86,8 @@ config EDD
>  	  BIOS tries boot from.  This information is then exported via sysfs.
>  
>  	  This option is experimental and is known to fail to boot on some
> -          obscure configurations. Most disk controller BIOS vendors do
> -          not yet implement this feature.
> +	  obscure configurations. Most disk controller BIOS vendors do
> +	  not yet implement this feature.
>  
>  config EDD_OFF
>  	bool "Sets default behavior for EDD detection to off"
> @@ -99,14 +99,14 @@ config EDD_OFF
>  	  using the kernel parameter 'edd={on|skipmbr|off}'.
>  
>  config FIRMWARE_MEMMAP
> -    bool "Add firmware-provided memory map to sysfs" if EXPERT
> -    default X86
> -    help
> -      Add the firmware-provided (unmodified) memory map to /sys/firmware/memmap.
> -      That memory map is used for example by kexec to set up parameter area
> -      for the next kernel, but can also be used for debugging purposes.
> +	bool "Add firmware-provided memory map to sysfs" if EXPERT
> +	default X86
> +	help
> +	  Add the firmware-provided (unmodified) memory map to /sys/firmware/memmap.
> +	  That memory map is used for example by kexec to set up parameter area
> +	  for the next kernel, but can also be used for debugging purposes.
>  
> -      See also Documentation/ABI/testing/sysfs-firmware-memmap.
> +	  See also Documentation/ABI/testing/sysfs-firmware-memmap.
>  
>  config EFI_PCDP
>  	bool "Console device selection via EFI PCDP or HCDP table"
> @@ -133,9 +133,9 @@ config EFI_PCDP
>  	  <http://www.dig64.org/specifications/> 
>  
>  config DMIID
> -    bool "Export DMI identification via sysfs to userspace"
> -    depends on DMI
> -    default y
> +	bool "Export DMI identification via sysfs to userspace"
> +	depends on DMI
> +	default y
>  	help
>  	  Say Y here if you want to query SMBIOS/DMI system identification
>  	  information from userspace through /sys/class/dmi/id/ or if you want
> @@ -170,7 +170,7 @@ config ISCSI_IBFT
>  	select ISCSI_BOOT_SYSFS
>  	select ISCSI_IBFT_FIND if X86
>  	depends on ACPI && SCSI && SCSI_LOWLEVEL
> -	default	n
> +	default n
>  	help
>  	  This option enables support for detection and exposing of iSCSI
>  	  Boot Firmware Table (iBFT) via sysfs to userspace. If you wish to
> 


-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
