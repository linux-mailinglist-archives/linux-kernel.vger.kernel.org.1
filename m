Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2252D9119
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 00:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436645AbgLMXEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 18:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgLMXEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 18:04:30 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58146C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 15:03:49 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o17so22662623lfg.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 15:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kZ1kFFVreGKD03uODfmWsV9UWQo/A1Kt+/wOUmfUcGA=;
        b=fprtqLsgay0HjFG4ByayuSp6dSAGGKv2v7+2JVInkJ+WLj54peF1Tkc0duKv0ntk70
         WNgISDFOJI4ucvvumOI4Xw0hqsKeXJORRavkXOT3dgjc7NaEFYsBbN3gXJsTgvDuJ6fF
         p2mA64hKKM4MwChJvSmq987aEbeEqjUGVJJWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kZ1kFFVreGKD03uODfmWsV9UWQo/A1Kt+/wOUmfUcGA=;
        b=Fakr/Ve65YdKpWlnLXMBdI+ojPKpnI0bcU2y5fS10fAoioQ16DvcF1e8pFpO9racoK
         qctJHJT9RrV5Oj6x769ktVEBOeRQzIXmuU8LFtIDbNxWLwLjDMfUmRx+0CTOKF2jEYd/
         386ue2dWhCdOMGegUV212TnoKpsmugmezdRaEuuokYg5rVjzdl2fL2lfpQeWgILlV1IN
         Xb0/BRpucXI7BtKg/8vqfqknyOAFpId91trkGQuRzuFFvYnvSfQcVOxhNO+AMfWOT9HB
         pueZhhplc39ZNWFfMWw7H1q3KJxOnyuLHDWjWIUWc04Nn9TddKa4UqNW/A7JtWbcL58n
         xXGQ==
X-Gm-Message-State: AOAM531m6fRWawFlz2nHMzvPELc3jYnmngZaZGNEWCAJ68GGeC4hoZgW
        XGgX2BKzSLQNodNS+6SA3WPqcIYpMKOAPw==
X-Google-Smtp-Source: ABdhPJxDK8QNz2FkidfI4D5SpSasdEf9W1OCKHYmvSO0MLatx5K23++ONdt0kUW9R5NCKQUSochEiQ==
X-Received: by 2002:a2e:9641:: with SMTP id z1mr9000599ljh.171.1607900627064;
        Sun, 13 Dec 2020 15:03:47 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id l84sm1861913lfd.75.2020.12.13.15.03.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Dec 2020 15:03:46 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id a9so25587612lfh.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 15:03:46 -0800 (PST)
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr3779738lfr.487.1607900625605;
 Sun, 13 Dec 2020 15:03:45 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Dec 2020 15:03:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whCKhxNyKn1Arut8xUDKTwp3fWcCj_jbL5dbzkUmo45gQ@mail.gmail.com>
Message-ID: <CAHk-=whCKhxNyKn1Arut8xUDKTwp3fWcCj_jbL5dbzkUmo45gQ@mail.gmail.com>
Subject: Linux 5.10
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here it is - 5.10 is tagged and pushed out.

I pretty much always wish that the last week was even calmer than it
was, and that's true here too. There's a fair amount of fixes in here,
including a few last-minute reverts for things that didn't get fixed,
but nothing makes me go "we need another week". Things look fairly
normal.

It's mostly drivers - as it should be - with a smattering of fixes all
over: networking, architectures, filesystems, tooling.. The shortlog
is appended, and scanning it gives a good idea of what kind of things
are there. Nothing that looks scary: most of the patches are very
small, and the biggest one is fixing pin mapping definitions for a
pincontrol driver.

This also obviously means that the merge window for 5.11 will start
tomorrow.  I already have a couple of pull requests pending - you guys
know who you are, and thank you.

The most notable thing about the 5.11 merge window will be obvious to
anybody who takes a look at the calendar: realistically speaking, we
only have one week before the holidays are upon us, and everybody is
much too distracted. That means that I will be particularly strict
about the whole "the merge window is for things that are ready
*before* the merge window starts".

