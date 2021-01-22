Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942F32FF9DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 02:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbhAVBPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 20:15:16 -0500
Received: from ozlabs.org ([203.11.71.1]:37849 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbhAVBPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 20:15:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DMLrf3P3Rz9s2g;
        Fri, 22 Jan 2021 12:14:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1611278070;
        bh=NJpPoI1A/neYhNngn2yurLBQDpyZQf7HFMPUpvWFaxk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YjoVlRaJFJ99ZTETmF2ODowAr6esWeLYFk5RMSMf8/cn1VAyGEI5kzN3V25M+m+U9
         TJyp4L4tei3zfiVzF62JjZAyA6FaE7NffIs9KAl3yajBUjNjJz9Z5OjTFWaI2YU1dJ
         81V1g3FDMHQ+PyCYsKLo6fcYdO93a6Tl+qAsYuwTfFehTsK9uzxuD5lvgeC/9/2M8g
         faW5YZf8aPzF1xQsynDiCppWOHKQCmzQ4r+dYDxDanEGZ8DLHGektqcKQ9YMxbI6Nv
         tZ5K4H19aWypStrn8Dy9egORIo1G8OXwbmaCIjrqZhCDWJQuxcOlCqLZ3r2jRDEjYg
         A6cu3YgkNomHA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: fix AKEBONO build failures
In-Reply-To: <6c442012-3bef-321b-bbc3-09c54608661f@infradead.org>
References: <CAAH8bW8-6Dp29fe6rrnA4eL1vo+mu0HuAVJ-5yjbwxDSvaHdeQ@mail.gmail.com> <6c442012-3bef-321b-bbc3-09c54608661f@infradead.org>
Date:   Fri, 22 Jan 2021 12:14:23 +1100
Message-ID: <875z3prcwg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> On 1/20/21 1:29 PM, Yury Norov wrote:
>> Hi all,
>> 
>> I found the power pc build broken on today's
>> linux-next (647060f3b592).
>
> Darn, I was building linux-5.11-rc4.
>
> I'll try linux-next after I send this.
>
> ---
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fulfill AKEBONO Kconfig requirements.
>
> Fixes these Kconfig warnings (and more) and fixes the subsequent
> build errors:
>
> WARNING: unmet direct dependencies detected for NETDEVICES
>   Depends on [n]: NET [=n]
>   Selected by [y]:
>   - AKEBONO [=y] && PPC_47x [=y]
>
> WARNING: unmet direct dependencies detected for MMC_SDHCI
>   Depends on [n]: MMC [=n] && HAS_DMA [=y]
>   Selected by [y]:
>   - AKEBONO [=y] && PPC_47x [=y]
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/powerpc/platforms/44x/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- lnx-511-rc4.orig/arch/powerpc/platforms/44x/Kconfig
> +++ lnx-511-rc4/arch/powerpc/platforms/44x/Kconfig
> @@ -206,6 +206,7 @@ config AKEBONO
>  	select PPC4xx_HSTA_MSI
>  	select I2C
>  	select I2C_IBM_IIC
> +	select NET
>  	select NETDEVICES
>  	select ETHERNET
>  	select NET_VENDOR_IBM

I think the problem here is too much use of select, for things that
should instead be in the defconfig.

The patch below results in the same result for make
44x/akebono_defconfig. Does it fix the original issue?

We don't need to add ETHERNET or NET_VENDOR_IBM to the defconfig because
they're both default y.

cheers


diff --git a/arch/powerpc/configs/44x/akebono_defconfig b/arch/powerpc/configs/44x/akebono_defconfig
index 3894ba8f8ffc..6b08a85f4ce6 100644
--- a/arch/powerpc/configs/44x/akebono_defconfig
+++ b/arch/powerpc/configs/44x/akebono_defconfig
@@ -21,6 +21,7 @@ CONFIG_IRQ_ALL_CPUS=y
 # CONFIG_COMPACTION is not set
 # CONFIG_SUSPEND is not set
 CONFIG_NET=y
+CONFIG_NETDEVICES=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
@@ -98,6 +99,8 @@ CONFIG_USB_OHCI_HCD=y
 # CONFIG_USB_OHCI_HCD_PCI is not set
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_M41T80=y
 CONFIG_EXT2_FS=y
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 78ac6d67a935..509b329c112f 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -206,15 +206,10 @@ config AKEBONO
        select PPC4xx_HSTA_MSI
        select I2C
        select I2C_IBM_IIC
-       select NETDEVICES
-       select ETHERNET
-       select NET_VENDOR_IBM
        select IBM_EMAC_EMAC4 if IBM_EMAC
        select USB if USB_SUPPORT
        select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD
        select USB_EHCI_HCD_PLATFORM if USB_EHCI_HCD
-       select MMC_SDHCI
-       select MMC_SDHCI_PLTFM
        select ATA
        select SATA_AHCI_PLATFORM
        help
