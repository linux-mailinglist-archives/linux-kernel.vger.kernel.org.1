Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EB72F9709
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbhARBAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730496AbhARA6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 19:58:00 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C418DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 16:57:05 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 23so21609683lfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 16:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Tl3KUD4+qlOq+MOkqyxy8y8FIQ3cX0OQVz22w1n+BBQ=;
        b=R9Mz5QxkHSSZgwLZkeBIMiQ9v2nNfe94jspMr02A8YCOpv8hKUcUqtGFNrl6HHNSMn
         u883/IyFET+1pPZ2g+hw+N8zSPBCCWXgHLrC5GWw9LPB3ZiZh1sOAWc96QPrGHATlteU
         scY3NJ8uSvU/VIM56S2ctl0dRIgDnYqm7PhaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Tl3KUD4+qlOq+MOkqyxy8y8FIQ3cX0OQVz22w1n+BBQ=;
        b=hpDHAmY9oQ6IGPnKGi7ElFt8GcRPc1oXfyZ+3VktVBvwV0AXi9p1Prc/sTl7UT+jCg
         z1D8mfLhSe5yylc7qDDvXRKb9oLrSnDDwssp4evbuc6msloPvGROjlRf58a4gR7mHXXn
         fDzTUD9nd887AwbduJhZd7+nJ+jL000qjVWpLwFnNxDyeeQfu8ITBxn4oeTbn1sMZwuc
         e2bpPfnz+xQdoVCpXC9Ikbst/y6XCp2e+mN3cNkVvJXTzGszZPnVRUzEgWk5WOCoy/9Q
         ss6KCCobiL0wCy9Xc8AxkUlJJLlhmisUVt1kD02zXB5TGDiY5ePFu8cSCNGkN70gDHGg
         NtaA==
X-Gm-Message-State: AOAM532p4zdv+lTED8BT+t7xFyDWTlxrsLMRqgW+P+ekEuALoTYdFqOv
        R/1yFRQ110SGQYdA+eYftuV6HQztjojUZA==
X-Google-Smtp-Source: ABdhPJzSKjvPDTsBGt9xc/Bzyk7Qd3RYZMEaofa+2ys2VG9GGFwNwuya5dFlIZ/7SoV69OQIumR6cw==
X-Received: by 2002:ac2:46e4:: with SMTP id q4mr9965521lfo.413.1610931423775;
        Sun, 17 Jan 2021 16:57:03 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id p3sm1612732lfu.271.2021.01.17.16.57.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jan 2021 16:57:03 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id y22so16479659ljn.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 16:57:02 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr9082187lji.48.1610931422248;
 Sun, 17 Jan 2021 16:57:02 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jan 2021 16:56:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjGqX0BFV0eH9R=9m2Xezib0w8Ty2zEc6XDJ73zNRPuPQ@mail.gmail.com>
Message-ID: <CAHk-=wjGqX0BFV0eH9R=9m2Xezib0w8Ty2zEc6XDJ73zNRPuPQ@mail.gmail.com>
Subject: Linux 5.11-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things continue to look fairly normal for this release: 5.11-rc4 is
solidly average in size, and nothing particularly scary stands out.

In the diff itself, the new ampere modesetting support shows up fairly
clearly - it's one of those hardware enablement things that should be
entirely invisible to people who don't have that hardware, but it does
end up being about a fifth of the whole rc4 patch.

If you ignore that oddity, the rest looks pretty normal, with random
patches all over, and a lot of it being quite small. All the usual
suspects: drivers (gpu, sound, rdma, md, networking..) arch updates
(arm64, risc-v, x86), fiesystems (ext4, nfs, btrfs), core networking,
documentation and tooling. And just random fixes.

The appended shortlog gives the details as usual..

            Linus

---

Adrian Hunter (1):
      perf intel-pt: Fix 'CPU too large' error

Aharon Landau (1):
      RDMA/umem: Avoid undefined behavior of rounddown_pow_of_two()

Akilesh Kailash (1):
      dm snapshot: flush merged data before committing metadata

Al Grant (1):
      perf inject: Correct event attribute sizes

