Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB3C2BFD39
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 01:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgKWAIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 19:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgKWAIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 19:08:05 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08D7C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 16:08:04 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id b17so16083364ljf.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 16:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ioDObt8gFxyLvP8iOuj08ue65lmanD/Q1SvpanfTDfk=;
        b=Hv4NCPKlIUg7kUBQdyib8Ao8ZQ9REk2SrA9nRNlF4a220ea7F3cewYc9TbTfaDZjR9
         +DNBS5pIOtS7B+AgA/wuCnOpuCQdix+Am7VLdaVVzsAPLixnThwNxTehlLcPgHiaBlyX
         5KuJ3446BjVz39M2RgxiTBa6TDFGiaARdIWMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ioDObt8gFxyLvP8iOuj08ue65lmanD/Q1SvpanfTDfk=;
        b=mxDSFhInkB8EU+qMu9anWPAzCqyPio7fvYYJtAxqbG+UfhGs2B5VT883VVGhT+Vl5H
         y9+lZVgPPiwOePOW47xAcpsp2DphfjxI5OC6y+DwZJLb3OIImqGuh/3gjXqJjLT2Ktp4
         PJGnHqcOPqkNIxbFfqFo0lKv8Bdwts2llkT97rCyVm74NRTsthOeuY9SP1urCUt1Oo6a
         Lv03uEIook7C6d4vcrtSSzHPNhjgXaccZUX8f2JO9f/m/hfI//EhrDbzu9mpqfDYOvpI
         NyISTtrP63PMcsaEpHNmmqOogn7/rYuXATx3nyP4czMHM7Tb+CnvJIKMPCCmhoTF3TG+
         SNrQ==
X-Gm-Message-State: AOAM533eMZ5xlOJ6xSvNucV+v0afgIi96IYGCHk67rwy7pgoMLRP5sgU
        f9SP54hkAYQZRfAJBQOphIErVRBZEdzWrw==
X-Google-Smtp-Source: ABdhPJyBnjby1n7hZb9/fL918Jx5CJV0qLWrcjGQq1s9GHg3h7isUVmt2i0c210/eK7YNO7n1ubp/Q==
X-Received: by 2002:a2e:9197:: with SMTP id f23mr406747ljg.83.1606090081762;
        Sun, 22 Nov 2020 16:08:01 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u19sm1108702ljk.128.2020.11.22.16.08.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 16:08:00 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id d20so5507627lfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 16:08:00 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr10855328lfy.352.1606090079320;
 Sun, 22 Nov 2020 16:07:59 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Nov 2020 16:07:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiYHcVOuZo8LNn__OgqY_ePW3BSPW8FxZbfChrT8SHnuw@mail.gmail.com>
Message-ID: <CAHk-=wiYHcVOuZo8LNn__OgqY_ePW3BSPW8FxZbfChrT8SHnuw@mail.gmail.com>
Subject: Linux 5.10-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. The 5.10 release candidates stubbornly keeps staying fairly big,
even though by rc5 we really should be seeing things starting to calm
down and shrink.

There's nothing in here that makes me particularly nervous, but in
pure numbers of commits, this is the largest rc5 we've had in the 5.x
series. Number of diff lines too, for that matter. And I can't even
claim that it's because previous rc's have been small and missing
stuff and we were just catching up.

Anyway, changes all over, and apart from it being a bit more than I'd
like, it all looks fairly normal. About half of the patch is drivers,
with the rest being fairly evenly spread out all over - architecture
fixes, filesystems, networking, self tests..

We'll have to see how this release shapes up, but I'm still hopeful
for things to calm down.   Otherwise we get into uncomfortable
territory for the next release with the holiday season coming up too.

So go forth and test,

             Linus

---

Adam Ford (2):
      arm64: dts: imx8mm-beacon-som: Fix Choppy BT audio
      arm64: dts imx8mn: Remove non-existent USB OTG2

Adrian Hunter (1):
      mmc: sdhci-pci: Prefer SDR25 timing for High Speed mode for
BYT-based Intel controllers

Aili Yao (1):
      ACPI, APEI, Fix error return value in apei_map_generic_address()

Al Grant (1):
      perf inject: Fix file corruption due to event deletion

Alejandro Concepcion Rodriguez (1):
      can: dev: can_restart(): post buffer from the right context

Alex Deucher (2):
      drm/amd/display: Add missing pflip irq for dcn2.0
      drm/amdgpu: remove experimental flag from arcturus

Alex Elder (1):
      net: ipa: lock when freeing transaction

Alex Marginean (1):
      enetc: Workaround for MDIO register access issue

Alexei Starovoitov (1):
      MAINTAINERS/bpf: Update Andrii's entry.

