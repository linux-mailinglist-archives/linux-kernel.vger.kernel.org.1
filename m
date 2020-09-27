Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF6127A44F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 23:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgI0V4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 17:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgI0V4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 17:56:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6859CC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 14:56:34 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y2so8820744lfy.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 14:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QlobbvSVVXJkUjIWa23tFCvYVBpireGZyWLXtkn3Y5A=;
        b=ZSlxALFPwEeN/vmbRkQou4jmuHrMxJtexiXc6y2Y5Bx/99B7YrGSaiA8a3y8TuUgmg
         tK1s9pPEx5Vl7AoUzuxNUgozZBftnQH58pGftdqxIM3i+4ySjLoAybXJ81D3Y+QBm8d3
         PFuwFxrG1aMPiZZGcC3THQyBzskXBQZF1cJXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QlobbvSVVXJkUjIWa23tFCvYVBpireGZyWLXtkn3Y5A=;
        b=hVfwIYZ0InYUJzNJHHP8SXoZLuFh4iq8Fb70kCQZFC7+++RPyRxVQfTgrheisnthr7
         nSa1CR2Py6S3EoEJsx4jdCpxPbbS6ha22Ty3/SaNHrX0gT81WC/k72oytvYhNU6lJ2oO
         ZQnvRpFz++8uTcsBtWMF2Dn1pHNm6qyfNi5XZYgb9WwT4DeVCC/eRq2dat5VnEK5BL7K
         Vi3x0u7i/cW5rmIFo0uIohNkc1plm7vtvVfy7uWEV9+sbXrnmeODPlt4WdIWA3pMO+MJ
         AjWLy/mS10xJk8kRW2RpzDJG+JIRRniSbCWB1gZao8dyfLUo9bVcfGz6X8AHOI1dSkHi
         5K9Q==
X-Gm-Message-State: AOAM532Iv5Mth1OyYJwyCRywfaCUJU6lQuhfK/EU4Xlg/skZU0Qv/E9Q
        wW2lyonQ8WbN6TWor0JAsj0GepBgIarDCw==
X-Google-Smtp-Source: ABdhPJytdi2F70NjhOk53Pn64zCvBun+aumKgdar5tbyxTaY06FUqwnhjQH7/ZXg/3L2aXqHnu8W0Q==
X-Received: by 2002:ac2:51aa:: with SMTP id f10mr2771961lfk.451.1601243791635;
        Sun, 27 Sep 2020 14:56:31 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id c4sm2560528lfr.108.2020.09.27.14.56.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 14:56:30 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id b22so8809986lfs.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 14:56:30 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr3221030lfg.344.1601243790116;
 Sun, 27 Sep 2020 14:56:30 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Sep 2020 14:56:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1SJmva5pQxT-XZkMREOa+iJuy0K8-zua0K=vF-Jz7zw@mail.gmail.com>
Message-ID: <CAHk-=wj1SJmva5pQxT-XZkMREOa+iJuy0K8-zua0K=vF-Jz7zw@mail.gmail.com>
Subject: Linux 5.9-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we finally have all the issues I know about sorted out - the fix
for the VM issue I mentioned in the rc6 announcement is here, as is
the fix for the slab corruption issue that was separately discussed,
along with another silly page locking bug one-liner fix.

But while I do now know of any remaining gating issues any more, the
fixes came in fairly late. So unless I feel insanely optimistic and/or
a burning bush tells me that everything is bug-free, my plan right now
is that I'll do another rc next Sunday rather than the final 5.9
release. And btw, please no more burning bushes. We're kind of
sensitive about those on the West coast right now.

Anyway, while the MM side is what kept me on my toes last week, most
of the changes here are actually drivers and networking. And
networking drivers. With a small smattering of documentation and
filesystem fixes and other noise thrown in.

Shortlog appended, but what I really hope you all will do is to give
it a nice good testing. One extra week or rc kernels will help, but
only if people actually try this out.

So.. Please?

              Linus

---

Adrian Hunter (1):
      ftrace: Fix missing synchronize_rcu() removing trampoline from kallsy=
ms

