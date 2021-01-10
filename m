Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624872F0A0F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbhAJWtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbhAJWts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:49:48 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD832C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 14:49:07 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o10so24271694lfl.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 14:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9o+FIUFJ1XMuhzbnjkTt0pKGRXe4oeOm2cFRUKr3mp8=;
        b=Yl3VMxMmxMtzpLJ5K8qRqInoS5/7La4CHJz9HlMKYE3BZhzAKTBDvJBHlz3ft7bXcX
         lEoG463O3bHnpuxM+B/s36cixu0qOZqUDL9VSyXLqQ7Za/rApDRaehG0DwTPLfxLsqo2
         d1yFm9g0NO2wvFyCDT0uaFtHeJkw2wcbOeD4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9o+FIUFJ1XMuhzbnjkTt0pKGRXe4oeOm2cFRUKr3mp8=;
        b=buiMJYA0fR5gduz7ygzNiqsotIQ8tuVUePT9UopxEFRqRYKMVCk/fDzZFtA9hR9upD
         vQ8VCj3x99437os7PPyOVSHSrHFz7htbObiY/+W1R7kOiSydUC5DN0EuyUio5I3+h7rW
         nnJDgeMgb8u33QEgNY+Roi9VB0LE0cdbaJGbFEfn4G5dyknDWsZioa/GgPPHultgc2d2
         M3t/mjW/HA7AgO8vuzPDhnZUoFSwN+Rccjl6bt5vE5y0TE+qn5tV57q0RgQULaVMvE5S
         hqc8m2/h5VK0lbye3FL691o4e+CkAfJDSBDnpRHlUvpZotnQCSAfahoH9I4Sf0wts184
         YyFQ==
X-Gm-Message-State: AOAM530tZk+boflgzOVvDTUAoRUIb3iwoDMzj281bBT+ycHFBd89fn7z
        og39I5QfLQMBjgBUZ1emuhqC4CfRAk+2Wg==
X-Google-Smtp-Source: ABdhPJxGvRUfyO6FfAYhcPvOFxIj8qiqX+KO7+3bJslbdlA5f/tazm5l+e0MAHknU0lRBxZdtLyt5g==
X-Received: by 2002:a05:6512:202c:: with SMTP id s12mr5584801lfs.409.1610318945350;
        Sun, 10 Jan 2021 14:49:05 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id x125sm2881802lff.58.2021.01.10.14.49.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 14:49:04 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id o17so35219904lfg.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 14:49:04 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr5589770lfl.41.1610318943312;
 Sun, 10 Jan 2021 14:49:03 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Jan 2021 14:48:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizR7--Ub-rasYx2S5XURkooCQ63Sat23BpvTAuN0scQA@mail.gmail.com>
Message-ID: <CAHk-=wizR7--Ub-rasYx2S5XURkooCQ63Sat23BpvTAuN0scQA@mail.gmail.com>
Subject: Linux 5.11-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So in the rc2 announcement notes I thought we might have a slow week
for rc3 as well due to people just coming back from vacations and it
taking some time for bug reports etc to start tricking in.

That turned out to be the incoherent ramblings of a crazy old man.

Because while the week started out fairly slow, you guys certainly
showed me, and the final rc3 ends up being on the bigger side as rc3s
go. Not "beating records" big, but certainly bigger than average. So
instead of some slow start due to the holidays, I think we saw some
pent-up fixes.

The changes are all over, with nothing in particular standing out.
About half the rc3 patch is drivers, with self-test updates (mostly
kvm and netfilter) being another healthy 15%. The rest is the usual
random mix: architecture updates (mostly x86 and arm64 and much of it
kvm-related), documentation, filesystem code (btrfs, io_uring),
networking, etc..

But there's nothing that looks particularly odd in there, and I think
the size is literally just about that rc2 being so small. So I think
on the whole everything looks normal for this release, and my theory
that maybe we'll need an extra release candidate just for the holiday
impact was just wrong.

Of course, we may end up with extra rc candidates if some nasty
development issue rears its ugly head later, but for now it all looks
fine.

So please go out and test, and report any issues you find,

            Linus

---

Aaro Koskinen (1):
      ARM: dts: OMAP3: disable AES on N950/N9

Alaa Hleihel (1):
      net/mlx5: E-Switch, fix changing vf VLANID

Alan Maguire (1):
      bpftool: Fix compilation failure for net.o with older glibc

Alan Stern (1):
      USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug

Aleksander Jan Bajkowski (1):
      net: dsa: lantiq_gswip: Exclude RMII from modes that report 1 GbE

Alex Deucher (2):
      drm/amdgpu/display: drop DCN support for aarch64
      Revert "drm/amd/display: Fix memory leaks in S3 resume"

Alex Elder (6):
      net: ipa: fix interconnect enable bug
      net: ipa: clear pending interrupts before enabling
      net: ipa: use state to determine channel command success
      net: ipa: use state to determine event ring command success
      net: ipa: don't return a value from gsi_channel_command()
      net: ipa: don't return a value from evt_ring_command()

Alexandru Elisei (5):
      KVM: Documentation: Add arm64 KVM_RUN error codes
      KVM: arm64: arch_timer: Remove VGIC initialization check
      KVM: arm64: Move double-checked lock to kvm_vgic_map_resources()
      KVM: arm64: Update comment in kvm_vgic_map_resources()
      KVM: arm64: Remove redundant call to kvm_pmu_vcpu_reset()