Amir Goldstein (1):
      fanotify: fix logic of reporting name info with watched parent

Anant Thazhemadam (2):
      can: af_can: prevent potential access of uninitialized member in can_=
rcv()
      can: af_can: prevent potential access of uninitialized member in
canfd_rcv()

Andrew Lunn (2):
      ARM: dts: vf610-zii-dev-rev-b: Fix MDIO over clocking
      net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset

Andrii Nakryiko (2):
      libbpf: Don't attempt to load unused subprog as an entry-point BPF pr=
ogram
      selftests/bpf: Fix unused attribute usage in subprogs_unused test

Andy Shevchenko (2):
      kunit: Do not pollute source directory with generated files (.kunitco=
nfig)
      kunit: Do not pollute source directory with generated files (test.log=
)

Ard Biesheuvel (1):
      efi/arm: set HSCTLR Thumb2 bit correctly for HVC calls from HYP

Arnaldo Carvalho de Melo (1):
      tools arch: Update arch/x86/lib/mem{cpy,set}_64.S copies used in
'perf bench mem memcpy'

Arnd Bergmann (1):
      dmaengine: ti: k3-udma: fix -Wenum-conversion warning

Arvind Sankar (1):
      efi/x86: Free efi_pgd with free_pages()

Aya Levin (1):
      net/mlx4_core: Fix init_hca fields offset

Biwen Li (1):
      arm64: dts: fsl: fix endianness issue of rcpm

Bob Peterson (1):
      gfs2: Fix regression in freeze_go_sync

Boqun Feng (1):
      lockdep: Put graph lock/unlock under lock_recursion protection

Brendan Higgins (1):
      kunit: tool: unmark test_data as binary blobs

Brian Masney (1):
      x86/xen: don't unbind uninitialized lock_kicker_irq

Brian O'Keefe (1):
      staging: rtl8723bs: Add 024c:0627 to the list of SDIO device-ids

Cezary Rojewski (2):
      ASoC: Intel: catpt: Skip position update for unprepared streams
      ASoC: Intel: catpt: Correct clock selection for dai trigger

Chen Yu (1):
      x86/microcode/intel: Check patch signature before saving
microcode for early loading

Chen-Yu Tsai (10):
      Revert "arm: sun8i: orangepi-pc-plus: Set EMAC activity LEDs to
active high"
      ARM: dts: sun6i: a31-hummingbird: Enable RGMII RX/TX delay on Etherne=
t PHY
      ARM: dts: sun7i: cubietruck: Enable RGMII RX/TX delay on Ethernet PHY
      ARM: dts: sun7i: bananapi-m1-plus: Enable RGMII RX/TX delay on
Ethernet PHY
      ARM: dts: sun8i: h3: orangepi-plus2e: Enable RGMII RX/TX delay
on Ethernet PHY
      ARM: dts: sun8i: a83t: Enable both RGMII RX/TX delay on Ethernet PHY
      ARM: dts: sun9i: Enable both RGMII RX/TX delay on Ethernet PHY
      ARM: dts: sunxi: bananapi-m2-plus: Enable RGMII RX/TX delay on
Ethernet PHY
      arm64: dts: allwinner: h5: libretech-all-h5-cc: Enable RGMII
RX/TX delay on PHY
      arm64: dts: allwinner: a64: bananapi-m64: Enable RGMII RX/TX delay on=
 PHY

Chris Co (1):
      Drivers: hv: vmbus: Allow cleanup of VMBUS_CONNECT_CPU if disconnecte=
d

Chris Wilson (2):
      drm/i915/gt: Remember to free the virtual breadcrumbs
      drm/i915/gt: Fixup tgl mocs for PTE tracking

Chris Ye (1):
      HID: add HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE for Gamevice devices

Christoph Hellwig (2):
      RMDA/sw: Don't allow drivers using dma_virt_ops on highmem configs
      blk-cgroup: fix a hd_struct leak in blkcg_fill_root_iostats

Claire Chang (1):
      rfkill: Fix use-after-free in rfkill_resume()

Cl=C3=A9ment P=C3=A9ron (2):
      arm64: dts: allwinner: pinetab: Drop unnecessary
address/size-cells information
      arm64: dts: allwinner: beelink-gs1: Enable both RGMII RX/TX delay

Colin Ian King (1):
      can: peak_usb: fix potential integer overflow on shift of a int

Colin Xu (1):
      drm/i915/gvt: Temporarily disable vfio_edid for BXT/APL

Corentin Labbe (1):
      arm64: dts: allwinner: Pine H64: Enable both RGMII RX/TX delay

Dan Carpenter (3):
      Input: adxl34x - clean up a data type in adxl34x_probe()
      ALSA: firewire: Clean up a locking issue in copy_resp_to_buf()
      dmaengine: fix error codes in channel_register()

