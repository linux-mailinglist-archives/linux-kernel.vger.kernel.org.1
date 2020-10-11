Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C7028AABD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 23:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgJKVa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 17:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgJKVa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 17:30:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDF1C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 14:30:27 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d24so11976738ljg.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 14:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NtfMoZcJsUOP21+R3/aYdVLkBdXfitlrNdcfOzs6A9w=;
        b=akPYubQdAz8wNfOKu26EmUh0DNehJNK1VBWG70YJFApHNI1y4w0zEM+8xwuecJLhWN
         tEzP8osZTOAn+Qls8JApIawfCMm67IXDKH0zmMJT5T5HjbXKeez3iHJlrzjYVbPiS1Kp
         9oTNwyeRS8zFJOBDOSm4l7LYQhqwFPDvxBXXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=NtfMoZcJsUOP21+R3/aYdVLkBdXfitlrNdcfOzs6A9w=;
        b=nRffrcLT4HrFuJSf6LZ80EwJVBk4OsdhZMymAgiW9/d7gS+sz7dLAUW/u5f+vai+4k
         DvHsa8807F7vCv0tF4E7CmUv+WYZjPKWAlFGkIM7x+egEjlpwgLFh7Vjjgr+BNVzulvu
         w0WQF6cKmGNcaA3j+qOCU9C6YNd0U60CLpDGcAwjCh90bYznVj0L7ILo186vuBoOiIRh
         w9TBLHVpnOlYt62SwK5eYrViU4tcuOmoijtBeSoGIWIvo4lH6SfW9Yr0NntommRJ4Az9
         FKus44eex6WEUdrPNFGTH/mHbSc9HNyUrwkiPyd6mL0IgM1lghyARt/mGUOIlsdRDpla
         vcyw==
X-Gm-Message-State: AOAM5337V8VBqELXR/eT7Azj/zfV2MjR2w4OK60dUOKxIRQoD0I4KtG2
        BZKJcTQBQUyV8TLBotAP6dCfKorGpGTiDQ==
X-Google-Smtp-Source: ABdhPJzumjRJRCe5GMcN7gufDJ9FWvJVuvgWaMg8dDEGe21l/KUK1jNbTKRIql5PE1hb978FqT0WBg==
X-Received: by 2002:a2e:90d2:: with SMTP id o18mr2065077ljg.337.1602451825559;
        Sun, 11 Oct 2020 14:30:25 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id g20sm3349466ljn.134.2020.10.11.14.30.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2020 14:30:24 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id a7so15238885lfk.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 14:30:24 -0700 (PDT)
X-Received: by 2002:a19:cbcb:: with SMTP id b194mr655463lfg.133.1602451824016;
 Sun, 11 Oct 2020 14:30:24 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Oct 2020 14:30:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-u86++np80GQvgDuARdt9xpBNho6SjHLmYgm8jibGag@mail.gmail.com>
Message-ID: <CAHk-=wi-u86++np80GQvgDuARdt9xpBNho6SjHLmYgm8jibGag@mail.gmail.com>
Subject: Linux 5.9
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, so I'll be honest - I had hoped for quite a bit fewer changes this
last week, but at the same time there doesn't really seem to be
anything particularly scary in here. It's just more commits and more
lines changed than I would have wished for.

The bulk of this is the networking fixes that I already mentioned as
being pending in the rc8 release notes last weekend. In fact, about
half the patch (and probably more of the number of commits) is from
the networking stuff (both drivers and elsewhere).

Outside of that, the most visible thing is a reinstatement of the
fbdev amba-clcd driver - that's a noticeable patch, but it's basically
just mainly a revert.

The rest is really really tiny (mostly some other minor driver
updates, but some filesystem and architecture fixes too). There's just
a bit more of those kinds of tiny details than there should be fo this
kind of last delayed week. But since nothing in there gives me any
particular reason to delay another week, here we are.

That obviously means that the merge window for 5.10 is open, and I'll
start doing those pulls tomorrow. I already have a couple of pulls
pending, but I hope people take the time to just do one last test of
the final 5.9 release.

So go get it.

              Linus

---

Aaron Ma (1):
      platform/x86: thinkpad_acpi: re-initialize ACPI buffer size when reus=
e

Alex Deucher (1):
      drm/amdgpu/swsmu: fix ARC build errors