Alon Mizrahi (5):
      habanalabs: add comment for pll frequency ioctl opcode
      habanalabs: fetch PSOC PLL frequency from F/W in goya
      habanalabs: remove generic gaudi get_pll_freq function
      habanalabs/gaudi: do not set EB in collective slave queues
      habanalabs: add validation cs counter, fix misplaced counters

Amanoel Dawod (1):
      Fonts: font_ter16x32: Update font with new upstream Terminus release

Amelie Delaunay (1):
      dmaengine: stm32-mdma: fix STM32_MDMA_VERY_HIGH_PRIORITY value

Andreas Kemnade (2):
      ARM: OMAP2+: omap_device: fix idling of devices during probe
      ARM: omap2plus_defconfig: enable SPI GPIO

Andrew Jones (3):
      KVM: selftests: Factor out guest mode code
      KVM: selftests: Use vm_create_with_vcpus in create_vm
      KVM: selftests: Implement perf_test_util more conventionally

Andrey Konovalov (1):
      kcov, usb: hide in_serving_softirq checks in __usb_hcd_giveback_urb

Andrey Zhizhikin (1):
      ARM: omap2plus_defconfig: drop unused POWER_AVS option

Andrii Nakryiko (1):
      selftests/bpf: Work-around EBUSY errors from hashmap update/delete

Andy Shevchenko (1):
      misc: pvpanic: Check devm_ioport_map() for NULL

Antoine Tenart (4):
      net-sysfs: take the rtnl lock when storing xps_cpus
      net-sysfs: take the rtnl lock when accessing xps_cpus_map and num_tc
      net-sysfs: take the rtnl lock when storing xps_rxqs
      net-sysfs: take the rtnl lock when accessing xps_rxqs_map and num_tc

Ard Biesheuvel (2):
      crypto: arm/chacha-neon - add missing counter increment
      crypto: ecdh - avoid buffer overflow in ecdh_set_secret()

Arend van Spriel (1):
      MAINTAINERS: switch to different email address

Arnd Bergmann (16):
      interconnect: qcom: fix rpmh link failures
      block: rsxx: select CONFIG_CRC32
      lightnvm: select CONFIG_CRC32
      zonefs: select CONFIG_CRC32
      dmaengine: qcom: fix gpi undefined behavior
      regulator: qcom-rpmh: add QCOM_COMMAND_DB dependency
      usb: gadget: select CONFIG_CRC32
      qed: select CONFIG_CRC32
      phy: dp83640: select CONFIG_CRC32
      can: kvaser_pciefd: select CONFIG_CRC32
      wil6210: select CONFIG_CRC32
      cfg80211: select CONFIG_CRC32
      misdn: dsp: select CONFIG_BITREVERSE
      wan: ds26522: select CONFIG_BITREVERSE
      drm/amd/display: Fix unused variable warning
      ARM: picoxcell: fix missing interrupt-parent properties

Aswath Govindraju (1):
      dt-bindings: usb: Add new compatible string for AM64 SoC

Aya Levin (2):
      net/mlx5e: Add missing capability check for uplink follow
      net/mlx5e: ethtool, Fix restriction of autoneg with 56G

Ayush Sawal (7):
      chtls: Fix hardware tid leak
      chtls: Remove invalid set_tcb call
      chtls: Fix panic when route to peer not configured
      chtls: Avoid unnecessary freeing of oreq pointer
      chtls: Replace skb_dequeue with skb_peek
      chtls: Added a check to avoid NULL pointer dereference
      chtls: Fix chtls resources release sequence

Bard Liao (2):
      Revert "device property: Keep secondary firmware node secondary by ty=
pe"
      device property: add description of fwnode cases

Baruch Siach (4):
      net: af_packet: fix procfs header for 64-bit pointers
      docs: netdev-FAQ: fix question headers formatting
      docs: networking: packet_mmap: fix formatting for C macros
      docs: networking: packet_mmap: fix old config reference

Ben Gardon (2):
      KVM: x86/mmu: Ensure TDP MMU roots are freed after yield
      KVM: x86/mmu: Clarify TDP MMU page list invariants

Bhaskar Chowdhury (1):
      docs: admin-guide: bootconfig: Fix feils to fails

Bjorn Andersson (1):
      iommu/arm-smmu-qcom: Initialize SCTLR of the bypass context

Bj=C3=B8rn Mork (2):
      USB: serial: option: add Quectel EM160R-GL
      net: usb: qmi_wwan: add Quectel EM160R-GL

Brian Gerst (1):
      fanotify: Fix sys_fanotify_mark() on native x86-32

Carl Huang (4):
      ath11k: fix crash caused by NULL rx_channel
      ath11k: start vdev if a bss peer is already created
      ath11k: qmi: try to allocate a big block of DMA memory first
      ath11k: pci: disable ASPM L0sLs before downloading firmware

Carl Philipp Klemm (1):
      ARM: omap2: pmic-cpcap: fix maximum voltage to be consistent
with defaults on xt875

Catalin Marinas (2):
      arm64: kasan: Set TCR_EL1.TBID1 when KASAN_HW_TAGS is enabled
      arm64: Move PSTATE.TCO setting to separate functions

Chandana Kishori Chiluveru (1):
      usb: gadget: configfs: Preserve function ordering after bind failure

Charan Teja Reddy (1):
      dmabuf: fix use-after-free of dmabuf's file->f_inode

Charles Keepax (1):
      net: macb: Correct usage of MACB_CAPS_CLK_HW_CHG flag

Chris Wilson (2):
      drm/i915/gt: Define guc firmware blob for older Cometlakes
      drm/i915/dp: Track pm_qos per connector

