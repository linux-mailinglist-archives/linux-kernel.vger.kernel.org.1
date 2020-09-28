Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C1A27A5BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 05:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI1DR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 23:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgI1DR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 23:17:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0575C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 20:17:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so7053589pgl.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 20:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=LavwGMbo0BMR+8bnSM0HgKKv2d5konIfb2udRJeaFsM=;
        b=e6ixB1XO8Qvplcz5mm1QCnfUzRmQSfUHEhP/g2O7C9KTZOEqzkPeDrpIuu02xadnmk
         Azaagme4yr4h8wu0BC5lL+4mOocwvr4KoUyiJfxNxFkj8qya88Zfd0BOObhd6eQZJMEd
         YgGMNrFC1hDrevxxayPTh0W2QyKK28zT8qjh3wjPUQmyyDivkDcw7qAq/ckNys3TnrUa
         H43//TDGf7MZ0a5+tMcZzb764HCIecQ4BuM2aDtFiCwMkKlDmFU98cvhytGO/ZPEHSqi
         tsbfprhgrilujR9rhsHEWHhMQOLO3gIZjkbrvYb4EDJj5PbBwx7YhvU8uka3ozQAuZcZ
         P7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=LavwGMbo0BMR+8bnSM0HgKKv2d5konIfb2udRJeaFsM=;
        b=PCSCkm/M5sA/2rBcWzB34nMwmwwpMWAOEwI7bW6kMj5ImNwOVF0ZFUkx5UKKWvaAbM
         W0O2yLbLDtOF0TUi5BGN3lompBB805S8wW5/JpUZndqiQJv87glt0Sx16+P9r/xwPANM
         pd9jur2Ee5QIhjG0Jcwa/AhR8dmiU1l3W6PMr7Qi/W3lJhRXgjq7ReriexjvTKswkxQI
         N+MGI80lpzVKjeCurf2OGQSlNlcLZeM9DSQg9+fJcvk/E/JhMlZ49u7Bt2iZBmZW3JqI
         2r8+v4K0NL0R+862ASAJV2wnLOrLMFU3hNNc7fFd+UCt7C94beSkqCTbI4KX5pp6nXii
         WlQQ==
X-Gm-Message-State: AOAM5320XGaFOW1JcsEBPziO7LhSagscLW6iuyAHRqhEozsNuXRikcMl
        vqzxVpz6SI5dj+gF2nSqVSfj+MFSTe8=
X-Google-Smtp-Source: ABdhPJyXue8tP6qxN7t6ZXdtnllC5doAJ+c+sFjGPkTfi9enr4Pp2QKLYHNIVLk8PZnEIf2F5NQLXQ==
X-Received: by 2002:a63:f006:: with SMTP id k6mr284451pgh.88.1601263075795;
        Sun, 27 Sep 2020 20:17:55 -0700 (PDT)
Received: from Gentoo (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id cf7sm5189536pjb.52.2020.09.27.20.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 20:17:54 -0700 (PDT)
Date:   Mon, 28 Sep 2020 08:47:46 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ..and it built and boots without a fuss! Linux 5.9-rc7
Message-ID: <20200928031746.GA5842@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wj1SJmva5pQxT-XZkMREOa+iJuy0K8-zua0K=vF-Jz7zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <CAHk-=wj1SJmva5pQxT-XZkMREOa+iJuy0K8-zua0K=vF-Jz7zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14:56 Sun 27 Sep 2020, Linus Torvalds wrote:
>So we finally have all the issues I know about sorted out - the fix
>for the VM issue I mentioned in the rc6 announcement is here, as is
>the fix for the slab corruption issue that was separately discussed,
>along with another silly page locking bug one-liner fix.
>
>But while I do now know of any remaining gating issues any more, the
>fixes came in fairly late. So unless I feel insanely optimistic and/or
>a burning bush tells me that everything is bug-free, my plan right now
>is that I'll do another rc next Sunday rather than the final 5.9
>release. And btw, please no more burning bushes. We're kind of
>sensitive about those on the West coast right now.
>
>Anyway, while the MM side is what kept me on my toes last week, most
>of the changes here are actually drivers and networking. And
>networking drivers. With a small smattering of documentation and
>filesystem fixes and other noise thrown in.
>
>Shortlog appended, but what I really hope you all will do is to give
>it a nice good testing. One extra week or rc kernels will help, but
>only if people actually try this out.
>

Well, something trivial for your eyes!

  5.191189] sd 0:0:0:0: [sda] Write Protect is off
