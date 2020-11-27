Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CB72C617E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgK0JSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgK0JSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:18:04 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077D3C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:18:03 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k14so4825258wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OZg83KzmGx9AZ1cwm1bx6ZhIKHuPf6ipmMxlAgdzuCc=;
        b=ucImfJCuwkpdttfHYtc5Fu/zCmQ1phSbAsYSol/eLXmsA5M5uk9FRkO8IMxUiPN10C
         nsDL8EpwcfJe8TE5q/d1fwk8srJdoxA1PjClIa2D/zzd862dyTmrL9hul1/zUhpTnjqK
         lwnNk+rOTsWrqPr2FySH8RqpMCIUxiUUGgAMjtuj5LS26RAtD+3hGgNKOi6Gh+3r1onh
         ag41eevqUXOBlXhkO+9aSF2wBCbbXkidFqPjrQrlXoVT5KSBxeldh+yALk0mid34G6Ij
         tYJFf42F6c2L/Ka5hD2QjAt+5xtbVM++LpGl0KoFaoqxT1gw0i3gXXPv/83EKPsY3PWm
         iT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OZg83KzmGx9AZ1cwm1bx6ZhIKHuPf6ipmMxlAgdzuCc=;
        b=UD98tO9oYzahqt87bT6AZxoY2YM7nlIQLPgszkuCAltFzmiP8tqHZMfRGm2pSZAAj7
         JX5WUDNCoqivFD8YfTzoL/40+/+nu8Ou8n26CqU56wOKI+xXS595a6FQeIRxpwhp0gMv
         VBaRqdD6Kih8RqVO3LRkWHDO1vS9se/FJQeFrfs/RKEcXK32QcHiQOLPMJYe1tJtSbuN
         kOa07SXv9HPgri+T1fWYDUx4R+CVTKUw5iHKDU6pDRWZNQEfhgERQYj090WeqmV4r4ud
         yZwVtZxQT7BUYbA2PluAPG4UlOKuYmYOpdiFWIi8byK6pY/0tP0wik4jjkkjockRt0+3
         ftag==
X-Gm-Message-State: AOAM533X9TePrnGl64rQh7XVybNMDwZuXkCUuT/h6Vg2S5rRpXFwBRud
        8KOoCUFU2HITPoA0aF6ZyIUQbA==
X-Google-Smtp-Source: ABdhPJxx5rmqC7cibdwstdc+YbA7qoi3X9bg2CAYXwJHk/nOMlspyOCmTDXPG/nvlBysLmksxDItjA==
X-Received: by 2002:adf:e787:: with SMTP id n7mr9351798wrm.153.1606468682116;
        Fri, 27 Nov 2020 01:18:02 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id 9sm12057352wmo.34.2020.11.27.01.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 01:18:01 -0800 (PST)
Date:   Fri, 27 Nov 2020 09:17:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/16] mfd: bcm590xx: drop of_match_ptr from of_device_id
 table
Message-ID: <20201127091759.GM2455276@dell>
References: <20201120162133.472938-1-krzk@kernel.org>
 <20201127080619.GJ2455276@dell>
 <CAJKOXPfdEbax7Z4xpu2QcLSND6fvWK__5hTKOESaO0n2pBMhtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJKOXPfdEbax7Z4xpu2QcLSND6fvWK__5hTKOESaO0n2pBMhtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020, Krzysztof Kozlowski wrote:

> On Fri, 27 Nov 2020 at 09:06, Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Fri, 20 Nov 2020, Krzysztof Kozlowski wrote:
> >
> > > The driver can match only via the DT table so the table should be always
> > > used and the of_match_ptr does not have any sense (this also allows ACPI
> > > matching via PRP0001, even though it is not relevant here).  This fixes
> > > compile warning (!CONFIG_OF on x86_64):
> > >
> > >   drivers/mfd/bcm590xx.c:95:34: warning: ‘bcm590xx_of_match’ defined but not used [-Wunused-const-variable=]
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  drivers/mfd/bcm590xx.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Couple of small points:
> >
> > - Patch-sets, particularly large ones should have a cover letter.
> > - Subject lines follow English grammar conventions and should start
> >   with an uppercase character.
> 
> Thanks for fixing this. I am not a native English speaker and I make
> mistakes. Either it is a grammar or convention mistake, I would
> appreciate it if you point them out, so I could learn from them.
> About the "start with an uppercase character", I actually on purpose
> changed my approach some time ago after seeing more senior kernel
> developers using this method (see commits from Linus Torvalds, Andrew
> Morton). After the subsystem prefix "mfd: ...." they start with
> lowercase. If you still insist that commit titles in MFD subsystem
> should use capital letter after the prefix, I will try to remember and
> follow this approach when sending patches to you.