Al Viro (1):
      fuse: fix the ->direct_IO() treatment of iov_iter

Alaa Hleihel (1):
      net/mlx5e: Fix using wrong stats_grps in mlx5e_update_ndo_stats()

Alexey Dobriyan (1):
      fs: fix cast in fsparam_u32hex() macro

Aloka Dixit (1):
      mac80211: Fix radiotap header channel flag for 6GHz band

Anand Jain (1):
      btrfs: fix put of uninitialized kobject after seed device delete

Andres Beltran (1):
      hv_netvsc: Add validation for untrusted Hyper-V values

Andrii Nakryiko (2):
      docs/bpf: Fix ringbuf documentation
      docs/bpf: Remove source code links

Bj=C3=B6rn T=C3=B6pel (1):
      xsk: Fix number of pinned pages/umem size discrepancy

Borislav Petkov (1):
      rcu/tree: Export rcu_idle_{enter,exit} to modules

Brian Vazquez (1):
      fib: fix fib_rule_ops indirect call wrappers when CONFIG_IPV6=3Dm

Chaitanya Kulkarni (2):
      nvme-core: get/put ctrl and transport module in nvme_dev_open/release=
()
      nvme-core: don't use NVME_NSID_ALL for command effects and supported =
log

Chanwoo Choi (1):
      PM / devfreq: Add timer type to devfreq_summary debugfs

Charan Teja Reddy (1):
      dmabuf: fix NULL pointer dereference in dma_buf_release()

Charles Keepax (2):
      regmap: debugfs: Fix handling of name string for debugfs init delays
      regmap: debugfs: Add back in erroneously removed initialisation of re=
t

Chris Packham (1):
      spi: fsl-espi: Only process interrupts for expected events

Chris Wilson (1):
      drm/i915/selftests: Push the fake iommu device from the stack to data

Christian Borntraeger (1):
      s390/zcrypt: Fix ZCRYPT_PERDEV_REQCNT ioctl

Christoph Hellwig (1):
      nvmet: get transport reference for passthru ctrl

Chuck Lever (1):
      SUNRPC: Fix svc_flush_dcache()

Claudiu Manoil (1):
      enetc: Fix mdio bus removal on PF probe bailout

Colin Ian King (1):
      rhashtable: fix indentation of a continue statement

Collin Walling (1):
      docs: kvm: add documentation for KVM_CAP_S390_DIAG318

Cong Wang (1):
      act_ife: load meta modules before tcf_idr_check_alloc()

Cristobal Forno (1):
      MAINTAINERS: Update ibmveth maintainer

Damien Le Moal (2):
      scsi: sd: sd_zbc: Fix handling of host-aware ZBC disks
      scsi: sd: sd_zbc: Fix ZBC disk initialization

Dan Carpenter (3):
      hdlc_ppp: add range checks in ppp_cp_parse_cr()
      sfc: Fix error code in probe
      PM / devfreq: tegra30: Disable clock on error in probe

Daniel Borkmann (1):
      bpf: Fix clobbering of r2 in bpf_gen_ld_abs

Dany Madden (1):
      ibmvnic: update MAINTAINERS

David Ahern (2):
      ipv4: Initialize flowi4_multipath_hash in data path
      ipv4: Update exception handling for multipath routes via same device

David Milburn (1):
      nvme-pci: disable the write zeros command for Intel 600P/P3100

David S. Miller (1):
      connector: Move maintainence under networking drivers umbrella.

Dexuan Cui (3):
      hv_netvsc: Fix hibernation for mlx5 VF driver
      hv_netvsc: Switch the data path at the right time during hibernation
      hv_netvsc: Cache the current data path to avoid duplicate call and me=
ssage

Dmitry Baryshkov (2):
      regmap: fix page selection for noinc reads
      regmap: fix page selection for noinc writes

Dmitry Bogdanov (3):
      net: qed: Disable aRFS for NPAR and 100G
      net: qede: Disable aRFS for NPAR and 100G
      net: qed: RDMA personality shouldn't fail VF load

Douglas Gilbert (1):
      tools/io_uring: fix compile breakage