Dan Murphy (2):
      can: m_can: m_can_class_free_dev(): introduce new function
      can: m_can: Fix freeing of can device from peripherials

Dan Williams (1):
      mm: fix phys_to_target_node() and memory_add_physaddr_to_nid() export=
s

Daniel Axtens (3):
      selftests/powerpc: entry flush test
      selftests/powerpc: refactor entry and rfi_flush tests
      powerpc/64s: rename pnv|pseries_setup_rfi_flush to
_setup_security_mitigations

Daniel Latypov (4):
      kunit: tool: fix pre-existing python type annotation errors
      kunit: tool: print out stderr from make (like build warnings)
      kunit: tool: fix extra trailing \n in raw + parsed test output
      kunit: fix display of failed expectations for strings

Daniel Xu (2):
      lib/strncpy_from_user.c: Mask out bytes after NUL terminator.
      selftest/bpf: Test bpf_probe_read_user_str() strips trailing
bytes after NUL

Darrick J. Wong (5):
      xfs: fix the minrecs logic when dealing with inode root child blocks
      xfs: strengthen rmap record flags checking
      xfs: directory scrub should check the null bestfree entries too
      xfs: ensure inobt record walks always make forward progress
      xfs: revert "xfs: fix rmap key and record comparison functions"

Dave Chinner (1):
      xfs: don't allow NOWAIT DIO across extent boundaries

Dave Jiang (2):
      dmaengine: idxd: fix wq config registers offset programming
      dmaengine: idxd: fix mapping of portal size

David Gow (1):
      kunit: Fix kunit.py parse subcommand (use null build_dir)

David Howells (1):
      afs: Fix speculative status fetch going out of order wrt to modificat=
ions

David Lechner (1):
      counter/ti-eqep: Fix regmap max_register

Dinh Nguyen (1):
      arm64: dts: agilex/stratix10: Fix qspi node compatible

Dmitrii Banshchikov (1):
      bpf: Relax return code check for subprograms

Dmitry Bogdanov (1):
      qed: fix ILT configuration of SRC block

Dmitry Osipenko (1):
      cpuidle: tegra: Annotate tegra_pm_set_cpu_in_lp2() with RCU_NONIDLE

Dmitry Torokhov (1):
      Input: sunkbd - avoid use-after-free in teardown paths

Dongli Zhang (1):
      page_frag: Recover from memory pressure

Eddie James (1):
      spi: fsi: Fix transfer returning without finalizing message

Edwin Peer (1):
      bnxt_en: read EEPROM A2h address using page 0

Eli Cohen (1):
      net/mlx5: E-Switch, Fail mlx5_esw_modify_vport_rate if qos disabled

Enric Balletbo i Serra (1):
      can: tcan4x5x: replace depends on REGMAP_SPI with depends on SPI

Eric Dumazet (1):
      mm/madvise: fix memory leak from process_madvise

Fabien Parent (1):
      iio: adc: mediatek: fix unset field

Fabio Estevam (1):
      ARM: dts: imx50-evk: Fix the chip select 1 IOMUX

Fabrice Gasnier (1):
      docs: ABI: testing: iio: stm32: remove re-introduced unsupported ABI

Faiz Abbas (1):
      can: m_can: m_can_stop(): set device to software init mode before clo=
sing

Felix Fietkau (3):
      mac80211: fix memory leak on filtered powersave frames
      mac80211: minstrel: remove deferred sampling code
      mac80211: minstrel: fix tx status processing corner case

Filip Moc (1):
      net: usb: qmi_wwan: Set DTR quirk for MR400

Florian Fainelli (1):
      net: Have netpoll bring-up DSA management interface

Florian Klink (1):
      ipv4: use IS_ENABLED instead of ifdef

Frank Yang (1):
      HID: cypress: Support Varmilo Keyboards' media hotkeys

Fugang Duan (1):
      tty: serial: imx: keep console clocks always on

Gao Xiang (1):
      xfs: fix forkoff miscalculation related to XFS_LITINO(mp)

Georg Kohmann (2):
      ipv6/netfilter: Discard first fragment not including all headers
      ipv6: Remove dependency of ipv6_frag_thdr_truncated on ipv6 module

Gerald Schaefer (1):
      mm/userfaultfd: do not access vma->vm_mm after calling handle_userfau=
lt()

Grygorii Strashko (1):
      net: ethernet: ti: cpsw: fix cpts irq after suspend

Guenter Roeck (2):
      ACPI: fan: Initialize performance state sysfs attribute
      ASOC: Intel: kbl_rt5663_rt5514_max98927: Do not try to disable
disabled clock

