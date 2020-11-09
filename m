Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6552AB002
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 04:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgKIDlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 22:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgKIDlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 22:41:08 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5FFC0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 19:41:07 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id b18so6823550qkc.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 19:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=f32fO6054v3K2JmQWs+1nCmnhForHLozrU4TYx4ZHzs=;
        b=DJxUqTmeWC5zbfgE8KKH4jqCq/lfqCVa5hyQq9uK0jyAb/BC7FNBDLZiEpayIgbsPJ
         7Wn4Ff0teJVHJ9gCW6IkZkTQ5oOZDPD1O818WzW7O6a4QaPvtS0SCiG+cTPSkwPyRB43
         ZM7MpUUEMINDSGnTTQF6CHcdrYhpZzQCxqACybAdvmBeOp4BMacgCRTHv+WNNkRPo0uV
         O6uNDM5MIY0AIOK5E8dKTC9npqZvZcEtH2zdZQScseWhwJ1LDpucNH7pVINHlD7TrQml
         Bfri+bnnkTQkU5sp6Lh8r0c6dBe/DqsbT14RjWvJHQHVyha5abW+nzUrNuJIXmDe5Cmq
         pp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=f32fO6054v3K2JmQWs+1nCmnhForHLozrU4TYx4ZHzs=;
        b=hhjbk/lQ+8QuFvBFxgFIA2KkTW3Kz7S4tXT1xuNwAN/MIAWYBGpsjS7008aklKgGHr
         g7DCuy0CCSmHG3FXqcZlyETzGbUX+MTwxiTlK3XHonbG2EUXh5XJeXFvbI4YQ7zQytFM
         US0KZG0pXfgYx30GNc5WOQmqz742JZbcsBuVF+ZW6+/X9klJxsPfaV6uvTL2hBuqYETr
         b9gRFRYvWVN3akDQdlmjgPft3fudtwZ2niN+N+FEsTTnPDVFgeOZW7gW4+2/ARutgy15
         0WQsCNXds0GI1GRqL3TIpmqrzlYkltaMAm+QDuA7LpxoZsx3O5GrdQmnLg+UEog4e2uR
         5KYg==
X-Gm-Message-State: AOAM5321sKv0MKrHYCdBFMHm3ZERf9g6LQIX92qi/PqGdj5VcaMfPJwq
        dDzkfIi5Gb6WXVUYXhh6TDPOYIVcdxyYlm27
X-Google-Smtp-Source: ABdhPJxRgHio3gu5FHnPa57UwNrMrB810HXdKb53Uj7SzsAMnVt+7UV/tQ4l60+D4kfHsFkVY41Agg==
X-Received: by 2002:a37:4487:: with SMTP id r129mr12202593qka.101.1604893265773;
        Sun, 08 Nov 2020 19:41:05 -0800 (PST)
Received: from Gentoo ([156.146.54.75])
        by smtp.gmail.com with ESMTPSA id h9sm4977314qth.78.2020.11.08.19.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 19:41:03 -0800 (PST)
Date:   Mon, 9 Nov 2020 09:10:55 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ..and it builds and boot without a fuss! Linux 5.10-rc3
Message-ID: <20201109034055.GA31274@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiZtabGDAxTbxaAkxf7QjuJSK7c7mcZXFkrYjRfXmSnmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZtabGDAxTbxaAkxf7QjuJSK7c7mcZXFkrYjRfXmSnmQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16:29 Sun 08 Nov 2020, Linus Torvalds wrote:
>Things look normal. rc3 is neither particularly small or particularly
>large - it's pretty much average for an rc3 release for the last
>couple of years. As usual, things have picked up a bit from rc2 as
>people are finding things, but that's normal and not worrisome.
>
>Nothing particularly stands out in the shortlog (appended) or the
>diffs either - the changes are pretty spread out, with all the usual
>suspects: drivers (gpu, sound, i2c, networking etc), architecture
>fixes (x86, powerpc, arm64, risc-v, s390), and various tooling and
>documentation updates. And to round it out, a random smattering
>elsewhere (core networking, kernel, some mm and filesystem noise).
>
>Please test,
>
>              Linus
>

Well, something for your eyes!

[    4.378607] md: Autodetecting RAID arrays.
[    4.379048] md: autorun ...
[    4.379470] md: ... autorun DONE.
[    4.500224] tsc: Refined TSC clocksource calibration: 2194.918 MHz
[    4.501001] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fa=
37202099, max_idle_ns: 440795206796 ns
[    4.503953] clocksource: Switched to clocksource tsc
[    4.563831] EXT4-fs (sda): recovery complete
[    4.579815] EXT4-fs (sda): mounted filesystem with ordered data mode. Op=
ts: (null)
[    4.584256] ext4 filesystem being mounted at /root supports timestamps u=
ntil 2038 (0x7fffffff)
[    4.585248] VFS: Mounted root (ext4 filesystem) on device 8:0.
[    4.603450] devtmpfs: mounted
[    4.622597] Freeing unused decrypted memory: 2036K
[    4.739189] Freeing unused kernel image (initmem) memory: 1628K
[    4.740247] Write protecting the kernel read-only data: 26624k
[    4.748217] Freeing unused kernel image (text/rodata gap) memory: 2028K
[    4.752938] Freeing unused kernel image (rodata/data gap) memory: 664K
[    4.754491] rodata_test: all tests were successful
[    4.755199] Run /sbin/init as init process
[    5.069777] EXT4-fs (sda): re-mounted. Opts: (null)
[    5.071165] ext4 filesystem being remounted at / supports timestamps unt=
il 2038 (0x7fffffff)
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
[    6.675665] random: crng init done
Initializing random number generator: OK
Saving random seed: OK
Starting network: OK

Welcome to Buildroot_Linux
Bhaskar_Thinkpad_x250 login: root
# uname -a
Linux Bhaskar_Thinkpad_x250 5.10.0-rc3-Gentoo #1 SMP Mon Nov 9 06:56:41 IST=
 2020 x86_64 GNU/Linux