Edwin Peer (1):
      bnxt_en: return proper error codes in bnxt_show_temp

Eelco Chaudron (1):
      netfilter: conntrack: nf_conncount_init is failing with IPv6 disabled

Eric Dumazet (5):
      mac802154: tx: fix use-after-free
      ipv6: avoid lockdep issue in fib6_del()
      net: qrtr: check skb_put_padto() return value
      net: add __must_check to skb_put_padto()
      inet_diag: validate INET_DIAG_REQ_PROTOCOL attribute

Felix Fietkau (5):
      mt76: mt7615: use v1 MCU API on MT7615 to fix issues with
adding/removing stations
      mt76: mt7915: use ieee80211_free_txskb to free tx skbs
      mac80211: extend AQL aggregation estimation to HE and fix unit mismat=
ch
      mac80211: add AQL support for VHT160 tx rates
      mac80211: do not allow bigger VHT MPDUs than the hardware supports

Florian Fainelli (3):
      net: phy: Avoid NPD upon phy_detach() when driver is unbound
      net: phy: Do not warn in phy_stop() on PHY_DOWN
      Documentation/llvm: Fix clang target examples

Ganji Aravind (1):
      cxgb4: Fix offset when clearing filter byte counters

Gao Xiang (1):
      mm, THP, swap: fix allocating cluster for swapfile by mistake

Geert Uytterhoeven (1):
      mmc: mmc_spi: Fix mmc_spi_dma_alloc() return type for !HAS_DMA

Geliang Tang (3):
      mptcp: fix subflow's local_id issues
      mptcp: fix subflow's remote_id issues
      mptcp: fix kmalloc flag in mptcp_pm_nl_get_local_id

Grygorii Strashko (1):
      net: ethernet: ti: cpsw_new: fix suspend/resume

Guo Ren (1):
      clocksource/drivers/timer-gx6605s: Fixup counter reload

Hans Verkuil (1):
      media: cec-adap.c: don't use flush_scheduled_work()

Hans de Goede (1):
      vboxsf: Fix the check for the old binary mount-arguments struct

Hauke Mehrtens (4):
      net: lantiq: Wake TX queue again
      net: lantiq: use netif_tx_napi_add() for TX NAPI
      net: lantiq: Use napi_complete_done()
      net: lantiq: Disable IRQs only if NAPI gets scheduled

Helmut Grohne (1):
      net: dsa: microchip: look for phy-mode in port nodes

Henry Ptasinski (1):
      net: sctp: Fix IPv6 ancestor_size calc in sctp_copy_descendant

Huacai Chen (1):
      MIPS: Loongson-3: Fix fp register access if MSA enabled

Hui Wang (1):
      ALSA: hda/realtek - Couldn't detect Mic if booting with headset plugg=
ed

Icenowy Zheng (1):
      regulator: axp20x: fix LDO2/4 description

Ido Schimmel (2):
      net: Fix bridge enslavement failure
      selftests: rtnetlink: Test bridge enslavement with different parent I=
Ds

Jacopo Mondi (1):
      media: dt-bindings: media: imx274: Convert to json-schema

Jakub Kicinski (3):
      ibmvnic: add missing parenthesis in do_reset()
      MAINTAINERS: remove John Allen from ibmvnic
      nfp: use correct define to return NONE fec

James Smart (2):
      scsi: lpfc: Fix initial FLOGI failure due to BBSCN not supported
      nvme-fc: fail new connections to a deleted host or remote port

Jan H=C3=B6ppner (1):
      s390/dasd: Fix zero write for FBA devices

Jan Kara (1):
      dax: Fix compilation for CONFIG_DAX && !CONFIG_FS_DAX

Jason A. Donenfeld (2):
      wireguard: noise: take lock when removing handshake entry from table
      wireguard: peerlookup: take lock before checking hash in replace oper=
ation

Jason Gunthorpe (1):
      RDMA/core: Fix ordering of CQ pool destruction

Jason Yan (3):
      spi: bcm2835: Make polling_limit_us static
      bootconfig: init: make xbc_namebuf static
      lib/memregion.c: include memregion.h