Anant Thazhemadam (3):
      net: team: fix memory leak in __team_options_register
      net: usb: rtl8150: set random MAC address when set_ethernet_addr() fa=
ils
      net: wireless: nl80211: fix out-of-bounds access in nl80211_del_key()

Andrii Nakryiko (1):
      libbpf: Fix XDP program load regression for old kernels

Andy Shevchenko (2):
      platform/x86: intel-vbtn: Revert "Fix SW_TABLET_MODE always
reporting 1 on the HP Pavilion 11 x360"
      gpiolib: Disable compat ->read() code in UML case

Anirudh Venkataramanan (1):
      ice: Fix call trace on suspend

Antoine Tenart (1):
      MAINTAINERS: Antoine Tenart's email address

Antony Antony (4):
      xfrm: clone XFRMA_SET_MARK in xfrm_do_migrate
      xfrm: clone XFRMA_REPLAY_ESN_VAL in xfrm_do_migrate
      xfrm: clone XFRMA_SEC_CTX in xfrm_do_migrate
      xfrm: clone whole liftime_cur structure in xfrm_do_migrate

Atish Patra (1):
      RISC-V: Make sure memblock reserves the memory containing DT

Aya Levin (6):
      net/mlx5e: Fix error path for RQ alloc
      net/mlx5e: Add resiliency in Striding RQ mode for packets larger than=
 MTU
      net/mlx5e: Fix driver's declaration to support GRE offload
      net/mlx5e: Fix return status when setting unsupported FEC mode
      net/mlx5e: Fix VLAN cleanup flow
      net/mlx5e: Fix VLAN create flow

Chaitanya Kulkarni (1):
      nvme-core: put ctrl ref when module ref get fail

Christian Eggers (1):
      i2c: imx: Fix reset of I2SR_IAL flag

Christoph Hellwig (1):
      partitions/ibm: fix non-DASD devices

Christophe JAILLET (1):
      net: typhoon: Fix a typo Typoon --> Typhoon

Coly Li (8):
      net: introduce helper sendpage_ok() in include/linux/net.h
      net: add WARN_ONCE in kernel_sendpage() for improper zero-copy send
      nvme-tcp: check page by sendpage_ok() before calling kernel_sendpage(=
)
      tcp: use sendpage_ok() to detect misused .sendpage
      drbd: code cleanup by using sendpage_ok() to check page for
kernel_sendpage()
      scsi: libiscsi: use sendpage_ok() in iscsi_tcp_segment_map()
      libceph: use sendpage_ok() in ceph_tcp_sendpage()
      mmc: core: don't set limits.discard_granularity as 0

Cong Wang (4):
      net_sched: defer tcf_idr_insert() in tcf_action_init_1()
      net_sched: commit action insertions together
      net_sched: remove a redundant goto chain check
      net_sched: check error pointer in tcf_dump_walker()

Cristian Ciocaltea (1):
      i2c: owl: Clear NACK and BUS error bits

Daniel Borkmann (1):
      bpf: Fix scalar32_min_max_or bounds tracking

David Howells (6):
      rxrpc: Downgrade the BUG() for unsupported token type in rxrpc_read()
      rxrpc: Fix some missing _bh annotations on locking conn->state_lock
      rxrpc: Fix accept on a connection that need securing
      rxrpc: The server keyring isn't network-namespaced
      rxrpc: Fix server keyring leak
      afs: Fix deadlock between writeback and truncate

Dinghao Liu (1):
      Platform: OLPC: Fix memleak in olpc_ec_probe

Dirk Gouders (1):
      drm/amdgpu: fix NULL pointer dereference for Renoir

Dumitru Ceara (1):
      openvswitch: handle DNAT tuple collision

Ed Wildgoose (1):
      platform/x86: pcengines-apuv2: Fix typo on define of
AMD_FCH_GPIO_REG_GPIO55_DEVSLP0

Eli Cohen (1):
      vdpa/mlx5: Fix dependency on MLX5_CORE

Eran Ben Elisha (4):
      net/mlx5: Fix a race when moving command interface to polling mode
      net/mlx5: Avoid possible free of command entry while timeout comp han=
dler
      net/mlx5: poll cmd EQ in case of command timeout
      net/mlx5: Add retry mechanism to the command entry index allocation

