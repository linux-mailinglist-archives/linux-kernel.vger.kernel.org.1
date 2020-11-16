Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572AB2B3ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 02:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgKPA7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 19:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKPA7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 19:59:48 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76F2C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 16:59:47 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id j205so22896640lfj.6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 16:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ik5vgXqj9+RqYejwnOEidb7gHBHGNrgNvl3Vd8yTQmE=;
        b=QoXww43+nXA1UDXGhVUiF6hbdzLYNuzSS/mjK+AaypfrBblI9dEJ2DmlXnV3YIvcrH
         SEnZ6MO0+x+sLPTGIRkbxcQcWPDJ7iaeYJNNlNsPCnxVC5u86o9BNQ4SB87HyZeWWXKT
         J+3E5BmvO2sFcMPqY/2p9yuWZoPF4WFyN2hl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Ik5vgXqj9+RqYejwnOEidb7gHBHGNrgNvl3Vd8yTQmE=;
        b=ZMbvmGfP6JmZA6R1hYndfKn0QdmIL3w3vHSKNAuAjfiZfCZXWo+2OQ2H9JjDAbkKUZ
         DRshRtI60gIaSwfq2PfjsuJ04UJjTCwP188fHYiOUvSPHapyAFhkZkcko+xW6W0+N7Di
         2/93efGrqI5ppdTgG06pIMHJrwYqH1DOOx6MnOCq5jR/D8U6/+sbyuZMZebPpvnFdpLg
         CVB9TFBcbepVLqXgAaSu0KBdEjCmNNrR2wh8CA2cKmcZeiynXbFvh4jZxfz/vP5ruIEW
         RrseWi/dp5EXKEyFqGs3joLz9SDUEgvvDZ926+kgpj6OmHUqyE93u3oOe4Z+iBwCxsL2
         aWZA==
X-Gm-Message-State: AOAM533pU2QsMUqjwFQSYegtjcI8cDX1SXa8UfhkELx2IzZqiLHQjG48
        UQVGLfYXM5n6wpMTF1RawXhbpjD7G398GA==
X-Google-Smtp-Source: ABdhPJwdm5ToNGHLwnGA2cfwA6FxPmmM5V0aCthiX1IrCu5Td8Ch0LCVTqBOGVK/wxwxS7v/TLWh/w==
X-Received: by 2002:a19:c897:: with SMTP id y145mr4791184lff.214.1605488385576;
        Sun, 15 Nov 2020 16:59:45 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id g84sm2532263lfd.188.2020.11.15.16.59.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 16:59:44 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id v20so18253223ljk.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 16:59:44 -0800 (PST)
X-Received: by 2002:a2e:a375:: with SMTP id i21mr4850762ljn.421.1605488383974;
 Sun, 15 Nov 2020 16:59:43 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Nov 2020 16:59:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFfAktnadOPb_iV5nKh=V5Am1sG-gciYveswRtuEkrLQ@mail.gmail.com>
Message-ID: <CAHk-=wjFfAktnadOPb_iV5nKh=V5Am1sG-gciYveswRtuEkrLQ@mail.gmail.com>
Subject: Linux 5.10-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're getting to the point in the rc series where I start hoping for
things to calm down.

5.10 hasn't calmed down yet, and there's a fair amount of small noise
all over the place. Nothing that makes me particularly worried, and
honestly, with about a third of the patch being various selftest
updates and fixes some of that noise is certainly welcome, but I'm
hoping next week will start seeing less actual changes.

Anyway, if you ignore the Documentation, tooling and selftest changes,
 about half of this is various minor driver updates (really all over
the place), with the rest being a mix of architecture (arm64 and x86),
filesystem fixes, and minor core kernel and vm changes.

All looks good, and nothing makes me go "uhhuh, 5.10 looks iffy". So
go test, let's get this all solid and calmed down, and this will
hopefully be one of those regular boring releases even if it's
certainly not been on the smaller side...

           Linus

