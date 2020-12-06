Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AF22D07B6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 23:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgLFWlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 17:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgLFWlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 17:41:17 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB90C0613D2
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 14:40:36 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id w13so2643294lfd.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 14:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/jqiaOILZohB2Q0iYlg5btjn4ETeEp3enZDW3dgM4sU=;
        b=aCDyDWUA4ieQPZS6zL7e9kxKdBVIQnhvBHzCZCBAKg78ApFQq97KEK06wIICIksPDG
         A02aoXR0bIchoT8Y36ShkiYE5k0vRJN1Ecqklf4rHDQRyS09kNgYoPeuDdIavSBEfF6T
         Gns7mEgfSYnVmeK340kBXSqm14icIxp57iQjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/jqiaOILZohB2Q0iYlg5btjn4ETeEp3enZDW3dgM4sU=;
        b=Nq+/d2y+J9/JSY/MVaTUp5d2PQ7sikem2McM761BRyz4PiwJAwIj9yXsOI4TVOxMMO
         OzPtnRDTqHaGeo1XZAveTUpaevpd/ZBYdEx5+MMnuCIuyHx+2MBodRBHdEuIOZLwlKep
         eG/hIgqBxcRMtgLabWqQDSKg8qQBWC+sRNe/GEGEMQ+ex+kEJEzs/2mlJZ0v62LuLuBE
         tqe/rqrB8f7jr3d/rng/s9kK6WEtRMdQMbRU/baKEbmbqfubbt/H4TW6JTTctoLgUjGb
         n55w2EXifbmUZIg+F39oATbhigUmNy8mdf4XIJMlvZyewsnwuo1TQw62KuGmG7HJbEK3
         T1fQ==
X-Gm-Message-State: AOAM533NG6IC/w/iCJ17jD/EBGqAdzwQtJg/LBLj4Rm78yDYReC5KbNw
        3OznGqsVinXmauFC6U889WcDOAnTU3HqYQ==
X-Google-Smtp-Source: ABdhPJxADkesCb8+IOx2kgeZiyRJI0z1xVI4seGfLyl60U2emi1PufNU1Eie6+zoSqXM0KSW5++v6A==
X-Received: by 2002:a19:890b:: with SMTP id l11mr2866130lfd.66.1607294434215;
        Sun, 06 Dec 2020 14:40:34 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id z7sm2658332lfr.304.2020.12.06.14.40.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Dec 2020 14:40:33 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id s30so15332336lfc.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 14:40:33 -0800 (PST)
X-Received: by 2002:ac2:46c3:: with SMTP id p3mr1136374lfo.105.1607294432793;
 Sun, 06 Dec 2020 14:40:32 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Dec 2020 14:40:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtCzNv7ghB=1VK1fYe82GwiS8xdaXTDqcVzQKn4QfrXw@mail.gmail.com>
Message-ID: <CAHk-=wgtCzNv7ghB=1VK1fYe82GwiS8xdaXTDqcVzQKn4QfrXw@mail.gmail.com>
Subject: Linux 5.10-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things look pretty good (knock wood), and  rc7 is solidly in the
average size department, with nothing that looks particularly scary.

There's patches all over: drivers, architectures, networking.
filesystems, mm, tooling, etc. But most of it is pretty small. The
exceptions are a revert of a new virtio MEI driver that wasn't quite
ready, some changes to the IBM vnic driver, and some arm64 entry code
fixes. But those don't feel particularly worrisome, and the rest all
looks normal.

So unless something odd and bad happens next week, we'll have a final
5.10 release next weekend, and then we'll get the bulk of the merge
window for 5.11 over and done with before the holiday season starts.

And in the meantime, please do give this all a whirl,

              Linus

---

Alex Shi (1):
      mm/filemap: add static for function __add_to_page_cache_locked

Alexander Aring (2):
      gfs2: Fix deadlock dumping resource group glocks
      gfs2: set lockdep subclass for iopen glocks