Christian K=C3=B6nig (2):
      drm/radeon: stop re-init the TTM page pool
      drm/ttm: unexport ttm_pool_init/fini

Christoph Hellwig (1):
      block: pre-initialize struct block_device in bdev_alloc_inode

Christophe JAILLET (7):
      interconnect: imx: Add a missing of_node_put after of_device_is_avail=
able
      interconnect: imx: Remove a useless test
      staging: spmi: hisi-spmi-controller: Fix some error handling paths
      staging: mt7621-dma: Fix a resource leak in an error handling path
      dmaengine: mediatek: mtk-hsdma: Fix a resource leak in the error
handling path of the probe function
      dmaengine: milbeaut-xdmac: Fix a resource leak in the error
handling path of the probe function
      net/sonic: Fix some resource leaks in error handling paths

Christophe Leroy (1):
      powerpc/32s: Fix RTAS machine check with VMAP stack

Chunyan Zhang (1):
      i2c: sprd: use a specific timeout to avoid system hang up issue

Colin Ian King (5):
      netfilter: nftables: fix incorrect increment of loop counter
      ath11k: add missing null check on allocated skb
      selftests/bpf: Fix spelling mistake "tranmission" -> "transmission"
      cpufreq: powernow-k8: pass policy rather than use cpufreq_cpu_get()
      octeontx2-af: fix memory leak of lmac and lmac->name

Coly Li (4):
      bcache: fix typo from SUUP to SUPP in features.h
      bcache: check unsupported feature sets for bcache register
      bcache: introduce BCH_FEATURE_INCOMPAT_LOG_LARGE_BUCKET_SIZE for
large bucket
      bcache: set bcache device into read-only mode for
BCH_FEATURE_INCOMPAT_OBSO_LARGE_BUCKET

Cong Wang (1):
      erspan: fix version 1 check in gre_parse_header()

Craig Tatlor (1):
      drm/msm: Call msm_init_vram before binding the gpu

Dan Carpenter (7):
      ath11k: Fix error code in ath11k_core_suspend()
      ath11k: Fix ath11k_pci_fix_l1ss()
      atm: idt77252: call pci_disable_device() on error path
      Staging: comedi: Return -EFAULT if copy_to_user() fails
      dmaengine: idxd: off by one in cleanup code
      dmaengine: dw-edma: Fix use after free in dw_edma_alloc_chunk()
      regmap: debugfs: Fix a reversed if statement in regmap_debugfs_init()

Dan Williams (1):
      x86/mm: Fix leak of pmd ptlock

Daniel Palmer (1):
      USB: serial: option: add LongSung M5710 module support

Darrick J. Wong (1):
      maintainers: update my email address

David Arcari (1):
      hwmon: (amd_energy) fix allocation of hwmon_channel_info config

David Brazdil (6):
      KVM: arm64: Prevent use of invalid PSCI v0.1 function IDs
      KVM: arm64: Use lm_alias in nVHE-only VA conversion
      KVM: arm64: Skip computing hyp VA layout for VHE
      KVM: arm64: Minor cleanup of hyp variables used in host
      KVM: arm64: Remove unused includes in psci-relay.c
      KVM: arm64: Move skip_host_instruction to adjust_pc.h

David Gow (1):
      kunit: tool: Force the use of the 'tty' console for UML

David Howells (2):
      afs: Work around strnlen() oops with CONFIG_FORTIFIED_SOURCE=3Dy
      afs: Fix directory entry size calculation

David Woodhouse (2):
      iommu/amd: Set iommu->int_enabled consistently when interrupts are se=
t up
      iommu/amd: Stop irq_remapping_select() matching when remapping is dis=
abled

Davide Caratti (2):
      net/sched: sch_taprio: ensure to reset/destroy all child qdiscs
      net: mptcp: cap forward allocation to 1M

Dennis Li (3):
      drm/amdgpu: fix a memory protection fault when remove amdgpu device
      drm/amdgpu: fix a GPU hang issue when remove device
      drm/amdgpu: fix no bad_pages issue after umc ue injection

Dinghao Liu (6):
      net: ethernet: mvneta: Fix error handling in mvneta_probe
      net: ethernet: Fix memleak in ethoc_probe
      habanalabs: Fix memleak in hl_device_reset
      iommu/intel: Fix memleak in intel_irq_remapping_alloc
      net/mlx5e: Fix two double free cases
      net/mlx5e: Fix memleak in mlx5e_create_l2_table_groups

Dmitry Baryshkov (2):
      dt-bindings: regulator: qcom,rpmh-regulator: add pm8009 revision
      regulator: qcom-rpmh-regulator: correct hfsmps515 definition

Douglas Anderson (4):
      spi: spi-geni-qcom: Fix geni_spi_isr() NULL dereference in timeout ca=
se
      spi: spi-geni-qcom: Fail new xfers if xfer/cancel/abort pending
      spi: spi-geni-qcom: Don't try to set CS if an xfer is pending
      spi: spi-geni-qcom: Print an error when we timeout setting the CS

Eddie Hung (1):
      usb: gadget: configfs: Fix use-after-free issue with udc_name

Eric Dumazet (1):
      bpf: Add schedule point in htab_init_buckets()

Fabio Estevam (1):
      usb: gadget: fsl_mxc_udc: Remove the driver

Fenghua Yu (2):
      x86/resctrl: Use an IPI instead of task_work_add() to update PQR_ASSO=
C MSR
      x86/resctrl: Don't move a task to the same resource group