Gwendal Grignou (1):
      iio: cros_ec: Use default frequencies when EC returns invalid informa=
tion

Hans de Goede (10):
      HID: ite: Replace ABS_MISC 120/121 events with touchpad on/off keypre=
sses
      Input: i8042 - allow insmod to succeed on devices without an
i8042 controller
      HID: i2c-hid: Put ACPI enumerated devices in D3 on shutdown
      HID: logitech-dj: Handle quad/bluetooth keyboards with a builtin trac=
kpad
      HID: logitech-hidpp: Add HIDPP_CONSUMER_VENDOR_KEYS quirk for
the Dinovo Edge
      HID: Add Logitech Dinovo Edge battery quirk
      iio: accel: kxcjk1013: Replace is_smo8500_device with an acpi_type en=
um
      iio: accel: kxcjk1013: Add support for KIOX010A ACPI DSM for
setting tablet-mode
      HID: logitech-dj: Fix an error in mse_bluetooth_descriptor
      HID: logitech-dj: Fix Dinovo Mini when paired with a MX5x00 receiver

Harry Cutts (1):
      HID: logitech-hidpp: Add PID for MX Anywhere 2

Heiko Carstens (2):
      s390: fix system call exit path
      s390: update defconfigs

Heiner Kallweit (1):
      net: bridge: add missing counters to ndo_get_stats64 callback

Huy Nguyen (2):
      net/mlx5e: Set IPsec WAs only in IP's non checksum partial case.
      net/mlx5e: Fix IPsec packet drop by mlx5e_tc_update_skb

Ian Rogers (1):
      perf test: Avoid an msan warning in a copied stack.

Ido Schimmel (2):
      mlxsw: Fix firmware flashing
      mlxsw: core: Use variable timeout for EMAD retries

Jack Yu (1):
      ASoC: rt1015: add delay to fix pop noise from speaker

Jan Kara (1):
      ext4: fix bogus warning in ext4_update_dx_flag()

Jarkko Nikula (1):
      can: m_can: process interrupt only when not runtime suspended

Jason Gunthorpe (1):
      RDMA/cm: Make the local_id_table xarray non-irq

Jeff Dike (1):
      net: Exempt multicast addresses from five-second neighbor lifetime

Jens Axboe (4):
      proc: don't allow async path resolution of /proc/self components
      io_uring: handle -EOPNOTSUPP on path resolution
      mm: never attempt async page lock if we've transferred data already
      io_uring: don't double complete failed reissue request

Jernej Skrabec (4):
      arm64: dts: allwinner: a64: OrangePi Win: Fix ethernet node
      arm64: dts: allwinner: a64: Pine64 Plus: Fix ethernet node
      arm64: dts: allwinner: h5: OrangePi PC2: Fix ethernet node
      ARM: dts: sun8i: r40: bananapi-m2-ultra: Fix ethernet node

Jimmy Assarsson (2):
      can: kvaser_pciefd: Fix KCAN bittiming limits
      can: kvaser_usb: kvaser_usb_hydra: Fix KCAN bittiming limits

Jiri Kosina (1):
      HID: add support for Sega Saturn

Jiri Olsa (1):
      libbpf: Fix VERSIONED_SYM_COUNT number parsing

Jisheng Zhang (1):
      net: stmmac: dwmac_lib: enlarge dma reset timeout

Joakim Tjernlund (1):
      ALSA: usb-audio: Add delay quirk for all Logitech USB devices

Joel Stanley (2):
      net/ncsi: Fix netlink registration
      net: ftgmac100: Fix crash when removing driver

Johannes Berg (1):
      mac80211: free sta in sta_info_insert_finish() on errors

John Fastabend (6):
      bpf, sockmap: Fix partial copy_page_to_iter so progress can still be =
made
      bpf, sockmap: Ensure SO_RCVBUF memory is observed on ingress redirect
      bpf, sockmap: Use truesize with sk_rmem_schedule()
      bpf, sockmap: Avoid returning unneeded EAGAIN when redirecting to sel=
f
      bpf, sockmap: Handle memory acct if skb_verdict prog redirects to sel=
f
      bpf, sockmap: Avoid failures from skb_to_sgvec when skb has frag_list

Jon Hunter (1):
      cpufreq: tegra186: Fix get frequency callback

Jonathan Liu (1):
      drm: bridge: dw-hdmi: Avoid resetting force in the detect function

Juri Lelli (1):
      sched/deadline: Fix priority inheritance with multiple scheduling cla=
sses

Kai Vehmanen (1):
      ALSA: hda: Add Alderlake-S PCI ID and HDMI codec vid

Kai-Heng Feng (1):
      ALSA: usb-audio: Use ALC1220-VB-DT mapping for ASUS ROG Strix TRX40 m=