Alexander Gordeev (1):
      s390/pci: fix CPU address in MSI for directed IRQ

Andrea Parri (Microsoft) (1):
      scsi: storvsc: Validate length of incoming packet in
storvsc_on_channel_callback()

Andrea Righi (1):
      ring-buffer: Set the right timestamp in the slow path of
__rb_reserve_next()

Andreas Gruenbacher (2):
      gfs2: Upgrade shared glocks for atime updates
      gfs2: Fix deadlock between gfs2_{create_inode,inode_lookup} and
delete_work_func

Antoine Tenart (2):
      netfilter: bridge: reset skb->pkt_type after
NF_INET_POST_ROUTING traversal
      net: ip6_gre: set dev->hard_header_len when using header_ops

Arnd Bergmann (2):
      Makefile.extrawarn: move -Wcast-align to W=3D3
      i2c: mlxbf: select CONFIG_I2C_SLAVE

Arunpravin (1):
      drm/amdgpu/pm/smu11: Fix fan set speed bug

Aurelien Aptel (1):
      cifs: add NULL check for ses->tcon_ipc

Axel Rasmussen (1):
      userfaultfd: selftests: fix SIGSEGV if huge mmap fails

Babu Moger (1):
      x86/resctrl: Fix AMD L3 QOS CDP enable/disable

Bj=C3=B6rn T=C3=B6pel (1):
      net, xsk: Avoid taking multiple skbuff references

Bj=C3=B8rn Mork (1):
      USB: serial: option: fix Quectel BG96 matching

Bob Peterson (2):
      gfs2: check for empty rgrp tree in gfs2_ri_update
      gfs2: Don't freeze the file system during unmount

Boyuan Zhang (2):
      drm/amdgpu/vcn3.0: stall DPG when WPTR/RPTR reset
      drm/amdgpu/vcn3.0: remove old DPG workaround

Brandon Syu (1):
      drm/amd/display: Init clock value by current vbios CLKs

Chris Wilson (5):
      drm/i915/gt: Program mocs:63 for cache eviction on gen9
      drm/i915/gt: Protect context lifetime with RCU
      drm/i915/gt: Split the breadcrumb spinlock between global and context=
s
      drm/i915/gt: Limit frequency drop to RPe on parking
      drm/i915/display: Defer initial modeset until after GGTT is initialis=
ed

Christian Eggers (3):
      i2c: imx: Fix reset of I2SR_IAL flag
      i2c: imx: Check for I2SR_IAL after every byte
      i2c: imx: Don't generate STOP condition if arbitration has been lost

Christian K=C3=B6nig (1):
      drm/nouveau: make sure ret is initialized in nouveau_ttm_io_mem_reser=
ve

Dan Carpenter (4):
      vhost_vdpa: return -EFAULT if copy_to_user() fails
      net/x25: prevent a couple of overflows
      rtw88: debug: Fix uninitialized memory in debugfs code
      chelsio/chtls: fix a double free in chtls_setkey()

Daniel Abrecht (1):
      drm: mxsfb: Implement .format_mod_supported

Dany Madden (7):
      ibmvnic: handle inconsistent login with reset
      ibmvnic: stop free_all_rwi on failed reset
      ibmvnic: avoid memset null scrq msgs
      ibmvnic: restore adapter state on failed reset
      ibmvnic: send_login should check for crq errors
      ibmvnic: no reset timeout for 5 seconds after reset
      ibmvnic: reduce wait for completion time

David Gow (1):
      fpga: Specify HAS_IOMEM dependency for FPGA_DFL

Davide Caratti (4):
      selftests: tc-testing: enable CONFIG_NET_SCH_RED as a module
      net: skbuff: ensure LSE is pullable before decrementing the MPLS ttl
      net: openvswitch: ensure LSE is pullable before reading it
      net/sched: act_mpls: ensure LSE is pullable before reading it