Now, I'm sure you all want to go off for holidays too, and I'm
actually surprised that I don't have more early pull requests pending.
So I think the whole "everything you send me should have already been
done" is something we can all sign up for. But exactly _because_ of
the timing, I will simply not be very interested in any new late pull
requests that come in the second week of the merge window: I expect to
still be handling some of the backlog that week _anyway_, but I
certainly do not want to get more of it.

So if it's not already in linux-next, and if you aren't happy sending
it in this upcoming week because it's not quite done yet, you should
basically plan on not getting it into 5.11 at all. There will be
releases after that one, don't worry.

This has _technically_ been the rule before too, it's just that I
generally haven't been all that hard-nosed about it, and have let
things slide if it wasn't _too_ egregious. This time around I have
fairly clear reasons why I'm just going to enforce that "it had better
be ready before the merge window even opened" rule.

If my overflow handling then ends up being interrupted by the
holidays, I may end up delaying rc1 just to catch up, but I hope and
expect that that won't even be needed. We'll see. But even if it does
happen, it most certainly will _not_ mean that I will take pull
requests that came in after the holidays.

Actual fixes that would be valid even outside the merge window are
obviously not affected by that rule.

             Linus

---

Adam Sampson (1):
      ARM: dts: sun7i: pcduino3-nano: enable RGMII RX/TX delay on PHY

Al Viro (2):
      fix return values of seq_read_iter()
      [regression fix] really dumb f**kup in sparc64
__csum_partial_copy() changes

Alex Deucher (3):
      drm/amdgpu/powerplay: parse fan table for CI asics
      drm/amdgpu/disply: set num_crtc earlier
      drm/amdgpu: fix size calculation with stolen vga memory

Alex Elder (1):
      net: ipa: pass the correct size when freeing DMA memory

Alexei Starovoitov (1):
      bpf: Fix propagation of 32-bit signed bounds from 64-bit bounds.

Alok Prasad (1):
      RDMA/qedr: iWARP invalid(zero) doorbell address fix

Andrea Parri (Microsoft) (1):
      Revert "scsi: storvsc: Validate length of incoming packet in
storvsc_on_channel_callback()"

Andrew Jeffery (1):
      pinctrl: aspeed: Fix GPIO requests on pass-through banks

Andrew Morton (1):
      revert "mm/filemap: add static for function __add_to_page_cache_locke=
d"

Andrey Grodzovsky (1):
      drm/amdgpu: Initialise drm_gem_object_funcs for imported BOs

Andrii Nakryiko (4):
      libbpf: Fix ring_buffer__poll() to return number of consumed samples
      selftests/bpf: Drain ringbuf samples at the end of test
      tools/bpftool: Fix PID fetching with a lot of results
      bpf: Fix enum names for bpf_this_cpu_ptr() and bpf_per_cpu_ptr() help=
ers

Andy Lutomirski (4):
      x86/membarrier: Get rid of a dubious optimization
      membarrier: Add an actual barrier before rseq_preempt()
      membarrier: Explicitly sync remote cores when SYNC_CORE is requested
      membarrier: Execute SYNC_CORE on the calling thread

Andy Shevchenko (4):
      pinctrl: jasperlake: Unhide SPI group of pins
      pinctrl: merrifield: Set default bias in case no particular value giv=
en
      pinctrl: baytrail: Avoid clearing debounce value when turning it off
      pinctrl: intel: Actually disable Tx and Rx buffers on GPIO request

Anna Schumaker (1):
      NFS: Disable READ_PLUS by default

Arnd Bergmann (9):
      mmc: mediatek: mark PM functions as __maybe_unused
      ethernet: select CONFIG_CRC32 as needed
      ch_ktls: fix build warning for ipv4-only config
      ARM: keystone: remove SECTION_SIZE_BITS/MAX_PHYSMEM_BITS
      drm/amdgpu: fix debugfs creation/removal, again
      selftest/fpu: avoid clang warning
      kbuild: avoid static_assert for genksyms
      initramfs: fix clang build failure
      elfcore: fix building with clang

Arvind Sankar (1):
      x86/mm/mem_encrypt: Fix definition of PMD_FLAGS_DEC_WP

Baruch Siach (1):
      gpio: mvebu: fix potential user-after-free on probe