Jeffle Xu (1):
      block: remove unused BLK_QC_T_EAGAIN flag

Jens Axboe (10):
      io_uring: grab any needed state during defer prep
      io_uring: drop 'ctx' ref on task work cancelation
      io_uring: don't run task work on an exiting task
      io_uring: don't re-setup vecs/iter in io_resumit_prep() is already th=
ere
      io_uring: don't use retry based buffered reads for non-async bdev
      io_uring: mark statx/files_update/epoll_ctl as non-SQPOLL
      io_uring: fix openat/openat2 unified prep handling
      io_uring: ensure open/openat2 name is cleaned on cancelation
      io_uring: don't unconditionally set plug->nowait =3D true
      io_uring: ensure async buffered read-retry is setup properly

Jianbo Liu (1):
      net/mlx5e: Fix memory leak of tunnel info when rule under
multipath not ready

Jiaxun Yang (1):
      MIPS: Loongson2ef: Disable Loongson MMI instructions

Jing Xiangfeng (1):
      atm: eni: fix the missed pci_disable_device() for eni_init_one()

Joakim Tjernlund (1):
      ALSA: usb-audio: Add delay quirk for H570e USB headsets

Johannes Berg (1):
      cfg80211: fix 6 GHz channel conversion

Johannes Thumshirn (1):
      btrfs: fix overflow when copying corrupt csums for a message

John Crispin (1):
      mac80211: fix 80 MHz association to 160/80+80 AP on 6 GHz

Julian Wiedmann (1):
      s390/qeth: delay draining the TX buffers

Kai-Heng Feng (2):
      ALSA: hda/realtek: Enable front panel headset LED on Lenovo
ThinkStation P520
      Revert "ALSA: usb-audio: Disable Lenovo P620 Rear line-in volume cont=
rol"

Keith Busch (1):
      nvme: return errors for hwmon init

Laurent Dufour (2):
      mm: replace memmap_context by meminit_context
      mm: don't rely on system state to detect hot-plug operations

Linus L=C3=BCssing (5):
      batman-adv: bla: fix type misuse for backbone_gw hash indexing
      batman-adv: mcast/TT: fix wrongly dropped or rerouted packets
      batman-adv: mcast: fix duplicate mcast packets in BLA backbone from L=
AN
      batman-adv: mcast: fix duplicate mcast packets in BLA backbone from m=
esh
      batman-adv: mcast: fix duplicate mcast packets from BLA backbone to m=
esh

Linus Torvalds (4):
      mm: split out the non-present case from copy_one_pte()
      mm: move the copy_one_pte() pte_present check into the caller
      mm: fix misplaced unlock_page in do_wp_page()
      Linux 5.9-rc7

Linus Walleij (1):
      net: dsa: rtl8366: Properly clear member config

Liu Jian (1):
      ieee802154: fix one possible memleak in ca8210_dev_com_init

Lorenzo Bianconi (2):
      net: mvneta: fix possible use-after-free in mvneta_xdp_put_buff
      net: mvneta: recycle the page in case of out-of-order

Lu Wei (3):
      net: tipc: kerneldoc fixes
      net: hns: kerneldoc fixes
      net: hns: kerneldoc fixes

Lucy Yan (1):
      net: dec: de2104x: Increase receive ring size for Tulip

Luo bin (4):
      hinic: bump up the timeout of SET_FUNC_STATE cmd
      hinic: bump up the timeout of UPDATE_FW cmd
      hinic: fix rewaking txq after netif_tx_disable
      hinic: fix sending pkts from core while self testing

Maor Dickman (2):
      net/mlx5e: Enable adding peer miss rules only if merged eswitch
is supported
      net/mlx5e: Fix endianness when calculating pedit mask first bit

Maor Gottlieb (1):
      net/mlx5: Fix FTE cleanup

Marc Zyngier (2):
      KVM: arm64: Assume write fault on S1PTW permission fault on
instruction fetch
      KVM: arm64: Remove S1PTW check from kvm_vcpu_dabt_iswrite()

Marek Szyprowski (1):
      drm/vc4/vc4_hdmi: fill ASoC card owner

