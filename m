Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFB8299556
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789807AbgJZSaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1789800AbgJZSaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:30:19 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D0B72076A;
        Mon, 26 Oct 2020 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603737018;
        bh=PG78Z3DmAgRcAWB1YiwWZZoFBQwRpXRhQZu1WFxx++s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fN07zSdL08lN7cDpPZ0NgjgF70Jy7XXPyZSOIfgaBKnt8lFmdIB4wcOQ+kNyaL8hq
         WIoT9ddzDME5IQjLObR6s0p4ECPsYh0DShcnsdxJtHnR345cJYpiThA0Gq0wR1F9wE
         JCxrTbFHNdvk3omq7oc4A9yaCnlHuvepF48VideU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kX7G4-004Q0T-A8; Mon, 26 Oct 2020 18:30:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Oct 2020 18:30:16 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] irq-meson-gpio: make it possible to build as a module
In-Reply-To: <7hy2jshp6w.fsf@baylibre.com>
References: <20201020072532.949137-1-narmstrong@baylibre.com>
 <87v9eyo75s.wl-maz@kernel.org> <7ha6w9hsfm.fsf@baylibre.com>
 <b0780e423d5fa527835ba55c64dba473@kernel.org> <7hy2jshp6w.fsf@baylibre.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <d98ba5ad9d32d3a6368fae78ca9b911c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: khilman@baylibre.com, narmstrong@baylibre.com, jbrunet@baylibre.com, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-26 17:28, Kevin Hilman wrote:
> Marc Zyngier <maz@kernel.org> writes:
> 
>> On 2020-10-26 16:18, Kevin Hilman wrote:
>>> Marc Zyngier <maz@kernel.org> writes:
>>> 
>>>> On Tue, 20 Oct 2020 08:25:30 +0100,
>>>> Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>> 
>>>>> In order to reduce the kernel Image size on multi-platform
>>>>> distributions,
>>>>> make it possible to build the Amlogic GPIO IRQ controller as a 
>>>>> module
>>>>> by switching it to a platform driver.
>>>>> 
>>>>> The second patch removes MESON_IRQ_GPIO selection from ARCH_MESON 
>>>>> to
>>>>> allow
>>>>> building the driver as module.
>>>>> 
>>>>> Neil Armstrong (2):
>>>>>   irqchip: irq-meson-gpio: make it possible to build as a module
>>>>>   arm64: meson: remove MESON_IRQ_GPIO selection
>>>>> 
>>>>>  arch/arm64/Kconfig.platforms     |  1 -
>>>>>  drivers/irqchip/Kconfig          |  5 +-
>>>>>  drivers/irqchip/irq-meson-gpio.c | 89
>>>>> ++++++++++++++++++++------------
>>>>>  3 files changed, 59 insertions(+), 36 deletions(-)
>>>> 
>>>> I've tried this series on my vim3l with the this driver compiled as 
>>>> a
>>>> module, and lost the Ethernet interface in the process, as the phy
>>>> wasn't able to resolve its interrupt and things fail later on:
>>>> 
>>>> [   72.238291] meson8b-dwmac ff3f0000.ethernet eth1: no phy at addr 
>>>> -1
>>>> [   72.238917] meson8b-dwmac ff3f0000.ethernet eth1: stmmac_open:
>>>> Cannot attach to PHY (error: -19)
>>>> 
>>>> This is a generic problem with making DT-based interrupt controllers
>>>> modular when not *all* the drivers can deal with probing deferral.
>>> 
>>> Yes, but this series still keeps the default as built-in.
>>> 
>>> If you build as a module, and you add `fw_devlink=on` to the kernel
>>> command-line, device-links will be created based on DT dependencies
>>> which will ensure the right module load order.
>> 
>> It doesn't work here. I get the exact same error (well, with eth0
>> instead
>> of eth1). In my experience, fw_devlink isn't reliable yet. Config on
>> request.
> 
> Other than CONFIG_MESON_IRQ_GPIO=m, are you using default upstream
> defconfig?

I use something that is much closer to a Debian configuration, given 
that
the same kernel as to run on *all* the systems I have access to.

> I just double-checked with this series on top of v5.10-rc1, and I have
> eth0 working with interrupts without needing fw_devlink=on.
> 
> With the default upstream defconfig all the networking for these 
> devices
> is already configured as modules.

dmesg: http://www.loen.fr/tmp/dmesg
config: http://www.loen.fr/tmp/Config.full-arm64