Bean Huo (1):
      mmc: block: Fixup condition for CMD13 polling for RPMB requests

Bernd Bauer (1):
      ARM: dts: imx6qdl-kontron-samx6i: fix I2C_PM scl pin

Bj=C3=B6rn T=C3=B6pel (4):
      xdp: Handle MEM_TYPE_XSK_BUFF_POOL correctly in xdp_return_buff()
      i40e: avoid premature Rx buffer reuse
      ixgbe: avoid premature Rx buffer reuse
      ice: avoid premature Rx buffer reuse

Borwankar, Antara (1):
      mac80211: set SDATA_STATE_RUNNING for monitor interfaces

Brett Mastbergen (1):
      netfilter: nft_ct: Remove confirmation check for NFT_CT_ID

Cengiz Can (1):
      net: tipc: prevent possible null deref of link

Changfeng (1):
      drm/amd/pm: update smu10.h WORKLOAD_PPLIB setting for raven

Chris Chiu (1):
      Input: i8042 - add Acer laptops to the i8042 reset list

Chris Mi (1):
      net: flow_offload: Fix memory leak for indirect flow block

Chris Park (1):
      drm/amd/display: Prevent bandwidth overflow

Chris Wilson (5):
      drm/i915/gem: Propagate error from cancelled submit due to context cl=
osure
      drm/i915/gt: Ignore repeated attempts to suspend request flow across =
reset
      drm/i915/gt: Cancel the preemption timeout on responding to it
      drm/i915/gt: Declare gen9 has 64 mocs entries!
      drm/i915/display: Go softly softly on initial modeset failure

Christophe JAILLET (1):
      dpaa2-mac: Add a missing of_node_put after of_device_is_available

Christophe Leroy (1):
      powerpc/mm: Fix KUAP warning by providing
copy_from_kernel_nofault_allowed()

Chuck Lever (1):
      NFS: Fix rpcrdma_inline_fixup() crash with new LISTXATTRS operation

Chunyan Zhang (1):
      gpio: eic-sprd: break loop when getting NULL device resource

Claudiu Manoil (1):
      enetc: Fix reporting of h/w packet counters

Coiby Xu (1):
      pinctrl: amd: remove debounce filter setting in IRQ type setting

Colin Ian King (2):
      media: [next] media: vidtv: fix a read from an object after it
has been freed
      drm/i915: fix size_t greater or equal to zero comparison

Cong Wang (1):
      lwt_bpf: Replace preempt_disable() with migrate_disable()

Dai Ngo (1):
      NFSv4.2: Fix 5 seconds delay when doing inter server copy

Damien Le Moal (1):
      zonefs: fix page reference and BIO leak

Dan Carpenter (2):
      scsi: be2iscsi: Revert "Fix a theoretical leak in beiscsi_create_eqs(=
)"
      drm/i915/gem: Check the correct variable in selftest

David Howells (1):
      afs: Fix memory leak when mounting with multiple source parameters

Davide Caratti (1):
      net/sched: fq_pie: initialize timer earlier in fq_pie_init()

Diego Santa Cruz (1):
      misc: eeprom: at24: fix NVMEM name with custom AT24 device name

Dmitry Safonov (3):
      xfrm/compat: Translate by copying XFRMA_UNSPEC attribute
      xfrm/compat: memset(0) 64-bit padding at right place
      xfrm/compat: Don't allocate memory with __GFP_ZERO

Dmitry Torokhov (2):
      Input: cros_ec_keyb - send 'scancodes' in addition to key events
      Input: cm109 - do not stomp on control URB

Dong Aisheng (1):
      clk: imx: scu: fix MXC_CLK_SCU module build break

Dongdong Wang (1):
      lwt: Disable BH too in run_lwt_bpf()

Edmond Chung (1):
      gpiolib: Don't free if pin ranges are not defined

Eric Dumazet (2):
      mac80211: mesh: fix mesh_pathtbl_init() error path
      tcp: select sane initial rcvq_space.space for big MSS

Evan Green (1):
      pinctrl: jasperlake: Fix HOSTSW_OWN offset

Evan Quan (1):
      drm/amd/pm: typo fix (CUSTOM -> COMPUTE)