obo

Kailang Yang (3):
      ALSA: hda/realtek - Add supported for Lenovo ThinkPad Headset Button
      ALSA: hda/realtek - Add supported mute Led for HP
      ALSA: hda/realtek - HP Headset Mic can't detect after boot

Kaixu Xia (1):
      bpf: Fix unsigned 'datasec_id' compared with zero in check_pseudo_btf=
_id

Karsten Graul (2):
      net/smc: fix matching of existing link groups
      net/smc: fix direct access to ib_gid_addr->ndev in smc_ib_determine_g=
id()

Kees Cook (2):
      selftests/seccomp: powerpc: Fix typo in macro variable name
      selftests/seccomp: sh: Fix register names

Keith Busch (2):
      nvme: directly cache command effects log
      nvme: fix memory leak freeing command effects

Krzysztof Kozlowski (11):
      MAINTAINERS: move Kamil Debski to credits
      MAINTAINERS: move Kyungmin Park to credits
      MAINTAINERS: remove Jeongtae Park from Samsung MFC entry
      CREDITS: remove trailing white spaces
      arm64: dts: imx8mm-var-som: fix missing PMIC's interrupt line pull-up
      arm64: dts: imx8mm-beacon-som: fix missing PMIC's interrupt line pull=
-up
      arm64: dts: imx8mm-evk: fix missing PMIC's interrupt line pull-up
      arm64: dts: imx8mn-var-som: fix missing PMIC's interrupt line pull-up
      arm64: dts: imx8mn-ddr4-evk: fix missing PMIC's interrupt line pull-u=
p
      arm64: dts: imx8mn-evk: fix missing PMIC's interrupt line pull-up
      ARM: dts: exynos: revert "add input clock to CMU in Exynos4412 Odroid=
"

Lad Prabhakar (1):
      arm64: dts: renesas: r8a774e1: Add missing audio_clk_b

Lars Povlsen (1):
      HID: mcp2221: Fix GPIO output handling

Laurent Pinchart (1):
      xtensa: uaccess: Add missing __user to strncpy_from_user() prototype

Laurent Vivier (1):
      vdpasim: fix "mac_pton" undefined error

Lee Duncan (1):
      scsi: libiscsi: Fix NOP race condition

Leo Yan (4):
      perf lock: Correct field name "flags"
      perf lock: Don't free "lock_seq_stat" if read_count isn't zero
      perf test: Fix a typo in cs-etm testing
      perf test: Update branch sample pattern for cs-etm

Linus Torvalds (1):
      Linux 5.10-rc5

Lorenzo Bianconi (2):
      iio: imu: st_lsm6dsx: set 10ms as min shub slave timeout
      net: mvneta: fix possible memory leak in mvneta_swbm_add_rx_fragment

Lu Baolu (1):
      iommu/vt-d: Fix compile error with CONFIG_PCI_ATS not set

Lucas Stach (1):
      arm64: dts: imx8mm: fix voltage for 1.6GHz CPU operating point

Lukas Bulwahn (1):
      dmaengine: ioatdma: remove unused function missed during dma_v2 remov=
al
v5.10-rc4..v5.10-rc5
Lukas Wunner (6):
      spi: Introduce device-managed SPI controller allocation
      spi: bcm2835: Fix use-after-free on unbind
      spi: bcm2835aux: Fix use-after-free on unbind
      spi: bcm-qspi: Fix use-after-free on unbind
      spi: lpspi: Fix use-after-free on unbind
      spi: npcm-fiu: Don't leak SPI master in probe error path

Luo Meng (1):
      fail_function: Remove a redundant mutex unlock

Madalin Bucur (1):
      arm64: dts: fsl: DPAA FMan DMA operations are coherent

Manish Narani (3):
      mmc: sdhci-of-arasan: Allow configuring zero tap values
      mmc: sdhci-of-arasan: Use Mask writes for Tap delays
      mmc: sdhci-of-arasan: Issue DLL reset explicitly

Maor Dickman (1):
      net/mlx5e: Fix check if netdev is bond slave

Maor Gottlieb (1):
      tools/testing/scatterlist: Fix test to compile and run

Marc Ferland (1):
      dmaengine: xilinx_dma: use readl_poll_timeout_atomic variant

Marc Kleine-Budde (5):
      can: mcba_usb: mcba_usb_start_xmit(): first fill skb, then pass
to can_put_echo_skb()
      can: flexcan: flexcan_setup_stop_mode(): add missing "req_bit"
to stop mode property comment
      can: tcan4x5x: tcan4x5x_can_probe(): add missing error checking
for devm_regmap_init()
      can: tcan4x5x: tcan4x5x_can_remove(): fix order of deregistration
      can: flexcan: flexcan_chip_start(): fix erroneous