Al Viro (3):
      MIPS: Fix malformed NT_FILE and NT_SIGINFO in 32bit coredumps
      umount(2): move the flag validity checks first
      dump_common_audit_data(): fix racy accesses to ->d_name

Alex Deucher (2):
      ALSA: hda/hdmi - enable runtime pm for CI AMD display audio
      MAINTAINERS: update radeon/amdgpu/amdkfd git trees

Alexander Lobakin (1):
      MIPS: relocatable: fix possible boot hangup with KASLR enabled

Alexandre Demers (1):
      drm/amdgpu: fix DRM_INFO flood if display core is not supported
(bug 210921)

Andreas Schwab (2):
      riscv: return -ENOSYS for syscall -1
      powerpc/vdso: Fix clock_gettime_fallback for vdso32

Andrew Morton (1):
      mm/process_vm_access.c: include compat.h

Andrey Zhizhikin (1):
      rndis_host: set proper input size for OID_GEN_PHYSICAL_MEDIUM request

Anthony Iliopoulos (1):
      dm integrity: select CRYPTO_SKCIPHER

Ariel Marcovitch (1):
      powerpc: Fix alignment bug within the init sections

Arnaldo Carvalho de Melo (3):
      perf bpf examples: Fix bpf.h header include directive in 5sec.c examp=
le
      tools headers UAPI: Sync kvm.h headers with the kernel sources
      tools headers: Syncronize linux/build_bug.h with the kernel sources

Arnd Bergmann (4):
      HID: sfh: fix address space confusion
      HID: sony: select CONFIG_CRC32
      dm zoned: select CONFIG_CRC32
      arm64: make atomic helpers __always_inline

Atish Patra (4):
      riscv: Trace irq on only interrupt is enabled
      RISC-V: Do not allocate memblock while iterating reserved memblocks
      RISC-V: Set current memblock limit
      RISC-V: Fix maximum allowed phsyical memory for RV32

Aya Levin (1):
      net: ipv6: Validate GSO SKB before finish IPv6 processing

Ayush Sawal (1):
      cxgb4/chtls: Fix tid stuck due to wrong update of qid

Baptiste Lepers (2):
      udp: Prevent reuseport_select_sock from reading uninitialized socks
      rxrpc: Call state should be read with READ_ONCE() under some circumst=
ances

Bard Liao (1):
      ASoC: max98373: don't access volatile registers in bias level off

Bas Nieuwenhuizen (1):
      drm: Check actual format for legacy pageflip.

Ben Skeggs (22):
      drm/nouveau/bios: fix issue shadowing expansion ROMs
      drm/nouveau/privring: ack interrupts the same way as RM
      drm/nouveau/i2c/gk110: split out from i2c/gk104
      drm/nouveau/i2c/gk110-: disable hw-initiated dpcd reads
      drm/nouveau/i2c/gm200: increase width of aux semaphore owner fields
      drm/nouveau/mmu: fix vram heap sizing
      drm/nouveau/core: recognise GA10[024]
      drm/nouveau/kms/nv50-: fix case where notifier buffer is at offset 0
      drm/nouveau/pci/ga10[024]: initial support
      drm/nouveau/bios/ga10[024]: initial support
      drm/nouveau/devinit/ga10[024]: initial support
      drm/nouveau/mc/ga10[024]: initial support
      drm/nouveau/privring/ga10[024]: initial support
      drm/nouveau/imem/ga10[024]: initial support
      drm/nouveau/fb/ga10[024]: initial support
      drm/nouveau/timer/ga10[024]: initial support
      drm/nouveau/mmu/ga10[024]: initial support
      drm/nouveau/bar/ga10[024]: initial support
      drm/nouveau/gpio/ga10[024]: initial support
      drm/nouveau/i2c/ga10[024]: initial support
      drm/nouveau/dmaobj/ga10[24]: initial support
      drm/nouveau/disp/ga10[24]: initial support

Can Guo (1):
      scsi: ufs: Correct the LUN used in eh_device_reset_handler() callback

Catalin Marinas (1):
      arm64: Remove arm64_dma32_phys_limit and its uses

Cezary Rojewski (1):
      ASoC: Intel: haswell: Add missing pm_ops