Filipe Manana (7):
      btrfs: fix deadlock when cloning inline extent and low on free
metadata space
      btrfs: send: fix wrong file path when there is an inode with a
pending rmdir
      btrfs: fix transaction leak and crash after RO remount caused by
qgroup rescan
      btrfs: fix transaction leak and crash after cleaning up orphans
on RO mount
      btrfs: fix race between RO remount and the cleaner task
      btrfs: add assertion for empty list of transactions at late
stage of umount
      btrfs: run delayed iputs when remounting RO to avoid leaking them

Florian Fainelli (1):
      net: systemport: set dev->max_mtu to UMAC_MAX_MTU_SIZE

Florian Westphal (4):
      netfilter: xt_RATEEST: reject non-null terminated string from userspa=
ce
      selftests: netfilter: add selftest for ipip pmtu discovery with
enabled connection tracking
      net: fix pmtu check in nopmtudisc mode
      net: ip: always refragment ip defragmented packets

Geert Uytterhoeven (1):
      arm64/smp: Remove unused irq variable in arch_show_interrupts()

Georgi Djakov (1):
      MAINTAINERS: Update Georgi's email address

Gopal Tiwari (1):
      nvme-pci: mark Samsung PM1725a as IGNORE_DEV_SUBNQN

Greg Kroah-Hartman (1):
      crypto: asym_tpm: correct zero out potential secrets

Grygorii Strashko (1):
      net: ethernet: ti: cpts: fix ethtool output when no ptp_clock registe=
red

Guido G=C3=BCnther (1):
      regulator: bd718x7: Add enable times

Guillaume Nault (2):
      ppp: Fix PPPIOCUNBRIDGECHAN request number
      ipv4: Ignore ECN bits for fib lookups in fib_compute_spec_dst()

Guoqing Jiang (1):
      block/rnbd-clt: Fix sg table use after free

Hans de Goede (1):
      i2c: i801: Fix the i2c-mux gpiod_lookup_table not being properly
terminated

Hawking Zhang (1):
      drm/amdgpu: switched to cached noretry setting for vangogh

Heiner Kallweit (1):
      r8169: work around power-saving bug on some chip versions

Ido Schimmel (4):
      selftests: mlxsw: Set headroom size of correct port
      nexthop: Fix off-by-one error in error path
      nexthop: Unlink nexthop group entry in error path
      selftests: fib_nexthops: Fix wrong mausezahn invocation

Iskren Chernev (3):
      drm/msm: Fix null dereference in _msm_gem_new
      drm/msm: Ensure get_pages is called when locked
      drm/msm: Add modparam to allow vram carveout

Israel Rukshin (1):
      nvmet-rdma: Fix list_del corruption on queue establishment failure

Jack Wang (3):
      block/rnbd: Select SG_POOL for RNBD_CLIENT
      block/rnbd-srv: Fix use after free in rnbd_srv_sess_dev_force_close
      block/rnbd-clt: avoid module unload race with close confirmation

Jakub Kicinski (6):
      iavf: fix double-release of rtnl_lock
      MAINTAINERS: remove names from mailing list maintainers
      net: suggest L2 discards be counted towards rx_dropped
      net: vlan: avoid leaks on register_vlan_dev() failures
      docs: net: fix documentation on .ndo_get_stats
      net: bareudp: add missing error handling for bareudp_link_config()

James Smart (2):
      nvme-fc: avoid calling _nvme_fc_abort_outstanding_ios from
interrupt context
      nvme-fcloop: Fix sscanf type and list_first_entry_or_null warnings

Jan Kara (1):
      bfq: Fix computation of shallow depth

Jeff Dike (1):
      virtio_net: Fix recursive call to cpus_read_lock()

Jerome Brunet (1):
      usb: gadget: f_uac2: reset wMaxPacketSize

Jian Shen (1):
      net: hns3: fix incorrect handling of sctp6 rss tuple

Jiang Wang (1):
      selftests/bpf: Fix a compile error for BPF_F_BPRM_SECUREEXEC

Jiawei Gu (1):
      drm/amdgpu: fix potential memory leak during navi12 deinitialization

Jiri Olsa (1):
      tools/resolve_btfids: Warn when having multiple IDs for single type

Jisheng Zhang (1):
      arm64: dts: bitmain: Use generic "ngpios" rather than "snps,nr-gpios"

Johan Hovold (3):
      USB: yurex: fix control-URB timeout handling
      USB: serial: iuu_phoenix: fix DMA from stack
      USB: usblp: fix DMA to stack

John Clements (2):
      drm/amd/pm: updated PM to I2C controller port on sienna cichlid
      drm/amdgpu: enable ras eeprom support for sienna cichlid

John Garry (2):
      scsi: hisi_sas: Expose HW queues for v2 hw
      blk-mq-debugfs: Add decode for BLK_MQ_F_TAG_HCTX_SHARED

John Millikin (2):
      kconfig: Support building mconf with vendor sysroot ncurses
      lib/raid6: Let $(UNROLL) rules work with macOS userland

John Wang (1):
      net/ncsi: Use real net-device for response handler

Jonathan Lemon (2):
      bpf: Save correct stopping point in file seq iteration
      bpf: Use thread_group_leader()

Jonathan Neusch=C3=A4fer (1):
      docs: binfmt-misc: Fix .rst formatting

Josef Bacik (1):
      btrfs: tests: initialize test inodes location

Jouni K. Sepp=C3=A4nen (1):
      net: cdc_ncm: correct overhead in delayed_ndp_size