Fabio Estevam (1):
      ARM: dts: imx6qdl-wandboard-revd1: Remove PAD_GPIO_6 from enetgrp

Felix Kuehling (1):
      drm/amdkfd: Fix leak in dmabuf import

Fugang Duan (5):
      net: stmmac: increase the timeout for dma reset
      net: stmmac: start phylink instance before stmmac_hw_setup()
      net: stmmac: free tx skb buffer in stmmac_resume()
      net: stmmac: delete the eee_ctrl_timer after napi disabled
      net: stmmac: overwrite the dma_cap.addr64 according to HW design

Furquan Shaikh (1):
      Input: raydium_ts_i2c - do not split tx transactions

Gal Pressman (2):
      RDMA/efa: Use the correct current and new states in modify QP
      RDMA/core: Fix empty gid table for non IB/RoCE devices

Geert Uytterhoeven (1):
      clk: renesas: r9a06g032: Drop __packed for portability

Gerald Schaefer (1):
      mm/hugetlb: clear compound_nr before freeing gigantic pages

Guillaume Nault (1):
      net: sched: Fix dump of MPLS_OPT_LSE_LABEL attribute in cls_flower

Hans Verkuil (2):
      media: pulse8-cec: fix duplicate free at disconnect or probe error
      media: pulse8-cec: add support for FW v10 and up

Hans de Goede (1):
      Input: soc_button_array - add Lenovo Yoga Tablet2 1051L to the
dmi_use_low_level_irq list

Heinrich Schuchardt (2):
      arm64: dts: allwinner: A64 Sopine: phy-mode rgmii-id
      arm64: dts: allwinner: H5: NanoPi Neo Plus2: phy-mode rgmii-id

Hillf Danton (1):
      io_uring: fix file leak on error path of io ctx creation

Huazhong Tan (1):
      net: hns3: remove a misused pragma packed

Icenowy Zheng (1):
      ARM: dts: sun8i: v3s: fix GIC node memory range

Jacob Xu (1):
      kvm: svm: de-allocate svm_cpu_data for all cpus in svm_cpu_uninit()

Jakub Kicinski (1):
      Revert "geneve: pull IP header before ECN decapsulation"

Jarod Wilson (1):
      bonding: fix feature flag setting at init time

Jean-Philippe Brucker (3):
      selftests/bpf: Add test for signed 32-bit bound check bug
      selftests/bpf: Fix array access with signed variable test
      selftests/bpf: Fix "dubious pointer arithmetic" test

Jernej Skrabec (1):
      arm64: dts: allwinner: h6: orangepi-one-plus: Fix ethernet

Jianguo Wu (1):
      mptcp: print new line in mptcp_seq_show() if mptcp isn't in use

Joseph Huang (1):
      bridge: Fix a deadlock when enabling multicast snooping

Juergen Gross (2):
      xen: add helpers for caching grant mapping pages
      xen: don't use page->lru for ZONE_DEVICE memory

KP Singh (1):
      bpf, doc: Update KP's email in MAINTAINERS

Krzysztof Kozlowski (2):
      MAINTAINERS: correct SoC Git address (formerly: arm-soc)
      MAINTAINERS: add a limited ARM and ARM64 SoC entry

Kuan-Ying Lee (1):
      kasan: fix object remaining in offline per-cpu quarantine

Leon Romanovsky (1):
      RDMA/cm: Fix an attempt to use non-valid pointer when cleaning timewa=
it

Libo Chen (1):
      ktest.pl: Fix incorrect reboot for grub2bls

Linus Torvalds (2):
      Revert "scsi: megaraid_sas: Added support for shared host tagset
for cpuhotplug"
      Linux 5.10

Luo Jiaxing (1):
      gpio: dwapb: fix NULL pointer dereference at dwapb_gpio_suspend()

Maciej S. Szmigiero (2):
      selftests: kvm/set_memory_region_test: Fix race in move region test
      KVM: mmu: Fix SPTE encoding of MMIO generation upper half

Manasi Navare (1):
      drm/i915/display/dp: Compute the correct slice count for VDSC on DP

Martin Blumenstingl (1):
      net: stmmac: dwmac-meson8b: fix mask definition of the m250_sel mux