Chen Yi (1):
      selftests: netfilter: Pass family parameter "-f" to conntrack tool

Chris Wilson (4):
      drm/i915: Disable RPM wakeref assertions during driver shutdown
      drm/i915/gt: Limit VFE threads based on GT
      drm/i915/gt: Restore clear-residual mitigations for Ivybridge, Baytra=
il
      drm/i915: Allow the sysadmin to override security mitigations

Christian K=C3=B6nig (1):
      drm/ttm: make the pool shrinker lock a mutex

Christoph Hellwig (1):
      iov_iter: fix the uaccess area in copy_compat_iovec_from_user

Chuck Lever (3):
      NFSD: Fix sparse warning in nfssvc.c
      SUNRPC: Handle TCP socket sends with kernel_sendpage() again
      NFSD: Restore NFSv4 decoding's SAVEMEM functionality

Colin Ian King (4):
      ASoC: codecs: fix spelling mistake in Kconfig "comunicate" ->
"communicate"
      ASoC: SOF: Fix spelling mistake in Kconfig "ond" -> "and"
      ASoC: atmel: fix spelling mistake in Kconfig "programable" ->
"programmable"
      scsi: mpt3sas: Fix spelling mistake in Kconfig "compatiblity" ->
"compatibility"

Colin Xu (1):
      drm/i915/gvt: Fix vfio_edid issue for BXT/APL

Cristian Dumitrescu (1):
      i40e: fix potential NULL pointer dereferencing

Daejun Park (2):
      ext4: fix wrong list_splice in ext4_fc_cleanup
      ext4: remove expensive flush on fast commit

Damien Le Moal (3):
      riscv: Fix kernel time_init()
      riscv: Fix sifive serial driver
      riscv: Enable interrupts during syscalls with M-Mode

Dan Carpenter (1):
      ASoC: Intel: fix error code cnl_set_dsp_D0()

Dave Wysochanski (1):
      NFS4: Fix use-after-free in trace_event_raw_event_nfs4_set_lock

David Disseldorp (1):
      scsi: target: Fix XCOPY NAA identifier lookup

David Howells (1):
      rxrpc: Fix handling of an unsupported token type in rxrpc_read()

David Woodhouse (5):
      xen: Fix event channel callback via INTX/GSI
      xen: Set platform PCI device INTX affinity to CPU0
      x86/xen: Add xen_no_vector_callback option to test PCI INTX delivery
      x86/xen: Don't register Xen IPIs when they aren't going to be used
      x86/xen: Fix xen_hvm_smp_init() when vector callback not available

David Wu (1):
      net: stmmac: Fixed mtu channged by cache aligned

Dexuan Cui (2):
      x86/hyperv: Fix kexec panic/hang issues
      ACPI: scan: Harden acpi_device_add() against device ID overflows

Dinghao Liu (3):
      scsi: scsi_debug: Fix memleak in scsi_debug_init()
      RDMA/usnic: Fix memleak in find_free_vf_and_create_qp_grp
      netfilter: nf_nat: Fix memleak in nf_nat_init

Dongseok Yi (1):
      net: fix use-after-free when UDP GRO with shared fraglist

Eric Dumazet (1):
      net: avoid 32 x truesize under-estimation for tiny skbs

Ewan D. Milne (1):
      scsi: sd: Suppress spurious errors when WRITE SAME is being disabled

Filipe La=C3=ADns (1):
      HID: logitech-dj: add the G602 receiver

Geert Uytterhoeven (4):
      dt-bindings: net: renesas,etheravb: RZ/G2H needs tx-internal-delay-ps
      ALSA: fireface: Fix integer overflow in transmit_midi_msg()
      ALSA: firewire-tascam: Fix integer overflow in midi_port_work()
      nt: usb: USB_RTL8153_ECM should not default to y

Guo Ren (1):
      riscv: Fixup CONFIG_GENERIC_TIME_VSYSCALL

Guvenc Gulce (1):
      net/smc: use memcpy instead of snprintf to avoid out of bounds read

Hailong Liu (1):
      arm/kasan: fix the array size of kasan_early_shadow_pte[]