Julian Wiedmann (3):
      s390/qeth: fix deadlock during recovery
      s390/qeth: fix locking for discipline setup / removal
      s390/qeth: fix L2 header access in qeth_l3_osa_features_check()

Kai-Heng Feng (1):
      ALSA: hda/realtek: Enable mute and micmute LED on HP EliteBook 850 G7

Kailang Yang (2):
      ALSA: hda/realtek - Fix speaker volume control on Lenovo C940
      ALSA: hda/realtek - Modify Dell platform name

Kamal Mostafa (1):
      selftests/bpf: Clarify build error if no vmlinux

Kevin Wang (1):
      drm/amd/display: fix sysfs amdgpu_current_backlight_pwm NULL pointer =
issue

Konrad Dybcio (1):
      drm/msm: Only enable A6xx LLCC code on A6xx

Kuogee Hsieh (1):
      drm/msm/dp: postpone irq_hpd event during connection pending state

Lad Prabhakar (1):
      can: rcar: Kconfig: update help description for CAN_RCAR config

Lai Jiangshan (1):
      kvm: check tlbs_dirty directly

Lalithambika Krishnakumar (1):
      nvme: avoid possible double fetch in handling CQE

Leon Romanovsky (1):
      net/mlx5: Release devlink object if adev fails

Liao Pingfang (1):
      docs/mm: concepts.rst: Correct the threshold to low watermark

Lijun Pan (2):
      ibmvnic: fix login buffer memory leak
      ibmvnic: continue fatal error reset after passive init

Linus Torvalds (3):
      mm: make wait_on_page_writeback() wait for multiple pending writeback=
s
      poll: fix performance regression due to out-of-line __put_user()
      Linux 5.11-rc3

Linus Walleij (1):
      ARM: dts: ux500/golden: Set display max brightness

Liu Yi L (3):
      iommu/vt-d: Move intel_iommu info from struct intel_svm to
struct intel_svm_dev
      iommu/vt-d: Fix general protection fault in aux_detach_device()
      iommu/vt-d: Fix ineffective devTLB invalidation for subdevices

Lorenzo Bianconi (4):
      mt76: mt76u: fix NULL pointer dereference in mt76u_status_worker
      mt76: usb: remove wake logic in mt76u_status_worker
      mt76: sdio: remove wake logic in mt76s_process_tx_queue
      mt76: mt76s: fix NULL pointer dereference in mt76s_process_tx_queue

Lu Baolu (3):
      iommu/vt-d: Fix misuse of ALIGN in qi_flush_piotlb()
      Revert "iommu: Add quirk for Intel graphic devices in map_sg"
      iommu/vt-d: Fix lockdep splat in sva bind()/unbind()

Lukas Bulwahn (4):
      atomic: remove further references to atomic_ops
      MAINTAINERS: adjust GCC PLUGINS after gcc-plugin.sh removal
      cpufreq: intel_pstate: remove obsolete functions
      docs: octeontx2: tune rst markup

L=C3=A9o Le Bouter (1):
      atlantic: remove architecture depends

Madhusudanarao Amara (1):
      usb: typec: intel_pmc_mux: Configure HPD first for HPD+IRQ request

Magnus Karlsson (3):
      xsk: Fix memory leak for failed bind
      xsk: Fix race in SKB mode transmit with shared cq
      xsk: Rollback reservation at NETDEV_TX_BUSY

Manish Chopra (1):
      qede: fix offload for IPIP tunnel packets

Manish Narani (1):
      usb: gadget: u_ether: Fix MTU size mismatch with RX packet size

Manuel Jim=C3=A9nez (1):
      ALSA: hda/realtek: Add mute LED quirk for more HP laptops

Maor Dickman (1):
      net/mlx5e: In skb build skip setting mark in switchdev mode

Marc Kleine-Budde (4):
      can: m_can: m_can_class_unregister(): remove erroneous m_can_clk_stop=
()
      can: tcan4x5x: fix bittiming const, use common bittiming from m_can d=
river
      can: mcp251xfd: mcp251xfd_handle_tefif(): fix TEF vs. TX race conditi=
on
      can: mcp251xfd: mcp251xfd_handle_rxif_ring(): first increment RX
tail pointer in HW, then in driver

Marc Zyngier (6):
      KVM: arm64: Don't access PMCR_EL0 when no PMU is available
      KVM: arm64: Declutter host PSCI 0.1 handling
      KVM: arm64: Consolidate dist->ready setting into kvm_vgic_map_resourc=
es()
      KVM: arm64: Fix hyp_cpu_pm_{init,exit} __init annotation
      KVM: arm64: Remove spurious semicolon in reg_to_encoding()
      KVM: arm64: Replace KVM_ARM_PMU with HW_PERF_EVENTS

Marek Beh=C3=BAn (1):
      net: mvneta: fix error message when MTU too large for XDP

Mario Limonciello (4):
      e1000e: Only run S0ix flows if shutdown succeeded
      e1000e: bump up timeout to wait when ME un-configures ULP mode
      Revert "e1000e: disable s0ix entry and exit flows for ME systems"
      e1000e: Export S0ix flags to ethtool

Mark Brown (1):
      regulator: pf8x00: Use specific compatible strings for devices

Mark Zhang (2):
      net/mlx5: Check if lag is supported before creating one
      net/mlx5: Use port_num 1 instead of 0 when delete a RoCE address

Martin Blumenstingl (3):
      net: stmmac: dwmac-meson8b: ignore the second clock input
      net: dsa: lantiq_gswip: Enable GSWIP_MII_CFG_EN also for internal PHY=