Eric Dumazet (5):
      bonding: set dev->needed_headroom in bond_setup_by_slave()
      team: set dev->needed_headroom in team_setup_by_port()
      tcp: fix receive window update in tcp_add_backlog()
      sctp: fix sctp_auth_init_hmacs() error path
      macsec: avoid use-after-free in macsec_handle_frame()

Felix Fietkau (1):
      mt76: mt7615: reduce maximum VHT MPDU length to 7991

Florian Fainelli (1):
      MAINTAINERS: Add Vladimir as a maintainer for DSA

Geert Uytterhoeven (1):
      Revert "ravb: Fixed to be able to unload modules"

Geetha sowjanya (1):
      octeontx2-pf: Fix TCP/UDP checksum offload for IPv6 frames

Greg Kroah-Hartman (1):
      platform/x86: intel_pmc_core: do not create a static struct device

Greg Kurz (3):
      vhost: Don't call access_ok() when using IOTLB
      vhost: Use vhost_get_used_size() in vhost_vring_set_addr()
      vhost: Don't call log_access_ok() when using IOTLB

Guillaume Nault (1):
      net/core: check length before updating Ethertype in skb_mpls_{push,po=
p}

Guo Ren (1):
      riscv: Fixup bootup failure with HARDENED_USERCOPY

Hans de Goede (6):
      platform/x86: touchscreen_dmi: Add info for the MPMAN Converter9 2-in=
-1
      platform/x86: asus-nb-wmi: Revert "Do not load on Asus T100TA and T20=
0TA"
      platform/x86: intel-vbtn: Fix SW_TABLET_MODE always reporting 1
on the HP Pavilion 11 x360
      platform/x86: intel-vbtn: Switch to an allow-list for
SW_TABLET_MODE reporting
      MAINTAINERS: Add Mark Gross and Hans de Goede as x86 platform
drivers maintainers
      platform/x86: asus-wmi: Fix SW_TABLET_MODE always reporting 1 on
many different models

Hariprasad Kelam (2):
      octeontx2-pf: Fix the device state on error
      octeontx2-pf: Fix synchnorization issue in mbox

Hauke Mehrtens (1):
      net: lantiq: Add locking for TX DMA channel

He Zhe (1):
      bpf, powerpc: Fix misuse of fallthrough in bpf_jit_comp()

Heiner Kallweit (4):
      r8169: fix RTL8168f/RTL8411 EPHY config
      r8169: fix handling ether_clk
      r8169: fix data corruption issue on RTL8402
      r8169: consider that PHY reset may still be in progress after
applying firmware

Heinrich Schuchardt (1):
      Documentation/x86: Fix incorrect references to zero-page.txt

Helmut Grohne (1):
      net: dsa: microchip: really look for phy-mode in port nodes

Henrik Bjoernlund (1):
      bridge: Netlink interface fix.

Herbert Xu (1):
      xfrm: Use correct address family in xfrm_state_find

Hugh Dickins (1):
      mm/khugepaged: fix filemap page_to_pgoff(page) !=3D offset

Ido Schimmel (1):
      mlxsw: spectrum_acl: Fix mlxsw_sp_acl_tcam_group_add()'s error path

Igor Russkikh (1):
      net: atlantic: fix build when object tree is separate

Ioana Ciornei (1):
      dpaa2-eth: fix command version for Tx shaping

Ivan Khoronzhuk (1):
      net: ethernet: cavium: octeon_mgmt: use phy_start and phy_stop

Jacob Keller (4):
      ice: fix memory leak if register_netdev_fails
      ice: fix memory leak in ice_vsi_setup
      ice: increase maximum wait time for flash write commands
      ice: preserve NVM capabilities in safe mode

Jakub Kicinski (2):
      genetlink: add missing kdoc for validation flags
      ethtool: mark netlink family as __ro_after_init

Jamie Iles (1):
      net/fsl: quieten expected MDIO access failures

Jeremy Linton (1):
      crypto: arm64: Use x16 with indirect branch to bti_c

Jerome Brunet (2):
      i2c: meson: fix clock setting overwrite
      i2c: meson: keep peripheral clock enabled

Johannes Berg (1):
      netlink: fix policy dump leak

Kajol Jain (1):
      perf: Fix task_function_call() error handling