Deepak R Varma (1):
      drm/tegra: replace idr_init() by idr_init_base()

Denys Zagorui (1):
      kbuild: use -fmacro-prefix-map for .S sources

Dmitry Torokhov (1):
      Input: soc_button_array - add missing include

Dominique Martinet (1):
      fs: 9p: add generic splice_write file operation

Eran Ben Elisha (1):
      net/mlx5: Fix wrong address reclaim when command interface is down

Eric Dumazet (2):
      netfilter: ipset: prevent uninit-value in hash_ip6_add
      geneve: pull IP header before ECN decapsulation

Eric Sandeen (1):
      uapi: fix statx attribute value overlap for DAX & MOUNT_ROOT

Florian Westphal (1):
      netfilter: nf_tables: avoid false-postive lockdep splat

Giacinto Cifelli (1):
      USB: serial: option: add support for Thales Cinterion EXS82

Golan Ben Ami (1):
      iwlwifi: pcie: add some missing entries for AX210

Greg Kroah-Hartman (3):
      Revert "uas: bump hw_max_sectors to 2048 blocks for SS or faster driv=
es"
      Revert "uas: fix sdev->host->dma_dev"
      Revert "usb-storage: fix sdev->host->dma_dev"

Greg Kurz (1):
      KVM: PPC: Book3S HV: XIVE: Fix vCPU id sanity check

Guillaume Nault (1):
      ipv4: Fix tos mask in inet_rtm_getroute()

Hans de Goede (1):
      ASoC: Intel: bytcr_rt5640: Fix HP Pavilion x2 Detachable quirks

Hector Martin (1):
      ALSA: usb-audio: US16x08: fix value count for level meters

Heiko Carstens (1):
      s390: fix irq state tracing

Hoang Le (1):
      tipc: fix incompatible mtu of transmission

Jan-Niklas Burfeind (1):
      USB: serial: ch341: add new Product ID for CH341A

Jani Nikula (1):
      drm/i915/display: return earlier from intel_modeset_init() without di=
splay

Jann Horn (2):
      tty: Fix ->pgrp locking in tiocspgrp()
      tty: Fix ->session locking

Jeroen Hofstee (2):
      can: sja1000: sja1000_err(): don't count arbitration lose as an error
      can: sun4i_can: sun4i_can_err(): don't count arbitration lose as an e=
rror

Jesper Dangaard Brouer (1):
      MAINTAINERS: Update XDP and AF_XDP entries

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable headset of ASUS UX482EG & B9400CEA with ALC=
294

Jing Xiangfeng (1):
      scsi: storvsc: Fix error return in storvsc_probe()

Johan Hovold (2):
      USB: serial: ch341: sort device-id entries
      USB: serial: kl5kusb105: fix memleak on open

Johannes Berg (1):
      iwlwifi: update MAINTAINERS entry

Jon Hunter (1):
      drm/tegra: sor: Don't warn on probe deferral

KP Singh (1):
      bpf: Add MAINTAINERS entry for BPF LSM

Kailang Yang (2):
      ALSA: hda/realtek - Fixed Dell AIO wrong sound tone
      ALSA: hda/realtek - Add new codec supported for ALC897

Krzysztof Kozlowski (1):
      dt-bindings: net: correct interrupt flags in examples

Laurent Vivier (2):
      genirq/irqdomain: Add an irq_create_mapping_affinity() function
      powerpc/pseries: Pass MSI affinity to irq_create_mapping()

Linus Torvalds (1):
      Linux 5.10-rc7

Linus Walleij (2):
      Input: atmel_mxt_ts - fix lost interrupts
      usb: ohci-omap: Fix descriptor conversion

Liu Zixian (1):
      mm/mmap.c: fix mmap return value when vma is merged after call_mmap()

Luca Coelho (2):
      iwlwifi: pcie: add one missing entry for AX210
      iwlwifi: pcie: invert values of NO_160 device config entries