root@tiger-roach:~# lsmod
Module                  Size  Used by
macvtap                16384  0
macvlan                32768  1 macvtap
tap                    32768  1 macvtap
nls_ascii              16384  1
nls_cp437              20480  1
vfat                   28672  1
fat                    81920  1 vfat
aes_ce_blk             36864  0
crypto_simd            24576  1 aes_ce_blk
cryptd                 28672  1 crypto_simd
aes_ce_cipher          20480  1 aes_ce_blk
ghash_ce               24576  0
gf128mul               16384  1 ghash_ce
sha2_ce                20480  0
sha256_arm64           28672  1 sha2_ce
sha1_ce                20480  0
panfrost               69632  0
gpu_sched              45056  1 panfrost
meson_saradc           24576  0
industrialio           90112  1 meson_saradc
irq_meson_gpio         20480  0
pwm_meson              20480  1
meson_dw_hdmi          24576  0
meson_drm              61440  1 meson_dw_hdmi
meson_canvas           16384  1 meson_drm
dw_hdmi                53248  1 meson_dw_hdmi
cec                    57344  1 dw_hdmi
drm_kms_helper        258048  4 meson_dw_hdmi,meson_drm,dw_hdmi
meson_rng              16384  0
rng_core               24576  1 meson_rng
cpufreq_dt             20480  0
leds_gpio              16384  0
drm                   606208  7 
gpu_sched,meson_dw_hdmi,meson_drm,drm_kms_helper,dw_hdmi,panfrost
ip_tables              32768  0
x_tables               45056  1 ip_tables
autofs4                49152  2
xhci_plat_hcd          20480  0
dwc2                  249856  0
dwc3                  151552  0
ulpi                   20480  1 dwc3
udc_core               69632  2 dwc2,dwc3
rtc_hym8563            20480  0
meson_gxl              20480  0
realtek                24576  0
dwmac_generic          16384  0
dwc3_meson_g12a        24576  0
meson_gx_mmc           24576  0
xhci_pci               24576  0
igb                   237568  0
xhci_hcd              290816  2 xhci_pci,xhci_plat_hcd
i2c_meson              20480  0
mdio_mux_meson_g12a    16384  0
mdio_mux               16384  1 mdio_mux_meson_g12a
nvme                   45056  2
nvme_core             110592  4 nvme
i2c_algo_bit           16384  1 igb
t10_pi                 16384  1 nvme_core
usbcore               311296  4 xhci_hcd,dwc2,xhci_pci,xhci_plat_hcd
dwmac_meson8b          16384  0
stmmac_platform        24576  2 dwmac_meson8b,dwmac_generic
stmmac                204800  3 
dwmac_meson8b,stmmac_platform,dwmac_generic
pcs_xpcs               20480  1 stmmac
phylink                45056  1 stmmac
of_mdio                20480  4 stmmac_platform,mdio_mux,stmmac,phylink
fixed_phy              16384  1 of_mdio
pwm_regulator          20480  1
libphy                151552  8 
of_mdio,realtek,mdio_mux,stmmac,fixed_phy,meson_gxl,phylink,pcs_xpcs

root@tiger-roach:~# cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
   9:          0          0          0          0     GICv2  25 Level     
vgic
  11:          0          0          0          0     GICv2  30 Level     
kvm guest ptimer
  12:          0          0          0          0     GICv2  27 Level     
kvm guest vtimer
  13:       4151       2344       3022       4003     GICv2  26 Level     
arch_timer
  16:          0          0          0          0     GICv2  89 Edge      
dw_hdmi_top_irq, ff600000.hdmi-tx
  20:       1994          0          0          0     GICv2 225 Edge      
ttyAML0
  21:         28          0          0          0     GICv2 227 Edge      
ff805000.i2c
  23:          2          0          0          0     GICv2 232 Edge      
ff809000.adc
  26:          0          0          0          0     GICv2  35 Edge      
meson
  29:       1317          0          0          0     GICv2 222 Edge      
ffe05000.sd
  30:        762          0          0          0     GICv2 223 Edge      
ffe07000.mmc
  32:          0          0          0          0     GICv2 194 Level     
panfrost-job
  33:          0          0          0          0     GICv2 193 Level     
panfrost-mmu
  34:          3          0          0          0     GICv2 192 Level     
panfrost-gpu
  35:          0          0          0          0     GICv2  31 Level     
arm-pmu
  37:          0          0          0          0     GICv2 255 Level     
PCIe PME, aerdrv
  43:         15          0          0          0   PCI-MSI 2621440 Edge  
     nvme0q0
  44:        951          0          0          0   PCI-MSI 2621441 Edge  
     nvme0q1
  45:        809          0          0          0   PCI-MSI 2621442 Edge  
     nvme0q2
  46:        605          0          0          0   PCI-MSI 2621443 Edge  
     nvme0q3
  47:        544          0          0          0   PCI-MSI 2621444 Edge  
     nvme0q4
  48:         38          0          0          0   PCI-MSI 1572864 Edge  
     xhci_hcd
  58:          0          0          0          0     GICv2  63 Level     
ff400000.usb, ff400000.usb
  59:         32          0          0          0     GICv2  62 Level     
xhci-hcd:usb3
IPI0:      1253       1491       2091       2098       Rescheduling 
interrupts
IPI1:       297        306        756        385       Function call 
interrupts
IPI2:         0          0          0          0       CPU stop 
interrupts
IPI3:         0          0          0          0       CPU stop (for 
crash dump) interrupts
IPI4:         0          0          0          0       Timer broadcast 
interrupts
IPI5:         0          0          0          0       IRQ work 
interrupts
IPI6:         0          0          0          0       CPU wake-up 
interrupts
Err:          0

and eth0 is dead.

         M.
-- 
Jazz is not dead. It just smells funny...