flexcan_transceiver_enable() during bus-off recovery

Marek Vasut (5):
      ARM: dts: stm32: Fix TA3-GPIO-C key on STM32MP1 DHCOM PDK2
      ARM: dts: stm32: Fix LED5 on STM32MP1 DHCOM PDK2
      ARM: dts: stm32: Define VIO regulator supply on DHCOM
      ARM: dts: stm32: Enable thermal sensor support on stm32mp15xx-dhcor
      ARM: dts: stm32: Keep VDDA LDO1 always on on DHCOM

Martijn van de Streek (1):
      HID: uclogic: Add ID for Trust Flex Design Tablet

Martin Blumenstingl (1):
      net: lantiq: Wait for the GPHY firmware to be ready

Matthew Murrian (2):
      dmaengine: xilinx_dma: Fix usage of xilinx_aximcdma_tx_segment
      dmaengine: xilinx_dma: Fix SG capability check for MCDMA

Matthew Wilcox (Oracle) (2):
      mm: fix readahead_page_batch for retry entries
      mm: fix madvise WILLNEED performance problem

Mauro Carvalho Chehab (1):
      jbd2: fix kernel-doc markups

Max Filippov (2):
      xtensa: fix TLBTEMP area placement
      xtensa: disable preemption around cache alias management calls

Maxim Mikityanskiy (1):
      net/mlx5e: Fix refcount leak on kTLS RX resync

Maxime Ripard (2):
      MAINTAINERS: Add Jernej =C5=A0krabec as a reviewer for Allwinner SoCs=
 support
      drm/sun4i: backend: Fix probe failure with multiple backends

Michael Chan (2):
      bnxt_en: Free port stats during firmware reset.
      bnxt_en: Fix counter overflow logic.

Michael Ellerman (1):
      powerpc: Only include kup-radix.h for 64-bit Book3S

Michael Guralnik (1):
      net/mlx5: Add handling of port type in rule deletion

Michael Sit Wei Hong (1):
      ASoC: Intel: KMB: Fix S24_LE configuration

Micha=C5=82 Miros=C5=82aw (3):
      regulator: fix memory leak with repeated set_machine_constraints()
      regulator: avoid resolve_supply() infinite recursion
      regulator: workaround self-referent regulators

Micka=C3=ABl Sala=C3=BCn (2):
      ptrace: Set PF_SUPERPRIV when checking capability
      seccomp: Set PF_SUPERPRIV when checking capability

Mike Christie (6):
      vhost: add helper to check if a vq has been setup
      vhost scsi: alloc cmds per vq instead of session
      vhost scsi: fix cmd completion race
      vhost scsi: add lun parser helper
      vhost scsi: Add support for LUN resets.
      scsi: target: iscsi: Fix cmd abort fabric stop race

Ming Lei (1):
      block: mark flush request as IDLE when it is really finished

Minwoo Im (1):
      nvme: free sq/cq dbbuf pointers when dbbuf set fails

Muchun Song (1):
      mm: memcg/slab: fix root memcg vmstats

Nathan Chancellor (1):
      spi: bcm2835aux: Restore err assignment in bcm2835aux_spi_probe

Necip Fazil Yildiran (3):
      staging: ralink-gdma: fix kconfig dependency bug for DMA_RALINK
      iio: light: fix kconfig dependency bug for VCNL4035
      Input: resistive-adc-touch - fix kconfig dependency on IIO_BUFFER

Nenad Peric (1):
      arm64: dts: allwinner: h5: OrangePi Prime: Fix ethernet node

Nicholas Piggin (2):
      powerpc/64s: flush L1D on kernel entry
      powerpc/64s: flush L1D after user accesses

Nick Desaulniers (1):
      compiler-clang: remove version check for BPF Tracing

Nishanth Menon (1):
      regulator: ti-abb: Fix array out of bound read access on the
first transition

Oleksij Rempel (1):
      ARM: dts: imx6q-prti6q: fix PHY address

Olivier Moysan (1):
      iio: adc: stm32-adc: fix a regression when using dma and irq

Pablo Ceballos (1):
      HID: hid-sensor-hub: Fix issue with devices with no report ID

Paul Cercueil (2):
      iio/adc: ingenic: Fix battery VREF for JZ4770 SoC
      iio/adc: ingenic: Fix AUX/VBAT readings when touchscreen is used

Paul E. McKenney (1):
      rcu: Don't invoke try_invoke_on_locked_down_task() with irqs disabled

Paul Moore (1):
      netlabel: fix an uninitialized warning in netlbl_unlabel_staticlist()

Pavel Begunkov (2):
      io_uring: get an active ref_node from files_data
      io_uring: order refnode recycling