Hailong liu (1):
      mm/page_alloc: add a missing mm_page_alloc_zone_locked() tracepoint

Hans de Goede (1):
      drm/i915/dsi: Use unconditional msleep for the panel_on_delay
when there is no reset-deassert MIPI-sequence

Hoang Le (1):
      tipc: fix NULL deref in tipc_link_xmit()

Huang Rui (1):
      drm/amdgpu: fix vram type and bandwidth error for DDR5 and DDR4

Hugh Dickins (1):
      mm/memcontrol: fix warning in mem_cgroup_page_lruvec()

Ian Rogers (3):
      libperf tests: Avoid uninitialized variable warning
      libperf tests: If a test fails return non-zero
      libperf tests: Fail when failing to get a tracepoint id

Ignat Korchagin (4):
      dm crypt: do not wait for backlogged crypto request completion in sof=
tirq
      dm crypt: use GFP_ATOMIC when allocating crypto requests from softirq
      dm crypt: do not call bio_endio() from the dm-crypt tasklet
      dm crypt: defer decryption to a tasklet if interrupts disabled

Imre Deak (1):
      drm/i915/icl: Fix initing the DSI DSC power refcount during HW readou=
t

Israel Rukshin (1):
      nvmet-rdma: Fix NULL deref when setting pi_enable and traddr INADDR_A=
NY

Jakub Kicinski (12):
      docs: net: explain struct net_device lifetime
      net: make free_netdev() more lenient with unregistering devices
      net: make sure devices go through netdev_wait_all_refs
      smc: fix out of bound access in smc_nl_get_sys_info()
      net: sit: unregister_netdevice on newlink's error path
      MAINTAINERS: altx: move Jay Cliburn to CREDITS
      MAINTAINERS: net: move Alexey Kuznetsov to CREDITS
      MAINTAINERS: vrf: move Shrijeet to CREDITS
      MAINTAINERS: ena: remove Zorik Machulsky from reviewers
      MAINTAINERS: tls: move Aviad to CREDITS
      MAINTAINERS: ipvs: move Wensong Zhang to CREDITS
      MAINTAINERS: dccp: move Gerrit Renker to CREDITS

Jan Kara (7):
      ext4: combine ext4_handle_error() and save_error_info()
      ext4: drop sync argument of ext4_commit_super()
      ext4: protect superblock modifications with a buffer lock
      ext4: save error info to sb through journal if available
      ext4: use sbi instead of EXT4_SB(sb) in ext4_update_super()
      ext4: fix superblock checksum failure when setting password salt
      ext4: drop ext4_handle_dirty_super()

Jan Stancek (1):
      mm: migrate: initialize err in do_migrate_pages

Jani Nikula (1):
      drm/i915/backlight: fix CPU mode backlight takeover on LPT

Jann Horn (1):
      mm, slub: consider rest of partial list if acquire_slab() fails

Jaroslav Kysela (2):
      ASoC: AMD Renoir - add DMI entry for Lenovo ThinkPad E14 Gen 2
      ASoC: AMD Renoir - add DMI entry for Lenovo ThinkPad X395

Jason Gunthorpe (1):
      RDMA/ucma: Do not miss ctx destruction steps in some cases

Jens Axboe (1):
      io_uring: ensure finish_wait() is always called in
__io_uring_task_cancel()

Jeremy Cline (2):
      drm/ttm: Fix address passed to dma_mapping_error() in ttm_pool_map()
      drm/amdkfd: Fix out-of-bounds read in kdf_create_vcrat_image_cpu()

Jeremy Szu (1):
      ALSA: hda/realtek: fix right sounds and mute/micmute LEDs for HP mach=
ines

Jerome Brunet (2):
      ASoC: meson: axg-tdmin: fix axg skew offset
      ASoC: meson: axg-tdm-interface: fix loopback

Jesper Dangaard Brouer (1):
      netfilter: conntrack: fix reading nf_conntrack_buckets

Jianlin Lv (1):
      arm64: rename S_FRAME_SIZE to PT_REGS_SIZE

John Stultz (1):
      dma-buf: cma_heap: Fix memory leak in CMA heap