Masami Hiramatsu (1):
      x86/kprobes: Fix optprobe to detect INT3 padding correctly

Matteo Scordino (1):
      ARM: dts: s3: pinecube: align compatible property to other S3 boards

Mauro Carvalho Chehab (2):
      media: vidtv: fix kernel-doc markups
      media: vidtv: fix some warnings

Michal Kubecek (1):
      ethtool: fix stack overflow in ethnl_parse_bitset()

Mickey Rachamim (1):
      MAINTAINERS: Add entry for Marvell Prestera Ethernet Switch driver

Mike Snitzer (1):
      md: change mddev 'chunk_sectors' from int to unsigned

Miles Chen (1):
      proc: use untagged_addr() for pagemap_read addresses

Minchan Kim (1):
      mm/madvise: remove racy mm ownership check

Ming Lei (1):
      scsi: core: Fix race between handling STS_RESOURCE and completion

Miquel Raynal (9):
      mtd: rawnand: ams-delta: Do not force a particular software ECC engin=
e
      mtd: rawnand: au1550: Do not force a particular software ECC engine
      mtd: rawnand: gpio: Do not force a particular software ECC engine
      mtd: rawnand: mpc5121: Do not force a particular software ECC engine
      mtd: rawnand: orion: Do not force a particular software ECC engine
      mtd: rawnand: pasemi: Do not force a particular software ECC engine
      mtd: rawnand: plat_nand: Do not force a particular software ECC engin=
e
      mtd: rawnand: socrates: Do not force a particular software ECC engine
      mtd: rawnand: xway: Do not force a particular software ECC engine

Moshe Shemesh (2):
      net/mlx4_en: Avoid scheduling restart task if it is already running
      net/mlx4_en: Handle TX error CQE

Muhammad Husaini Zulkifli (1):
      mmc: sdhci-of-arasan: Fix clock registration error for Keem Bay SOC

Neal Cardwell (1):
      tcp: fix cwnd-limited bug for TSO deferral where we send nothing

Oliver Hartkopp (1):
      can: isotp: isotp_setsockopt(): block setsockopt on bound sockets

Pablo Greco (3):
      ARM: dts: sun7i: bananapi: Enable RGMII RX/TX delay on Ethernet PHY
      ARM: dts: sun8i: r40: bananapi-m2-berry: Fix dcdc1 regulator
      ARM: dts: sun8i: v40: bananapi-m2-berry: Fix ethernet node

Pablo Neira Ayuso (2):
      netfilter: nft_dynset: fix timeouts later than 23 days
      netfilter: nftables: comment indirect serialization of
commit_mutex with rtnl_mutex

Palmer Dabbelt (1):
      RISC-V: Define get_cycles64() regardless of M-mode

Paolo Abeni (1):
      selftests: fix poll error in udpgro.sh

Paul Kocialkowski (1):
      ARM: sunxi: Add machine match for the Allwinner V3 SoC

Pavel Begunkov (1):
      io_uring: fix mis-seting personality's creds

Qinglang Miao (1):
      gpio: zynq: fix reference leak in zynq_gpio functions

Randy Dunlap (1):
      scsi: bnx2i: Requires MMU

Rick Edgecombe (1):
      kvm: x86/mmu: Use cpuid to determine max gfn

Robert Karszniewicz (1):
      ARM: imx: Use correct SRC base address

Sara Sharon (1):
      cfg80211: initialize rekey_data

Sean Young (1):
      media: mtk-cir: fix calculation of chk period

Serge Hallyn (1):
      [SECURITY] fix namespaced fscaps when !CONFIG_SECURITY

Sergey Senozhatsky (1):
      media: vb2: set cache sync hints when init buffers

Simon Beginn (1):
      Input: goodix - add upside-down quirk for Teclast X98 Pro tablet

Song Liu (6):
      Revert "dm raid: remove unnecessary discard limits for raid10"
      Revert "md/raid10: improve discard request for far layout"
      Revert "md/raid10: improve raid10 discard request"
      Revert "md/raid10: pull codes that wait for blocked dev into one func=
tion"
      Revert "md/raid10: extend r10bio devs to raid disks"
      Revert "md: add md_submit_discard_bio() for submitting discard bio"