It's a per-subsystem convention thing.

Looks like some use capitals, some don't (MFD does):

$ for f in `ls --color=never drivers`; do echo -ne "$f: \t"; git --no-pager log --no-merges --oneline -n1 -- drivers/$f; done

accessibility: 	d412275444279 speakup: Do not let the line discipline be used several times
acpi: 		774c4a3b5e5fd ACPI/IORT: Fix doc warnings in iort.c
amba: 		06f3a5a4cbb5f ARM: tegra: Replace zero-length array with flexible-array
android: 	1987f112f1425 binder: add trace at free transaction.
ata: 		8e4c309f9f33b ata: sata_nv: Fix retrieving of active qcs
atm: 		2de680dea6a88 atm: lanai: Remove in_interrupt() usage
auxdisplay: 	351dcacc6d774 auxdisplay: panel: Remove redundant charlcd_ops structures
base: 		e6e9354b58307 regmap: Remove duplicate `type` field from regmap `regcache_sync` trace event
bcma: 		703314b2db3bb bcma: use semicolons rather than commas to separate statements
block: 		21f7748069e02 zram: support page writeback
bluetooth: 	d45330536ce31 Bluetooth: btmtksdio: Add the missed release_firmware() in mtk_setup_firmware()
bus: 		65fb73676112f bus: ti-sysc: suppress err msg for timers used as clockevent/source
cdrom: 		faf041388c28e gdrom: use bdev_check_media_change
char: 		a24d22b225ce1 crypto: sha - split sha.h into sha1.h and sha2.h
clk: 		44a9e78f92428 clk: samsung: Prevent potential endless loop in the PLL ops
clocksource: 	8da10e545406b clocksource/drivers/cadence_ttc: Fix memory leak in ttc_setup_clockevent()
connector: 	fe6bc89abe2c2 connector: simplify the return expression of cn_add_callback()
counter: 	271b339236e1c counter/ti-eqep: Fix regmap max_register
cpufreq: 	f943849f72068 cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK
cpuidle: 	c39de538a06e7 cpuidle: tegra: Annotate tegra_pm_set_cpu_in_lp2() with RCU_NONIDLE
crypto: 	732b764099f65 crypto: sun8i-ce - fix two error path's memory leak
dax: 		99a33a943cebd vm_ops: rename .split() callback to .may_split()
dca: 		0548745fa335a dca: Use PTR_ERR_OR_ZERO() to simplify code
devfreq: 	98fd9972ed60d PM / devfreq: tegra20: Deprecate in a favor of emc-stat based driver
dio: 		fe557319aa06c maccess: rename probe_kernel_{read,write} to copy_{from,to}_kernel_nofault
dma: 		5d051f37f49d5 dmaengine: ti: drop of_match_ptr and mark of_device_id table as maybe unused
dma-buf: 	1faad6c51a0cf dma-buf: use krealloc_array()
edac: 		47a3f41802d85 edac: ghes: use krealloc_array()
eisa: 		a7f7f6248d974 treewide: replace '---help---' in Kconfig files with 'help'
extcon: 	54589b557a8dd extcon: fsa9480: Support TI TSU6111 variant
firewire: 	c51a9868d361a firewire-ohci: use dma_alloc_pages
firmware: 	ad3f23269250f treewide: remove stringification from __alias macro definition
fpga: 		aaf8fe39c9521 Revert "fpga: dfl: fix the definitions of type & feature_id for dfl devices"
fsi: 		4a851d714eade fsi: aspeed: Support CFAM reset GPIO
gnss: 		a7f7f6248d974 treewide: replace '---help---' in Kconfig files with 'help'
gpio: 		9dd47d88ba6d5 gpio: xilinx: utilize generic bitmap_get_value and _set_value
gpu: 		31bef3efe6255 drm/amd/display/dc/basics/vector: Make local function 'dal_vector_presized_costruct' static
greybus: 	947bece14b741 drivers/greybus: Use kobj_to_dev()
hid: 		b4c00e7976636 HID: logitech-dj: Fix Dinovo Mini when paired with a MX5x00 receiver
hsi: 		df561f6688fef treewide: Use fallthrough pseudo-keyword
hv: 		14c685d9eb361 drivers: hv: vmbus: Fix call msleep using < 20ms
hwmon: 		d7971d57d2737 hwmon: (scmi) Update hwmon internal scale data type
hwspinlock: 	8266b809264ca hwspinlock: sprd: fixed warning of unused variable 'sprd_hwspinlock_of_match'
hwtracing: 	987a649b19c5a hwtracing: intel: use krealloc_array()
i2c: 		3b5f7f10ff6e6 i2c: designware: slave should do WRITE_REQUESTED before WRITE_RECEIVED
i3c: 		9ad9a52cce282 i3c/master: introduce the mipi-i3c-hci driver
ide: 		0915f3d3974ce ide: remove BUG_ON(in_interrupt() || irqs_disabled()) from ide_unregister()
idle: 		4e0ba5577dba6 intel_idle: Fix max_cstate for processor models without C-state tables
iio: 		74d826da3842c iio: core: return -EINVAL when no ioctl handler has been run
infiniband: 	6830ff853a576 IB/mthca: fix return value of error branch in mthca_init_cq()
input: 		896ff83d2620f input: touchscreen: surface3_spi: Remove set but unused variable 'timestamp'
interconnect: 	3d7c7b9907a68 interconnect: Add generic interconnect driver for Exynos SoCs
iommu: 		77c38c8cf52ef iommu: Check return of __iommu_attach_device()
ipack: 		552c08a8e03f0 ipack: iopctal: remove unneeded break
irqchip: 	74cde1a53368a irqchip/gic-v3-its: Unconditionally save/restore the ITS state on suspend
isdn: 		cc69837fcaf46 net: don't include ethtool.h from netdevice.h
leds: 		6c3e42616bf23 leds: various: add missing put_device() call in netxbig_leds_get_of_pdata()
lightnvm: 	a48faebe65b0d lightnvm: fix out-of-bounds write to array devices->info[]
macintosh: 	acff5e6c37fa4 macintosh: smu_sensors: use for_each_child_of_node() macro
mailbox: 	c7dacf5b0f329 mailbox: avoid timer start from callback
mcb: 		891e60368ba18 drivers: mcb: use symbol namespaces
md: 		3f5dba110d124 dm writecache: remove BUG() and fail gracefully instead
media: 		cc69837fcaf46 net: don't include ethtool.h from netdevice.h
memory: 	e45b57df4b9e9 memory: tegra30-emc: Remove unnecessary of_node_put in tegra_emc_probe
memstick: 	e3e9ced5c9380 memstick: fix a double-free bug in memstick_check
message: 	b9dd44fd79a1e scsi: message: fusion: Remove unneeded break
mfd: 		14639a22de657 mfd: cpcap: Fix interrupt regression with regmap clear_ack
misc: 		b17830cc7fa92 drivers/misc/lkdtm/lkdtm.h: correct wrong filenames in comment
mmc: 		8223e885e74b6 mmc: mxc: Convert the driver to DT-only
most: 		ceea93444808c drivers: most: add character device interface driver
mtd: 		b86bcb8f99993 mtd: rawnand: gpmi: fix reference count leak in gpmi ops
mux: 		df561f6688fef treewide: Use fallthrough pseudo-keyword
net: 		53033d524755b net: ethernet: ibm: ibmvnic: Fix some kernel-doc issues
nfc: 		a24d22b225ce1 crypto: sha - split sha.h into sha1.h and sha2.h
ntb: 		b8e2c8bbdf777 NTB: Use struct_size() helper in devm_kzalloc()
nubus: 		51b67a6e6592d nubus: Remove cast to void pointer
nvdimm: 	b7b3c01b19159 mm/memremap_pages: support multiple ranges per invocation
nvme: 		5a7a9e038b032 RDMA/core: remove use of dma_virt_ops
nvmem: 		292b72c982a62 nvmem: imx-ocotp: add support for the unaliged word count
of: 		07d13a1d6120d of: unittest: Add test for of_dma_get_max_cpu_address()
opp: 		ed40e33c0b912 opp: Reduce the size of critical section in _opp_kref_release()
oprofile: 	0340a6b7fb767 module: Fix up module_notifier return values
parisc: 	0a0f0d8be76dc dma-mapping: split <linux/dma-mapping.h>
parport: 	df561f6688fef treewide: Use fallthrough pseudo-keyword
pci: 		c67742924cbf0 PCI/ERR: Fix reset logic in pcie_do_recovery() call
pcmcia: 	91be3e89f450a pcmcia: at91_cf: remove platform data support
perf: 		887e2cff0f8dc perf: arm-cmn: Fix conversion specifiers for node type
phy: 		46bc965df0387 phy: samsung: phy-exynos-pcie: rework driver to support Exynos5433 PCIe PHY
pinctrl: 	1e6f5dde15378 arch: arm: mach-at91: pm: Move prototypes to mutually included header
platform: 	bb81dcd4eda20 platform/x86: touchscreen_dmi: Add info for the Irbis TW118 tablet
pnp: 		e510785f8aca4 PNP: fix kernel-doc markups
power: 		785b5bb41b0a9 PM: AVS: Drop the avs directory and the corresponding Kconfig
powercap: 	8a9d881f22d7a powercap: RAPL: Add AMD Fam19h RAPL support
pps: 		a7f7f6248d974 treewide: replace '---help---' in Kconfig files with 'help'
ps3: 		df561f6688fef treewide: Use fallthrough pseudo-keyword
ptp: 		34890b30dc731 ptp: ptp_ines: use new PTP_MSGTYPE_* define(s)
pwm: 		228fe8e4deb27 pwm: keembay: Fix build failure with -Os
rapidio: 	f4b3d141938e8 rapidio: remove unused rio_get_asm() and rio_get_device()
ras: 		4bd442e9a8388 RAS/CEC: Convert to DEFINE_SHOW_ATTRIBUTE()
regulator: 	34c5aa2666db5 regulator: Kconfig: Fix REGULATOR_QCOM_RPMH dependencies to avoid build error
remoteproc: 	a7ed5e57bdbab remoteproc: qcom_q6v5_mss: map/unmap MBA region before/after use
reset: 		aac025437f14c reset: add BCM6345 reset controller driver
rpmsg: 		950a7388f02bf rpmsg: Turn name service into a stand alone driver
rtc: 		673536cc5f21b rtc: pcf8523: use BIT
s390: 		7ed10e16e50da s390/qeth: fix tear down of async TX buffers
sbus: 		a7f7f6248d974 treewide: replace '---help---' in Kconfig files with 'help'
scsi: 		3256b46823862 scsi: fnic: Validate io_req before others
sfi: 		a7f7f6248d974 treewide: replace '---help---' in Kconfig files with 'help'
sh: 		8f28ca6bd8211 iomap: constify ioreadX() iomem argument (as in generic implementation)
siox: 		5a158981aafa7 siox: Use the correct style for SPDX License Identifier
slimbus: 	9c239fa83e2b6 slimbus: qcom-ngd-ctrl: Constify static structs
soc: 		48f6051b6e07d soc: bcm: brcmstb: pm: pm-arm: Provide prototype for brcmstb_pm_s3_finish()
soundwire: 	47b8520997a8e soundwire: bus: only clear valid DPN interrupts
spi: 		a6f483b2e4415 spi: Fix potential NULL pointer dereference in spi_shutdown()
spmi: 		2d5a2f913b658 spmi: pmic-arb: Set lockdep class for hierarchical irq domains
ssb: 		41650c45fbd2d ssb: Remove meaningless jump label to simplify the code
staging: 	cc69837fcaf46 net: don't include ethtool.h from netdevice.h
target: 	f36199355c64a scsi: target: iscsi: Fix cmd abort fabric stop race
tc: 		3d9f44ef75533 tc: Make tc_match_device() static
tee: 		a24d22b225ce1 crypto: sha - split sha.h into sha1.h and sha2.h
thermal: 	cb68a8580e208 thermal: amlogic: Add hwmon support
thunderbolt: 	600c0849cf86b thunderbolt: Fix use-after-free in remove_unplugged_switch()
tty: 		a7b5458ce73b2 m68k: Fix WARNING splat in pmac_zilog driver
uio: 		ef84928cff589 uio/uio_pci_generic: use device-managed function equivalents
usb: 		7103c599177a5 usb: cdns3: fix NULL pointer dereference on no platform data
vdpa: 		a312db697cb05 vdpasim: fix "mac_pton" undefined error
vfio: 		e4eccb853664d vfio/pci: Bypass IGD init in case of -ENODEV
vhost: 		91ce5f69e27ed vhost: vringh: use krealloc_array()
video: 		04295bc3362d4 video: fbdev: pm2fb: Fix fall-through warnings for Clang
virt: 		d9109fe0f30a1 nitro_enclaves: Fixup type and simplify logic of the poll mask setup
virtio: 	cc8a7d6b9c3e8 mm, page_poison: remove CONFIG_PAGE_POISONING_NO_SANITY
visorbus: 	a7f7f6248d974 treewide: replace '---help---' in Kconfig files with 'help'
vlynq: 		fd534e9b5fdcf treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 102
vme: 		8bd160690a6c0 vme: fix two kernel-doc markups
w1: 		439e8f6f1e5d1 w1: w1_therm: Rename conflicting sysfs attribute 'eeprom' to 'eeprom_cmd'
watchdog: 	3e3f354bc383a ARM: remove ebsa110 platform
xen: 		383bb2cd7a8de xen/unpopulated-alloc: consolidate pgmap manipulation
zorro: 		ea2abe2fd59a7 zorro: Fix address space collision message with RAM expansion boards


-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