Jonathan Neusch=C3=A4fer (1):
      ALSA: doc: Fix reference to mixart.rst

Josef Bacik (2):
      btrfs: print the actual offset in btrfs_root_name
      btrfs: shrink delalloc pages instead of full inodes

Kai-Heng Feng (1):
      HID: multitouch: Enable multi-input for Synaptics
pointstick/touchpad device

Kefeng Wang (3):
      riscv: Drop a duplicated PAGE_KERNEL_EXEC
      riscv: cacheinfo: Fix using smp_processor_id() in preemptible
      riscv: stacktrace: Move register keyword to beginning of declaration

Kiwoong Kim (1):
      scsi: ufs: Relocate flush of exceptional event

Konrad Dybcio (1):
      iommu: arm-smmu-qcom: Add sdm630/msm8998 compatibles for qcom quirks

Kuninori Morimoto (1):
      ASoC: rsnd: don't call clk_disable_unprepare() if can't use

Leon Romanovsky (1):
      RDMA/restrack: Don't treat as an error allocation ID wrapping

Leon Schuermann (2):
      r8152: Add Lenovo Powered USB-C Travel Hub
      r8153_ecm: Add Lenovo Powered USB-C Hub as a fallback of r8152

Li, Roman (1):
      drm/amd/display: disable dcn10 pipe split by default

Likun Gao (1):
      drm/amdgpu: set power brake sequence

Linus Torvalds (4):
      mm: fix clear_refs_write locking
      mm: don't play games with pinned pages in clear_page_refs
      mm: don't put pinned pages into the swap cache
      Linux 5.11-rc4

Lu Baolu (1):
      iommu/vt-d: Fix unaligned addresses for intel_flush_svm_range_dev()

Lukas Bulwahn (1):
      scsi: sd: Remove obsolete variable in sd_remove()

Manish Chopra (1):
      netxen_nic: fix MSI/MSI-x interrupts

Marcelo Diop-Gonzalez (1):
      io_uring: flush timeouts that should already have expired

Marco Felsch (1):
      net: phy: smsc: fix clk error handling

Mark Bloch (1):
      RDMA/mlx5: Fix wrong free of blue flame register on error

Mark Brown (2):
      selftests: Skip BPF seftests by default
      arm64: selftests: Fix spelling of 'Mismatch'

Mark Rutland (2):
      arm64: entry: remove redundant IRQ flag tracing
      arm64: syscall: include prototype for EL0 SVC functions

Masami Hiramatsu (2):
      tracing/kprobes: Do the notrace functions check without kprobes on ft=
race
      tools/bootconfig: Add tracing_on support to helper scripts

Mauro Carvalho Chehab (1):
      net: tip: fix a couple kernel-doc markups

Menglong Dong (2):
      MIPS: OCTEON: fix unreachable code in octeon_irq_init_ciu
      fs: cifs: remove unneeded variable in smb3_fs_context_dup

Miaohe Lin (2):
      mm/vmalloc.c: fix potential memory leak
      mm/hugetlb: fix potential missing huge page size info

Michael Chan (1):
      bnxt_en: Improve stats context resource accounting with RDMA
driver loaded.

Mike Snitzer (2):
      dm raid: fix discard limits for raid1
      dm: eliminate potential source of excessive kernel log noise

Mikulas Patocka (2):
      dm integrity: fix flush with external metadata device
      dm integrity: fix the maximum number of arguments

Namhyung Kim (3):
      perf test: Fix shadow stat test for non-bash shells
      perf stat: Introduce struct runtime_stat_data
      perf stat: Take cgroups into account for shadow stats

Neta Ostrovsky (1):
      RDMA/cma: Fix error flow in default_roce_mode_store

Nicholas Miell (1):
      HID: logitech-hidpp: Add product ID for MX Ergo in Bluetooth mode

Nick Hu (1):
      riscv: Fix KASAN memory mapping.

Nikola Cornij (1):
      drm/amd/display: Add a missing DCN3.01 API mapping

Nilesh Javali (1):
      scsi: qedi: Correct max length of CHAP secret

Oliver Hartkopp (1):
      can: isotp: isotp_getname(): fix kernel information leak