[    5.195216] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    5.216432] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    5.217571] cdrom: Uniform CD-ROM driver Revision: 3.20
[    5.259708] tsc: Refined TSC clocksource calibration: 2194.917 MHz
[    5.260783] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fa=
37107ca2, max_idle_ns: 440795258165 ns
[    5.262035] clocksource: Switched to clocksource tsc
[    5.275091] Key type encrypted registered
[    5.285337] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.306124] md: Waiting for all devices to be available before autodetect
[    5.307345] md: If you don't use raid, use raid=3Dnoautodetect
[    5.309091] md: Autodetecting RAID arrays.
[    5.309996] md: autorun ...
[    5.310354] md: ... autorun DONE.
[    5.495612] EXT4-fs (sda): recovery complete
[    5.511867] EXT4-fs (sda): mounted filesystem with ordered data mode. Op=
ts: (null)
[    5.514269] ext4 filesystem being mounted at /root supports timestamps u=
ntil 2038 (0x7fffffff)
[    5.516852] VFS: Mounted root (ext4 filesystem) on device 8:0.
[    5.531445] devtmpfs: mounted
[    5.600919] Freeing unused decrypted memory: 2040K
[    5.809762] Freeing unused kernel image (initmem) memory: 1600K
[    5.812846] Write protecting the kernel read-only data: 26624k
[    5.822103] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    5.830467] Freeing unused kernel image (rodata/data gap) memory: 876K
[    5.832276] rodata_test: all tests were successful
[    5.833948] Run /sbin/init as init process
[    6.264201] EXT4-fs (sda): re-mounted. Opts: (null)
[    6.266284] ext4 filesystem being remounted at / supports timestamps unt=
il 2038 (0x7fffffff)
Starting syslogd: OK
Starting klogd: OK
Running sysctl: [    7.674742] random: crng init done
OK
Initializing random number generator: OK
Saving random seed: OK
Starting network: OK

Welcome to Buildroot_Linux
Bhaskar_Thinkpad_x250 login: root
# uname -a
Linux Bhaskar_Thinkpad_x250 5.9.0-rc7-Gentoo #1 SMP Mon Sep 28 06:16:34 IST=
 2020 x86_64 GNU/Linux

~Bhaskar

>So.. Please?
>
>              Linus
>
>---
>
>Adrian Hunter (1):
>      ftrace: Fix missing synchronize_rcu() removing trampoline from kalls=
yms
>
>Al Viro (1):
>      fuse: fix the ->direct_IO() treatment of iov_iter
>
>Alaa Hleihel (1):
>      net/mlx5e: Fix using wrong stats_grps in mlx5e_update_ndo_stats()
>
>Alexey Dobriyan (1):
>      fs: fix cast in fsparam_u32hex() macro
>
>Aloka Dixit (1):
>      mac80211: Fix radiotap header channel flag for 6GHz band
>
>Anand Jain (1):
>      btrfs: fix put of uninitialized kobject after seed device delete
>
>Andres Beltran (1):
>      hv_netvsc: Add validation for untrusted Hyper-V values
>
>Andrii Nakryiko (2):
>      docs/bpf: Fix ringbuf documentation
>      docs/bpf: Remove source code links
>
>Bj=C3=B6rn T=C3=B6pel (1):
>      xsk: Fix number of pinned pages/umem size discrepancy
>
>Borislav Petkov (1):
>      rcu/tree: Export rcu_idle_{enter,exit} to modules
>
>Brian Vazquez (1):
>      fib: fix fib_rule_ops indirect call wrappers when CONFIG_IPV6=3Dm
>
>Chaitanya Kulkarni (2):
>      nvme-core: get/put ctrl and transport module in nvme_dev_open/releas=
e()
>      nvme-core: don't use NVME_NSID_ALL for command effects and supported=
 log