~Bhaskar
>---
>
>Aaron Liu (1):
>      drm/amdgpu: enable green_sardine_asd.bin loading (v2)
>
>Adit Ranadive (1):
>      RDMA/vmw_pvrdma: Fix the active_speed and phys_state value
>
>Alan Stern (1):
>      USB: Add NO_LPM quirk for Kingston flash drive
>
>Alex Deucher (4):
>      drm/amdgpu/powerplay: Only apply optimized mclk dpm policy on polaris
>      drm/amdgpu/swsmu: remove duplicate call to smu_set_default_dpm_table
>      drm/amdgpu: add Green_Sardine APU flag
>      drm/amdgpu/display: remove DRM_AMD_DC_GREEN_SARDINE
>
>Alex Williamson (1):
>      vfio/pci: Implement ioeventfd thread handler for contended memory lo=
ck
>
>Alexander Aring (1):
>      gfs2: Wake up when sd_glock_disposal becomes zero
>
>Alexander Ovechkin (1):
>      ip6_tunnel: set inner ipproto before ip6_tnl_encap
>
>Alexander Sverdlin (1):
>      mtd: spi-nor: Don't copy self-pointing struct around
>
>Anand K Mistry (1):
>      x86/speculation: Allow IBPB to be conditionally enabled on CPUs
>with always-on STIBP
>
>Andreas Gruenbacher (1):
>      gfs2: Don't call cancel_delayed_work_sync from within delete work fu=
nction
>
>Andrey Konovalov (1):
>      kasan: adopt KUNIT tests to SW_TAGS mode
>
>Andy Shevchenko (1):
>      kunit: Don't fail test suites if one of them is empty
>
>Anup Patel (1):
>      RISC-V: Use non-PGD mappings for early DTB access
>
>Ard Biesheuvel (1):
>      ARM, xtensa: highmem: avoid clobbering non-page aligned memory
>reservations
>
>Arnaldo Carvalho de Melo (14):
>      perf tools: Update copy of libbpf's hashmap.c
>      tools headers UAPI: Update process_madvise affected files
>      perf scripting python: Avoid declaring function pointers with a
>visibility attribute
>      tools headers UAPI: Sync prctl.h with the kernel sources
>      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
>      tools headers UAPI: Update fscrypt.h copy
>      tools x86 headers: Update cpufeatures.h headers copies
>      tools x86 headers: Update required-features.h header from the kernel
>      tools arch x86: Sync the msr-index.h copy with the kernel sources
>      tools UAPI: Update copy of linux/mman.h from the kernel sources
>      tools kvm headers: Update KVM headers from the kernel sources
>      tools headers UAPI: Update tools's copy of linux/perf_event.h
>      tools include UAPI: Update linux/mount.h copy
>      tools feature: Fixup fast path feature detection
>
>Arnd Bergmann (2):
>      ALSA: make snd_kcontrol_new name a normal string
>      drm/imx: tve remove extraneous type qualifier
>
>Artem Lapkin (1):
>      ALSA: usb-audio: add usb vendor id as DSD-capable for Khadas devices
>
>Atish Patra (1):
>      RISC-V: Remove any memblock representing unusable memory area
>
>Bard Liao (1):
>      ASoC: SOF: loader: handle all SOF_IPC_EXT types
>
>Benjamin Gwin (1):
>      arm64: kexec_file: try more regions if loading segments fails
>
>Bert Vermeulen (1):
>      mtd: spi-nor: Fix address width on flash chips > 16MB
>
>Bob Peterson (6):
>      gfs2: Free rd_bits later in gfs2_clear_rgrpd to fix use-after-free
>      gfs2: Add missing truncate_inode_pages_final for sd_aspace
>      gfs2: init_journal's undo directive should also undo the statfs inod=
es
>      gfs2: Split up gfs2_meta_sync into inode and rgrp versions
>      gfs2: don't initialize statfs_change inodes in spectator mode
>      gfs2: check for live vs. read-only file system in gfs2_fitrim
>
>Boris Brezillon (1):
>      drm/panfrost: Fix a deadlock between the shrinker and madvise path
>
>Brendan Higgins (1):
>      kunit: tools: fix kunit_tool tests for parsing test plans
>
>Brian Foster (3):
>      xfs: flush new eof page on truncate to avoid post-eof corruption
>      iomap: support partial page discard on writeback block mapping failu=
re
>      iomap: clean up writeback state logic on writepage error
>
>Camelia Groza (2):
>      dpaa_eth: update the buffer layout for non-A050385 erratum scenarios
>      dpaa_eth: fix the RX headroom size alignment
>
>Cezary Rojewski (3):
>      ASoC: Intel: atom: Remove duplicate kconfigs
>      ASoC: Intel: catpt: Wake up device before configuring SSP port
>      ASoC: Intel: catpt: Relax clock selection conditions
>
>Changbin Du (1):
>      riscv: uaccess: fix __put_kernel_nofault()
>
>Chao Leng (3):
>      nvme: introduce nvme_sync_io_queues
>      nvme-rdma: avoid race between time out and tear down
>      nvme-tcp: avoid race between time out and tear down
>
>Charles Haithcock (1):
>      mm, oom: keep oom_adj under or at upper limit when printing
>
>Chris Wilson (5):
>      drm/i915/gem: Flush coherency domains on first set-domain-ioctl
>      drm/i915/gt: Use the local HWSP offset during submission
>      drm/i915/gt: Expose more parameters for emitting writes into the ring
>      drm/i915/gt: Flush xcs before tgl breadcrumbs
>      drm/i915: Hold onto an explicit ref to i915_vma_work.pinned
>
>Christoph Hellwig (5):
>      seq_file: add seq_read_iter
>      proc: wire up generic_file_splice_read for iter ops
>      proc/cpuinfo: switch to ->read_iter
>      proc/stat: switch to ->read_iter
>      proc "seq files": switch to ->read_iter
>
>Christophe Kerello (1):
>      mtd: rawnand: stm32_fmc2: fix broken ECC
>
>Christophe Leroy (4):
>      powerpc/603: Always fault when _PAGE_ACCESSED is not set
>      powerpc/40x: Always fault when _PAGE_ACCESSED is not set
>      powerpc/8xx: Always fault when _PAGE_ACCESSED is not set
>      powerpc/8xx: Manage _PAGE_ACCESSED through APG bits in L1 entry
>
>Claire Chang (1):
>      serial: 8250_mtk: Fix uart_get_baud_rate warning
>
>Claudiu Manoil (2):
>      gianfar: Replace skb_realloc_headroom with skb_cow_head for PTP
>      gianfar: Account for Tx PTP timestamp in the skb headroom
>
>Codrin Ciubotariu (1):
>      ASoC: mchp-spdiftx: Do not set Validity bit(s)
>
>Colin Ian King (3):
>      selftests/ftrace: check for do_sys_openat2 in user-memory test
>      net: atm: fix update of position index in lec_seq_next
>      can: isotp: padlen(): make const array static, makes object smaller
>
>Colin Xu (4):
>      drm/i915/gvt: Allow zero out HWSP addr on hws_pga_write
>      drm/i915/gvt: Set SNOOP for PAT3 on BXT/APL to workaround GPU BB hang
>      drm/i915/gvt: Only pin/unpin intel_context along with workload
>      drm/i915/gvt: Fix mmio handler break on BXT/APL.
>
>Damien Le Moal (1):
>      null_blk: Fix scheduling in atomic with zoned mode
>
>Dan Carpenter (5):
>      vfio/fsl-mc: return -EFAULT if copy_to_user() fails
>      ALSA: hda: prevent undefined shift in snd_hdac_ext_bus_get_link()
>      iommu: Fix a check in iommu_check_bind_data()
>      vfio/fsl-mc: prevent underflow in vfio_fsl_mc_mmap()
>      can: peak_usb: add range checking in decode operations
>
>Daniel Vetter (1):
>      vt: Disable KD_FONT_OP_COPY
>
>Daniele Palmas (3):
>      net: usb: qmi_wwan: add Telit LE910Cx 0x1230 composition
>      USB: serial: option: add LE910Cx compositions 0x1203, 0x1230, 0x1231
>      USB: serial: option: add Telit FN980 composition 0x1055
>
>Darrick J. Wong (4):
>      xfs: set xefi_discard when creating a deferred agfl free log intent =
item
>      xfs: fix missing CoW blocks writeback conversion retry
>      xfs: fix scrub flagging rtinherit even if there is no rt device
>      xfs: only flush the unshared range in xfs_reflink_unshare
>
>David Gow (1):
>      kunit: Fix kunit.py --raw_output option
>
>David Howells (2):
>      afs: Fix warning due to unadvanced marshalling pointer
>      afs: Fix incorrect freeing of the ACL passed to the YFS ACL store op
>
>Davide Caratti (1):
>      mptcp: token: fix unititialized variable
>
>Diana Craciun (1):
>      vfio/fsl-mc: Make vfio_fsl_mc_irqs_allocate static
>
>Eddy Wu (1):
>      fork: fix copy_process(CLONE_PARENT) race with the exiting ->real_pa=
rent
>
>Eelco Chaudron (1):
>      net: openvswitch: silence suspicious RCU usage warning
>
>Evan Quan (5):
>      drm/amdgpu: perform srbm soft reset always on SDMA resume
>      drm/amd/pm: correct the baco reset sequence for CI ASICs
>      drm/amd/pm: enable baco reset for Hawaii
>      drm/amd/pm: perform SMC reset on suspend/hibernation
>      drm/amd/pm: do not use ixFEATURE_STATUS for checking smc running
>
>Evgeny Novikov (1):
>      usb: gadget: goku_udc: fix potential crashes in probe
>
>Fabio Estevam (2):
>      mtd: rawnand: mxc: Move the ECC engine initialization to the right p=
lace
>      mtd: rawnand: ifc: Move the ECC engine initialization to the right p=
lace
>
>Fabrice Gasnier (1):
>      irqchip/stm32-exti: Add all LP timer exti direct events support
>
>Fangrui Song (1):
>      x86/lib: Change .weak to SYM_FUNC_START_WEAK for arch/x86/lib/mem*_6=
4.S
>
>Flora Cui (2):
>      drm/amdgpu: disable DCN and VCN for Navi14 0x7340/C9 SKU
>      drm/amdgpu: rename nv_is_headless_sku()
>
>Fred Gao (1):
>      vfio/pci: Bypass IGD init in case of -ENODEV
>
>Geert Uytterhoeven (5):
>      irqchip/mst: MST_IRQ should depend on ARCH_MEDIATEK or ARCH_MSTARV7
>      irqchip/renesas-intc-irqpin: Merge irlm_bit and needs_irlm
>      of: Drop superfluous ULL suffix for ~0
>      can: isotp: Explain PDU in CAN_ISOTP help text
>      i2c: mlxbf: I2C_MLXBF should depend on MELLANOX_PLATFORM
>
>Geoffrey D. Bennett (2):
>      ALSA: usb-audio: Add implicit feedback quirk for MODX
>      ALSA: usb-audio: Add implicit feedback quirk for Qu-16
>
>Gerald Schaefer (1):
>      s390/mm: make pmd/pud_deref() large page aware
>
>Greentime Hu (2):
>      irqchip/sifive-plic: Fix broken irq_set_affinity() callback
>      irqchip/sifive-plic: Fix chip_data access within a hierarchy
>
>Greg Kroah-Hartman (2):
>      Documentation: remove mic/index from misc-devices/index.rst
>      proc "single files": switch to ->read_iter
>
>Greg Ungerer (1):
>      net: fec: fix MDIO probing for some FEC hardware blocks
>
>Grygorii Strashko (1):
>      net: ethernet: ti: cpsw: disable PTPv1 hw timestamping advertisement
>
>Hangbin Liu (2):
>      ICMPv6: Add ICMPv6 Parameter Problem, code 3 definition
>      IPv6: reply ICMP error if the first fragment don't include all heade=
rs
>
>Hannes Reinecke (1):
>      scsi: scsi_dh_alua: Avoid crash during alua_bus_detach()
>
>Harald Freudenberger (2):
>      s390/ap: fix ap devices reference counting
>      s390/pkey: fix paes selftest failure with paes and pkey static build
>
>Heikki Krogerus (1):
>      usb: dwc3: pci: add support for the Intel Alder Lake-S
>
>Heiko Carstens (3):
>      s390/vdso: remove empty unused file
>      s390/vdso: remove unused constants
>      s390: update defconfigs
>
>Heiner Kallweit (1):
>      r8169: work around short packet hw bug on RTL8125
>
>Imre Deak (1):
>      drm/i915: Fix encoder lookup during PSR atomic check
>
>Jason A. Donenfeld (2):
>      wireguard: selftests: check that route_me_harder packets use the rig=
ht sk
>      netfilter: use actual socket sk rather than skb sk when routing hard=
er
>
>Jason Gunthorpe (2):
>      mm: always have io_remap_pfn_range() set pgprot_decrypted()
>      RDMA/srpt: Fix typo in srpt_unregister_mad_agent docstring
>
>Jason Yan (1):
>      mm/truncate.c: make __invalidate_mapping_pages() static
>
>Jean-Philippe Brucker (1):
>      arm64: kprobes: Use BRK instead of single-step when executing
>instructions out-of-line
>
>Jeff Layton (1):
>      ceph: check session state after bumping session->s_seq
>
>Jens Axboe (5):
>      io-wq: cancel request if it's asking for files and we don't have them
>      io_uring: properly handle SQPOLL request cancelations
>      io_uring: ensure consistent view of original task ->mm from SQPOLL
>      io_uring: drop req/tctx io_identity separately
>      io_uring: use correct pointer for io_uring_show_cred()
>
>Jerry Snitselaar (1):
>      tpm_tis: Disable interrupts on ThinkPad T490s
>
>Jin Yao (1):
>      perf vendor events: Fix DRAM_BW_Use 0 issue for CLX/SKX
>
>Jiri Olsa (2):
>      perf tools: Initialize output buffer in build_id__sprintf
>      perf tools: Add missing swap for ino_generation
>
>Joakim Zhang (4):
>      can: flexcan: remove FLEXCAN_QUIRK_DISABLE_MECR quirk for LS1021A
>      can: flexcan: add ECC initialization for LX2160A
>      can: flexcan: add ECC initialization for VF610
>      can: flexcan: flexcan_remove(): disable wakeup completely
>
>Joe Perches (1):
>      MAINTAINERS: Update AMD POWERPLAY pattern
>
>Joerg Roedel (5):
>      x86/boot/compressed/64: Introduce sev_status
>      x86/boot/compressed/64: Sanity-check CPUID results in the early
>#VC handler
>      x86/boot/compressed/64: Check SEV encryption in 64-bit boot-path
>      x86/head/64: Check SEV encryption before switching to kernel page-ta=
ble
>      x86/sev-es: Do not support MMIO to/from encrypted memory
>
>Johan Hovold (1):
>      USB: serial: cyberjack: fix write-URB completion race
>
>Johannes Berg (4):
>      mac80211: fix use of skb payload instead of header
>      cfg80211: initialize wdev data earlier
>      mac80211: always wind down STA state
>      mac80211: don't require VHT elements for HE on 2.4 GHz
>
>John Clements (1):
>      drm/amdgpu: resolved ASD loading issue on sienna
>
>Jonathan Corbet (1):
>      docs: fix automarkup regression on Python 2
>
>Jonathan McDowell (1):
>      net: dsa: qca8k: Fix port MTU setting
>
>Julia Lawall (2):
>      Documentation: PM: cpuidle: correct typo
>      Documentation: PM: cpuidle: correct path name
>
>Justin M. Forbes (1):
>      perf tools: Remove LTO compiler options when building perl support
>
>Kai-Heng Feng (3):
>      ALSA: hda: Refactor codec PM to use direct-complete optimization
>      ALSA: hda: Separate runtime and system suspend
>      ALSA: hda: Reinstate runtime_allow() for all hda controllers
>
>Kailang Yang (2):
>      ALSA: hda/realtek - Fixed HP headset Mic can't be detected
>      ALSA: hda/realtek - Enable headphone for ASUS TM420
>
>Keita Suzuki (1):
>      scsi: hpsa: Fix memory leak in hpsa_init_one()
>
>Keith Busch (1):
>      Revert "nvme-pci: remove last_sq_tail"
>
>Keith Winstein (1):
>      ALSA: usb-audio: Add implicit feedback quirk for Zoom UAC-2
>
>Kent Russell (1):
>      amdkfd: Check kvmalloc return before memcpy
>
>Khalil Blaiech (5):
>      i2c: mlxbf: Add CONFIG_ACPI to guard ACPI function call
>      i2c: mlxbf: Fix resrticted cast warning of sparse
>      i2c: mlxbf: Remove unecessary wrapper functions
>      i2c: mlxbf: Update reference clock frequency
>      i2c: mlxbf: Update author and maintainer email info
>
>Lee Jones (1):
>      Fonts: Replace discarded const qualifier
>
>Likun Gao (1):
>      drm/amdgpu: update golden setting for sienna_cichlid
>
>Linus Torvalds (2):
>      tty: make FONTX ioctl use the tty pointer they were actually passed
>      Linux 5.10-rc3
>
>Liu Shaohua (1):
>      riscv: fix pfn_to_virt err in do_page_fault().
>
>Liu Yi L (1):
>      iommu/vt-d: Fix sid not set issue in intel_svm_bind_gpasid()
>
>Liu, Yi L (1):
>      iommu/vt-d: Fix a bug for PDP check in prq_event_thread
>
>Lu Baolu (1):
>      iommu/vt-d: Fix kernel NULL pointer dereference in find_domain()
>
>Lucas Stach (1):
>      tty: serial: imx: enable earlycon by default if
>IMX_SERIAL_CONSOLE is enabled
>
>Lukas Bulwahn (1):
>      kernel/hung_task.c: make type annotations consistent
>
>Macpaul Lin (1):
>      usb: mtu3: fix panic in mtu3_gadget_stop()
>
>Maor Gottlieb (1):
>      IB/srpt: Fix memory leak in srpt_add_one
>
>Marc Kleine-Budde (2):
>      can: rx-offload: don't call kfree_skb() from IRQ context
>      can: mcp251xfd: mcp251xfd_regmap_crc_read(): increase severity
>of CRC read error messages
>
>Marc Zyngier (4):
>      genirq: Let GENERIC_IRQ_IPI select IRQ_DOMAIN_HIERARCHY
>      irqchip/mst: Make mst_intc_of_init static
>      irqchip/mips: Drop selection of IRQ_DOMAIN_HIERARCHY
>      irqchip/bcm2836: Fix missing __init annotation
>
>Marco Felsch (1):
>      drm/imx: parallel-display: fix edid memory leak
>
>Marek Szyprowski (1):
>      net: stmmac: Fix channel lock initialization
>
>Mark Deneen (1):
>      cadence: force nonlinear buffers to be cloned
>
>Martin Blumenstingl (1):
>      usb: dwc2: Avoid leaving the error_debugfs label unused
>
>Martin Hundeb=C3=B8ll (2):
>      spi: bcm2835: fix gpio cs level inversion
>      spi: bcm2835: remove use of uninitialized gpio flags variable
>
>Mathy Vanhoef (1):
>      mac80211: fix regression where EAPOL frames were sent in plaintext
>
>Matthias Reichl (1):
>      tty: fix crash in release_tty if tty->port is not set
>
>Mauro Carvalho Chehab (35):
>      ALSA: fix kernel-doc markups
>      kunit: test: fix remaining kernel-doc warnings
>      docs: Makefile: honor V=3D0 for docs building
>      scripts: kernel-doc: fix typedef parsing
>      scripts: kernel-doc: split typedef complex regex
>      scripts: kernel-doc: use :c:union when needed
>      sphinx: conf.py: properly handle Sphinx 4.0
>      docs: hwmon: adm1266.rst: fix a broken reference
>      docs: admin-guide: net.rst: add a missing blank line
>      docs: kasan.rst: add two missing blank lines
>      docs: net: statistics.rst: remove a duplicated kernel-doc
>      docs: hwmon: mp2975.rst: address some html build warnings
>      docs: userspace-api: add iommu.rst to the index file
>      blk-mq: docs: add kernel-doc description for a new struct member
>      mm: pagemap.h: fix two kernel-doc markups
>      net: phy: remove kernel-doc duplication
>      crypto: sun8x-ce*: update entries to its documentation
>      ice: docs fix a devlink info that broke a table
>      MAINTAINERS: fix broken doc refs due to yaml conversion
>      docs: lockdep-design: fix some warning issues
>      locking/refcount: move kernel-doc markups to the proper place
>      IB/srpt: docs: add a description for cq_size member
>      docs: fs: api-summary.rst: get rid of kernel-doc include
>      drm: amdgpu: kernel-doc: update some adev parameters
>      gpu: docs: amdgpu.rst: get rid of wrong kernel-doc markups
>      drm: amdgpu_dm: fix a typo
>      selftests: kselftest_harness.h: fix kernel-doc markups
>      amdgpu: fix a few kernel-doc markup issues
>      docs: SafeSetID: fix a warning
>      mac80211: fix kernel-doc markups
>      docs: ABI: sysfs-driver-dma-ioatdma: what starts with /sys
>      docs: ABI: sysfs-class-net: fix a typo
>      docs: leds: index.rst: add a missing file
>      scripts: get_abi.pl: Don't let ABI files to create subtitles
>      scripts: get_api.pl: Add sub-titles to ABI output
>
>Maxime Ripard (7):
>      drm/vc4: bo: Add a managed action to cleanup the cache
>      drm/vc4: drv: Use managed drm_mode_config_init
>      drm/vc4: gem: Add a managed action to cleanup the job queue
>      drm/vc4: Use the helper to retrieve vc4_dev when needed
>      drm/vc4: Use devm_drm_dev_alloc
>      drm/vc4: kms: Add functions to create the state objects
>      drm/vc4: drv: Remove unused variable
>
>Michael Ellerman (1):
>      powerpc: Use asm_goto_volatile for put_user()
>
>Michael Kelley (1):
>      x86/hyperv: Clarify comment on x2apic mode
>
>Michael Wu (2):
>      i2c: designware: call i2c_dw_read_clear_intrbits_slave() once
>      i2c: designware: slave should do WRITE_REQUESTED before WRITE_RECEIV=
ED
>
>Micha=C5=82 Miros=C5=82aw (1):
>      regulator: defer probe when trying to get voltage from unresolved su=
pply
>
>Mike Galbraith (1):
>      futex: Handle transient "ownerless" rtmutex state correctly
>
>Mike Kravetz (1):
>      hugetlb_cgroup: fix reservation accounting
>
>Mike Travis (3):
>      x86/platform/uv: Fix missing OEM_TABLE_ID
>      x86/platform/uv: Remove spaces from OEM IDs
>      x86/platform/uv: Recognize UV5 hubless system identifier
>
>Namhyung Kim (1):
>      perf tools: Add missing swap for cgroup events
>
>Navid Emamdoost (1):
>      can: xilinx_can: handle failure cases of pm_runtime_get_sync
>
>Niklas Schnelle (1):
>      s390/pci: fix hot-plug of PCI function missing bus
>
>Olaf Hering (1):
>      hv_balloon: disable warning when floor reached
>
>Oleg Nesterov (1):
>      ptrace: fix task_join_group_stop() for the case when current is trac=
ed
>
>Oleksij Rempel (3):
>      dt-bindings: can: add can-controller.yaml
>      dt-bindings: can: flexcan: convert fsl,*flexcan bindings to yaml
>      can: can_create_echo_skb(): fix echo skb generation: always use
>skb_clone()
>
>Oliver Hartkopp (2):
>      can: dev: __can_get_echo_skb(): fix real payload length return
>value for RTR frames
>      can: isotp: isotp_rcv_cf(): enable RX timeout handling in listen-onl=
y mode
>
>Olivier Moysan (1):
>      ASoC: cs42l51: manage mclk shutdown delay
>
>Pablo Neira Ayuso (2):
>      netfilter: nftables: fix netlink report logic in flowtable and genid
>      netfilter: nf_tables: missing validation from the abort path
>
>Palmer Dabbelt (1):
>      RISC-V: Fix the VDSO symbol generaton for binutils-2.35+
>
>Parav Pandit (1):
>      RDMA: Fix software RDMA drivers for dma mapping error
>
>Pavel Begunkov (3):
>      io_uring: fix overflowed cancel w/ linked ->files
>      io_uring: don't forget to task-cancel drained reqs
>      io_uring: fix link lookup racing with link timeout
>
>Peter Ujfalusi (3):
>      dt-bindings: irqchip: ti, sci-inta: Update for unmapped event handli=
ng
>      irqchip/ti-sci-inta: Add support for unmapped event handling
>      dt-bindings: irqchip: ti, sci-inta: Fix diagram indentation for
>unmapped events
>
>Peter Zijlstra (1):
>      perf tools: Remove broken __no_tail_call attribute
>
>Petr Malat (1):
>      sctp: Fix COMM_LOST/CANT_STR_ASSOC err reporting on big-endian platf=
orms
>
>Philipp Zabel (9):
>      gpu: ipu-v3: remove unused functions
>      drm/imx: dw_hdmi-imx: use imx_drm_encoder_parse_of
>      drm/imx: imx-tve: use regmap fast_io spinlock
>      drm/imx: imx-tve: remove redundant enable tracking
>      drm/imx: drop explicit drm_mode_config_cleanup
>      drm/imx: dw_hdmi-imx: remove empty encoder_disable callback
>      drm/imx: imx-ldb: reduce scope of edid_len
>      drm/imx: parallel-display: remove unused function enc_to_imxpd()
>      drm/imx: parallel-display: reduce scope of edid_len
>
>Prike Liang (4):
>      drm/amdgpu: add green_sardine support for gpu_info and ip block
>setting (v2)
>      drm/amdgpu: add soc15 common ip block support for green_sardine (v3)
>      drm/amdgpu: add gfx support for green_sardine (v2)
>      drm/amdgpu/sdma: add sdma engine support for green_sardine (v2)
>
>Qian Cai (3):
>      powerpc/eeh_cache: Fix a possible debugfs deadlock
>      powerpc/smp: Call rcu_cpu_starting() earlier
>      s390/smp: move rcu_cpu_starting() earlier
>
>Qii Wang (1):
>      i2c: mediatek: move dma reset before i2c reset
>
>Qinglang Miao (1):
>      serial: txx9: add missing platform_driver_unregister() on error
>in serial_txx9_init
>
>Qiujun Huang (2):
>      tracing: Fix out of bounds write in get_trace_buf
>      tracing: Fix the checking of stackidx in __ftrace_trace_stack
>
>Rafael J. Wysocki (3):
>      PM: runtime: Drop runtime PM references to supplier on link removal
>      PM: runtime: Drop pm_runtime_clean_up_links()
>      PM: runtime: Resume the device earlier in __device_release_driver()
>
>Rajat Jain (1):
>      PCI: Always enable ACS even if no ACS Capability
>
>Ralph Campbell (1):
>      mm/mremap_pages: fix static key devmap_managed_key updates
>
>Ran Wang (1):
>      usb: gadget: fsl: fix null pointer checking
>
>Rob Herring (2):
>      PCI: dwc: Restore ATU memory resource setup to use last entry
>      PCI: mvebu: Fix duplicate resource requests
>
>Robert Marko (1):
>      MAINTAINERS: Add entry for Qualcomm IPQ4019 VQMMC regulator
>
>Roman Gushchin (1):
>      mm: memcg: link page counters to root if use_hierarchy is false
>
>Roman Li (2):
>      drm/amd/display: Add green_sardine support to DC
>      drm/amd/display: Add green_sardine support to DM
>
>Ryan Kosta (1):
>      risc-v: kernel: ftrace: Fixes improper SPDX comment style
>
>Sagi Grimberg (2):
>      nvme-rdma: avoid repeated request completion
>      nvme-tcp: avoid repeated request completion
>
>Sascha Hauer (1):
>      spi: imx: fix runtime pm support for !CONFIG_PM
>
>Scott Cheloha (1):
>      powerpc/numa: Fix build when CONFIG_NUMA=3Dn
>
>Sean Anderson (1):
>      riscv: Set text_offset correctly for M-Mode
>
>SeongJae Park (1):
>      Documentation: kunit: Update Kconfig parts for KUNIT's module support
>
>Shannon Nelson (1):
>      ionic: check port ptr before use
>
>Shijie Luo (1):
>      mm: mempolicy: fix potential pte_unmap_unlock pte error
>
>Soheil Hassas Yeganeh (1):
>      epoll: add a selftest for epoll timeout race
>
>Song Liu (1):
>      perf hists browser: Increase size of 'buf' in perf_evsel__hists_brow=
se()
>
>Sreekanth Reddy (1):
>      scsi: mpt3sas: Fix timeouts observed while reenabling IRQ
>
>Srinivas Kandagatla (4):
>      ASoC: codecs: wsa881x: add missing stream rates and format
>      ASoC: qcom: sdm845: set driver name correctly
>      ASoC: codecs: wcd934x: Set digital gain range correctly
>      ASoC: codecs: wcd9335: Set digital gain range correctly
>
>Stanislav Ivanichkin (1):
>      perf trace: Fix segfault when trying to trace events by cgroup
>
>Stefano Brivio (1):
>      netfilter: ipset: Update byte and packet counters regardless of
>whether they match
>
>Stephane Grosjean (2):
>      can: peak_usb: peak_usb_get_ts_time(): fix timestamp wrapping
>      can: peak_canfd: pucan_handle_can_rx(): fix echo management when
>loopback is on
>
>Steven Price (1):
>      drm/panfrost: Fix module unload
>
>Steven Rostedt (VMware) (6):
>      selftests/ftrace: Use $FUNCTION_FORK to reference kernel fork functi=
on
>      ftrace: Fix recursion check for NMI test
>      ftrace: Handle tracing when switching between context
>      ring-buffer: Fix recursion protection transitions between
>interrupt context
>      tracing: Make -ENOMEM the default error for parse_synth_field()
>      kprobes: Tell lockdep about kprobe nesting
>
>Sukadev Bhattiprolu (1):
>      powerpc/vnic: Extend "failover pending" window
>
>Suravee Suthikulpanit (1):
>      iommu/amd: Increase interrupt remapping table limit to 512 entries
>
>Thinh Nguyen (1):
>      usb: dwc3: ep0: Fix delay status handling
>
>Thomas Gleixner (1):
>      entry: Fix the incorrect ordering of lockdep and RCU check
>
>Thong Thai (1):
>      drm/amdgpu: enable vcn support for green_sardine (v2)
>
>Tom Rix (2):
>      powercap/intel_rapl: remove unneeded semicolon
>      can: mcp251xfd: remove unneeded break
>
>Tomasz Figa (1):
>      ASoC: Intel: kbl_rt5663_max98927: Fix kabylake_ssp_fixup function
>
>Tommi Rantala (12):
>      selftests: filter kselftest headers from command in lib.mk
>      selftests: pidfd: fix compilation errors due to wait.h
>      selftests/harness: prettify SKIP message whitespace again
>      selftests: pidfd: use ksft_test_result_skip() when skipping test
>      selftests: pidfd: skip test on kcmp() ENOSYS
>      selftests: pidfd: add CONFIG_CHECKPOINT_RESTORE=3Dy to config
>      selftests: pidfd: drop needless linux/kcmp.h inclusion in
>pidfd_setns_test.c
>      perf tools: Fix crash with non-jited bpf progs
>      selftests: proc: fix warning: _GNU_SOURCE redefined
>      selftests: core: use SKIP instead of XFAIL in close_range_test.c
>      selftests: clone3: use SKIP instead of XFAIL
>      selftests: binderfs: use SKIP instead of XFAIL
>
>Tyler Hicks (1):
>      tpm: efi: Don't create binary_bios_measurements file for an empty log
>
>Tzung-Bi Shih (1):
>      ASoC: mediatek: mt8183-da7219: fix DAPM paths for rt1015
>
>Ulrich Hecht (1):
>      i2c: sh_mobile: implement atomic transfers
>
>V Sujith Kumar Reddy (2):
>      ASoC: qcom: lpass-sc7180: Fix MI2S bitwidth field bit positions
>      ASoC: qcom: lpass-cpu: Fix clock disable failure
>
>Vanshidhar Konda (1):
>      arm64: NUMA: Kconfig: Increase NODES_SHIFT to 4
>
>Vasily Gorbik (1):
>      lib/crc32test: remove extra local_irq_disable/enable
>
>Veerabadhran Gopalakrishnan (1):
>      amd/amdgpu: Disable VCN DPG mode for Picasso
>
>Vinay Kumar Yadav (2):
>      chelsio/chtls: fix memory leaks caused by a race
>      chelsio/chtls: fix always leaking ctrl_skb
>
>Vincent Mailhol (1):
>      can: dev: can_get_echo_skb(): prevent call to kfree_skb() in
>hard IRQ context
>
>Vineet Gupta (2):
>      ARC: stack unwinding: avoid indefinite looping
>      ARC: [plat-hsdk] Remap CCMs super early in asm boot trampoline
>
>Viresh Kumar (4):
>      opp: Don't always remove static OPPs in _of_add_opp_table_v1()
>      opp: Fix early exit from dev_pm_opp_register_set_opp_helper()
>      opp: Reduce the size of critical section in _opp_table_kref_release()
>      cpufreq: schedutil: Don't skip freq update if need_freq_update is set
>
>Wilken Gottwalt (1):
>      documentation: arm: sunxi: add Allwinner H6 documents
>
>Wong Vee Khee (1):
>      stmmac: intel: Fix kernel panic on pci probe
>
>Xin Long (1):
>      xfrm: interface: fix the priorities for ipip and ipv6 tunnels
>
>Ye Bin (1):
>      cfg80211: regulatory: Fix inconsistent format argument
>
>Yegor Yefremov (4):
>      can: j1939: rename jacd tool
>      can: j1939: fix syntax and spelling
>      can: j1939: swap addr and pgn in the send example
>      can: j1939: use backquotes for code samples
>
>YueHaibing (1):
>      sfp: Fix error handing in sfp_probe()
>Aaron Liu (1):
>      drm/amdgpu: enable green_sardine_asd.bin loading (v2)
>
>Adit Ranadive (1):
>      RDMA/vmw_pvrdma: Fix the active_speed and phys_state value
>
>Alan Stern (1):
>      USB: Add NO_LPM quirk for Kingston flash drive
>
>Alex Deucher (4):
>      drm/amdgpu/powerplay: Only apply optimized mclk dpm policy on polaris
>      drm/amdgpu/swsmu: remove duplicate call to smu_set_default_dpm_table
>      drm/amdgpu: add Green_Sardine APU flag
>      drm/amdgpu/display: remove DRM_AMD_DC_GREEN_SARDINE
>
>Alex Williamson (1):
>      vfio/pci: Implement ioeventfd thread handler for contended memory lo=
ck
>
>Alexander Aring (1):
>      gfs2: Wake up when sd_glock_disposal becomes zero
>
>Alexander Ovechkin (1):
>      ip6_tunnel: set inner ipproto before ip6_tnl_encap
>
>Alexander Sverdlin (1):
>      mtd: spi-nor: Don't copy self-pointing struct around
>
>Anand K Mistry (1):
>      x86/speculation: Allow IBPB to be conditionally enabled on CPUs
>with always-on STIBP
>
>Andreas Gruenbacher (1):
>      gfs2: Don't call cancel_delayed_work_sync from within delete work fu=
nction
>
>Andrey Konovalov (1):
>      kasan: adopt KUNIT tests to SW_TAGS mode
>
>Andy Shevchenko (1):
>      kunit: Don't fail test suites if one of them is empty
>
>Anup Patel (1):
>      RISC-V: Use non-PGD mappings for early DTB access
>
>Ard Biesheuvel (1):
>      ARM, xtensa: highmem: avoid clobbering non-page aligned memory
>reservations
>
>Arnaldo Carvalho de Melo (14):
>      perf tools: Update copy of libbpf's hashmap.c
>      tools headers UAPI: Update process_madvise affected files
>      perf scripting python: Avoid declaring function pointers with a
>visibility attribute
>      tools headers UAPI: Sync prctl.h with the kernel sources
>      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
>      tools headers UAPI: Update fscrypt.h copy
>      tools x86 headers: Update cpufeatures.h headers copies
>      tools x86 headers: Update required-features.h header from the kernel
>      tools arch x86: Sync the msr-index.h copy with the kernel sources
>      tools UAPI: Update copy of linux/mman.h from the kernel sources
>      tools kvm headers: Update KVM headers from the kernel sources
>      tools headers UAPI: Update tools's copy of linux/perf_event.h
>      tools include UAPI: Update linux/mount.h copy
>      tools feature: Fixup fast path feature detection
>
>Arnd Bergmann (2):
>      ALSA: make snd_kcontrol_new name a normal string
>      drm/imx: tve remove extraneous type qualifier
>
>Artem Lapkin (1):
>      ALSA: usb-audio: add usb vendor id as DSD-capable for Khadas devices
>
>Atish Patra (1):
>      RISC-V: Remove any memblock representing unusable memory area
>
>Bard Liao (1):
>      ASoC: SOF: loader: handle all SOF_IPC_EXT types
>
>Benjamin Gwin (1):
>      arm64: kexec_file: try more regions if loading segments fails
>
>Bert Vermeulen (1):
>      mtd: spi-nor: Fix address width on flash chips > 16MB
>
>Bob Peterson (6):
>      gfs2: Free rd_bits later in gfs2_clear_rgrpd to fix use-after-free
>      gfs2: Add missing truncate_inode_pages_final for sd_aspace
>      gfs2: init_journal's undo directive should also undo the statfs inod=
es
>      gfs2: Split up gfs2_meta_sync into inode and rgrp versions
>      gfs2: don't initialize statfs_change inodes in spectator mode
>      gfs2: check for live vs. read-only file system in gfs2_fitrim
>
>Boris Brezillon (1):
>      drm/panfrost: Fix a deadlock between the shrinker and madvise path
>
>Brendan Higgins (1):
>      kunit: tools: fix kunit_tool tests for parsing test plans
>
>Brian Foster (3):
>      xfs: flush new eof page on truncate to avoid post-eof corruption
>      iomap: support partial page discard on writeback block mapping failu=
re
>      iomap: clean up writeback state logic on writepage error
>
>Camelia Groza (2):
>      dpaa_eth: update the buffer layout for non-A050385 erratum scenarios
>      dpaa_eth: fix the RX headroom size alignment
>
>Cezary Rojewski (3):
>      ASoC: Intel: atom: Remove duplicate kconfigs
>      ASoC: Intel: catpt: Wake up device before configuring SSP port
>      ASoC: Intel: catpt: Relax clock selection conditions
>
>Changbin Du (1):
>      riscv: uaccess: fix __put_kernel_nofault()
>
>Chao Leng (3):
>      nvme: introduce nvme_sync_io_queues
>      nvme-rdma: avoid race between time out and tear down
>      nvme-tcp: avoid race between time out and tear down
>
>Charles Haithcock (1):
>      mm, oom: keep oom_adj under or at upper limit when printing
>
>Chris Wilson (5):
>      drm/i915/gem: Flush coherency domains on first set-domain-ioctl
>      drm/i915/gt: Use the local HWSP offset during submission
>      drm/i915/gt: Expose more parameters for emitting writes into the ring
>      drm/i915/gt: Flush xcs before tgl breadcrumbs
>      drm/i915: Hold onto an explicit ref to i915_vma_work.pinned
>
>Christoph Hellwig (5):
>      seq_file: add seq_read_iter
>      proc: wire up generic_file_splice_read for iter ops
>      proc/cpuinfo: switch to ->read_iter
>      proc/stat: switch to ->read_iter
>      proc "seq files": switch to ->read_iter
>
>Christophe Kerello (1):
>      mtd: rawnand: stm32_fmc2: fix broken ECC
>
>Christophe Leroy (4):
>      powerpc/603: Always fault when _PAGE_ACCESSED is not set
>      powerpc/40x: Always fault when _PAGE_ACCESSED is not set
>      powerpc/8xx: Always fault when _PAGE_ACCESSED is not set
>      powerpc/8xx: Manage _PAGE_ACCESSED through APG bits in L1 entry
>
>Claire Chang (1):
>      serial: 8250_mtk: Fix uart_get_baud_rate warning
>
>Claudiu Manoil (2):
>      gianfar: Replace skb_realloc_headroom with skb_cow_head for PTP
>      gianfar: Account for Tx PTP timestamp in the skb headroom
>
>Codrin Ciubotariu (1):
>      ASoC: mchp-spdiftx: Do not set Validity bit(s)
>
>Colin Ian King (3):
>      selftests/ftrace: check for do_sys_openat2 in user-memory test
>      net: atm: fix update of position index in lec_seq_next
>      can: isotp: padlen(): make const array static, makes object smaller
>
>Colin Xu (4):
>      drm/i915/gvt: Allow zero out HWSP addr on hws_pga_write
>      drm/i915/gvt: Set SNOOP for PAT3 on BXT/APL to workaround GPU BB hang
>      drm/i915/gvt: Only pin/unpin intel_context along with workload
>      drm/i915/gvt: Fix mmio handler break on BXT/APL.
>
>Damien Le Moal (1):
>      null_blk: Fix scheduling in atomic with zoned mode
>
>Dan Carpenter (5):
>      vfio/fsl-mc: return -EFAULT if copy_to_user() fails
>      ALSA: hda: prevent undefined shift in snd_hdac_ext_bus_get_link()
>      iommu: Fix a check in iommu_check_bind_data()
>      vfio/fsl-mc: prevent underflow in vfio_fsl_mc_mmap()
>      can: peak_usb: add range checking in decode operations
>
>Daniel Vetter (1):
>      vt: Disable KD_FONT_OP_COPY
>
>Daniele Palmas (3):
>      net: usb: qmi_wwan: add Telit LE910Cx 0x1230 composition
>      USB: serial: option: add LE910Cx compositions 0x1203, 0x1230, 0x1231
>      USB: serial: option: add Telit FN980 composition 0x1055
>
>Darrick J. Wong (4):
>      xfs: set xefi_discard when creating a deferred agfl free log intent =
item
>      xfs: fix missing CoW blocks writeback conversion retry
>      xfs: fix scrub flagging rtinherit even if there is no rt device
>      xfs: only flush the unshared range in xfs_reflink_unshare
>
>David Gow (1):
>      kunit: Fix kunit.py --raw_output option
>
>David Howells (2):
>      afs: Fix warning due to unadvanced marshalling pointer
>      afs: Fix incorrect freeing of the ACL passed to the YFS ACL store op
>
>Davide Caratti (1):
>      mptcp: token: fix unititialized variable
>
>Diana Craciun (1):
>      vfio/fsl-mc: Make vfio_fsl_mc_irqs_allocate static
>
>Eddy Wu (1):
>      fork: fix copy_process(CLONE_PARENT) race with the exiting ->real_pa=
rent
>
>Eelco Chaudron (1):
>      net: openvswitch: silence suspicious RCU usage warning
>
>Evan Quan (5):
>      drm/amdgpu: perform srbm soft reset always on SDMA resume
>      drm/amd/pm: correct the baco reset sequence for CI ASICs
>      drm/amd/pm: enable baco reset for Hawaii
>      drm/amd/pm: perform SMC reset on suspend/hibernation
>      drm/amd/pm: do not use ixFEATURE_STATUS for checking smc running
>
>Evgeny Novikov (1):
>      usb: gadget: goku_udc: fix potential crashes in probe
>
>Fabio Estevam (2):
>      mtd: rawnand: mxc: Move the ECC engine initialization to the right p=
lace
>      mtd: rawnand: ifc: Move the ECC engine initialization to the right p=
lace
>
>Fabrice Gasnier (1):
>      irqchip/stm32-exti: Add all LP timer exti direct events support
>
>Fangrui Song (1):
>      x86/lib: Change .weak to SYM_FUNC_START_WEAK for arch/x86/lib/mem*_6=
4.S
>
>Flora Cui (2):
>      drm/amdgpu: disable DCN and VCN for Navi14 0x7340/C9 SKU
>      drm/amdgpu: rename nv_is_headless_sku()
>
>Fred Gao (1):
>      vfio/pci: Bypass IGD init in case of -ENODEV
>
>Geert Uytterhoeven (5):
>      irqchip/mst: MST_IRQ should depend on ARCH_MEDIATEK or ARCH_MSTARV7
>      irqchip/renesas-intc-irqpin: Merge irlm_bit and needs_irlm
>      of: Drop superfluous ULL suffix for ~0
>      can: isotp: Explain PDU in CAN_ISOTP help text
>      i2c: mlxbf: I2C_MLXBF should depend on MELLANOX_PLATFORM
>
>Geoffrey D. Bennett (2):
>      ALSA: usb-audio: Add implicit feedback quirk for MODX
>      ALSA: usb-audio: Add implicit feedback quirk for Qu-16
>
>Gerald Schaefer (1):
>      s390/mm: make pmd/pud_deref() large page aware
>
>Greentime Hu (2):
>      irqchip/sifive-plic: Fix broken irq_set_affinity() callback
>      irqchip/sifive-plic: Fix chip_data access within a hierarchy
>
>Greg Kroah-Hartman (2):
>      Documentation: remove mic/index from misc-devices/index.rst
>      proc "single files": switch to ->read_iter
>
>Greg Ungerer (1):
>      net: fec: fix MDIO probing for some FEC hardware blocks
>
>Grygorii Strashko (1):
>      net: ethernet: ti: cpsw: disable PTPv1 hw timestamping advertisement
>
>Hangbin Liu (2):
>      ICMPv6: Add ICMPv6 Parameter Problem, code 3 definition
>      IPv6: reply ICMP error if the first fragment don't include all heade=
rs
>
>Hannes Reinecke (1):
>      scsi: scsi_dh_alua: Avoid crash during alua_bus_detach()
>
>Harald Freudenberger (2):
>      s390/ap: fix ap devices reference counting
>      s390/pkey: fix paes selftest failure with paes and pkey static build
>
>Heikki Krogerus (1):
>      usb: dwc3: pci: add support for the Intel Alder Lake-S
>
>Heiko Carstens (3):
>      s390/vdso: remove empty unused file
>      s390/vdso: remove unused constants
>      s390: update defconfigs
>
>Heiner Kallweit (1):
>      r8169: work around short packet hw bug on RTL8125
>
>Imre Deak (1):
>      drm/i915: Fix encoder lookup during PSR atomic check
>
>Jason A. Donenfeld (2):
>      wireguard: selftests: check that route_me_harder packets use the rig=
ht sk
>      netfilter: use actual socket sk rather than skb sk when routing hard=
er
>
>Jason Gunthorpe (2):
>      mm: always have io_remap_pfn_range() set pgprot_decrypted()
>      RDMA/srpt: Fix typo in srpt_unregister_mad_agent docstring
>
>Jason Yan (1):
>      mm/truncate.c: make __invalidate_mapping_pages() static
>
>Jean-Philippe Brucker (1):
>      arm64: kprobes: Use BRK instead of single-step when executing
>instructions out-of-line
>
>Jeff Layton (1):
>      ceph: check session state after bumping session->s_seq
>
>Jens Axboe (5):
>      io-wq: cancel request if it's asking for files and we don't have them
>      io_uring: properly handle SQPOLL request cancelations
>      io_uring: ensure consistent view of original task ->mm from SQPOLL
>      io_uring: drop req/tctx io_identity separately
>      io_uring: use correct pointer for io_uring_show_cred()
>
>Jerry Snitselaar (1):
>      tpm_tis: Disable interrupts on ThinkPad T490s
>
>Jin Yao (1):
>      perf vendor events: Fix DRAM_BW_Use 0 issue for CLX/SKX
>
>Jiri Olsa (2):
>      perf tools: Initialize output buffer in build_id__sprintf
>      perf tools: Add missing swap for ino_generation
>
>Joakim Zhang (4):
>      can: flexcan: remove FLEXCAN_QUIRK_DISABLE_MECR quirk for LS1021A
>      can: flexcan: add ECC initialization for LX2160A
>      can: flexcan: add ECC initialization for VF610
>      can: flexcan: flexcan_remove(): disable wakeup completely
>
>Joe Perches (1):
>      MAINTAINERS: Update AMD POWERPLAY pattern
>
>Joerg Roedel (5):
>      x86/boot/compressed/64: Introduce sev_status
>      x86/boot/compressed/64: Sanity-check CPUID results in the early
>#VC handler
>      x86/boot/compressed/64: Check SEV encryption in 64-bit boot-path
>      x86/head/64: Check SEV encryption before switching to kernel page-ta=
ble
>      x86/sev-es: Do not support MMIO to/from encrypted memory
>
>Johan Hovold (1):
>      USB: serial: cyberjack: fix write-URB completion race
>
>Johannes Berg (4):
>      mac80211: fix use of skb payload instead of header
>      cfg80211: initialize wdev data earlier
>      mac80211: always wind down STA state
>      mac80211: don't require VHT elements for HE on 2.4 GHz
>
>John Clements (1):
>      drm/amdgpu: resolved ASD loading issue on sienna
>
>Jonathan Corbet (1):
>      docs: fix automarkup regression on Python 2
>
>Jonathan McDowell (1):
>      net: dsa: qca8k: Fix port MTU setting
>
>Julia Lawall (2):
>      Documentation: PM: cpuidle: correct typo
>      Documentation: PM: cpuidle: correct path name
>
>Justin M. Forbes (1):
>      perf tools: Remove LTO compiler options when building perl support
>
>Kai-Heng Feng (3):
>      ALSA: hda: Refactor codec PM to use direct-complete optimization
>      ALSA: hda: Separate runtime and system suspend
>      ALSA: hda: Reinstate runtime_allow() for all hda controllers
>
>Kailang Yang (2):
>      ALSA: hda/realtek - Fixed HP headset Mic can't be detected
>      ALSA: hda/realtek - Enable headphone for ASUS TM420
>
>Keita Suzuki (1):
>      scsi: hpsa: Fix memory leak in hpsa_init_one()
>
>Keith Busch (1):
>      Revert "nvme-pci: remove last_sq_tail"
>
>Keith Winstein (1):
>      ALSA: usb-audio: Add implicit feedback quirk for Zoom UAC-2
>
>Kent Russell (1):
>      amdkfd: Check kvmalloc return before memcpy
>
>Khalil Blaiech (5):
>      i2c: mlxbf: Add CONFIG_ACPI to guard ACPI function call
>      i2c: mlxbf: Fix resrticted cast warning of sparse
>      i2c: mlxbf: Remove unecessary wrapper functions
>      i2c: mlxbf: Update reference clock frequency
>      i2c: mlxbf: Update author and maintainer email info
>
>Lee Jones (1):
>      Fonts: Replace discarded const qualifier
>
>Likun Gao (1):
>      drm/amdgpu: update golden setting for sienna_cichlid
>
>Linus Torvalds (2):
>      tty: make FONTX ioctl use the tty pointer they were actually passed
>      Linux 5.10-rc3
>
>Liu Shaohua (1):
>      riscv: fix pfn_to_virt err in do_page_fault().
>
>Liu Yi L (1):
>      iommu/vt-d: Fix sid not set issue in intel_svm_bind_gpasid()
>
>Liu, Yi L (1):
>      iommu/vt-d: Fix a bug for PDP check in prq_event_thread
>
>Lu Baolu (1):
>      iommu/vt-d: Fix kernel NULL pointer dereference in find_domain()
>
>Lucas Stach (1):
>      tty: serial: imx: enable earlycon by default if
>IMX_SERIAL_CONSOLE is enabled
>
>Lukas Bulwahn (1):
>      kernel/hung_task.c: make type annotations consistent
>
>Macpaul Lin (1):
>      usb: mtu3: fix panic in mtu3_gadget_stop()
>
>Maor Gottlieb (1):
>      IB/srpt: Fix memory leak in srpt_add_one
>
>Marc Kleine-Budde (2):
>      can: rx-offload: don't call kfree_skb() from IRQ context
>      can: mcp251xfd: mcp251xfd_regmap_crc_read(): increase severity
>of CRC read error messages
>
>Marc Zyngier (4):
>      genirq: Let GENERIC_IRQ_IPI select IRQ_DOMAIN_HIERARCHY
>      irqchip/mst: Make mst_intc_of_init static
>      irqchip/mips: Drop selection of IRQ_DOMAIN_HIERARCHY
>      irqchip/bcm2836: Fix missing __init annotation
>
>Marco Felsch (1):
>      drm/imx: parallel-display: fix edid memory leak
>
>Marek Szyprowski (1):
>      net: stmmac: Fix channel lock initialization
>
>Mark Deneen (1):
>      cadence: force nonlinear buffers to be cloned
>
>Martin Blumenstingl (1):
>      usb: dwc2: Avoid leaving the error_debugfs label unused
>
>Martin Hundeb=C3=B8ll (2):
>      spi: bcm2835: fix gpio cs level inversion
>      spi: bcm2835: remove use of uninitialized gpio flags variable
>
>Mathy Vanhoef (1):
>      mac80211: fix regression where EAPOL frames were sent in plaintext
>
>Matthias Reichl (1):
>      tty: fix crash in release_tty if tty->port is not set
>
>Mauro Carvalho Chehab (35):
>      ALSA: fix kernel-doc markups
>      kunit: test: fix remaining kernel-doc warnings
>      docs: Makefile: honor V=3D0 for docs building
>      scripts: kernel-doc: fix typedef parsing
>      scripts: kernel-doc: split typedef complex regex
>      scripts: kernel-doc: use :c:union when needed
>      sphinx: conf.py: properly handle Sphinx 4.0
>      docs: hwmon: adm1266.rst: fix a broken reference
>      docs: admin-guide: net.rst: add a missing blank line
>      docs: kasan.rst: add two missing blank lines
>      docs: net: statistics.rst: remove a duplicated kernel-doc
>      docs: hwmon: mp2975.rst: address some html build warnings
>      docs: userspace-api: add iommu.rst to the index file
>      blk-mq: docs: add kernel-doc description for a new struct member
>      mm: pagemap.h: fix two kernel-doc markups
>      net: phy: remove kernel-doc duplication
>      crypto: sun8x-ce*: update entries to its documentation
>      ice: docs fix a devlink info that broke a table
>      MAINTAINERS: fix broken doc refs due to yaml conversion
>      docs: lockdep-design: fix some warning issues
>      locking/refcount: move kernel-doc markups to the proper place
>      IB/srpt: docs: add a description for cq_size member
>      docs: fs: api-summary.rst: get rid of kernel-doc include
>      drm: amdgpu: kernel-doc: update some adev parameters
>      gpu: docs: amdgpu.rst: get rid of wrong kernel-doc markups
>      drm: amdgpu_dm: fix a typo
>      selftests: kselftest_harness.h: fix kernel-doc markups
>      amdgpu: fix a few kernel-doc markup issues
>      docs: SafeSetID: fix a warning
>      mac80211: fix kernel-doc markups
>      docs: ABI: sysfs-driver-dma-ioatdma: what starts with /sys
>      docs: ABI: sysfs-class-net: fix a typo
>      docs: leds: index.rst: add a missing file
>      scripts: get_abi.pl: Don't let ABI files to create subtitles
>      scripts: get_api.pl: Add sub-titles to ABI output
>
>Maxime Ripard (7):
>      drm/vc4: bo: Add a managed action to cleanup the cache
>      drm/vc4: drv: Use managed drm_mode_config_init
>      drm/vc4: gem: Add a managed action to cleanup the job queue
>      drm/vc4: Use the helper to retrieve vc4_dev when needed
>      drm/vc4: Use devm_drm_dev_alloc
>      drm/vc4: kms: Add functions to create the state objects
>      drm/vc4: drv: Remove unused variable
>
>Michael Ellerman (1):
>      powerpc: Use asm_goto_volatile for put_user()
>
>Michael Kelley (1):
>      x86/hyperv: Clarify comment on x2apic mode
>
>Michael Wu (2):
>      i2c: designware: call i2c_dw_read_clear_intrbits_slave() once
>      i2c: designware: slave should do WRITE_REQUESTED before WRITE_RECEIV=
ED
>
>Micha=C5=82 Miros=C5=82aw (1):
>      regulator: defer probe when trying to get voltage from unresolved su=
pply
>
>Mike Galbraith (1):
>      futex: Handle transient "ownerless" rtmutex state correctly
>
>Mike Kravetz (1):
>      hugetlb_cgroup: fix reservation accounting
>
>Mike Travis (3):
>      x86/platform/uv: Fix missing OEM_TABLE_ID
>      x86/platform/uv: Remove spaces from OEM IDs
>      x86/platform/uv: Recognize UV5 hubless system identifier
>
>Namhyung Kim (1):
>      perf tools: Add missing swap for cgroup events
>
>Navid Emamdoost (1):
>      can: xilinx_can: handle failure cases of pm_runtime_get_sync
>
>Niklas Schnelle (1):
>      s390/pci: fix hot-plug of PCI function missing bus
>
>Olaf Hering (1):
>      hv_balloon: disable warning when floor reached
>
>Oleg Nesterov (1):
>      ptrace: fix task_join_group_stop() for the case when current is trac=
ed
>
>Oleksij Rempel (3):
>      dt-bindings: can: add can-controller.yaml
>      dt-bindings: can: flexcan: convert fsl,*flexcan bindings to yaml
>      can: can_create_echo_skb(): fix echo skb generation: always use
>skb_clone()
>
>Oliver Hartkopp (2):
>      can: dev: __can_get_echo_skb(): fix real payload length return
>value for RTR frames
>      can: isotp: isotp_rcv_cf(): enable RX timeout handling in listen-onl=
y mode
>
>Olivier Moysan (1):
>      ASoC: cs42l51: manage mclk shutdown delay
>
>Pablo Neira Ayuso (2):
>      netfilter: nftables: fix netlink report logic in flowtable and genid
>      netfilter: nf_tables: missing validation from the abort path
>
>Palmer Dabbelt (1):
>      RISC-V: Fix the VDSO symbol generaton for binutils-2.35+
>
>Parav Pandit (1):
>      RDMA: Fix software RDMA drivers for dma mapping error
>
>Pavel Begunkov (3):
>      io_uring: fix overflowed cancel w/ linked ->files
>      io_uring: don't forget to task-cancel drained reqs
>      io_uring: fix link lookup racing with link timeout
>
>Peter Ujfalusi (3):
>      dt-bindings: irqchip: ti, sci-inta: Update for unmapped event handli=
ng
>      irqchip/ti-sci-inta: Add support for unmapped event handling
>      dt-bindings: irqchip: ti, sci-inta: Fix diagram indentation for
>unmapped events
>
>Peter Zijlstra (1):
>      perf tools: Remove broken __no_tail_call attribute
>
>Petr Malat (1):
>      sctp: Fix COMM_LOST/CANT_STR_ASSOC err reporting on big-endian platf=
orms
>
>Philipp Zabel (9):
>      gpu: ipu-v3: remove unused functions
>      drm/imx: dw_hdmi-imx: use imx_drm_encoder_parse_of
>      drm/imx: imx-tve: use regmap fast_io spinlock
>      drm/imx: imx-tve: remove redundant enable tracking
>      drm/imx: drop explicit drm_mode_config_cleanup
>      drm/imx: dw_hdmi-imx: remove empty encoder_disable callback
>      drm/imx: imx-ldb: reduce scope of edid_len
>      drm/imx: parallel-display: remove unused function enc_to_imxpd()
>      drm/imx: parallel-display: reduce scope of edid_len
>
>Prike Liang (4):
>      drm/amdgpu: add green_sardine support for gpu_info and ip block
>setting (v2)
>      drm/amdgpu: add soc15 common ip block support for green_sardine (v3)
>      drm/amdgpu: add gfx support for green_sardine (v2)
>      drm/amdgpu/sdma: add sdma engine support for green_sardine (v2)
>
>Qian Cai (3):
>      powerpc/eeh_cache: Fix a possible debugfs deadlock
>      powerpc/smp: Call rcu_cpu_starting() earlier
>      s390/smp: move rcu_cpu_starting() earlier
>
>Qii Wang (1):
>      i2c: mediatek: move dma reset before i2c reset
>
>Qinglang Miao (1):
>      serial: txx9: add missing platform_driver_unregister() on error
>in serial_txx9_init
>
>Qiujun Huang (2):
>      tracing: Fix out of bounds write in get_trace_buf
>      tracing: Fix the checking of stackidx in __ftrace_trace_stack
>
>Rafael J. Wysocki (3):
>      PM: runtime: Drop runtime PM references to supplier on link removal
>      PM: runtime: Drop pm_runtime_clean_up_links()
>      PM: runtime: Resume the device earlier in __device_release_driver()
>
>Rajat Jain (1):
>      PCI: Always enable ACS even if no ACS Capability
>
>Ralph Campbell (1):
>      mm/mremap_pages: fix static key devmap_managed_key updates
>
>Ran Wang (1):
>      usb: gadget: fsl: fix null pointer checking
>
>Rob Herring (2):
>      PCI: dwc: Restore ATU memory resource setup to use last entry
>      PCI: mvebu: Fix duplicate resource requests
>
>Robert Marko (1):
>      MAINTAINERS: Add entry for Qualcomm IPQ4019 VQMMC regulator
>
>Roman Gushchin (1):
>      mm: memcg: link page counters to root if use_hierarchy is false
>
>Roman Li (2):
>      drm/amd/display: Add green_sardine support to DC
>      drm/amd/display: Add green_sardine support to DM
>
>Ryan Kosta (1):
>      risc-v: kernel: ftrace: Fixes improper SPDX comment style
>
>Sagi Grimberg (2):
>      nvme-rdma: avoid repeated request completion
>      nvme-tcp: avoid repeated request completion
>
>Sascha Hauer (1):
>      spi: imx: fix runtime pm support for !CONFIG_PM
>
>Scott Cheloha (1):
>      powerpc/numa: Fix build when CONFIG_NUMA=3Dn
>
>Sean Anderson (1):
>      riscv: Set text_offset correctly for M-Mode
>
>SeongJae Park (1):
>      Documentation: kunit: Update Kconfig parts for KUNIT's module support
>
>Shannon Nelson (1):
>      ionic: check port ptr before use
>
>Shijie Luo (1):
>      mm: mempolicy: fix potential pte_unmap_unlock pte error
>
>Soheil Hassas Yeganeh (1):
>      epoll: add a selftest for epoll timeout race
>
>Song Liu (1):
>      perf hists browser: Increase size of 'buf' in perf_evsel__hists_brow=
se()
>
>Sreekanth Reddy (1):
>      scsi: mpt3sas: Fix timeouts observed while reenabling IRQ
>
>Srinivas Kandagatla (4):
>      ASoC: codecs: wsa881x: add missing stream rates and format
>      ASoC: qcom: sdm845: set driver name correctly
>      ASoC: codecs: wcd934x: Set digital gain range correctly
>      ASoC: codecs: wcd9335: Set digital gain range correctly
>
>Stanislav Ivanichkin (1):
>      perf trace: Fix segfault when trying to trace events by cgroup
>
>Stefano Brivio (1):
>      netfilter: ipset: Update byte and packet counters regardless of
>whether they match
>
>Stephane Grosjean (2):
>      can: peak_usb: peak_usb_get_ts_time(): fix timestamp wrapping
>      can: peak_canfd: pucan_handle_can_rx(): fix echo management when
>loopback is on
>
>Steven Price (1):
>      drm/panfrost: Fix module unload
>
>Steven Rostedt (VMware) (6):
>      selftests/ftrace: Use $FUNCTION_FORK to reference kernel fork functi=
on
>      ftrace: Fix recursion check for NMI test
>      ftrace: Handle tracing when switching between context
>      ring-buffer: Fix recursion protection transitions between
>interrupt context
>      tracing: Make -ENOMEM the default error for parse_synth_field()
>      kprobes: Tell lockdep about kprobe nesting
>
>Sukadev Bhattiprolu (1):
>      powerpc/vnic: Extend "failover pending" window
>
>Suravee Suthikulpanit (1):
>      iommu/amd: Increase interrupt remapping table limit to 512 entries
>
>Thinh Nguyen (1):
>      usb: dwc3: ep0: Fix delay status handling
>
>Thomas Gleixner (1):
>      entry: Fix the incorrect ordering of lockdep and RCU check
>
>Thong Thai (1):
>      drm/amdgpu: enable vcn support for green_sardine (v2)
>
>Tom Rix (2):
>      powercap/intel_rapl: remove unneeded semicolon
>      can: mcp251xfd: remove unneeded break
>
>Tomasz Figa (1):
>      ASoC: Intel: kbl_rt5663_max98927: Fix kabylake_ssp_fixup function
>
>Tommi Rantala (12):
>      selftests: filter kselftest headers from command in lib.mk
>      selftests: pidfd: fix compilation errors due to wait.h
>      selftests/harness: prettify SKIP message whitespace again
>      selftests: pidfd: use ksft_test_result_skip() when skipping test
>      selftests: pidfd: skip test on kcmp() ENOSYS
>      selftests: pidfd: add CONFIG_CHECKPOINT_RESTORE=3Dy to config
>      selftests: pidfd: drop needless linux/kcmp.h inclusion in
>pidfd_setns_test.c
>      perf tools: Fix crash with non-jited bpf progs
>      selftests: proc: fix warning: _GNU_SOURCE redefined
>      selftests: core: use SKIP instead of XFAIL in close_range_test.c
>      selftests: clone3: use SKIP instead of XFAIL
>      selftests: binderfs: use SKIP instead of XFAIL
>
>Tyler Hicks (1):
>      tpm: efi: Don't create binary_bios_measurements file for an empty log
>
>Tzung-Bi Shih (1):
>      ASoC: mediatek: mt8183-da7219: fix DAPM paths for rt1015
>
>Ulrich Hecht (1):
>      i2c: sh_mobile: implement atomic transfers
>
>V Sujith Kumar Reddy (2):
>      ASoC: qcom: lpass-sc7180: Fix MI2S bitwidth field bit positions
>      ASoC: qcom: lpass-cpu: Fix clock disable failure
>
>Vanshidhar Konda (1):
>      arm64: NUMA: Kconfig: Increase NODES_SHIFT to 4
>
>Vasily Gorbik (1):
>      lib/crc32test: remove extra local_irq_disable/enable
>
>Veerabadhran Gopalakrishnan (1):
>      amd/amdgpu: Disable VCN DPG mode for Picasso
>
>Vinay Kumar Yadav (2):
>      chelsio/chtls: fix memory leaks caused by a race
>      chelsio/chtls: fix always leaking ctrl_skb
>
>Vincent Mailhol (1):
>      can: dev: can_get_echo_skb(): prevent call to kfree_skb() in
>hard IRQ context
>
>Vineet Gupta (2):
>      ARC: stack unwinding: avoid indefinite looping
>      ARC: [plat-hsdk] Remap CCMs super early in asm boot trampoline
>
>Viresh Kumar (4):
>      opp: Don't always remove static OPPs in _of_add_opp_table_v1()
>      opp: Fix early exit from dev_pm_opp_register_set_opp_helper()
>      opp: Reduce the size of critical section in _opp_table_kref_release()
>      cpufreq: schedutil: Don't skip freq update if need_freq_update is set
>
>Wilken Gottwalt (1):
>      documentation: arm: sunxi: add Allwinner H6 documents
>
>Wong Vee Khee (1):
>      stmmac: intel: Fix kernel panic on pci probe
>
>Xin Long (1):
>      xfrm: interface: fix the priorities for ipip and ipv6 tunnels
>
>Ye Bin (1):
>      cfg80211: regulatory: Fix inconsistent format argument
>
>Yegor Yefremov (4):
>      can: j1939: rename jacd tool
>      can: j1939: fix syntax and spelling
>      can: j1939: swap addr and pgn in the send example
>      can: j1939: use backquotes for code samples
>
>YueHaibing (1):
>      sfp: Fix error handing in sfp_probe()
>
>Zenghui Yu (1):
>      vfio/type1: Use the new helper to find vfio_group
>
>Zhang Changzhong (3):
>      can: proc: can_remove_proc(): silence remove_proc_entry warning
>      can: j1939: j1939_sk_bind(): return failure if netdev is down
>      can: ti_hecc: ti_hecc_probe(): add missed
>clk_disable_unprepare() in error path
>
>Zhang Qilong (2):
>      vfio: platform: fix reference leak in vfio_platform_open
>      USB: apple-mfi-fastcharge: fix reference leak in apple_mfi_fc_set_pr=
operty
>
>Zhao Qiang (1):
>      spi: fsl-dspi: fix wrong pointer in suspend/resume
>
>Ziyi Cao (1):
>      USB: serial: option: add Quectel EC200T module support
>
>Zqiang (2):
>      usb: raw-gadget: fix memory leak in gadget_setup
>      kthread_worker: prevent queuing delayed work from timer_fn when
>it is being canceled
>
>kernel test robot (1):
>      can: mcp251xfd: mcp251xfd_regmap_nocrc_read(): fix
>semicolon.cocci warnings
>
>kiyin(=E5=B0=B9=E4=BA=AE) (1):
>      perf/core: Fix a memory leak in perf_event_parse_addr_filter()
>
>wenxu (1):
>      ip_tunnel: fix over-mtu packet send fail without
>TUNNEL_DONT_FRAGMENT flags
>
>zhongjiang-ali (1):
>      mm: memcontrol: correct the NR_ANON_THPS counter of hierarchical mem=
cg
>
>zhuoliang zhang (1):
>      net: xfrm: fix a race condition during allocing spi
>
>Zenghui Yu (1):
>      vfio/type1: Use the new helper to find vfio_group
>
>Zhang Changzhong (3):
>      can: proc: can_remove_proc(): silence remove_proc_entry warning
>      can: j1939: j1939_sk_bind(): return failure if netdev is down
>      can: ti_hecc: ti_hecc_probe(): add missed
>clk_disable_unprepare() in error path
>
>Zhang Qilong (2):
>      vfio: platform: fix reference leak in vfio_platform_open
>      USB: apple-mfi-fastcharge: fix reference leak in apple_mfi_fc_set_pr=
operty
>
>Zhao Qiang (1):
>      spi: fsl-dspi: fix wrong pointer in suspend/resume
>
>Ziyi Cao (1):
>      USB: serial: option: add Quectel EC200T module support
>
>Zqiang (2):
>      usb: raw-gadget: fix memory leak in gadget_setup
>      kthread_worker: prevent queuing delayed work from timer_fn when
>it is being canceled
>
>kernel test robot (1):
>      can: mcp251xfd: mcp251xfd_regmap_nocrc_read(): fix
>semicolon.cocci warnings
>
>kiyin(=E5=B0=B9=E4=BA=AE) (1):
>      perf/core: Fix a memory leak in perf_event_parse_addr_filter()
>
>wenxu (1):
>      ip_tunnel: fix over-mtu packet send fail without
>TUNNEL_DONT_FRAGMENT flags
>
>zhongjiang-ali (1):
>      mm: memcontrol: correct the NR_ANON_THPS counter of hierarchical mem=
cg
>
>zhuoliang zhang (1):
>      net: xfrm: fix a race condition during allocing spi

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl+oukIACgkQsjqdtxFL
KRVAhAgAiRjo6ICvhK+JJFRJHgGHIGYlaQCNNyi+coL+1wJNQwO2T8GwY8uLJA47
dlu0Jcoj57UKVH/t2qbO74WLVswgsSfP4NOsayZlm7USba+WLZyQfxjRmd49QOJN
q3JNdUvElcuQ7wzmnL9RijlUPbo57k5Yb9o1miR2W5SvYA6xTFkUUesTIc7CIKhe
aDkTfYzirxfvWjL7NAGfDSnleUHN6h8H7fQ+N2hxlgKcihSvJdLzsUJHS0njTemz
/50oeOdJLzodJZDqgz7BY2ICcObq8jxQt0K3mqevr8RWjLQDSwcz/l8JqIyVFdta
uJnZkrbzU+Qz8OF3D6C5gC/glpRrJw==
=cQ4W
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