Oscar Salvador (1):
      mm,hwpoison: fix printing of page flags

Paolo Abeni (3):
      mptcp: more strict state checking for acks
      mptcp: better msk-level shutdown.
      mptcp: fix locking in mptcp_disconnect()

Parav Pandit (1):
      IB/mlx5: Fix error unwinding when set_has_smi_cap fails

Paul Cercueil (1):
      MIPS: boot: Fix unaligned access with CONFIG_MIPS_RAW_APPENDED_DTB

Paulo Alcantara (1):
      cifs: fix interrupted close commands

Pavan Chebbi (1):
      bnxt_en: Clear DEFRAG flag in firmware message when retry flashing.

Pavel Begunkov (4):
      io_uring: drop mm and files after task_work_run
      io_uring: don't take files/mm for a dead task
      io_uring: fix null-deref in io_disable_sqo_submit
      io_uring: do sqo disable on install_fd error

Peter Geis (2):
      clk: tegra30: Add hda clock default rates to clock driver
      ALSA: hda/tegra: fix tegra-hda on tegra30 soc

Peter Ujfalusi (2):
      MAINTAINERS: Update email address for TI ASoC and twl4030 codec drive=
rs
      ASoC: dt-bindings: ti, j721e: Update maintainer and author informatio=
n

Petr Machata (1):
      net: dcb: Accept RTM_GETDCB messages carrying set-like DCB commands

Ping Cheng (1):
      HID: wacom: Fix memory leakage caused by kfifo_alloc

Prike Liang (1):
      drm/amdgpu: add green_sardine device id (v2)

Qinglang Miao (1):
      can: mcp251xfd: mcp251xfd_handle_rxif_one(): fix wrong NULL pointer c=
heck

Qingqing Zhuo (1):
      drm/amd/display: NULL pointer hang

Qiuxu Zhuo (1):
      Documentation: ACPI: EINJ: Fix error type values for PCIe errors

Qu Wenruo (1):
      btrfs: reloc: fix wrong file extent type check to avoid false ENOENT

Ravulapati Vishnu vardhan rao (1):
      ASoC: amd: Replacing MSI with Legacy IRQ model

Rodrigo Siqueira (4):
      Revert "drm/amd/display: Fixed Intermittent blue screen on OLED panel=
"
      Revert "drm/amd/display: Fix unused variable warning"
      Revert "drm/amdgpu/disply: fix documentation warnings in display mana=
ger"
      Revert "drm/amd/display: Expose new CRC window property"

Roger Pau Monne (1):
      xen/privcmd: allow fetching resource sizes

Sagar Shrikant Kadam (3):
      dts: phy: fix missing mdio device and probe failure of vsc8541-01 dev=
ice
      dts: phy: add GPIO number and active state used for phy reset
      riscv: defconfig: enable gpio support for HiFive Unleashed

Sagi Grimberg (3):
      nvme-tcp: Fix warning with CONFIG_DEBUG_PREEMPT
      nvme-tcp: fix possible data corruption with bio merges
      nvme: don't intialize hwmon for discovery controllers

Scott Mayhew (1):
      NFS: Adjust fs_context error logging

Seb Laveze (2):
      dt-bindings: net: dwmac: fix queue priority documentation
      net: stmmac: use __napi_schedule() for PREEMPT_RT

Seth Miller (1):
      HID: Ignore battery for Elan touchscreen on ASUS UX550

Shuming Fan (1):
      ASoC: rt711: mutex between calibration and power state changes

Srinivasa Rao Mandadapu (2):
      ASoC: qcom: Fix incorrect volatile registers
      ASoC: qcom: Add support for playback recover after resume

Stanley Chu (2):
      scsi: ufs: Fix possible power drain during system suspend
      scsi: ufs: Relax the condition of UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_C=
TRL

Stefan Chulski (1):
      net: mvpp2: Remove Pause and Asym_Pause support

Stephan Gerhold (1):
      net: ipa: modem: add missing SET_NETDEV_DEV() for proper sysfs links

Su Yue (2):
      btrfs: prevent NULL pointer dereference in extent_io_tree_panic
      btrfs: tree-checker: check if chunk item end overflows