Mark Gray (1):
      geneve: add transport ports in route lookup for geneve

Martin Cerveny (2):
      drm/sun4i: sun8i-csc: Secondary CSC register correction
      drm/sun4i: mixer: Extend regmap max_register

Martin KaFai Lau (1):
      bpf: Bpf_skc_to_* casting helpers require a NULL check on sk

Martin Willi (1):
      netfilter: ctnetlink: fix mark based dump filtering regression

Masahiro Yamada (1):
      scripts/kallsyms: skip ppc compiler stub *.long_branch.* / *.plt_bran=
ch.*

Masami Hiramatsu (6):
      kprobes: Fix to check probe enabled before disarm_kprobe_ftrace()
      kprobes: tracing/kprobes: Fix to kill kprobes on initmem after boot
      lib/bootconfig: Fix a bug of breaking existing tree nodes
      lib/bootconfig: Fix to remove tailing spaces after value
      tools/bootconfig: Add testcases for repeated key with brace
      tools/bootconfig: Add testcase for tailing space

Matthias Schiffer (1):
      net: dsa: microchip: ksz8795: really set the correct number of ports

Mauro Carvalho Chehab (1):
      Revert "wlcore: Adding suppoprt for IGTK key in wlcore driver"

Maxim Levitsky (1):
      KVM: x86: fix MSR_IA32_TSC read for nested migration

Maxim Mikityanskiy (2):
      net/mlx5e: Use RCU to protect rq->xdp_prog
      net/mlx5e: Use synchronize_rcu to sync with NAPI

Maximilian Luz (1):
      mwifiex: Increase AES key storage size to 256 bits

Miaohe Lin (2):
      net: Correct the comment of dst_dev_put()
      net: Fix broken NETIF_F_CSUM_MASK spell in netdev_features.h

Michael Chan (3):
      bnxt_en: Protect bnxt_set_eee() and bnxt_set_pauseparam() with mutex.
      bnxt_en: Fix HWRM_FUNC_QSTATS_EXT firmware call.
      bnxt_en: Fix wrong flag value passed to HWRM_PORT_QSTATS_EXT fw call.

Michal Kubecek (1):
      ethtool: add and use message type for tunnel info reply

Mike Snitzer (2):
      dm: fix bio splitting and its bio completion order for regular IO
      dm: fix comment in dm_process_bio()

Mikulas Patocka (1):
      arch/x86/lib/usercopy_64.c: fix __copy_user_flushcache() cache writeb=
ack

Milan Broz (2):
      dm crypt: document new no_workqueue flags
      dm crypt: document encrypted keyring key option

Minchan Kim (1):
      mm: validate pmd after splitting

Miroslav Benes (1):
      ftrace: Free the trampoline when ftrace_startup() fails

Mohammed Gamal (1):
      KVM: x86: VMX: Make smaller physical guest address space support
user-configurable

Muchun Song (1):
      mm: memcontrol: fix missing suffix of workingset_restore

Naveen N. Rao (1):
      libbpf: Remove arch-specific include path in Makefile

Necip Fazil Yildiran (3):
      nvme-tcp: fix kconfig dependency warning when !CRYPTO
      lib80211: fix unmet direct dependendices config warning when !CRYPTO
      net: ipv6: fix kconfig dependency warning for IPV6_SEG6_HMAC

Nick Desaulniers (1):
      lib/string.c: implement stpcpy

Nicolas Dichtel (1):
      netlink: fix doc about nlmsg_parse/nla_validate

Olympia Giannou (1):
      rndis_host: increase sleep time in the query-response loop

Pablo Neira Ayuso (2):
      netfilter: nf_tables: coalesce multiple notifications into one skbuff
      netfilter: nft_meta: use socket user_ns to retrieve skuid and skgid

Parshuram Thombare (1):
      net: macb: fix for pause frame receive enable bit

Paul E. McKenney (1):
      rcu-tasks: Prevent complaints of unused
show_rcu_tasks_classic_gp_kthread()

Peilin Ye (1):
      tipc: Fix memory leak in tipc_group_create_member()