Lucas Stach (1):
      drm: mxsfb: fix fence synchronization

Luo Meng (2):
      Input: i8042 - fix error return code in i8042_setup_aux()
      ASoC: wm_adsp: fix error return code in wm_adsp_load()

Magnus Karlsson (1):
      xsk: Fix umem cleanup bug at socket destruct

Marc Kleine-Budde (1):
      can: m_can: tcan4x5x_can_probe(): fix error path: remove
erroneous clk_disable_unprepare()

Marc Zyngier (2):
      drm/tegra: sor: Ensure regulators are disabled on teardown
      MAINTAINERS: Move Jason Cooper to CREDITS

Marek Majtyka (1):
      xsk: Fix incorrect netdev reference count

Mark Rutland (11):
      arm64: syscall: exit userspace before unmasking exceptions
      arm64: mark idle code as noinstr
      arm64: entry: mark entry code as noinstr
      arm64: entry: move enter_from_user_mode to entry-common.c
      arm64: entry: prepare ret_to_user for function call
      arm64: entry: move el1 irq/nmi logic to C
      arm64: entry: fix non-NMI user<->kernel transitions
      arm64: ptrace: prepare for EL1 irq/rcu tracking
      arm64: entry: fix non-NMI kernel<->kernel transitions
      arm64: entry: fix NMI {user, kernel}->kernel transitions
      arm64: entry: fix EL1 debug transitions

Masahiro Yamada (1):
      kbuild: avoid split lines in .mod files

Masami Hiramatsu (10):
      tools/bootconfig: Fix errno reference after printf()
      tools/bootconfig: Fix to check the write failure correctly
      tools/bootconfig: Align the bootconfig applied initrd image size to 4
      docs: bootconfig: Update file format on initrd image
      bootconfig: Load size and checksum in the footer as le32
      tools/bootconfig: Store size and checksum in footer as le32
      docs: bootconfig: Add the endianness of fields
      x86/uprobes: Do not use prefixes.nbytes when looping over prefixes.by=
tes
      x86/insn-eval: Use new for_each_insn_prefix() macro to loop over
prefixes bytes
      x86/sev-es: Use new for_each_insn_prefix() macro to loop over
prefixes bytes

Menglong Dong (1):
      coredump: fix core_pattern parse error

Michael S. Tsirkin (1):
      Revert "mei: virtio: virtualization frontend driver"

Mika Westerberg (1):
      thunderbolt: Fix use-after-free in remove_unplugged_switch()

Mike Christie (1):
      vhost scsi: fix lun reset completion handling

Mike Kravetz (1):
      hugetlb_cgroup: fix offline of hugetlb cgroup with reservations

Mike Snitzer (6):
      block: use gcd() to fix chunk_sectors limit stacking
      dm writecache: remove BUG() and fail gracefully instead
      dm: fix IO splitting
      dm: fix double RCU unlock in dm_dax_zero_page_range() error path
      dm: remove invalid sparse __acquires and __releases annotations
      block: fix incorrect branching in blk_max_size_offset()

Mike Travis (1):
      x86/platform/uv: Fix UV4 hub revision adjustment

Mikulas Patocka (3):
      dm integrity: don't use drivers that have CRYPTO_ALG_ALLOCATES_MEMORY
      dm writecache: advance the number of arguments when reporting max_age
      dm writecache: fix the maximum number of arguments

Minchan Kim (2):
      tracing: Fix alignment of static buffer
      mm/zsmalloc.c: drop ZSMALLOC_PGTABLE_MAPPING

Namhyung Kim (1):
      perf/x86/intel: Fix a warning on x86_pmu_stop() with large PEBS

Namjae Jeon (1):
      smb3: set COMPOUND_FID to FileID field of subsequent compound request

Nathan Chancellor (2):
      kbuild: Hoist '--orphan-handling' into Kconfig
      kbuild: Disable CONFIG_LD_ORPHAN_WARN for ld.lld 10.0.1