Takashi Iwai (5):
      ALSA: usb-audio: Fix the missing endpoints creations for quirks
      ALSA: usb-audio: Choose audioformat of a counter-part substream
      ALSA: usb-audio: Avoid unnecessary interface re-setup
      ALSA: usb-audio: Annotate the endpoint index in audioformat
      ALSA: usb-audio: Fix implicit feedback sync setup for Pioneer devices

Tariq Toukan (1):
      net: Allow NETIF_F_HW_TLS_TX if IP_CSUM && IPV6_CSUM

Theodore Ts'o (1):
      ext4: don't leak old mountpoint samples

Thomas Hebb (1):
      ASoC: dapm: remove widget from dirty list on free

Tian Tao (1):
      iommu/vt-d: Fix duplicate included linux/dma-map-ops.h

Tom Parkin (1):
      ppp: fix refcount underflow on channel unbridge

Tom Rix (4):
      HID: uclogic: remove h from printk format specifier
      HID: wiimote: remove h from printk format specifier
      RDMA/ocrdma: Fix use after free in ocrdma_dealloc_ucontext_pd()
      cifs: check pointer before freeing

Trond Myklebust (11):
      nfsd: Fixes for nfsd4_encode_read_plus_data()
      nfsd: Don't set eof on a truncated READ_PLUS
      pNFS: Mark layout for return if return-on-close was not sent
      pNFS: We want return-on-close to complete when evicting the inode
      pNFS: Clean up pnfs_layoutreturn_free_lsegs()
      pNFS: Stricter ordering of layoutget and layoutreturn
      NFS/pNFS: Don't call pnfs_free_bucket_lseg() before removing the requ=
est
      NFS/pNFS: Don't leak DS commits in pnfs_generic_retry_commit()
      NFS/pNFS: Fix a leak of the layout 'plh_outstanding' counter
      NFS: nfs_delegation_find_inode_server must first reference the superb=
lock
      NFS: nfs_igrab_and_active must first reference the superblock

Vadim Fedorenko (1):
      selftests/tls: fix selftests after adding ChaCha20-Poly1305

Vadim Pasternak (2):
      mlxsw: core: Add validation of transceiver temperature thresholds
      mlxsw: core: Increase critical threshold for ASIC thermal zone

Victor Zhao (1):
      drm/amdgpu/psp: fix psp gfx ctrl cmds

Vladimir Oltean (2):
      net: dsa: unbind all switches from tree when DSA master unbinds
      net: dsa: clear devlink port type before unregistering slave netdevs

Vlastimil Babka (1):
      MAINTAINERS: add Vlastimil as slab allocators maintainer

Wayne Lin (1):
      drm/amd/display: Fix to be able to stop crc calculation

Wei Liu (1):
      x86/hyperv: check cpu mask after interrupt has been disabled

Wesley Chalmers (1):
      drm/amd/display: Initialize stack variable

Will Deacon (2):
      Revert "arm64: Enable perf events based hard lockup detector"
      compiler.h: Raise minimum version of GCC to 5.1 for arm64

Willem de Bruijn (3):
      net: support kmap_local forced debugging in skb_frag_foreach
      net: compound page support in skb_seq_read
      esp: avoid unneeded kmap_atomic call

YANG LI (2):
      cifs: connect: style: Simplify bool comparison
      cifs: style: replace one-element array with flexible-array

Yannick Vignon (2):
      net: stmmac: fix taprio schedule configuration
      net: stmmac: fix taprio configuration when base_time is in the past

Yi Li (1):
      ext4: use IS_ERR instead of IS_ERR_OR_NULL and set inode null when IS=
_ERR

chen gong (1):
      drm/amdgpu/gfx10: add updated GOLDEN_TSC_COUNT_UPPER/LOWER
register offsets for VGH

j.nixdorf@avm.de (1):
      net: sunrpc: interpret the return value of kstrtou32 correctly

mengwang (1):
      drm/amdgpu: add new device id for Renior

shengjiu wang (1):
      ASoC: imx-hdmi: Fix warning of the uninitialized variable ret

yangerkun (1):
      ext4: fix bug for rename with RENAME_WHITEOUT