s
      net: dsa: lantiq_gswip: Fix GSWIP_MII_CFG(p) register access

Martin K. Petersen (1):
      Revert "Revert "scsi: megaraid_sas: Added support for shared
host tagset for cpuhotplug""

Martin Kepplinger (1):
      interconnect: imx8mq: Use icc_sync_state

Masahiro Yamada (8):
      ARC: build: remove non-existing bootpImage from KBUILD_IMAGE
      ARC: build: add uImage.lzma to the top-level target
      ARC: build: add boot_targets to PHONY
      ARC: build: move symlink creation to arch/arc/Makefile to avoid race
      ARC: build: remove unneeded extra-y
      ARC: build: use $(READELF) instead of hard-coded readelf
      Compiler Attributes: remove CONFIG_ENABLE_MUST_CHECK
      kconfig: remove 'kvmconfig' and 'xenconfig' shorthands

Matthew Auld (2):
      drm/i915: clear the shadow batch
      drm/i915: clear the gpu reloc batch

Matthew Wilcox (Oracle) (1):
      io_uring: Fix return value from alloc_fixed_file_ref_node

Matthias Maennich (1):
      staging: ION: remove some references to CONFIG_ION

Max Gurtovoy (1):
      nvme: remove the unused status argument from nvme_trace_bio_complete

Maxim Levitsky (3):
      KVM: nSVM: correctly restore nested_run_pending on migration
      KVM: nSVM: mark vmcb as dirty when forcingly leaving the guest mode
      KVM: nSVM: cancel KVM_REQ_GET_NESTED_STATE_PAGES on nested vmexit

Michael Chan (1):
      bnxt_en: Check TQM rings for maximum supported value.

Michael Ellerman (1):
      net: ethernet: fs_enet: Add missing MODULE_LICENSE

Michael Grzeschik (1):
      USB: xhci: fix U1/U2 handling for hardware with XHCI_INTEL_HOST quirk=
 set

Miguel Ojeda (1):
      docs: remove mention of ENABLE_MUST_CHECK

Ming Lei (1):
      block: fix use-after-free in disk_part_iter_next

Minwoo Im (1):
      nvme: unexport functions with no external caller

Moshe Shemesh (1):
      net/mlx5e: Fix SWP offsets when vlan inserted by driver

Nathan Chancellor (2):
      powerpc: Handle .text.{hot,unlikely}.* in linker script
      KVM: SVM: Add register operand to vmsave call in sev_es_vcpu_load

Nick Desaulniers (1):
      arm64: link with -z norelro for LLD or aarch64-elf

Nicolas Saenz Julienne (1):
      arm64: mm: Fix ARCH_LOW_ADDRESS_LIMIT when !CONFIG_ZONE_DMA

Noor Azura Ahmad Tarmizi (1):
      stmmac: intel: Add PCI IDs for TGL-H platform

N=C3=ADcolas F. R. A. Prado (1):
      docs: Fix reST markup when linking to sections

Oded Gabbay (7):
      habanalabs/gaudi: disable CGM at HW initialization
      habanalabs/gaudi: enhance reset message
      habanalabs: update comment in hl_boot_if.h
      habanalabs: adjust pci controller init to new firmware
      habanalabs/gaudi: retry loading TPC f/w on -EINTR
      habanalabs: register to pci shutdown callback
      habanalabs: fix order of status check

Ofir Bitton (2):
      habanalabs: preboot hard reset support
      habanalabs: full FW hard reset support

Oz Shlomo (1):
      net/mlx5e: CT: Use per flow counter when CT flow accounting is enable=
d

Pablo Neira Ayuso (2):
      netfilter: nft_dynset: report EOPNOTSUPP on missing set feature
      netfilter: nftables: add set expression flags

Paolo Bonzini (2):
      KVM: x86: fix shift out of bounds reported by UBSAN
      KVM: x86: __kvm_vcpu_halt can be static

Pavel Begunkov (14):
      btrfs: fix async discard stall
      btrfs: fix racy access to discard_ctl data
      btrfs: merge critical sections of discard lock in workfn
      io_uring: synchronise IOPOLL on task_submit fail
      io_uring: patch up IOPOLL overflow_flush sync
      io_uring: drop file refs after task cancel
      io_uring: cancel more aggressively in exit_work
      io_uring: trigger eventfd for IOPOLL
      io_uring: dont kill fasync under completion_lock
      io_uring: synchronise ev_posted() with waitqueues
      io_uring: io_rw_reissue lockdep annotations
      io_uring: inline io_uring_attempt_task_drop()
      io_uring: add warn_once for io_uring_flush()
      io_uring: stop SQPOLL submit on creator's death

PeiSen Hou (1):
      ALSA: hda/realtek: Add two "Intel Reference board" SSID in the ALC256=
.

Peter Chen (1):
      usb: gadget: core: change the comment for usb_gadget_connect

Peter Collingbourne (2):
      arm64: mte: remove an ISB on kernel exit
      arm64: vdso: disable .eh_frame_hdr via /DISCARD/ instead of
--no-eh-frame-hdr

Peter Gonda (1):
      x86/sev-es: Fix SEV-ES OUT/IN immediate opcode vc handling

Peter Robinson (2):
      usb: typec: Fix copy paste error for NVIDIA alt-mode description
      ACPI: Update Kconfig help text for items that are no longer modular

Peter Ujfalusi (3):
      dmaengine: ti: k3-udma: Fix pktdma rchan TPL level setup
      MAINTAINERS: Add entry for Texas Instruments DMA drivers
      dt-bindings: dma: ti: Update maintainer and author information