Naveen N. Rao (2):
      ftrace: Fix updating FTRACE_FL_TRAMP
      ftrace: Fix DYNAMIC_FTRACE_WITH_DIRECT_CALLS dependency

Nicholas Piggin (5):
      powerpc/64s: Fix hash ISA v3.0 TLBIEL instruction generation
      powerpc/64s/pseries: Fix hash tlbiel_all_isa300 for guest kernels
      kernel/cpu: add arch override for clear_tasks_mm_cpumask() mm handlin=
g
      powerpc/64s: Trim offlined CPUs from mm_cpumasks
      powerpc/64s/powernv: Fix memory corruption when saving SLB entries on=
 MCE

Nick Desaulniers (2):
      Kbuild: do not emit debug info for assembly with LLVM_IAS=3D1
      Revert "dm cache: fix arm link errors with inline"

Ofir Bitton (2):
      habanalabs: free host huge va_range if not used
      habanalabs: put devices before driver removal

Pablo Neira Ayuso (2):
      netfilter: nftables_offload: set address type in control dissector
      netfilter: nftables_offload: build mask based from the matching bytes

Paul Kocialkowski (1):
      drm/rockchip: Avoid uninitialized use of endpoint id in LVDS

Paulo Alcantara (2):
      cifs: allow syscalls to be restarted in __smb_send_rqst()
      cifs: fix potential use-after-free in cifs_echo_request()

Pavel Begunkov (1):
      io_uring: fix recvmsg setup with compat buf-select

Peter Chen (2):
      usb: cdns3: gadget: clear trb->length as zero after preparing every t=
rb
      usb: cdns3: core: fix goto label for error path

Peter Zijlstra (1):
      intel_idle: Build fix

Po-Hsu Lin (1):
      Input: i8042 - add ByteSpeed touchpad to noloop table

Qian Cai (1):
      mm/swapfile: do not sleep with a spin lock held

Qinglang Miao (1):
      drm/tegra: sor: Disable clocks on error in tegra_sor_init()

Randy Dunlap (4):
      net: broadcom CNIC: requires MMU
      vdpa: mlx5: fix vdpa/vhost dependencies
      net: mlx5e: fix fs_tcp.c build when IPV6 is not enabled
      zlib: export S390 symbols for zlib modules

Robert Foss (1):
      i2c: qcom: Fix IRQ error misassignement

Roger Quadros (1):
      usb: cdns3: Fix hardware based role switch

Roman Gushchin (1):
      mm: memcg/slab: fix obj_cgroup_charge() return value handling

Ronnie Sahlberg (1):
      cifs: refactor create_sd_buf() and and avoid corrupting the buffer

Sami Tolvanen (1):
      samples/ftrace: Mark my_tramp[12]? global

Samuel Thibault (1):
      speakup: Reject setting the speakup line discipline outside of speaku=
p

Sanjay Govind (1):
      Input: xpad - support Ardwiino Controllers

Sebastian Reichel (1):
      drm/panel: sony-acx565akm: Fix race condition in probe

Sergei Shtepa (1):
      dm: fix bug with RCU locking in dm_blk_report_zones

Shuming Fan (1):
      ASoC: rt5682: change SAR voltage threshold

Si-Wei Liu (1):
      vhost-vdpa: fix page pinning leakage in error path (rework)

Sreekanth Reddy (1):
      scsi: mpt3sas: Increase IOCInit request timeout to 30s

Srikar Dronamraju (1):
      powerpc/numa: Fix a regression on memoryless node 0

Srinivasa Rao Mandadapu (1):
      ASoC: qcom: Fix enabling BCLK and LRCLK in LPAIF invalid state

Stanislaw Gruszka (1):
      mt76: usb: fix crash on device removal

Stefano Garzarella (1):
      vringh: fix vringh_iov_push_*() documentation