---

Aaron Lewis (3):
      selftests: kvm: Fix the segment descriptor layout to match the
actual layout
      selftests: kvm: Clear uc so UCALL_NONE is being properly reported
      selftests: kvm: Add exception handling to selftests

Al Viro (1):
      don't dump the threads that had been already exiting when zapped.

Alexander A. Klimov (1):
      tools/power turbostat: Replace HTTP links with HTTPS ones:
TURBOSTAT UTILITY

Alexander Kapshuk (1):
      drm/nouveau/kms: Fix NULL pointer dereference in
nouveau_connector_detect_depth

Alexander Lobakin (4):
      virtio: virtio_console: fix DMA memory allocation for rproc serial
      ethtool: netlink: add missing netdev_features_change() call
      net: udp: fix UDP header access on Fast/frag0 UDP GRO
      net: udp: fix IP header access and skb lookup on Fast/frag0 UDP GRO

Alexander Monakov (1):
      tools/power turbostat: Build with _FILE_OFFSET_BITS=3D64

Alexander Usyskin (1):
      mei: protect mei_cl_mtu from null dereference

Anand Jain (1):
      btrfs: dev-replace: fail mount if we don't have replace item
with target device

Andra Paraschiv (1):
      nitro_enclaves: Fixup type and simplify logic of the poll mask setup

Andrew Jeffery (1):
      ARM: 9019/1: kprobes: Avoid fortify_panic() when copying optprobe tem=
plate

Andrew Jones (9):
      KVM: arm64: Don't hide ID registers from userspace
      KVM: arm64: Consolidate REG_HIDDEN_GUEST/USER
      KVM: arm64: Check RAZ visibility in ID register accessors
      KVM: arm64: Remove AA64ZFR0_EL1 accessors
      KVM: selftests: Add aarch64 get-reg-list test
      KVM: selftests: Add blessed SVE registers to get-reg-list
      KVM: selftests: Drop pointless vm_create wrapper
      KVM: selftests: Make the per vcpu memory size global
      KVM: selftests: Make the number of vcpus global

Andrey Konovalov (1):
      MAINTAINERS: add usb raw gadget entry

Andrii Nakryiko (2):
      selftest/bpf: Fix profiler test using CO-RE relocation for enums
      bpf: Add struct bpf_redir_neigh forward declaration to BPF helper def=
s

Andy Shevchenko (7):
      pinctrl: intel: Fix 2 kOhm bias which is 833 Ohm
      pinctrl: intel: Set default bias in case no particular value given
      pinctrl: mcp23s08: Use full chunk of memory for regmap configuration
      pinctrl: mcp23s08: Print error message when regmap init fails
      Documentation: firmware-guide: gpio-properties: Fix factual mistakes
      Documentation: firmware-guide: gpio-properties: active_low only
for GpioIo()
      Documentation: firmware-guide: gpio-properties: Clarify initial
output state

Anshuman Khandual (1):
      arm64/mm: Validate hotplug range before creating linear mapping

Antti Laakso (1):
      tools/power turbostat: Remove empty columns for Jacobsville

Ard Biesheuvel (1):
      bpf: Don't rely on GCC __attribute__((optimize)) to disable GCSE

Arnaud de Turckheim (3):
      gpio: pcie-idio-24: Fix irq mask when masking
      gpio: pcie-idio-24: Fix IRQ Enable Register value
      gpio: pcie-idio-24: Enable PEX8311 interrupts

Arnd Bergmann (6):
      asm-generic: percpu: avoid Wshadow warning
      bpf: Fix -Wshadow warnings
      clk: define to_clk_regmap() as inline function
      habanalabs: fix kernel pointer type
      firmware: xilinx: fix out-of-bounds access
      perf/x86/intel/uncore: Fix Add BW copypasta

Arvind Sankar (1):
      compiler.h: fix barrier_data() on clang

Aya Levin (1):
      net/mlx5e: Fix VXLAN synchronization after function reload

