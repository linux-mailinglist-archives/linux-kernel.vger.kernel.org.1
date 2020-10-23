Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF0F296E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463565AbgJWMTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463557AbgJWMTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:19:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FBFC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:19:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c16so1288608wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y/GfJ9csAvfz01MS4Yn4Vgi/f+7eaIOIFC90GAIpUwE=;
        b=Aci/DNmZebnhV4C16EppF+h3LtGgs6kLpDOfugo37Yy1//0UN7ZOS0arxKB9wYhewc
         VvozNpORLF/GhbfC9hfJg9qxrVTMlenxx9QGqrk7dgQDo9LL/8OvIogxyMaa6CqDKsn6
         1ZEBss0QEptkNk9N/R1f5K8SZQgpK7gMRfxUEKGfW3qmButhbH8lZ/60lfWxSYQlmn5R
         a9AC6P++p5ihu8aGLrpbtoxTodk2JQybsluL2wO2D/G4Gor0wdawRTbBEM2bizxjntU9
         2j0xo6WW5rIxXSNc66oNvp6GAWSj822y+Gg4FNc9e4bqo7/fcn1KGSEdZyBlGehlYhga
         3iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y/GfJ9csAvfz01MS4Yn4Vgi/f+7eaIOIFC90GAIpUwE=;
        b=Zg3KymeKX9T+NHaeQcNTCpVC2seTl7hR6OtyumxYNghg/ZInUs7WjhidqGeDjYIBPn
         cN30Oo1eswinMQMdeyxqKC7Ai7oTIg6QaJL4AnnqFQYMa/FldK+1dWgiSn7Olwx0VHlT
         TtcExjNcnZQRXwImTWdfr8OYY4zxjiaja7GAVC+IEDCgY+zibBjG4ju4JrbINnM9Z+aS
         a/mwMEFV3qeUTp3aLTeYTnG8fVvNHmBvM4FP62V1rVA8SKkRsCQUYjV5TluDKJnC7XTs
         KZ2L41YA/sxjpyCMFmzM2DLOT34hmAXuzkGnTbKsMOggS1dN2CUT0SOl8pwpa7bnjUbX
         cHfA==
X-Gm-Message-State: AOAM531skUMbbn6c4q96eg/BuPhiwkcZSWyLQmBnDJ8cauRcF7UIRiXA
        7BrOUx+nUewA+gCbsFRukQsZnQ==
X-Google-Smtp-Source: ABdhPJwWD1gWpwQ2e1XVk2aDU+s9cpkEk5nS/AIqufoggM/l57jtLHvu/lSzSa5cCA4Djv/bz8+kOA==
X-Received: by 2002:a05:600c:25a:: with SMTP id 26mr1643531wmj.39.1603455588466;
        Fri, 23 Oct 2020 05:19:48 -0700 (PDT)
Received: from tnowicki.c.googlers.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id m1sm2754479wme.48.2020.10.23.05.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 05:19:47 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] Add system mmu support for Armada-806
To:     Denis Odintsov <d.odintsov@traviangames.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "hannah@marvell.com" <hannah@marvell.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nadavh@marvell.com" <nadavh@marvell.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200715070649.18733-1-tn@semihalf.com>
 <517BB937-1F18-4CCF-81BF-11777BB99779@traviangames.com>
From:   Tomasz Nowicki <tn@semihalf.com>
Message-ID: <9ff9682f-c165-2ad4-6edd-9e56d7ec7424@semihalf.com>
Date:   Fri, 23 Oct 2020 12:19:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <517BB937-1F18-4CCF-81BF-11777BB99779@traviangames.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

Sorry for late response, we had to check few things. Please see comments 
inline.

On 10/6/20 3:16 PM, Denis Odintsov wrote:
> Hi,
> 
>> Am 15.07.2020 um 09:06 schrieb Tomasz Nowicki <tn@semihalf.com>:
>>
>> The series is meant to support SMMU for AP806 and a workaround
>> for accessing ARM SMMU 64bit registers is the gist of it.
>>
>> For the record, AP-806 can't access SMMU registers with 64bit width.
>> This patches split the readq/writeq into two 32bit accesses instead
>> and update DT bindings.
>>
>> The series was successfully tested on a vanilla v5.8-rc3 kernel and
>> Intel e1000e PCIe NIC. The same for platform devices like SATA and USB.
>>
>> For reference, previous versions are listed below:
>> V1: https://lkml.org/lkml/2018/10/15/373
>> V2: https://lkml.org/lkml/2019/7/11/426
>> V3: https://lkml.org/lkml/2020/7/2/1114
>>
> 
> 1) After enabling SMMU on Armada 8040, and ARM_SMMU_DISABLE_BYPASS_BY_DEFAUL=y by default in kernel since 954a03be033c7cef80ddc232e7cbdb17df735663,
> internal eMMC is prevented from being initialised (as there is no iommus property for ap_sdhci0)
> Disabling "Disable bypass by default" make it work, but the patch highly suggest doing it properly.
> I wasn't able to find correct path for ap_sdhci for iommus in any publicly available documentation,
> would be highly appreciated addressed properly, thank you!
> 
> 2) Second issue I got (btw I have ClearFog GT 8k armada-8040 based board) is mpci ath10k card.
> It is found, it is enumerated, it is visible in lspci, but it fails to be initialised. Here is the log:

Firmware has to configure and assign device StreamIDs. Most of the 
devices are configured properly and supported in public FW. However, for 
both these cases (ap_sdhci0 and PCIe) some extra (u-boot/UEFI/ATF) 
patches are required which are not available yet. Sorry we let that happen.

Since we have dependency on custom FW and we cannot enforce people to 
patch their FW we will send the follow up fix patch (v5.9+) and revert 
respective DTS changes.

The most important Armada-806 SMMU driver enhancements were merged so 
people who still willing to use SMMU need to provide proper DTB and use 
ARM_SMMU_DISABLE_BYPASS_BY_DEFAUL=n (or via kernel command line) with 
extra cautious.

Thanks,
Tomasz

> 
> [    1.743754] armada8k-pcie f2600000.pcie: host bridge /cp0/pcie@f2600000 ranges:
> [    1.751116] armada8k-pcie f2600000.pcie:      MEM 0x00f6000000..0x00f6efffff -> 0x00f6000000
> [    1.964690] armada8k-pcie f2600000.pcie: Link up
> [    1.969379] armada8k-pcie f2600000.pcie: PCI host bridge to bus 0000:00
> [    1.976026] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    1.981537] pci_bus 0000:00: root bus resource [mem 0xf6000000-0xf6efffff]
> [    1.988462] pci 0000:00:00.0: [11ab:0110] type 01 class 0x060400
> [    1.994504] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> [    2.000843] pci 0000:00:00.0: supports D1 D2
> [    2.005132] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> [    2.011853] pci 0000:01:00.0: [168c:003c] type 00 class 0x028000
> [    2.018001] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x001fffff 64bit]
> [    2.025002] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> [    2.032111] pci 0000:01:00.0: supports D1 D2
> [    2.049409] pci 0000:00:00.0: BAR 14: assigned [mem 0xf6000000-0xf61fffff]
> [    2.056322] pci 0000:00:00.0: BAR 0: assigned [mem 0xf6200000-0xf62fffff]
> [    2.063142] pci 0000:00:00.0: BAR 15: assigned [mem 0xf6300000-0xf63fffff pref]
> [    2.070484] pci 0000:01:00.0: BAR 0: assigned [mem 0xf6000000-0xf61fffff 64bit]
> [    2.077880] pci 0000:01:00.0: BAR 6: assigned [mem 0xf6300000-0xf630ffff pref]
> [    2.085135] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> [    2.090384] pci 0000:00:00.0:   bridge window [mem 0xf6000000-0xf61fffff]
> [    2.097202] pci 0000:00:00.0:   bridge window [mem 0xf6300000-0xf63fffff pref]
> [    2.104539] pcieport 0000:00:00.0: Adding to iommu group 4
> [    2.110232] pcieport 0000:00:00.0: PME: Signaling with IRQ 38
> [    2.116141] pcieport 0000:00:00.0: AER: enabled with IRQ 38
> [    8.131135] ath10k_pci 0000:01:00.0: Adding to iommu group 4
> [    8.131874] ath10k_pci 0000:01:00.0: enabling device (0000 -> 0002)
> [    8.132203] ath10k_pci 0000:01:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
> 
> up to that point the log is the same as without SMMU enabled, except "Adding to iommu group N" lines, and IRQ being 37
> 
> [    8.221328] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
> [    8.313362] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
> [    8.409373] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
> [    8.553433] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
> [    8.641370] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
> [    8.737979] ath10k_pci 0000:01:00.0: failed to poke copy engine: -16
> [    8.807356] ath10k_pci 0000:01:00.0: Failed to get pcie state addr: -16
> [    8.814032] ath10k_pci 0000:01:00.0: failed to setup init config: -16
> [    8.820605] ath10k_pci 0000:01:00.0: could not power on hif bus (-16)
> [    8.827111] ath10k_pci 0000:01:00.0: could not probe fw (-16)
> 
> Thank you!
> 
>> v3 -> v4
>> - call cfg_probe() impl hook a bit earlier which simplifies errata handling
>> - use hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() for register accessors
>> - keep SMMU status disabled by default and enable where possible (DTS changes)
>> - commit logs improvements and other minor fixes
>>
>> Hanna Hawa (1):
>>   iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum
>>     #582743
>>
>> Marcin Wojtas (1):
>>   arm64: dts: marvell: add SMMU support
>>
>> Tomasz Nowicki (2):
>>   iommu/arm-smmu: Call configuration impl hook before consuming features
>>   dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806
>>     SMMU-500
>>
>> Documentation/arm64/silicon-errata.rst        |  3 ++
>> .../devicetree/bindings/iommu/arm,smmu.yaml   |  4 ++
>> arch/arm64/boot/dts/marvell/armada-7040.dtsi  | 28 ++++++++++++
>> arch/arm64/boot/dts/marvell/armada-8040.dtsi  | 40 +++++++++++++++++
>> arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 18 ++++++++
>> drivers/iommu/arm-smmu-impl.c                 | 45 +++++++++++++++++++
>> drivers/iommu/arm-smmu.c                      | 11 +++--
>> 7 files changed, 145 insertions(+), 4 deletions(-)
>>
>> -- 
>> 2.17.1
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
> 