Stephane Eranian (1):
      perf/x86/intel: Check PEBS status correctly

Steven Rostedt (VMware) (2):
      ring-buffer: Update write stamp with the correct ts
      ring-buffer: Always check to put back before stamp when crossing page=
s

Suganath Prabu S (1):
      scsi: mpt3sas: Fix ioctl timeout

Sukadev Bhattiprolu (2):
      ibmvnic: delay next reset if hard reset fails
      ibmvnic: track pending login

Sven Eckelmann (5):
      batman-adv: Consider fragmentation for needed_headroom
      batman-adv: Reserve needed_*room for fragments
      batman-adv: Don't always reallocate the fragmentation skb head
      vxlan: Add needed_headroom for lower device
      vxlan: Copy needed_tailroom from lowerdev

Takashi Iwai (3):
      ALSA: hda/generic: Add option to enforce preferred_dacs pairs
      ALSA: hda/realtek: Fix bass speaker DAC assignment on Asus Zephyrus G=
14
      ALSA: hda/realtek: Add mute LED quirk to yet another HP x360 model

Tariq Toukan (1):
      net/mlx5e: kTLS, Enforce HW TX csum offload with kTLS

Thierry Reding (1):
      drm/tegra: output: Do not put OF node twice

Thomas Falcon (2):
      ibmvnic: Ensure that SCRQ entry reads are correctly ordered
      ibmvnic: Fix TX completion error handling

Thomas Gleixner (1):
      dm table: Remove BUG_ON(in_interrupt())

Toke H=C3=B8iland-J=C3=B8rgensen (2):
      fs: 9p: add generic splice_read file operations
      inet_ecn: Fix endianness of checksum update when setting ECT(1)

Tomi Valkeinen (1):
      drm/omap: sdi: fix bridge enable/disable

Uwe Kleine-K=C3=B6nig (2):
      pwm: sl28cpld: fix getting driver data in pwm callbacks
      mailmap: add two more addresses of Uwe Kleine-K=C3=B6nig

Vamsi Krishna Samavedam (1):
      usb: gadget: f_fs: Use local copy of descriptors for userspace copy

Vasily Averin (1):
      tracing: Remove WARN_ON in start_thread()

Venkata Ramana Nayana (1):
      drm/i915/gt: Retain default context state across shrinking

Vinay Kumar Yadav (1):
      chelsio/chtls: fix panic during unload reload chtls

Vincent Palatin (1):
      USB: serial: option: add Fibocom NL668 variants

Vincenzo Frascino (1):
      arm64: mte: Fix typo in macro definition

Wang Hai (2):
      ipvs: fix possible memory leak in ip_vs_control_net_init
      net: mvpp2: Fix error return code in mvpp2_open()

Wang Xiaojun (1):
      i2c: mlxbf: Fix the return check of devm_ioremap and ioremap

Willy Tarreau (1):
      lib/syscall: fix syscall registers retrieval on 32-bit platforms

Xingxing Su (1):
      tools/testing/selftests/vm: fix build error

Yang Shi (1):
      mm: list_lru: set shrinker map bit when child nr_items is not zero

Yangbo Lu (1):
      dpaa_eth: copy timestamp fields to new skb in A-050385 workaround

Yevgeny Kliteynik (1):
      net/mlx5: DR, Proper handling of unsupported Connect-X6DX SW steering

Zhang Changzhong (3):
      cxgb3: fix error return code in t3_sge_alloc_qset()
      net: pasemi: fix error return code in pasemi_mac_open()
      vxlan: fix error return code in __vxlan_dev_create()

Zhang Qilong (2):
      can: c_can: c_can_power_up(): fix error handling
      can: kvaser_pciefd: kvaser_pciefd_open(): fix error handling

Zhen Lei (1):
      bpftool: Fix error return value in build_btf_type_table

Zhihao Cheng (1):
      i2c: qup: Fix error return code in qup_i2c_bam_schedule_desc()