Babu Moger (2):
      KVM: x86: Introduce cr3_lm_rsvd_bits in kvm_vcpu_arch
      KVM: SVM: Update cr3_lm_rsvd_bits for AMD SEV guests

Ben Gardon (5):
      KVM: selftests: Factor code out of demand_paging_test
      KVM: selftests: Remove address rounding in guest code
      KVM: selftests: Simplify demand_paging_test with timespec_diff_now
      KVM: selftests: Add wrfract to common guest code
      KVM: selftests: Introduce the dirty log perf test

Ben Skeggs (1):
      drm/nouveau/ttm: avoid using nouveau_drm.ttm.type_vram prior to nv50

Bhawanpreet Lakha (1):
      drm/amd/display: Add missing pflip irq

Billy Tsai (2):
      gpio: aspeed: fix ast2600 bank properties
      pinctrl: aspeed: Fix GPI only function problem.

Bjorn Andersson (1):
      pinctrl: qcom: sm8250: Specify PDC map

Bob Peterson (2):
      Revert "gfs2: Ignore journal log writes for jdata holes"
      gfs2: Fix case in which ail writes are done to jdata holes

Boqun Feng (1):
      lockdep: Avoid to modify chain keys in validate_chain()

Brad Campbell (1):
      hwmon: (applesmc) Re-work SMC comms

Can Guo (2):
      scsi: ufs: Fix unbalanced scsi_block_reqs_cnt caused by ufshcd_hold()
      scsi: ufs: Try to save power mode change and UIC cmd completion timeo=
ut

Casey Bowman (1):
      thunderbolt: Add uaccess dependency to debugfs interface

Chao Yu (1):
      MAINTAINERS: add missing file in ext4 entry

Chen Yu (3):
      tools/power turbostat: Make the energy variable to be 64 bit
      tools/power turbostat: Introduce functions to accumulate RAPL consump=
tion
      tools/power turbostat: Enable accumulate RAPL display

Chen Zhou (1):
      selinux: Fix error return code in sel_ib_pkey_sid_slow()

Chris Brandt (1):
      usb: cdc-acm: Add DISABLE_ECHO for Renesas USB Download mode

Chris Wilson (1):
      drm/i915/gem: Pull phys pread/pwrite implementations to the backend

Christoph Hellwig (4):
      swiotlb: remove the tbl_dma_addr argument to swiotlb_tbl_map_single
      nbd: fix a block_device refcount leak in nbd_release
      xfs: fix a missing unlock on error in xfs_fs_map_blocks
      block: add a return value to set_capacity_revalidate_and_notify

Christophe Leroy (1):
      panic: don't dump stack twice on warn

Chuck Lever (4):
      NFSD: NFSv3 PATHCONF Reply is improperly formed
      SUNRPC: Fix general protection fault in trace_rpc_xdr_overflow()
      NFSD: MKNOD should return NFSERR_BADTYPE instead of NFSERR_INVAL
      NFS: Fix listxattr receive buffer size

Coiby Xu (2):
      pinctrl: amd: fix incorrect way to disable debounce filter
      pinctrl: amd: use higher precision for 512 RtcClk

Colin Ian King (1):
      sched/debug: Fix memory corruption caused by multiple small reads of =
flags

Dai Ngo (2):
      NFSD: Fix use-after-free warning when doing inter-server copy
      NFSD: fix missing refcount in nfsd4_copy by nfsd4_do_async_copy

Damien Le Moal (1):
      gpio: sifive: Fix SiFive gpio probe

Dan Carpenter (7):
      hwmon: (pmbus/max20730) use scnprintf() instead of snprintf()
      btrfs: clean up NULL checks in qgroup_unreserve_range()
      net/sunrpc: return 0 on attempt to write to "transports"
      ext4: silence an uninitialized variable warning
      net/sunrpc: fix useless comparison in proc_do_xprt()
      futex: Don't enable IRQs unconditionally in put_pi_state()
      i40e, xsk: uninitialized variable in i40e_clean_rx_irq_zc()