PeiSen Hou (1):
      ALSA: hda/realtek: Add some Clove SSID in the ALC293(ALC1220)

Peter Ujfalusi (1):
      thermal: ti-soc-thermal: Disable the CPU PM notifier for OMAP4430

Peter Zijlstra (2):
      sched: Fix data-race in wakeup
      sched: Fix rq->nr_iowait ordering

Pi-Hsun Shih (1):
      regulator: core: don't disable regulator if is_enabled return error.

Qinglang Miao (1):
      RDMA/pvrdma: Fix missing kfree() in pvrdma_register_device()

Quentin Perret (1):
      sched/fair: Fix overutilized update in enqueue_task_fair()

Raju Rangoju (1):
      MAINTAINERS: update cxgb4 and cxgb3 maintainer

Randy Dunlap (4):
      MIPS: export has_transparent_hugepage() for modules
      KUnit: Docs: fix a wording typo
      KUnit: Docs: style: fix some Kconfig example issues
      KUnit: Docs: usage: wording fixes

Rijo Thomas (2):
      tee: amdtee: fix memory leak due to reset of global shm list
      tee: amdtee: synchronize access to shm list

Rodrigo Siqueira (1):
      drm/amd/display: Always get CRTC updated constant values inside
commit tail

Rodrigo Vivi (1):
      drm/i915/tgl: Fix Media power gate sequence.

Russell Currey (1):
      selftests/powerpc: rfi_flush: disable entry flush if present

Ryan Sharpelletti (1):
      tcp: only postpone PROBE_RTT if RTT is < current min_rtt estimate

Sam Nobs (1):
      tty: serial: imx: fix potential deadlock

Sami Tolvanen (1):
      perf/x86: fix sysfs type mismatches

Samuel Thibault (1):
      speakup: Do not let the line discipline be used several times

Scott Mayhew (1):
      SUNRPC: Fix oops in the rpc_xdr_buf event class

Sean Nyekjaer (1):
      regulator: pfuze100: limit pfuze-support-disable-sw to pfuze{100,200}

Sebastian Andrzej Siewior (1):
      atm: nicstar: Unmap DMA on send error

Serge Semin (1):
      spi: dw: Set transfer handler before unmasking the IRQs

Sergey Matyukevich (1):
      arm: dts: imx6qdl-udoo: fix rgmii phy-mode for ksz9031 phy

Sergio Paracuellos (1):
      staging: mt7621-pci: avoid to request pci bus resources

Shuming Fan (1):
      ASoC: rt1015: increase the time to detect BCLK

Srinivasa Rao Mandadapu (1):
      ASoC: qcom: lpass-platform: Fix memory leak

Steen Hegelund (1):
      net: phy: mscc: remove non-MACSec compatible phy

Stefan Haberland (1):
      s390/dasd: fix null pointer dereference for ERP requests

Stefano Garzarella (1):
      vsock: forward all packets to the host when no H2G is registered

Stephen Rothwell (1):
      swiotlb: using SIZE_MAX needs limits.h included

Subash Abhinov Kasiviswanathan (1):
      net: qualcomm: rmnet: Fix incorrect receive packet handling during cl=
eanup

Sudeep Holla (1):
      cpufreq: scmi: Fix OPP addition failure with a dummy clock provider

Sugar Zhang (1):
      dmaengine: pl330: _prep_dma_memcpy: Fix wrong burst size

Sven Van Asbroeck (3):
      spi: fix client driver breakages when using GPIO descriptors
      lan743x: fix issue causing intermittent kernel log warnings
      lan743x: prevent entire kernel HANG on open, for some platforms

Taehee Yoo (1):
      netdevsim: set .owner to THIS_MODULE

Takashi Iwai (2):
      ALSA: hda/ca0132: Fix compile warning without PCI
      ALSA: mixart: Fix mutex deadlock

Takashi Sakamoto (1):
      ALSA: ctl: fix error path at adding user-defined element set

Tariq Toukan (1):
      net/tls: Fix wrong record sn in async mode of device resync

Theodore Ts'o (1):
      ext4: drop fast_commit from /proc/mounts

Thomas Bogendoerfer (1):
      MIPS: kernel: Fix for_each_memblock conversion

Thomas Gleixner (3):
      iommu/vt-d: Take CONFIG_PCI_ATS into account
      x86/dumpstack: Do not try to access user space code of other tasks
      Revert "iommu/vt-d: Take CONFIG_PCI_ATS into account"

Thomas Richter (1):
      s390/cpum_sf.c: fix file permission for cpum_sfb_size

Thomas Zimmermann (1):
      drm/vram-helper: Fix use of top-down placement