Karol Herbst (2):
      drm/nouveau/device: return error for unknown chipsets
      drm/nouveau/mem: guard against NULL pointer access in mem_del

Kees Cook (1):
      MAINTAINERS: change hardening mailing list

Kevin Brace (4):
      via-rhine: Fix for the hardware having a reset failure after resume
      via-rhine: VTunknown1 device is really VT8251 South Bridge
      via-rhine: Eliminate version information
      via-rhine: New device driver maintainer

Linus Torvalds (4):
      splice: teach splice pipe reading about empty pipe buffers
      usermodehelper: reset umask to default before executing user process
      mm: avoid early COW write protect games during fork()
      Linux 5.9

Luo bin (1):
      hinic: fix wrong return value of mac-set cmd

Maciej =C5=BBenczykowski (1):
      net/ipv4: always honour route mtu during forwarding

Magnus Karlsson (1):
      xsk: Do not discard packet when NETDEV_TX_BUSY

Manivannan Sadhasivam (2):
      net: qrtr: ns: Protect radix_tree_deref_slot() using rcu read locks
      net: qrtr: ns: Fix the incorrect usage of rcu_read_lock()

Maor Dickman (1):
      net/mlx5e: CT, Fix coverity issue

Maor Gottlieb (1):
      net/mlx5: Fix request_irqs error flow

Marc Dionne (1):
      rxrpc: Fix rxkad token xdr encoding

Marc Zyngier (1):
      gpio: pca953x: Survive spurious interrupts

Marian-Cristian Rotariu (1):
      dt-bindings: net: renesas,ravb: Add support for r8a774e1 SoC

Marius Iacob (1):
      platform/x86: asus-wmi: Add BATC battery name to the list of supporte=
d

Masami Hiramatsu (1):
      arm/arm64: xen: Fix to convert percpu address to gfn correctly

Mat Martineau (3):
      mptcp: Wake up MPTCP worker when DATA_FIN found on a TCP FIN packet
      mptcp: Consistently use READ_ONCE/WRITE_ONCE with msk->ack_seq
      mptcp: Handle incoming 32-bit DATA_FIN values

Mauro Carvalho Chehab (2):
      drm: drm_dsc.h: fix a kernel-doc markup
      net: core: document two new elements of struct net_device

Miaohe Lin (1):
      mm: mmap: Fix general protection fault in unlink_file_vma()

Michael Walle (1):
      spi: fsl-dspi: fix NULL pointer dereference

Mike Christie (1):
      vhost vdpa: fix vhost_vdpa_open error handling

Minchan Kim (1):
      mm: validate inode in mapping_set_error()

Namjae Jeon (1):
      exfat: fix use of uninitialized spinlock on error path

Necip Fazil Yildiran (2):
      platform/x86: fix kconfig dependency warning for LG_LAPTOP
      platform/x86: fix kconfig dependency warning for FUJITSU_LAPTOP

Nicolas Belin (1):
      i2c: meson: fixup rate calculation with filter delay

Nikolay Aleksandrov (1):
      net: bridge: fdb: don't flush ext_learn entries

Paolo Abeni (2):
      tcp: fix syn cookied MPTCP request socket leak
      mptcp: more DATA FIN fixes

Peilin Ye (4):
      fbdev, newport_con: Move FONT_EXTRA_WORDS macros into linux/font.h
      Fonts: Support FONT_EXTRA_WORDS macros for built-in fonts
      fbcon: Fix global-out-of-bounds read in fbcon_get_font()
      block/scsi-ioctl: Fix kernel-infoleak in scsi_put_cdrom_generic_arg()

Peter Collingbourne (1):
      Partially revert "video: fbdev: amba-clcd: Retire elder CLCD driver"

Petko Manolov (1):
      net: usb: pegasus: Proper error handing when setting pegasus' MAC add=
ress

Priyaranjan Jha (1):
      tcp: skip DSACKs with dubious sequence ranges

Qian Cai (1):
      pipe: Fix memory leaks in create_pipe_files()

Randy Dunlap (3):
      Documentation: laptops: thinkpad-acpi: fix underline length build war=
ning
      mdio: fix mdio-thunder.c dependency & build error
      net: hinic: fix DEVLINK build errors

Rohit Maheshwari (1):
      net/tls: race causes kernel panic