Peter Xu (4):
      mm: Introduce mm_struct.has_pinned
      mm/fork: Pass new vma pointer into copy_page_range()
      mm: Do early cow for pinned pages during fork() for ptes
      mm/thp: Split huge pmds/puds if they're pinned when fork()

Petr Machata (1):
      net: DCB: Validate DCB_ATTR_DCB_BUFFER argument

Rafael J. Wysocki (1):
      ACPI: processor: Fix build for ARCH_APICTIMER_STOPS_ON_C3 unset

Raju Rangoju (1):
      cxgb4: fix memory leak during module unload

Randy Dunlap (2):
      netdevice.h: fix proto_down_reason kernel-doc warning
      netdevice.h: fix xdp_state kernel-doc warning

Ray Jui (1):
      spi: bcm-qspi: Fix probe regression on iProc platforms

Roi Dayan (1):
      net/mlx5e: CT: Fix freeing ct_label mapping

Ron Diskin (1):
      net/mlx5e: Fix multicast counter not up-to-date in "ip -s"

Saeed Mahameed (4):
      net/mlx5e: kTLS, Add missing dma_unmap in RX resync
      net/mlx5e: kTLS, Fix leak on resync error flow
      net/mlx5e: kTLS, Avoid kzalloc(GFP_KERNEL) under spinlock
      net/mlx5e: mlx5e_fec_in_caps() returns a boolean

Sascha Hauer (1):
      spi: fsl-dspi: fix use-after-free in remove path

Sean Christopherson (1):
      KVM: x86: Reset MMU context if guest toggles CR4.SMAP or CR4.PKE

Sean Wang (1):
      net: Update MAINTAINERS for MediaTek switch driver

Sebastian Andrzej Siewior (1):
      tracing: Make the space reserved for the pid wider

Sergey Senozhatsky (1):
      media: media/v4l2: remove V4L2_FLAG_MEMORY_NON_CONSISTENT flag

Shakeel Butt (1):
      mm: slab: fix potential double free in ___cache_free

Stefan Assmann (2):
      i40e: fix return of uninitialized aq_ret in i40e_set_vsi_promisc
      i40e: always propagate error value in i40e_set_vsi_promisc()

Sven Eckelmann (1):
      batman-adv: Add missing include for in_interrupt()

Taehee Yoo (1):
      Revert "netns: don't disable BHs when locking "nsid_lock""

Takashi Iwai (1):
      Revert "ALSA: hda - Fix silent audio output and corrupted input
on MSI X570-A PRO"

Tariq Toukan (2):
      net/mlx5e: TLS, Do not expose FPGA TLS counter if not supported
      net/mlx5e: kTLS, Fix napi sync and possible use-after-free

Tetsuo Handa (1):
      tipc: fix shutdown() of connection oriented socket

Thomas Gleixner (2):
      x86/irq: Make run_on_irqstack_cond() typesafe
      x86/ioapic: Unbreak check_timer()

Tianjia Zhang (1):
      clocksource/drivers/h8300_timer8: Fix wrong return value in
h8300_8timer_init()

Tobias Klauser (1):
      ftrace: Let ftrace_enable_sysctl take a kernel pointer buffer

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      tools/bpf: build: Make sure resolve_btfids cleans up after itself

Tom Lendacky (1):
      KVM: SVM: Add a dedicated INVD intercept routine

Tom Rix (3):
      ieee802154/adf7242: check status of adf7242_read_reg
      tracing: fix double free
      ALSA: asihpi: fix iounmap in error handler

Tony Ambardar (2):
      libbpf: Fix build failure from uninitialized variable warning
      tools/libbpf: Avoid counting local symbols in ABI check

Tony Lindgren (1):
      clocksource/drivers/timer-ti-dm: Do reset before enable

Ulf Hansson (2):
      cpuidle: psci: Fix suspicious RCU usage
      cpuidle: Drop misleading comments about RCU usage

Vadym Kochan (1):
      net: ipa: fix u32_replace_bits by u32p_xxx version

Vasily Gorbik (1):
      mm/gup: fix gup_fast with dynamic page table folding