Petr Machata (2):
      net: dcb: Validate netlink message in DCB handler
      nexthop: Bounce NHA_GATEWAY in FDB nexthop groups

Petr Mladek (1):
      Revert "init/console: Use ttynull as a fallback when there is no cons=
ole"

Ping-Ke Shih (1):
      rtlwifi: rise completion at the last step of firmware callback

Po-Hsu Lin (1):
      selftests: fix the return value for UDP GRO test

Prashant Malani (1):
      usb: typec: Send uevent for num_altmodes update

Qii Wang (1):
      i2c: mediatek: Fix apdma and i2c hand-shake timeout

Qinglang Miao (1):
      net: qrtr: fix null-ptr-deref in qrtr_ns_remove

Qu Wenruo (1):
      btrfs: qgroup: don't try to wait flushing if we're already
holding a transaction

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Use HWP capabilities in intel_cpufreq_adjust_p=
erf()
      ACPI: PM: s2idle: Drop unused local variables and related code

Randy Dunlap (11):
      mt76: mt7915: fix MESH ifdef block
      net: sched: prevent invalid Scell_log shift count
      hwmon: (sbtsi_temp) Fix Documenation kernel-doc warning
      Documentation: admin: early_param()s are also listed in kernel-parame=
ters
      Documentation: doc-guide: fixes to sphinx.rst
      kconfig: config script: add a little user help
      usb: usbip: vhci_hcd: protect shift size
      arch/arc: add copy_user_page() to <asm/page.h> to fix build error on =
ARC
      net: dsa: fix led_classdev build errors
      ptp: ptp_ines: prevent build when HAS_IOMEM is not set
      Documentation/admin-guide: kernel-parameters: hyphenate comma-separat=
ed

Rasmus Villemoes (3):
      ethernet: ucc_geth: set dev->max_mtu to 1518
      ethernet: ucc_geth: fix definition and size of ucc_geth_tx_global_pra=
m
      ethernet: ucc_geth: fix use-after-free in ucc_geth_remove()

Rob Clark (1):
      drm/msm: Fix WARN_ON() splat in _free_object()

Roger Quadros (1):
      MAINTAINERS: Update address for Cadence USB3 driver

Roland Dreier (1):
      CDC-NCM: remove "connected" log message

Roman Guskov (1):
      spi: stm32: FIFO threshold level - fix align packet size

Sagi Grimberg (1):
      nvme-tcp: Fix possible race of io_work and direct send

Samuel Holland (4):
      net: stmmac: dwmac-sun8i: Fix probe error handling
      net: stmmac: dwmac-sun8i: Balance internal PHY resource references
      net: stmmac: dwmac-sun8i: Balance internal PHY power
      net: stmmac: dwmac-sun8i: Balance syscon (de)initialization

Samuel Thibault (1):
      speakup: Add github repository URL and bug tracker

Satya Tangirala (1):
      fs: Fix freeze_bdev()/thaw_bdev() accounting of bd_fsfreeze_sb

Sean Christopherson (5):
      KVM: x86/mmu: Use -1 to flag an undefined spte in get_mmio_spte()
      KVM: x86/mmu: Get root level from walkers when retrieving MMIO SPTE
      KVM: x86/mmu: Use raw level to index into MMIO walks' sptes array
      KVM: x86/mmu: Optimize not-present/MMIO SPTE check in get_mmio_spte()
      MAINTAINERS: Really update email address for Sean Christopherson

Sean Tranchetti (2):
      net: ipv6: fib: flush exceptions when purging route
      tools: selftests: add test for changing routes with PTMU exceptions

Sean Young (1):
      USB: cdc-acm: blacklist another IR Droid device

Serge Semin (3):
      usb: dwc3: ulpi: Use VStsDone to detect PHY regs access completion
      usb: dwc3: ulpi: Replace CPU-based busyloop with Protocol-based one
      usb: dwc3: ulpi: Fix USB2.0 HS/FS/LS PHY suspend regression

Shannon Nelson (1):
      ionic: account for vlan tag len in rx buffer len

Shannon Zhao (1):
      arm64: cpufeature: remove non-exist CONFIG_KVM_ARM_HOST

Shawn Guo (1):
      ACPI: scan: add stub acpi_create_platform_device() for !CONFIG_ACPI

Shravya Kumbham (3):
      dmaengine: xilinx_dma: check dma_async_device_register return value
      dmaengine: xilinx_dma: fix incompatible param warning in _child_probe=
()
      dmaengine: xilinx_dma: fix mixed_enum_type coverity warning

Sriharsha Allenki (1):
      usb: gadget: Fix spinlock lockup on usb_function_deactivate

Sriram Dash (1):
      MAINTAINERS: Update MCAN MMIO device driver maintainer

Stefan Chulski (5):
      net: mvpp2: disable force link UP during port init procedure
      net: mvpp2: Add TCAM entry to drop flow control pause frames
      net: mvpp2: prs: fix PPPoE with ipv6 packet parse
      net: mvpp2: Fix GoP port 3 Networking Complex Control configurations
      net: mvpp2: fix pkt coalescing int-threshold configuration

Stefano Garzarella (2):
      vhost/vsock: add IOTLB API support
      iommu/iova: fix 'domain' typos

Stephen Zhang (1):
      KVM: x86: change in pv_eoi_get_pending() to make code more readable

Subash Abhinov Kasiviswanathan (1):
      netfilter: x_tables: Update remaining dereference to RCU

Swapnil Ingle (1):
      block/rnbd: Adding name to the Contributors List