Darrick J. Wong (7):
      xfs: fix flags argument to rmap lookup when converting shared file rm=
aps
      xfs: set the unwritten bit in rmap lookup flags in
xchk_bmap_get_rmapextents
      xfs: fix rmap key and record comparison functions
      xfs: fix brainos in the refcount scrubber's rmap fragment processor
      vfs: remove lockdep bogosity in __sb_start_write
      vfs: separate __sb_start_write into blocking and non-blocking helpers
      vfs: move __sb_{start,end}_write* to fs.h

David Arcari (1):
      tools/power turbostat: Fix output formatting for ACPI CST enumeration

David Edmondson (1):
      KVM: x86: clflushopt should be treated as a no-op by emulation

David Howells (1):
      afs: Fix afs_write_end() when called with copied =3D=3D 0 [ver #3]

David Sterba (1):
      btrfs: scrub: update message regarding read-only status

David Verbeiren (1):
      bpf: Zero-fill re-used per-cpu map element

Dennis Zhou (1):
      percpu: convert flexible array initializers to use struct_size()

Dinghao Liu (1):
      btrfs: ref-verify: fix memory leak in btrfs_ref_tree_mod

Dmitry Baryshkov (1):
      mailmap: fix entry for Dmitry Baryshkov/Eremin-Solenikov

Doug Smythies (1):
      tools/power turbostat: Always print idle in the system
configuration header

Eric Biggers (2):
      fscrypt: remove reachable WARN in fscrypt_setup_iv_ino_lblk_32_key()
      fscrypt: fix inline encryption not used on new files

Evan Nimmo (1):
      of/address: Fix of_node memory leak in of_dma_is_coherent

Flavio Suligoi (1):
      Documentation: ACPI: fix spelling mistakes

Gao Xiang (2):
      erofs: derive atime instead of leaving it empty
      erofs: fix setting up pcluster for temporary pages

Gavin Shan (1):
      KVM: arm64: Fix build error in user_mem_abort()

Geert Uytterhoeven (1):
      Revert "usb: musb: convert to devm_platform_ioremap_resource_byname"

Hans de Goede (1):
      ACPI: button: Add DMI quirk for Medion Akoya E2228T

Harshad Shirwadkar (23):
      ext4: describe fast_commit feature flags
      ext4: mark fc ineligible if inode gets evictied due to mem pressure
      ext4: drop redundant calls ext4_fc_track_range
      ext4: fixup ext4_fc_track_* functions' signature
      jbd2: rename j_maxlen to j_total_len and add jbd2_journal_max_txn_buf=
s
      ext4: clean up the JBD2 API that initializes fast commits
      jbd2: drop jbd2_fc_init documentation
      jbd2: don't use state lock during commit path
      jbd2: don't pass tid to jbd2_fc_end_commit_fallback()
      jbd2: add todo for a fast commit performance optimization
      jbd2: don't touch buffer state until it is filled
      jbd2: don't read journal->j_commit_sequence without taking a lock
      ext4: dedpulicate the code to wait on inode that's being committed
      ext4: fix code documentatioon
      ext4: mark buf dirty before submitting fast commit buffer
      ext4: remove unnecessary fast commit calls from ext4_file_mmap
      ext4: fix inode dirty check in case of fast commits
      ext4: disable fast commit with data journalling
      ext4: issue fsdev cache flush before starting fast commit
      ext4: make s_mount_flags modifications atomic
      jbd2: don't start fast commit on aborted journal
      ext4: cleanup fast commit mount options
      ext4: handle dax mount option collision

Heikki Krogerus (1):
      usb: typec: ucsi: Report power supply changes

Heiner Kallweit (3):
      r8169: fix potential skb double free in an error path
      r8169: disable hw csum for short packets on all chip versions
      net: phy: realtek: support paged operations on RTL8201CP

Helge Deller (1):
      nfsroot: Default mount option should ask for built-in NFS version

Ian Rogers (3):
      tools, bpftool: Avoid array index warnings.
      tools, bpftool: Remove two unused variables.
      libbpf, hashmap: Fix undefined behavior in hash_bits

J. Bruce Fields (1):
      NFSv4.2: fix failure to unregister shrinker

Jakub Kicinski (1):
      net: switch to the kernel.org patchwork instance

Jason Gunthorpe (1):
      mm/gup: use unpin_user_pages() in __gup_longterm_locked()

Jens Axboe (1):
      io_uring: round-up cq size before comparing with rounded sq size

Jia He (1):
      gpio: dwapb: Fix missing conversion to GPIO-lib-based IRQ-chip

Jianqun Xu (2):
      pinctrl: rockchip: enable gpio pclk for rockchip_gpio_to_irq
      pinctrl: rockchip: create irq mapping in gpio_to_irq

Jing Xiangfeng (1):
      thunderbolt: Add the missed ida_simple_remove() in ring_request_msix(=
)

Jiri Slaby (1):
      x86/platform/uv: Drop last traces of uv_flush_tlb_others

John Garry (1):
      ACPI: scan: Fix acpi_dma_configure_id() kerneldoc name

Jonathan Neusch=C3=A4fer (1):
      docs: networking: phy: s/2.5 times faster/2.5 times as fast/

Josef Bacik (2):
      btrfs: print the block rsv type when we fail our reservation
      btrfs: fix min reserved size calculation in merge_reloc_root

Joseph Qi (1):
      ext4: unlock xattr_sem properly in ext4_inline_data_truncate()

KP Singh (1):
      bpf: Update verification logic for LSM programs

Kaixu Xia (1):
      ext4: correctly report "not supported" for {usr,grp}jquota when
!CONFIG_QUOTA

Kent Gibson (6):
      gpio: uapi: fix kernel-doc warnings
      gpio: uapi: comment consistency
      gpio: uapi: kernel-doc formatting improvements
      gpio: uapi: remove whitespace
      gpio: uapi: clarify the meaning of 'empty' char arrays
      gpiolib: fix sysfs when cdev is not selected

Kim Phillips (1):
      tools/power turbostat: Support AMD Family 19h

Konrad Dybcio (4):
      arm64: Add MIDR value for KRYO2XX gold/silver CPU cores
      arm64: kpti: Add KRYO2XX gold/silver CPU cores to kpti safelist
      arm64: proton-pack: Add KRYO2XX silver CPUs to spectre-v2 safe-list
      arm64: cpu_errata: Apply Erratum 845719 to KRYO2XX Silver

Laurent Dufour (1):
      mm/slub: fix panic in slab_alloc_node()

Len Brown (7):
      tools/power turbostat: Print /dev/cpu_dma_latency
      tools/power turbostat: Support additional CPU model numbers
      tools/power turbostat: Skip pc8, pc9, pc10 columns, if they are disab=
led
      tools/power turbostat: adjust for temperature offset
      tools/power turbostat: harden against cpu hotplug
      powercap: restrict energy meter to root access
      tools/power turbostat: update version number

Li RongQing (1):
      KVM: x86/mmu: fix counting of rmap entries in pte_list_add

Linus Torvalds (1):
      Linux 5.10-rc4

Linus Walleij (1):
      drm/mcde: Fix unbalanced regulator

Lorenz Bauer (1):
      tools/bpftool: Fix attaching flow dissector

Lyude Paul (1):
      drm/nouveau/kms/nv50-: Use atomic encoder callbacks everywhere

Magnus Karlsson (3):
      xsk: Fix possible memory leak at socket close
      libbpf: Fix null dereference in xsk_socket__delete
      libbpf: Fix possible use after free in xsk_socket__delete

Mao Wenan (1):
      net: Update window_clamp if SOCK_RCVBUF is set

Maor Dickman (1):
      net/mlx5e: Fix modify header actions memory leak

Maor Gottlieb (1):
      net/mlx5: Fix deletion of duplicate rules

Marc Kleine-Budde (3):
      dt-bindings: can: fsl,flexcan.yaml: fix fsl,stop-mode
      dt-bindings: can: fsl,flexcan.yaml: fix compatible for i.MX35 and i.M=
X53
      dt-bindings: clock: imx5: fix example

Marc Zyngier (3):
      KVM: arm64: Allow setting of ID_AA64PFR0_EL1.CSV2 from userspace
      KVM: arm64: Unify trap handlers injecting an UNDEF
      KVM: arm64: Handle SCXTNUM_ELx traps

Martin Schiller (1):
      net/x25: Fix null-ptr-deref in x25_connect

Martin Willi (1):
      vrf: Fix fast path output packet handling with async Netfilter rules

Masami Hiramatsu (1):
      bootconfig: Extend the magic check range to the preceding 3 bytes

Matteo Croce (2):
      Revert "kernel/reboot.c: convert simple_strtoul to kstrtoint"
      reboot: fix overflow parsing reboot cpu number

Matthew Auld (1):
      drm/i915/gem: Allow backends to override pread implementation

Matthew Wilcox (Oracle) (1):
      btrfs: fix potential overflow in cluster_pages_for_defrag on 32bit ar=
ch

Maulik Shah (1):
      pinctrl: qcom: Move clearing pending IRQ to
.irq_request_resources callback

Maxim Levitsky (1):
      KVM: x86: use positive error values for msr emulation that causes #GP

Maxim Mikityanskiy (2):
      net/mlx5e: Use spin_lock_bh for async_icosq_lock
      net/mlx5e: Fix incorrect access of RCU-protected xdp_prog

Maximilian Luz (1):
      ACPI: Fix whitespace inconsistencies

Michael Walle (1):
      arm64: dts: fsl-ls1028a-kontron-sl28: specify in-band mode for ENETC

Mika Westerberg (3):
      thunderbolt: Fix memory leak if ida_simple_get() fails in
enumerate_services()
      thunderbolt: Only configure USB4 wake for lane 0 adapters
      thunderbolt: Add support for Intel Tiger Lake-H

Mike Kravetz (1):
      hugetlbfs: fix anon huge page migration race

Mike Travis (1):
      x86/platform/uv: Fix copied UV5 output archtype

Muchun Song (1):
      mm: memcontrol: fix missing wakeup polling thread

Naveen Krishna Chatradhi (1):
      hwmon: (amd_energy) modify the visibility of the counters

Nicholas Piggin (1):
      mm/vmscan: fix NR_ISOLATED_FILE corruption on 64-bit

Nick Desaulniers (1):
      ACPI: GED: fix -Wformat

Nishanth Menon (1):
      drm: bridge: cdns: Kconfig: Switch over dependency to ARCH_K3

Oded Gabbay (1):
      habanalabs/gaudi: mask WDT error in QMAN

Ofir Bitton (1):
      habanalabs/gaudi: move coresight mmu config

Olaf Hering (1):
      video: hyperv_fb: include vmalloc.h

Oliver Herms (1):
      IPv6: Set SIT tunnel hard_header_len to zero

Oliver Upton (4):
      kvm: x86: reads of restricted pv msrs should also result in #GP
      kvm: x86: ensure pv_cpuid.features is initialized when enabling cap
      kvm: x86: request masterclock update any time guest uses different ms=
r
      selftests: kvm: test enforcement of paravirtual cpuid features

Ond=C5=99ej Lyson=C4=9Bk (1):
      tools/power x86_energy_perf_policy: Input/output error in a VM

Pankaj Gupta (1):
      KVM: x86: handle MSR_IA32_DEBUGCTLMSR with report_ignored_msrs

Paolo Abeni (1):
      mptcp: provide rmem[0] limit

Paolo Bonzini (2):
      KVM: selftests: allow two iterations of dirty_log_perf_test
      kvm: mmu: fix is_tdp_mmu_check when the TDP MMU is not in use

Parav Pandit (2):
      net/mlx5: E-switch, Avoid extack error log for disabled vport
      devlink: Avoid overwriting port attributes of registered port

Paul Barker (1):
      hwmon: (pwm-fan) Fix RPM calculation

Paul Cercueil (1):
      pinctrl: ingenic: Fix invalid SSI pins

Paul Moore (1):
      netlabel: fix our progress tracking in netlbl_unlabel_staticlist()

Peng Fan (1):
      clk: imx8m: fix bus critical clk registration

Peter Xu (4):
      KVM: Documentation: Update entry for KVM_X86_SET_MSR_FILTER
      KVM: Documentation: Update entry for KVM_CAP_ENFORCE_PV_CPUID
      KVM: selftests: Always clear dirty bitmap after iteration
      KVM: selftests: Use a single binary for dirty/clear log test

Peter Zijlstra (10):
      perf: Reduce stack usage of perf_output_begin()
      perf/x86: Reduce stack usage for x86_pmu::drain_pebs()
      perf: Fix get_recursion_context()
      perf: Optimize get_recursion_context()
      perf/arch: Remove perf_sample_data::regs_user_copy
      perf/x86: Make dummy_iregs static
      perf: Simplify group_sched_out()
      perf: Simplify group_sched_in()
      perf: Fix event multiplexing for exclusive groups
      perf: Tweak perf_event_attr::exclusive semantics

Petr Vorel (1):
      loop: Fix occasional uevent drop

Prarit Bhargava (1):
      tools/power turbostat: Use sched_getcpu() instead of hardcoded cpu 0

Qinglang Miao (1):
      scsi: ufshcd: Fix missing destroy_workqueue()

Rafael Antognolli (1):
      tools/power turbostat: Add a new GFXAMHz column that exposes
gt_act_freq_mhz.

Rafael J. Wysocki (4):
      cpufreq: Introduce governor flags
      cpufreq: Introduce CPUFREQ_GOV_STRICT_TARGET
      cpufreq: Add strict_target to struct cpufreq_policy
      cpufreq: intel_pstate: Take CPUFREQ_GOV_STRICT_TARGET into account

Randy Dunlap (1):
      bpf: BPF_PRELOAD depends on BPF_SYSCALL

Richard Weinberger (1):
      um: Call pgtable_pmd_page_dtor() in __pmd_free_tlb()

Robert Hancock (1):
      hwmon: (pmbus) Add mutex locking for sysfs reads

Rohit Maheshwari (12):
      cxgb4/ch_ktls: decrypted bit is not enough
      ch_ktls: Correction in finding correct length
      ch_ktls: Update cheksum information
      cxgb4/ch_ktls: creating skbs causes panic
      ch_ktls: Correction in trimmed_len calculation
      ch_ktls: missing handling of header alone
      ch_ktls: Correction in middle record handling
      ch_ktls: packet handling prior to start marker
      ch_ktls: don't free skb before sending FIN
      ch_ktls/cxgb4: handle partial tag alone SKBs
      ch_ktls: tcb update fails sometimes
      ch_ktls: stop the txq if reaches threshold

Roman Li (1):
      drm/amdgpu: add ta firmware load for green-sardine

Sagi Grimberg (1):
      nvme: fix incorrect behavior when BLKROSET is called by the user

Samuel Thibault (3):
      speakup: Fix var_id_t values and thus keymap
      speakup: Fix clearing selection in safe context
      speakup ttyio: Do not schedule() in ttyio_in_nowait

Santosh Sivaraj (1):
      kernel/watchdog: fix watchdog_allowed_mask not used warning

Shin'ichiro Kawasaki (1):
      uio: Fix use-after-free in uio_unregister_device()

Slawomir Laba (1):
      i40e: Fix MAC address setting for a VF via Host/VM

Srinivas Pandruvada (1):
      ACPI: DPTF: Support Alder Lake

Stefano Brivio (1):
      tunnels: Fix off-by-one in lower MTU bounds for ICMP/ICMPv6 replies

Stefano Stabellini (1):
      swiotlb: fix "x86: Don't panic if can not alloc buffer for swiotlb"

Stephane Eranian (1):
      perf/x86/intel: Make anythread filter support conditional

Sven Van Asbroeck (3):
      lan743x: correctly handle chips with internal PHY
      lan743x: fix "BUG: invalid wait context" when setting rx mode
      lan743x: fix use of uninitialized variable

Theodore Ts'o (3):
      ext4: fix sparse warnings in fast_commit code
      jbd2: fix up sparse warnings in checkpoint code
      Revert "ext4: fix superblock checksum calculation race"

Thomas Gleixner (1):
      iommu/vt-d: Cure VF irqdomain hickup

Thomas Zimmermann (1):
      drm/gma500: Fix out-of-bounds access to struct drm_device.vblank[]

Tianci.Yin (1):
      drm/amdgpu: enable DCN for navi10 headless SKU

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      samples/bpf: Set rlimit for memlock to infinity in all samples

Tony Lindgren (1):
      Revert "Revert "gpio: omap: Fix lost edge wake-up interrupts""

Tony Nguyen (1):
      MAINTAINERS: Update repositories for Intel Ethernet Drivers

Trond Myklebust (2):
      NFS: Remove unnecessary inode locking in nfs_llseek_dir()
      NFS: Remove unnecessary inode lock in nfs_fsync_dir()

Ursula Braun (2):
      net/af_iucv: fix null pointer dereference on shutdown
      MAINTAINERS: remove Ursula Braun as s390 network maintainer

Vadym Kochan (1):
      net: marvell: prestera: fix compilation with CONFIG_BRIDGE=3Dm

Venkata Sandeep Dhanalakota (1):
      drm/i915: Correctly set SFC capability for video engines

Vincent Guittot (2):
      sched/fair: Ensure tasks spreading in LLC during LB
      sched/fair: Prefer prev cpu in asymmetric wakeup path

Vinicius Costa Gomes (1):
      igc: Fix returning wrong statistics

Vlad Buslov (2):
      net/mlx5e: Protect encap route dev from concurrent release
      selftest: fix flower terse dump tests

Wang Hai (2):
      tipc: fix memory leak in tipc_topsrv_start()
      cosa: Add missing kfree in error path of cosa_write

Wengang Wang (1):
      ocfs2: initialize ip_next_orphan

Will Deacon (4):
      arm64: errata: Fix handling of 1418040 with late CPU onlining
      arm64: kexec_file: Fix sparse warning
      arm64: psci: Avoid printing in cpu_psci_cpu_die()
      arm64: smp: Tell RCU about CPUs that fail to come online

Wolfram Sang (3):
      mmc: tmio: when resetting, reset DMA controller, too
      mmc: tmio: bring tuning HW to a sane state with MMC_POWER_OFF
      Revert "mmc: renesas_sdhi: workaround a regression when
reinserting SD cards"

Yangbo Lu (1):
      mmc: sdhci-of-esdhc: Handle pulse width detection erratum for more So=
Cs

Yoshihiro Shimoda (1):
      mmc: renesas_sdhi_core: Add missing tmio_mmc_host_free() at remove

Zhang Qilong (2):
      gfs2: fix possible reference leak in gfs2_check_blk_type
      xhci: hisilicon: fix refercence leak in xhci_histb_probe

Zi Yan (2):
      mm/compaction: count pages and stop correctly during page isolation
      mm/compaction: stop isolation if too many pages are isolated and
we have pages to migrate

zhangxiaoxu (1):
      net: dsa: mv88e6xxx: Fix memleak in mv88e6xxx_region_atu_snapshot