Vasundhara Volam (4):
      bnxt_en: Avoid sending firmware messages when AER error is detected.
      bnxt_en: Fix NULL ptr dereference crash in bnxt_fw_reset_task()
      bnxt_en: Use memcpy to copy VPD field info.
      bnxt_en: Return -EOPNOTSUPP for ETHTOOL_GREGS on VFs.

Vinicius Costa Gomes (3):
      igc: Fix wrong timestamp latency numbers
      igc: Fix not considering the TX delay for timestamps
      taprio: Fix allowing too small intervals

Vitaly Kuznetsov (1):
      Revert "KVM: Check the allocation of pv cpu mask"

Vladimir Oltean (13):
      net: dsa: link interfaces with the DSA master to get rid of
lockdep warnings
      spi: spi-fsl-dspi: use XSPI mode instead of DMA for DPAA2 SoCs
      net: mscc: ocelot: fix race condition with TX timestamping
      net: mscc: ocelot: add locking for the port TX timestamp ID
      net: dsa: seville: fix buffer size of the queue system
      net: mscc: ocelot: check for errors on memory allocation of ports
      net: mscc: ocelot: error checking when calling ocelot_init()
      net: mscc: ocelot: refactor ports parsing code into a dedicated funct=
ion
      net: mscc: ocelot: unregister net devices on unbind
      net: mscc: ocelot: deinitialize only initialized ports
      net: bridge: br_vlan_get_pvid_rcu() should dereference the VLAN
group under RCU
      net: dsa: seville: fix some key offsets for IP4_TCP_UDP VCAP IS2 entr=
ies
      net: mscc: ocelot: fix some key offsets for IP4_TCP_UDP VCAP IS2 entr=
ies

Wei Li (3):
      hinic: fix potential resource leak
      MIPS: Add the missing 'CPU_1074K' into __get_cpu_type()
      MIPS: BCM47XX: Remove the needless check with the 1074K

Wei Wang (1):
      ip: fix tos reflection in ack and reset packets

Wen Gong (1):
      mac80211: do not disable HE if HT is missing on 2.4 GHz

Will McVicker (1):
      netfilter: ctnetlink: add a range check for l3/l4 protonum

Wright Feng (1):
      brcmfmac: reserve tx credit only when txctl is ready to send

Xianting Tian (1):
      nvme-pci: fix NULL req in completion handler

Xiaoliang Yang (1):
      net: dsa: felix: fix some key offsets for IP4_TCP_UDP VCAP IS2 entrie=
s

Xie He (3):
      drivers/net/wan/hdlc_fr: Add needed_headroom for PVC devices
      drivers/net/wan/lapbether: Make skb->protocol consistent with the hea=
der
      drivers/net/wan/hdlc: Set skb->protocol before transmitting

Xin Long (4):
      tipc: use skb_unshare() instead in tipc_buf_append()
      net: sched: only keep the available bits when setting vxlan md->gbp
      lwtunnel: only keep the available bits when setting vxlan md->gbp
      net: sched: initialize with 0 before setting erspan md->u

Xu Wang (1):
      ipv6: route: convert comma to semicolon

Yang Weijiang (1):
      selftests: kvm: Fix assert failure in single-step test

Yangbo Lu (1):
      dpaa2-eth: fix a build warning in dpmac.c

Ye Bin (1):
      hsr: avoid newline at end of message in NL_SET_ERR_MSG_MOD

Yonghong Song (3):
      bpf: Do not use bucket_lock for hashmap iterator
      selftests/bpf: Add bpf_{update, delete}_map_elem in hashmap iter prog=
ram
      bpf: Fix a rcu warning for bpffs map pretty-print

Yoshihiro Shimoda (1):
      net: phy: call phy_disable_interrupts() in phy_attach_direct() instea=
d

Yunsheng Lin (1):
      net: sch_generic: aviod concurrent reset and enqueue op for lockless =
qdisc

Zhenyu Wang (1):
      drm/i915/gvt: Fix port number for BDW on EDID region setup

Zi Yan (1):
      mm/migrate: correct thp migration stats