>
>Chanwoo Choi (1):
>      PM / devfreq: Add timer type to devfreq_summary debugfs
>
>Charan Teja Reddy (1):
>      dmabuf: fix NULL pointer dereference in dma_buf_release()
>
>Charles Keepax (2):
>      regmap: debugfs: Fix handling of name string for debugfs init delays
>      regmap: debugfs: Add back in erroneously removed initialisation of r=
et
>
>Chris Packham (1):
>      spi: fsl-espi: Only process interrupts for expected events
>
>Chris Wilson (1):
>      drm/i915/selftests: Push the fake iommu device from the stack to data
>
>Christian Borntraeger (1):
>      s390/zcrypt: Fix ZCRYPT_PERDEV_REQCNT ioctl
>
>Christoph Hellwig (1):
>      nvmet: get transport reference for passthru ctrl
>
>Chuck Lever (1):
>      SUNRPC: Fix svc_flush_dcache()
>
>Claudiu Manoil (1):
>      enetc: Fix mdio bus removal on PF probe bailout
>
>Colin Ian King (1):
>      rhashtable: fix indentation of a continue statement
>
>Collin Walling (1):
>      docs: kvm: add documentation for KVM_CAP_S390_DIAG318
>
>Cong Wang (1):
>      act_ife: load meta modules before tcf_idr_check_alloc()
>
>Cristobal Forno (1):
>      MAINTAINERS: Update ibmveth maintainer
>
>Damien Le Moal (2):
>      scsi: sd: sd_zbc: Fix handling of host-aware ZBC disks
>      scsi: sd: sd_zbc: Fix ZBC disk initialization
>
>Dan Carpenter (3):
>      hdlc_ppp: add range checks in ppp_cp_parse_cr()
>      sfc: Fix error code in probe
>      PM / devfreq: tegra30: Disable clock on error in probe
>
>Daniel Borkmann (1):
>      bpf: Fix clobbering of r2 in bpf_gen_ld_abs
>
>Dany Madden (1):
>      ibmvnic: update MAINTAINERS
>
>David Ahern (2):
>      ipv4: Initialize flowi4_multipath_hash in data path
>      ipv4: Update exception handling for multipath routes via same device
>
>David Milburn (1):
>      nvme-pci: disable the write zeros command for Intel 600P/P3100
>
>David S. Miller (1):
>      connector: Move maintainence under networking drivers umbrella.
>
>Dexuan Cui (3):
>      hv_netvsc: Fix hibernation for mlx5 VF driver
>      hv_netvsc: Switch the data path at the right time during hibernation
>      hv_netvsc: Cache the current data path to avoid duplicate call and m=
essage
>
>Dmitry Baryshkov (2):
>      regmap: fix page selection for noinc reads
>      regmap: fix page selection for noinc writes
>
>Dmitry Bogdanov (3):
>      net: qed: Disable aRFS for NPAR and 100G
>      net: qede: Disable aRFS for NPAR and 100G
>      net: qed: RDMA personality shouldn't fail VF load
>
>Douglas Gilbert (1):
>      tools/io_uring: fix compile breakage
>
>Edwin Peer (1):
>      bnxt_en: return proper error codes in bnxt_show_temp
>
>Eelco Chaudron (1):
>      netfilter: conntrack: nf_conncount_init is failing with IPv6 disabled
>
>Eric Dumazet (5):
>      mac802154: tx: fix use-after-free
>      ipv6: avoid lockdep issue in fib6_del()
>      net: qrtr: check skb_put_padto() return value
>      net: add __must_check to skb_put_padto()
>      inet_diag: validate INET_DIAG_REQ_PROTOCOL attribute
>
>Felix Fietkau (5):
>      mt76: mt7615: use v1 MCU API on MT7615 to fix issues with
>adding/removing stations
>      mt76: mt7915: use ieee80211_free_txskb to free tx skbs
>      mac80211: extend AQL aggregation estimation to HE and fix unit misma=
tch
>      mac80211: add AQL support for VHT160 tx rates
>      mac80211: do not allow bigger VHT MPDUs than the hardware supports
>
>Florian Fainelli (3):
>      net: phy: Avoid NPD upon phy_detach() when driver is unbound
>      net: phy: Do not warn in phy_stop() on PHY_DOWN
>      Documentation/llvm: Fix clang target examples
>
>Ganji Aravind (1):
>      cxgb4: Fix offset when clearing filter byte counters
>
>Gao Xiang (1):
>      mm, THP, swap: fix allocating cluster for swapfile by mistake
>
>Geert Uytterhoeven (1):
>      mmc: mmc_spi: Fix mmc_spi_dma_alloc() return type for !HAS_DMA
>
>Geliang Tang (3):
>      mptcp: fix subflow's local_id issues
>      mptcp: fix subflow's remote_id issues
>      mptcp: fix kmalloc flag in mptcp_pm_nl_get_local_id
>
>Grygorii Strashko (1):
>      net: ethernet: ti: cpsw_new: fix suspend/resume
>
>Guo Ren (1):
>      clocksource/drivers/timer-gx6605s: Fixup counter reload
>
>Hans Verkuil (1):
>      media: cec-adap.c: don't use flush_scheduled_work()
>
>Hans de Goede (1):
>      vboxsf: Fix the check for the old binary mount-arguments struct
>
>Hauke Mehrtens (4):
>      net: lantiq: Wake TX queue again
>      net: lantiq: use netif_tx_napi_add() for TX NAPI
>      net: lantiq: Use napi_complete_done()
>      net: lantiq: Disable IRQs only if NAPI gets scheduled
>
>Helmut Grohne (1):
>      net: dsa: microchip: look for phy-mode in port nodes
>
>Henry Ptasinski (1):
>      net: sctp: Fix IPv6 ancestor_size calc in sctp_copy_descendant
>
>Huacai Chen (1):
>      MIPS: Loongson-3: Fix fp register access if MSA enabled
>
>Hui Wang (1):
>      ALSA: hda/realtek - Couldn't detect Mic if booting with headset plug=
ged
>
>Icenowy Zheng (1):
>      regulator: axp20x: fix LDO2/4 description
>
>Ido Schimmel (2):
>      net: Fix bridge enslavement failure
>      selftests: rtnetlink: Test bridge enslavement with different parent =
IDs
>
>Jacopo Mondi (1):
>      media: dt-bindings: media: imx274: Convert to json-schema
>
>Jakub Kicinski (3):
>      ibmvnic: add missing parenthesis in do_reset()
>      MAINTAINERS: remove John Allen from ibmvnic
>      nfp: use correct define to return NONE fec
>
>James Smart (2):
>      scsi: lpfc: Fix initial FLOGI failure due to BBSCN not supported
>      nvme-fc: fail new connections to a deleted host or remote port
>
>Jan H=C3=B6ppner (1):
>      s390/dasd: Fix zero write for FBA devices
>
>Jan Kara (1):
>      dax: Fix compilation for CONFIG_DAX && !CONFIG_FS_DAX
>
>Jason A. Donenfeld (2):
>      wireguard: noise: take lock when removing handshake entry from table
>      wireguard: peerlookup: take lock before checking hash in replace ope=
ration
>
>Jason Gunthorpe (1):
>      RDMA/core: Fix ordering of CQ pool destruction
>
>Jason Yan (3):
>      spi: bcm2835: Make polling_limit_us static
>      bootconfig: init: make xbc_namebuf static
>      lib/memregion.c: include memregion.h
>
>Jeffle Xu (1):
>      block: remove unused BLK_QC_T_EAGAIN flag
>
>Jens Axboe (10):
>      io_uring: grab any needed state during defer prep
>      io_uring: drop 'ctx' ref on task work cancelation
>      io_uring: don't run task work on an exiting task
>      io_uring: don't re-setup vecs/iter in io_resumit_prep() is already t=
here
>      io_uring: don't use retry based buffered reads for non-async bdev
>      io_uring: mark statx/files_update/epoll_ctl as non-SQPOLL
>      io_uring: fix openat/openat2 unified prep handling
>      io_uring: ensure open/openat2 name is cleaned on cancelation
>      io_uring: don't unconditionally set plug->nowait =3D true
>      io_uring: ensure async buffered read-retry is setup properly
>
>Jianbo Liu (1):
>      net/mlx5e: Fix memory leak of tunnel info when rule under
>multipath not ready
>
>Jiaxun Yang (1):
>      MIPS: Loongson2ef: Disable Loongson MMI instructions
>
>Jing Xiangfeng (1):
>      atm: eni: fix the missed pci_disable_device() for eni_init_one()
>
>Joakim Tjernlund (1):
>      ALSA: usb-audio: Add delay quirk for H570e USB headsets
>
>Johannes Berg (1):
>      cfg80211: fix 6 GHz channel conversion
>
>Johannes Thumshirn (1):
>      btrfs: fix overflow when copying corrupt csums for a message
>
>John Crispin (1):
>      mac80211: fix 80 MHz association to 160/80+80 AP on 6 GHz
>
>Julian Wiedmann (1):
>      s390/qeth: delay draining the TX buffers
>
>Kai-Heng Feng (2):
>      ALSA: hda/realtek: Enable front panel headset LED on Lenovo
>ThinkStation P520
>      Revert "ALSA: usb-audio: Disable Lenovo P620 Rear line-in volume con=
trol"
>
>Keith Busch (1):
>      nvme: return errors for hwmon init
>
>Laurent Dufour (2):
>      mm: replace memmap_context by meminit_context
>      mm: don't rely on system state to detect hot-plug operations
>
>Linus L=C3=BCssing (5):
>      batman-adv: bla: fix type misuse for backbone_gw hash indexing
>      batman-adv: mcast/TT: fix wrongly dropped or rerouted packets
>      batman-adv: mcast: fix duplicate mcast packets in BLA backbone from =
LAN
>      batman-adv: mcast: fix duplicate mcast packets in BLA backbone from =
mesh
>      batman-adv: mcast: fix duplicate mcast packets from BLA backbone to =
mesh
>
>Linus Torvalds (4):
>      mm: split out the non-present case from copy_one_pte()
>      mm: move the copy_one_pte() pte_present check into the caller
>      mm: fix misplaced unlock_page in do_wp_page()
>      Linux 5.9-rc7
>
>Linus Walleij (1):
>      net: dsa: rtl8366: Properly clear member config
>
>Liu Jian (1):
>      ieee802154: fix one possible memleak in ca8210_dev_com_init
>
>Lorenzo Bianconi (2):
>      net: mvneta: fix possible use-after-free in mvneta_xdp_put_buff
>      net: mvneta: recycle the page in case of out-of-order
>
>Lu Wei (3):
>      net: tipc: kerneldoc fixes
>      net: hns: kerneldoc fixes
>      net: hns: kerneldoc fixes
>
>Lucy Yan (1):
>      net: dec: de2104x: Increase receive ring size for Tulip
>
>Luo bin (4):
>      hinic: bump up the timeout of SET_FUNC_STATE cmd
>      hinic: bump up the timeout of UPDATE_FW cmd
>      hinic: fix rewaking txq after netif_tx_disable
>      hinic: fix sending pkts from core while self testing
>
>Maor Dickman (2):
>      net/mlx5e: Enable adding peer miss rules only if merged eswitch
>is supported
>      net/mlx5e: Fix endianness when calculating pedit mask first bit
>
>Maor Gottlieb (1):
>      net/mlx5: Fix FTE cleanup
>
>Marc Zyngier (2):
>      KVM: arm64: Assume write fault on S1PTW permission fault on
>instruction fetch
>      KVM: arm64: Remove S1PTW check from kvm_vcpu_dabt_iswrite()
>
>Marek Szyprowski (1):
>      drm/vc4/vc4_hdmi: fill ASoC card owner
>
>Mark Gray (1):
>      geneve: add transport ports in route lookup for geneve
>
>Martin Cerveny (2):
>      drm/sun4i: sun8i-csc: Secondary CSC register correction
>      drm/sun4i: mixer: Extend regmap max_register
>
>Martin KaFai Lau (1):
>      bpf: Bpf_skc_to_* casting helpers require a NULL check on sk
>
>Martin Willi (1):
>      netfilter: ctnetlink: fix mark based dump filtering regression
>
>Masahiro Yamada (1):
>      scripts/kallsyms: skip ppc compiler stub *.long_branch.* / *.plt_bra=
nch.*
>
>Masami Hiramatsu (6):
>      kprobes: Fix to check probe enabled before disarm_kprobe_ftrace()
>      kprobes: tracing/kprobes: Fix to kill kprobes on initmem after boot
>      lib/bootconfig: Fix a bug of breaking existing tree nodes
>      lib/bootconfig: Fix to remove tailing spaces after value
>      tools/bootconfig: Add testcases for repeated key with brace
>      tools/bootconfig: Add testcase for tailing space
>
>Matthias Schiffer (1):
>      net: dsa: microchip: ksz8795: really set the correct number of ports
>
>Mauro Carvalho Chehab (1):
>      Revert "wlcore: Adding suppoprt for IGTK key in wlcore driver"
>
>Maxim Levitsky (1):
>      KVM: x86: fix MSR_IA32_TSC read for nested migration
>
>Maxim Mikityanskiy (2):
>      net/mlx5e: Use RCU to protect rq->xdp_prog
>      net/mlx5e: Use synchronize_rcu to sync with NAPI
>
>Maximilian Luz (1):
>      mwifiex: Increase AES key storage size to 256 bits
>
>Miaohe Lin (2):
>      net: Correct the comment of dst_dev_put()
>      net: Fix broken NETIF_F_CSUM_MASK spell in netdev_features.h
>
>Michael Chan (3):
>      bnxt_en: Protect bnxt_set_eee() and bnxt_set_pauseparam() with mutex.
>      bnxt_en: Fix HWRM_FUNC_QSTATS_EXT firmware call.
>      bnxt_en: Fix wrong flag value passed to HWRM_PORT_QSTATS_EXT fw call.
>
>Michal Kubecek (1):
>      ethtool: add and use message type for tunnel info reply
>
>Mike Snitzer (2):
>      dm: fix bio splitting and its bio completion order for regular IO
>      dm: fix comment in dm_process_bio()
>
>Mikulas Patocka (1):
>      arch/x86/lib/usercopy_64.c: fix __copy_user_flushcache() cache write=
back
>
>Milan Broz (2):
>      dm crypt: document new no_workqueue flags
>      dm crypt: document encrypted keyring key option
>
>Minchan Kim (1):
>      mm: validate pmd after splitting
>
>Miroslav Benes (1):
>      ftrace: Free the trampoline when ftrace_startup() fails
>
>Mohammed Gamal (1):
>      KVM: x86: VMX: Make smaller physical guest address space support
>user-configurable
>
>Muchun Song (1):
>      mm: memcontrol: fix missing suffix of workingset_restore
>
>Naveen N. Rao (1):
>      libbpf: Remove arch-specific include path in Makefile
>
>Necip Fazil Yildiran (3):
>      nvme-tcp: fix kconfig dependency warning when !CRYPTO
>      lib80211: fix unmet direct dependendices config warning when !CRYPTO
>      net: ipv6: fix kconfig dependency warning for IPV6_SEG6_HMAC
>
>Nick Desaulniers (1):
>      lib/string.c: implement stpcpy
>
>Nicolas Dichtel (1):
>      netlink: fix doc about nlmsg_parse/nla_validate
>
>Olympia Giannou (1):
>      rndis_host: increase sleep time in the query-response loop
>
>Pablo Neira Ayuso (2):
>      netfilter: nf_tables: coalesce multiple notifications into one skbuff
>      netfilter: nft_meta: use socket user_ns to retrieve skuid and skgid
>
>Parshuram Thombare (1):
>      net: macb: fix for pause frame receive enable bit
>
>Paul E. McKenney (1):
>      rcu-tasks: Prevent complaints of unused
>show_rcu_tasks_classic_gp_kthread()
>
>Peilin Ye (1):
>      tipc: Fix memory leak in tipc_group_create_member()
>
>Peter Xu (4):
>      mm: Introduce mm_struct.has_pinned
>      mm/fork: Pass new vma pointer into copy_page_range()
>      mm: Do early cow for pinned pages during fork() for ptes
>      mm/thp: Split huge pmds/puds if they're pinned when fork()
>
>Petr Machata (1):
>      net: DCB: Validate DCB_ATTR_DCB_BUFFER argument
>
>Rafael J. Wysocki (1):
>      ACPI: processor: Fix build for ARCH_APICTIMER_STOPS_ON_C3 unset
>
>Raju Rangoju (1):
>      cxgb4: fix memory leak during module unload
>
>Randy Dunlap (2):
>      netdevice.h: fix proto_down_reason kernel-doc warning
>      netdevice.h: fix xdp_state kernel-doc warning
>
>Ray Jui (1):
>      spi: bcm-qspi: Fix probe regression on iProc platforms
>
>Roi Dayan (1):
>      net/mlx5e: CT: Fix freeing ct_label mapping
>
>Ron Diskin (1):
>      net/mlx5e: Fix multicast counter not up-to-date in "ip -s"
>
>Saeed Mahameed (4):
>      net/mlx5e: kTLS, Add missing dma_unmap in RX resync
>      net/mlx5e: kTLS, Fix leak on resync error flow
>      net/mlx5e: kTLS, Avoid kzalloc(GFP_KERNEL) under spinlock
>      net/mlx5e: mlx5e_fec_in_caps() returns a boolean
>
>Sascha Hauer (1):
>      spi: fsl-dspi: fix use-after-free in remove path
>
>Sean Christopherson (1):
>      KVM: x86: Reset MMU context if guest toggles CR4.SMAP or CR4.PKE
>
>Sean Wang (1):
>      net: Update MAINTAINERS for MediaTek switch driver
>
>Sebastian Andrzej Siewior (1):
>      tracing: Make the space reserved for the pid wider
>
>Sergey Senozhatsky (1):
>      media: media/v4l2: remove V4L2_FLAG_MEMORY_NON_CONSISTENT flag
>
>Shakeel Butt (1):
>      mm: slab: fix potential double free in ___cache_free
>
>Stefan Assmann (2):
>      i40e: fix return of uninitialized aq_ret in i40e_set_vsi_promisc
>      i40e: always propagate error value in i40e_set_vsi_promisc()
>
>Sven Eckelmann (1):
>      batman-adv: Add missing include for in_interrupt()
>
>Taehee Yoo (1):
>      Revert "netns: don't disable BHs when locking "nsid_lock""
>
>Takashi Iwai (1):
>      Revert "ALSA: hda - Fix silent audio output and corrupted input
>on MSI X570-A PRO"
>
>Tariq Toukan (2):
>      net/mlx5e: TLS, Do not expose FPGA TLS counter if not supported
>      net/mlx5e: kTLS, Fix napi sync and possible use-after-free
>
>Tetsuo Handa (1):
>      tipc: fix shutdown() of connection oriented socket
>
>Thomas Gleixner (2):
>      x86/irq: Make run_on_irqstack_cond() typesafe
>      x86/ioapic: Unbreak check_timer()
>
>Tianjia Zhang (1):
>      clocksource/drivers/h8300_timer8: Fix wrong return value in
>h8300_8timer_init()
>
>Tobias Klauser (1):
>      ftrace: Let ftrace_enable_sysctl take a kernel pointer buffer
>
>Toke H=C3=B8iland-J=C3=B8rgensen (1):
>      tools/bpf: build: Make sure resolve_btfids cleans up after itself
>
>Tom Lendacky (1):
>      KVM: SVM: Add a dedicated INVD intercept routine
>
>Tom Rix (3):
>      ieee802154/adf7242: check status of adf7242_read_reg
>      tracing: fix double free
>      ALSA: asihpi: fix iounmap in error handler
>
>Tony Ambardar (2):
>      libbpf: Fix build failure from uninitialized variable warning
>      tools/libbpf: Avoid counting local symbols in ABI check
>
>Tony Lindgren (1):
>      clocksource/drivers/timer-ti-dm: Do reset before enable
>
>Ulf Hansson (2):
>      cpuidle: psci: Fix suspicious RCU usage
>      cpuidle: Drop misleading comments about RCU usage
>
>Vadym Kochan (1):
>      net: ipa: fix u32_replace_bits by u32p_xxx version
>
>Vasily Gorbik (1):
>      mm/gup: fix gup_fast with dynamic page table folding
>
>Vasundhara Volam (4):
>      bnxt_en: Avoid sending firmware messages when AER error is detected.
>      bnxt_en: Fix NULL ptr dereference crash in bnxt_fw_reset_task()
>      bnxt_en: Use memcpy to copy VPD field info.
>      bnxt_en: Return -EOPNOTSUPP for ETHTOOL_GREGS on VFs.
>
>Vinicius Costa Gomes (3):
>      igc: Fix wrong timestamp latency numbers
>      igc: Fix not considering the TX delay for timestamps
>      taprio: Fix allowing too small intervals
>
>Vitaly Kuznetsov (1):
>      Revert "KVM: Check the allocation of pv cpu mask"
>
>Vladimir Oltean (13):
>      net: dsa: link interfaces with the DSA master to get rid of
>lockdep warnings
>      spi: spi-fsl-dspi: use XSPI mode instead of DMA for DPAA2 SoCs
>      net: mscc: ocelot: fix race condition with TX timestamping
>      net: mscc: ocelot: add locking for the port TX timestamp ID
>      net: dsa: seville: fix buffer size of the queue system
>      net: mscc: ocelot: check for errors on memory allocation of ports
>      net: mscc: ocelot: error checking when calling ocelot_init()
>      net: mscc: ocelot: refactor ports parsing code into a dedicated func=
tion
>      net: mscc: ocelot: unregister net devices on unbind
>      net: mscc: ocelot: deinitialize only initialized ports
>      net: bridge: br_vlan_get_pvid_rcu() should dereference the VLAN
>group under RCU
>      net: dsa: seville: fix some key offsets for IP4_TCP_UDP VCAP IS2 ent=
ries
>      net: mscc: ocelot: fix some key offsets for IP4_TCP_UDP VCAP IS2 ent=
ries
>
>Wei Li (3):
>      hinic: fix potential resource leak
>      MIPS: Add the missing 'CPU_1074K' into __get_cpu_type()
>      MIPS: BCM47XX: Remove the needless check with the 1074K
>
>Wei Wang (1):
>      ip: fix tos reflection in ack and reset packets
>
>Wen Gong (1):
>      mac80211: do not disable HE if HT is missing on 2.4 GHz
>
>Will McVicker (1):
>      netfilter: ctnetlink: add a range check for l3/l4 protonum
>
>Wright Feng (1):
>      brcmfmac: reserve tx credit only when txctl is ready to send
>
>Xianting Tian (1):
>      nvme-pci: fix NULL req in completion handler
>
>Xiaoliang Yang (1):
>      net: dsa: felix: fix some key offsets for IP4_TCP_UDP VCAP IS2 entri=
es
>
>Xie He (3):
>      drivers/net/wan/hdlc_fr: Add needed_headroom for PVC devices
>      drivers/net/wan/lapbether: Make skb->protocol consistent with the he=
ader
>      drivers/net/wan/hdlc: Set skb->protocol before transmitting
>
>Xin Long (4):
>      tipc: use skb_unshare() instead in tipc_buf_append()
>      net: sched: only keep the available bits when setting vxlan md->gbp
>      lwtunnel: only keep the available bits when setting vxlan md->gbp
>      net: sched: initialize with 0 before setting erspan md->u
>
>Xu Wang (1):
>      ipv6: route: convert comma to semicolon
>
>Yang Weijiang (1):
>      selftests: kvm: Fix assert failure in single-step test
>
>Yangbo Lu (1):
>      dpaa2-eth: fix a build warning in dpmac.c
>
>Ye Bin (1):
>      hsr: avoid newline at end of message in NL_SET_ERR_MSG_MOD
>
>Yonghong Song (3):
>      bpf: Do not use bucket_lock for hashmap iterator
>      selftests/bpf: Add bpf_{update, delete}_map_elem in hashmap iter pro=
gram
>      bpf: Fix a rcu warning for bpffs map pretty-print
>
>Yoshihiro Shimoda (1):
>      net: phy: call phy_disable_interrupts() in phy_attach_direct() inste=
ad
>
>Yunsheng Lin (1):
>      net: sch_generic: aviod concurrent reset and enqueue op for lockless=
 qdisc
>
>Zhenyu Wang (1):
>      drm/i915/gvt: Fix port number for BDW on EDID region setup
>
>Zi Yan (1):
>      mm/migrate: correct thp migration stats

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9xVdYACgkQsjqdtxFL
KRUNGwf9HrIYv/5ICyZrEX7DQXw9pjy7flakCKdmb1utzUysydlbp7XTFMd8zy/5
1aYv8L7PaiWkiOb3q2X9HP/qo6w3aq9q/xo7G0RI+NIg+zTG53XXie80O7efI9tc
uvV/mjLnZ+fSMaND9SdHTTRTh0/9WTRILAHuhRzGYhURqY50TIO1efs1uVEjuTyC
Y9Q0napYhgfoZHAGCP1ZSGFgdk0xBWPk4JhIbYdcWluLhQYfn/VV/bmNoAEyaQWI
IKabtr9urY2Rzy2oMIYkmn/VM/lWOJeGx28jrSnrw2ERuIhN6R2qinPnH+sAbdww
3BHoXxhpo0wamfJf3DkpToOnvPVqKA==
=jHaw
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