Ronak Doshi (1):
      vmxnet3: fix cksum offload issues for non-udp tunnels

Sabrina Dubroca (2):
      espintcp: restore IP CB before handing the packet to xfrm
      xfrmi: drop ignore_df check before updating pmtu

Saeed Mahameed (1):
      net/mlx5: cmdif, Avoid skipping reclaim pages if FW is not accessible

Sebastian Reichel (1):
      power: supply: sbs-battery: chromebook workaround for PEC

Serge Semin (1):
      MAINTAINERS: Add maintainer of DW APB SSI driver

Si-Wei Liu (3):
      vhost-vdpa: fix vhost_vdpa_map() on error condition
      vhost-vdpa: fix page pinning leakage in error path
      vdpa/mlx5: should keep avail_index despite device status

Subbaraya Sundeep (1):
      octeontx2-af: Fix enable/disable of default NPC entries

Sylwester Dziedziuch (1):
      iavf: Fix incorrect adapter get in iavf_resume

Taehee Yoo (3):
      net: core: add __netdev_upper_dev_unlink()
      net: core: introduce struct netdev_nested_priv for nested
interface infrastructure
      net: core: add nested_level variable in net_device

Tetsuhiro Kohada (1):
      exfat: fix pointer error checking

Thomas Gleixner (1):
      x86/mce: Use idtentry_nmi_enter/exit()

Tian Tao (1):
      net: switchdev: Fixed kerneldoc warning

Tom Rix (2):
      platform/x86: thinkpad_acpi: initialize tp_nvram_state variable
      net: mvneta: fix double free of txq->buf

Tonghao Zhang (1):
      virtio-net: don't disable guest csum when disable LRO

Tony Ambardar (4):
      tools/bpftool: Support passing BPFTOOL_VERSION to make
      bpf: Fix sysfs export of empty BTF section
      bpf: Prevent .BTF section elimination
      libbpf: Fix native endian assumption when parsing BTF

Tony Nguyen (1):
      MAINTAINERS: Update MAINTAINERS for Intel ethernet drivers

Vadim Pasternak (1):
      platform/x86: mlx-platform: Fix extended topology configuration
for power supply units

Vijay Balakrishna (1):
      mm: khugepaged: recalculate min_free_kbytes after memory hotplug
as expected by khugepaged

Vineetha G. Jaya Kumaran (1):
      net: stmmac: Modify configuration method of EEE timers

Vlad Buslov (1):
      net/mlx5e: Fix race condition on nhe->n pointer in neigh update

Vladimir Oltean (4):
      net: dsa: felix: fix incorrect action offsets for VCAP IS2
      net: dsa: seville: fix VCAP IS2 action width
      net: mscc: ocelot: divide watermark value by 60 when writing to SYS_A=
TOP
      net: mscc: ocelot: warn when encoding an out-of-bounds watermark valu=
e

Vladimir Zapolskiy (1):
      cifs: Fix incomplete memory allocation on setxattr path

Voon Weifeng (1):
      net: stmmac: removed enabling eee in EEE set callback

Wang Qing (1):
      net/ethernet/broadcom: fix spelling typo

Wilken Gottwalt (4):
      net: usb: ax88179_178a: add Toshiba usb 3.0 adapter
      net: usb: ax88179_178a: fix missing stop entry in driver_info
      net: usb: ax88179_178a: add MCT usb 3.0 adapter
      net: usb: qmi_wwan: add Cellient MPL200 card

Willy Liu (1):
      net: phy: realtek: fix rtl8211e rx/tx delay config

Wolfram Sang (1):
      Revert "i2c: imx: Fix reset of I2SR_IAL flag"

Wong Vee Khee (1):
      net: stmmac: Fix clock handling on remove path

Xiaoliang Yang (2):
      net: dsa: felix: convert TAS link speed based on phylink speed
      net: mscc: ocelot: fix fields offset in SG_CONFIG_REG_3

Xie He (1):
      drivers/net/wan/x25_asy: Correct the ndo_open and ndo_stop functions

Yonghong Song (1):
      bpf: Fix "unresolved symbol" build error with resolve_btfids

Yongqiang Sun (1):
      drm/amd/display: Change ABM config init interface

YueHaibing (1):
      ip_vti: Fix unused variable warning