Sylwester Dziedziuch (1):
      i40e: Fix Error I40E_AQ_RC_EINVAL when removing VFs

Taehee Yoo (2):
      bareudp: set NETIF_F_LLTX flag
      bareudp: Fix use of incorrect min_headroom size

Takashi Iwai (4):
      ALSA: usb-audio: Fix UBSAN warnings for MIDI jacks
      ALSA: usb-audio: Add quirk for BOSS AD-10
      ALSA: hda/hdmi: Fix incorrect mutex unlock in silent_stream_disable()
      ALSA: hda/via: Fix runtime PM for Clevo W35xSS

Tejun Heo (1):
      blk-iocost: fix NULL iocg deref from racing against initialization

Tetsuo Handa (1):
      USB: cdc-wdm: Fix use after free in service_outstanding_interrupt().

Thinh Nguyen (2):
      usb: uas: Add PNY USB Portable SSD to unusual_uas
      usb: dwc3: gadget: Clear wait flag on dequeue

Tian Tao (2):
      bpf: Remove unused including <linux/version.h>
      arm64: traps: remove duplicate include statement

Timon Reinold (1):
      ALSA: usb-audio: Add quirk for RC-505

Tobias Klauser (2):
      selftests/vDSO: add additional binaries to .gitignore
      selftests/vDSO: fix -Wformat warning in vdso_test_correctness

Tom Lendacky (1):
      KVM: SVM: Add support for booting APs in an SEV-ES guest

Tomer Tayar (2):
      habanalabs: Fix a missing-braces warning
      habanalabs: Revise comment to align with mirror list name

Tudor Ambarus (1):
      spi: Fix the clamping of spi->max_speed_hz

Uladzislau Rezki (Sony) (1):
      rcu-tasks: Move RCU-tasks initialization to before early_initcall()

Uros Bizjak (1):
      KVM/SVM: Remove leftover __svm_vcpu_run prototype from svm.c

Uwe Kleine-K=C3=B6nig (1):
      hwmon: (pwm-fan) Ensure that calculation doesn't discard big period v=
alues

Valdis Kletnieks (1):
      gcc-plugins: fix gcc 11 indigestion with plugins...

Vasily Averin (2):
      netfilter: ipset: fixes possible oops in mtype_resize
      netfilter: ipset: fix shift-out-of-bounds in htable_bits()

Vasundhara Volam (1):
      bnxt_en: Fix AER recovery.

Vineet Gupta (3):
      include/soc: remove headers for EZChip NPS
      ARC: unbork 5.11 bootup: fix snafu in _TIF_NOTIFY_SIGNAL handling
      ARC: [hsdk]: Enable FPU_SAVE_RESTORE

Viresh Kumar (1):
      Documentation: kbuild: Fix section reference

Wesley Cheng (1):
      usb: dwc3: gadget: Restart DWC3 gadget when enabling pullup

Xiaojian Du (4):
      drm/amd/pm: correct the sensor value of power for vangogh
      drm/amd/pm: improve the fine grain tuning function for RV/RV2/PCO
      drm/amd/pm: fix the failure when change power profile for renoir
      drm/amd/pm: improve the fine grain tuning function for RV/RV2/PCO

Xiaolei Wang (1):
      regmap: debugfs: Fix a memory leak when calling regmap_attach_dev

Xiaoming Ni (1):
      dmaengine: qcom: gpi: Fixes a format mismatch

Xie He (2):
      net: hdlc_ppp: Fix issues when mod_timer is called while timer is run=
ning
      net: lapb: Decrease the refcount of "struct lapb_cb" in lapb_device_e=
vent

Xu Yilun (2):
      spi: altera: fix return value for altera_spi_txrx()
      spi: fix the divide by 0 error when calculating xfer waiting time

YANG LI (1):
      ibmvnic: fix: NULL pointer dereference.

Yang Yingliang (1):
      USB: gadget: legacy: fix return error code in acm_ms_bind()

Ye Bin (1):
      io_uring: Delete useless variable =E2=80=98id=E2=80=99 in io_prep_asy=
nc_work

Yi Li (1):
      bcache: set pdev_set_uuid before scond loop iteration

Ying-Tsun Huang (1):
      x86/mtrr: Correct the range check before performing MTRR type lookups

Yonghong Song (1):
      bpf: Fix a task_iter bug caused by a merge conflict resolution

Yonglong Liu (1):
      net: hns3: fix a phy loopback fail issue

Yu Kuai (1):
      usb: chipidea: ci_hdrc_imx: add missing put_device() call in
usbmisc_get_init_data()

Yufeng Mo (1):
      net: hns3: fix the number of queues actually used by ARQ

Yunjian Wang (3):
      tun: fix return value when the number of iovs exceeds MAX_SKB_FRAGS
      net: hns: fix return value check in __lb_other_process()
      vhost_net: fix ubuf refcount incorrectly when sendmsg fails

Zheng Yongjun (1):
      qcom: bam_dma: Delete useless kfree code

Zheng Zengkai (1):
      usb: dwc3: meson-g12a: disable clk on error handling path in probe

Zqiang (1):
      usb: gadget: function: printer: Fix a memory leak for interface descr=
iptor

bo liu (1):
      ALSA: hda/conexant: add a new hda codec CX11970

ethanwu (1):
      btrfs: correctly calculate item size used when item key collision hap=
pens

taehyun.cho (1):
      usb: gadget: enable super speed plus

weichenchen (1):
      net: neighbor: fix a crash caused by mod zero