Tina Zhang (1):
      drm/i915/gvt: Set ENHANCED_FRAME_CAP bit

Tobias Waldekranz (1):
      net: dsa: mv88e6xxx: Avoid VTU corruption on 6097

Tony Lindgren (1):
      dmaengine: ti: omap-dma: Block PM if SDMA is busy to fix audio

Tvrtko Ursulin (1):
      drm/i915: Avoid memory leak with more than 16 workarounds on a list

Vadim Fedorenko (1):
      net/tls: fix corrupted data in recvmsg

Vamshi K Sthambamkadi (1):
      efivarfs: fix memory leak in efivarfs_create()

Vasundhara Volam (1):
      bnxt_en: Avoid unnecessary NVM_GET_DEV_INFO cmd error log on VFs.

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Handle max_bpc=3D=3D16

Vincent Stehl=C3=A9 (1):
      net: ethernet: mtk-star-emac: return ok when xmit drops

Vladyslav Tarasiuk (2):
      net/mlx5: Clear bw_share upon VF disable
      net/mlx5: Disable QoS when min_rates on all VFs are zero

Wang Hai (6):
      tools, bpftool: Add missing close before bpftool net attach exit
      net: marvell: prestera: fix error return code in prestera_pci_probe()
      devlink: Add missing genlmsg_cancel() in devlink_nl_sb_port_pool_fill=
()
      selftests/bpf: Fix error return code in run_getsockopt_test()
      net/mlx5: fix error return code in mlx5e_tc_nic_init()
      inet_diag: Fix error path to cancel the meseage in inet_req_diag_fill=
()

Wang Qing (2):
      bpf: Fix passing zero to PTR_ERR() in bpf_btf_printf_prepare
      net: ethernet: ti: am65-cpts: update ret when ptp_clock is ERROR

Will Deacon (1):
      MAINTAINERS: Temporarily add myself to the IOMMU entry

Wong Vee Khee (1):
      net: stmmac: Use rtnl_lock/unlock on netif_set_real_num_rx_queues() c=
all

Wu Bo (1):
      can: m_can: m_can_handle_state_change(): fix state change

Xie He (2):
      net: x25: Increase refcnt of "struct x25_neigh" in x25_rx_call_reques=
t
      MAINTAINERS: Add Martin Schiller as a maintainer for the X.25 stack

Xin Long (1):
      sctp: change to hold/put transport for proto_unreach_timer

Xiongfeng Wang (2):
      drm/i915/gvt: return error when failing to take the module reference
      drm/sun4i: dw-hdmi: fix error return code in sun8i_dw_hdmi_bind()

Yi-Hung Wei (1):
      ip_tunnels: Set tunnel option flag when tunnel metadata is present

Yicong Yang (1):
      libfs: fix error cast of negative value in simple_attr_write()

Yu Kuai (1):
      xfs: return corresponding errcode if xfs_initialize_perag() fail

Zhang Changzhong (12):
      net: ethernet: mtk-star-emac: fix error return code in mtk_star_enabl=
e()
      IB/hfi1: Fix error return code in hfi1_init_dd()
      net: phy: smsc: add missed clk_disable_unprepare in smsc_phy_probe()
      cx82310_eth: fix error return code in cx82310_bind()
      qlcnic: fix error return code in qlcnic_83xx_restart_hw()
      net: stmmac: dwmac-intel-plat: fix error return code in
intel_eth_plat_probe()
      net: ethernet: ti: cpsw: fix error return code in cpsw_probe()
      qed: fix error return code in qed_iwarp_ll2_start()
      net: b44: fix error return code in b44_init_one()
      ah6: fix error return code in ah6_input()
      atl1c: fix error return code in atl1c_probe()
      atl1e: fix error return code in atl1e_probe()

Zhang Qilong (6):
      ipv6: Fix error path to cancel the meseage
      can: ti_hecc: Fix memleak in ti_hecc_probe
      can: flexcan: fix failure handling of pm_runtime_get_sync()
      PM: runtime: Add pm_runtime_resume_and_get to deal with usage counter
      net: fec: Fix reference count leak in fec series ops
      MIPS: Alchemy: Fix memleak in alchemy_clk_setup_cpu

Zhang Xiaoxu (2):
      drm/i915/selftests: Fix wrong return value of perf_series_engines()
      drm/i915/selftests: Fix wrong return value of perf_request_latency()

Zheng Zengkai (1):
      serial: ar933x_uart: disable clk on error handling path in probe

Zhenzhong Duan (1):
      iommu/vt-d: Avoid panic if iommu init fails in tboot system

Zhihao Cheng (1):
      spi: cadence-quadspi: Fix error return code in cqspi_probe

jingle.wu (1):
      Input: elan_i2c - fix firmware update on newer ICs