Stanley.Yang (1):
      drm/amdgpu: fix sdma instance fw version and feature version init

Stefan Raspl (1):
      tools/kvm_stat: Exempt time-based counters

Stephen Suryaputra (1):
      vrf: packets with lladdr src needs dst at input with orig_iif
when needs strict

Steven Rostedt (VMware) (1):
      tracing: Fix userstacktrace option for instances

Subash Abhinov Kasiviswanathan (1):
      netfilter: x_tables: Switch synchronization to RCU

Sung Lee (1):
      drm/amd/display: Add wm table for Renoir

Suravee Suthikulpanit (1):
      iommu/amd: Set DTE[IntTabLen] to represent 512 IRTEs

Sven Auhagen (6):
      igb: XDP xmit back fix error code
      igb: take VLAN double header into account
      igb: XDP extack message on error
      igb: skb add metasize for xdp
      igb: use xdp_do_flush
      igb: avoid transmit queue timeout in xdp path

Thomas Gleixner (1):
      x86/apic/vector: Fix ordering in vector assignment

Toke H=C3=B8iland-J=C3=B8rgensen (7):
      xdp: Remove the xdp_attachment_flags_ok() callback
      selftests/bpf/test_offload.py: Remove check for program load flags ma=
tch
      netdevsim: Add debugfs toggle to reject BPF programs in verifier
      selftests/bpf/test_offload.py: Only check verifier log on
verification fails
      selftests/bpf/test_offload.py: Fix expected case of extack messages
      selftests/bpf/test_offload.py: Reset ethtool features after failed se=
tting
      selftests/bpf/test_offload.py: Filter bpftool internal map when
counting maps

Trond Myklebust (1):
      pNFS/flexfiles: Fix array overflow when flexfiles mirroring is enable=
d

Vitaly Lifshits (1):
      e1000e: fix S0ix flow to allow S0i3.2 subset entry

Vladimir Oltean (1):
      net: mscc: ocelot: fix dropping of unknown IPv4 multicast on Seville

Wang Hai (1):
      openvswitch: fix error return code in validate_and_copy_dec_ttl()

Wei Wang (1):
      tcp: Retain ECT bits for tos reflection

Wen Gong (1):
      mac80211: fix return value of ieee80211_chandef_he_6ghz_oper

Wenbin Mei (1):
      mmc: mediatek: Fix system suspend/resume support for CQHCI

Wolfram Sang (1):
      mmc: tmio: improve bringing HW to a sane state with MMC_POWER_OFF

Xiang Chen (1):
      scsi: hisi_sas: Select a suitable queue for internal I/Os

Xiaochen Shen (1):
      x86/resctrl: Fix incorrect local bandwidth when mba_sc is enabled

Xin Long (1):
      udp: fix the proto value passed to ip_protocol_deliver_rcu for
the segments

Xuan Zhuo (2):
      xsk: Replace datagram_poll by sock_poll_wait
      xsk: Change the tx writeable condition

Yanan Wang (3):
      KVM: arm64: Fix memory leak on stage2 update of a valid PTE
      KVM: arm64: Fix handling of merging tables into a block entry
      KVM: arm64: Add usage of stage 2 fault lookup level in user_mem_abort=
()

Yu Kuai (1):
      net: xfrm: fix memory leak in xfrm_user_policy()

Zhang Changzhong (5):
      xsk: Return error code if force_zc is set
      ipv4: fix error return code in rtm_to_fib_config()
      net: bridge: vlan: fix error return code in __vlan_add()
      net: marvell: prestera: Fix error return code in prestera_port_create=
()
      net: ll_temac: Fix potential NULL dereference in temac_probe()

Zhang Qilong (1):
      can: softing: softing_netdev_open(): fix error handling

Zhen Lei (1):
      ARM: dts: mmp2-olpc-xo-1-75: clear the warnings when make dtbs

Zheng Liang (1):
      gpio: arizona: disable pm_runtime in case of failure

Zou Wei (1):
      firmware: xilinx: Mark pm_api_features_map with static keyword

yong mao (1):
      mmc: mediatek: Extend recheck_sdio_irq fix to more variants
