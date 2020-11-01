Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA35B2A2248
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 00:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgKAXEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 18:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgKAXEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 18:04:52 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E314C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 15:04:51 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 23so12964463ljv.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 15:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hRuV24phRBOkiFPZbFGr5OsPuvId1CNkVxLViIBH7hU=;
        b=EJRJ7LMqPdRpXZPZjUnGMweHEAAIQr7rXtinCkKixM/30CsK17vas4xwVrZ+oGY9rc
         +/xXNtbC3Antd94H6iQETHpNI2HkfCRswvi7tUb+ZwuKtQxkATGHvdsYankKljSa6D1p
         MdHyU+pPiGBAn+wE6kAik6VcT2nsMUU1DHruc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hRuV24phRBOkiFPZbFGr5OsPuvId1CNkVxLViIBH7hU=;
        b=NhjV442YjCIErRGn8XG0g7GcHatRQB/7iIvSBWcJYy7ZvB/TsVQQO7RQIRyvneT0BZ
         A0NxEmDpSxyswSAkmSwIerztQd9qR4egOkErjWYmyy37NThXYVHTCSQE6Abi3ArMNDI3
         3OxnLHSzZT0kGZBSUOR6N0c9wPSFA6trtbyn91VJ2UvY5isZCvqfONcdA21QDKtnxIan
         hwNrrxhi94zGG2zAsA3/EinyviJBO3bD+4/lp21z7Lrd5wy0Ge07c8ByVDedvT3658aF
         8B3umbXKOKHUTbEUrPXcw4HcrtYXugNowNvPqJLIJcYZiIKx5tRPSQkbT/zq8tiathdW
         Klsg==
X-Gm-Message-State: AOAM531ekGNaXFDL39dVteipZGqqKuu13jS2Zcpdjxb5hE1rXQwPjc8y
        /8hT3noIIBIv838RVqBbfCzWhmlcxGe7cA==
X-Google-Smtp-Source: ABdhPJwDBWsfgT7BOmS9VxOkr3KrKexekU7UEs5mII8DnqVgbcdqe7Pg8fn8uesDna9Zoezc/AybLg==
X-Received: by 2002:a2e:b0fa:: with SMTP id h26mr5267412ljl.243.1604271888920;
        Sun, 01 Nov 2020 15:04:48 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id d6sm2064673lja.63.2020.11.01.15.04.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2020 15:04:47 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id m16so12991626ljo.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 15:04:47 -0800 (PST)
X-Received: by 2002:a2e:8092:: with SMTP id i18mr5151789ljg.314.1604271886733;
 Sun, 01 Nov 2020 15:04:46 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Nov 2020 15:04:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGc62spBHh+i1yH9sVLpCqZBznUF8QdO7H5772qO1xqQ@mail.gmail.com>
Message-ID: <CAHk-=wiGc62spBHh+i1yH9sVLpCqZBznUF8QdO7H5772qO1xqQ@mail.gmail.com>
Subject: Linux 5.10-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As usual, the start of the week after the merge window closed was
pretty quiet, but things picked up in the last few days. Almost
everything here got merged Friday or during the weekend.

Which is all normal, but a few things stand out.

One is that rc2 continues the pattern of this being a fairly large
release - not outrageously so, but this is a slightly bigger rc2 than
we usually have.

The other is that the diffstat looks quite odd, since I merged the
pull from Greg that removed the MIC drivers for hardware that never
shipped. That is about half the patch, although it's not why I call
rc2 big - it's just a single commit. There's also a few big ABI
documentation formatting patches that look a bit odd, but make the
docs more easily parsable by tools. Again, just a couple of patches,
but a big part of the diff.

Anyway, if you ignore those things, the rest looks fairly normal, with
small fixes all over the place. The shortlog below gives a flavor of
the details, I don't think anything else particularly stands out.

Despite the size, I don't get the feeling that there's anything really
odd going on, and so far the release seems to be going smoothly. But
please test, that's how we find problems,

               Linus

---

Aleksandr Nogikh (1):
      netem: fix zero division in tabledist

Alex Deucher (3):
      drm/amdgpu/display: use kvzalloc again in dc_create_state
      drm/amdgpu/swsmu: drop smu i2c bus on navi1x
      drm/amdgpu/pm: fix the fan speed in fan1_input in manual mode for nav=
i1x

Alex Elder (1):
      net: ipa: command payloads already mapped

Alexander Sverdlin (2):
      staging: octeon: repair "fixed-link" support
      staging: octeon: Drop on uncorrectable alignment or FCS error

Alok Prasad (1):
      RDMA/qedr: Fix memory leak in iWARP CM

Amelie Delaunay (2):
      usb: typec: add missing MODULE_DEVICE_TABLE() to stusb160x
      usb: typec: stusb160x: fix signedness comparison issue with enum vari=
ables

Amit Cohen (2):
      mlxsw: Only advertise link modes supported by both driver and device
      mlxsw: core: Fix use-after-free in mlxsw_emad_trans_finish()

Anand Moon (1):
      arm64: dts: amlogic: add missing ethernet reset ID

Andrea Righi (1):
      ext4: properly check for dirty state in ext4_inode_datasync_dirty()

Andrew Gabbasov (1):
      ravb: Fix bit fields checking in ravb_hwtstamp_get()

Andrew Jones (1):
      KVM: selftests: Don't require THP to run tests

Andy Lutomirski (1):
      x86/syscalls: Document the fact that syscalls 512-547 are a legacy mi=
stake

Andy Shevchenko (3):
      device property: Keep secondary firmware node secondary by type
      device property: Don't clear secondary pointer for shared
primary firmware node
      xsysace: use platform_get_resource() and platform_get_irq_optional()

Anson Huang (3):
      arm64: defconfig: Build in CONFIG_GPIO_MXC by default
      ARM: imx_v6_v7_defconfig: Build in CONFIG_GPIO_MXC by default
      ARM: multi_v7_defconfig: Build in CONFIG_GPIO_MXC by default

Ard Biesheuvel (4):
      ARM: mvebu: drop pointless check for coherency_base
      arm64: vmlinux.lds: account for spurious empty .igot.plt sections
      arm64: efi: increase EFI PE/COFF header padding to 64 KB
      module: use hidden visibility for weak symbol references

Arjun Roy (1):
      tcp: Prevent low rmem stalls with SO_RCVLOWAT.

Arnd Bergmann (3):
      ACPI: dock: fix enum-conversion warning
      arm64: avoid -Woverride-init warning
      coresight: add module license

Bastien Nocera (2):
      usbcore: Check both id_table and match() when both available
      USB: apple-mfi-fastcharge: don't probe unhandled devices

Bob Pearson (1):
      RDMA/rxe: Fix small problem in network_type patch

Catalin Marinas (1):
      arm64: mte: Document that user PSTATE.TCO is ignored by kernel uacces=
s

Chaitanya Kulkarni (1):
      nvmet: fix a NULL pointer dereference when tracing the flush command

Chen Yu (1):
      intel_idle: Fix max_cstate for processor models without C-state table=
s

Christian K=C3=B6nig (1):
      drm/amdgpu: increase the reserved VM size to 2MB

Christoph Hellwig (1):
      asm-generic: mark __{get,put}_user_fn as __always_inline

Cl=C3=A9ment P=C3=A9ron (1):
      ARM: dts: sun4i-a10: fix cpu_alert temperature

Colin Ian King (1):
      xhci: Fix sizeof() mismatch

Cristian Marussi (1):
      firmware: arm_scmi: Fix locking in notifications

Damien Le Moal (2):
      null_blk: Fix zone reset all tracing
      null_blk: Fix locking in zoned mode

Dan Carpenter (8):
      drm/v3d: Fix double free in v3d_submit_cl_ioctl()
      net: hns3: clean up a return in hclge_tm_bp_setup()
      afs: Fix a use after free in afs_xattr_get_acl()
      devlink: Fix some error codes
      devlink: Unlock on error in dumpit()
      usb: typec: stusb160x: fix some signedness bugs
      usb: typec: stusb160x: fix an IS_ERR() vs NULL check in probe
      vhost_vdpa: Return -EFAULT if copy_from_user() fails

Dan Murphy (1):
      dt-bindings: leds: Update devicetree documents for ID_RGB

Daniel Rosenberg (1):
      ext4: use generic casefolding support

Daniel Vetter (1):
      drm/shme-helpers: Fix dma_buf_mmap forwarding bug

Daniel Wagner (1):
      scsi: qla2xxx: Return EBUSY on fcport deletion

Daniel Xu (1):
      btrfs: tree-checker: validate number of chunk stripes and parity

David Disseldorp (1):
      lib/scatterlist: use consistent sg_copy_buffer() return type

David Galiffi (1):
      drm/amd/display: Fixed panic during seamless boot.

David Howells (10):
      afs: Fix copy_file_range()
      afs: Fix tracing deref-before-check
      afs: Fix afs_launder_page to not clear PG_writeback
      afs: Fix to take ref on page when PG_private is set
      afs: Fix page leak on afs_write_begin() failure
      afs: Fix where page->private is set during write
      afs: Wrap page->private manipulations in inline functions
      afs: Alter dirty range encoding in page->private
      afs: Fix afs_invalidatepage to adjust the dirty region
      afs: Fix dirty-region encoding on ppc32 with 64K pages

David Woodhouse (1):
      x86/kvm: Reserve KVM_FEATURE_MSI_EXT_DEST_ID

Davidlohr Bueso (1):
      btrfs: convert data_seqcount to seqcount_mutex_t

Dmitry Baryshkov (1):
      interconnect: qcom: use icc_sync state for sm8[12]50

Dmytro Laktyushkin (1):
      drm/amd/display: prevent null pointer access

Eric Biggers (1):
      crypto: x86/poly1305 - add back a needed assignment

Etienne Carriere (2):
      firmware: arm_scmi: Fix ARCH_COLD_RESET
      firmware: arm_scmi: Expand SMC/HVC message pool to more than one

Fabien Parent (1):
      dt-bindings: mailbox: mtk-gce: fix incorrect mbox-cells value

Fabio Estevam (2):
      ARM: imx_v4_v5_defconfig: Select CONFIG_GPIO_MXC
      ARM: multi_v5_defconfig: Select CONFIG_GPIO_MXC

Fangrui Song (1):
      arm64: Change .weak to SYM_FUNC_START_WEAK_PI for arch/arm64/lib/mem*=
.S

Filipe Manana (3):
      btrfs: fix relocation failure due to race with fallocate
      btrfs: fix use-after-free on readahead extent after failure to create=
 it
      btrfs: fix readahead hang and use-after-free after removing a device

Florian Fainelli (1):
      firmware: arm_scmi: Fix duplicate workqueue name

Gabriel Krisman Bertazi (2):
      blk-cgroup: Fix memleak on error path
      blk-cgroup: Pre-allocate tree node on blkg_conf_prep

Gal Pressman (1):
      RDMA/uverbs: Fix false error in query gid IOCTL

Gavin Shan (1):
      KVM: arm64: Use fallback mapping sizes for contiguous huge page sizes

Geert Uytterhoeven (2):
      mm/process_vm_access: Add missing #include <linux/compat.h>
      dma-mapping: fix 32-bit overflow with CONFIG_ARM_LPAE=3Dn

Georgi Djakov (5):
      interconnect: qcom: sdm845: Enable keepalive for the MM1 BCM
      interconnect: Aggregate before setting initial bandwidth
      interconnect: qcom: sdm845: Init BCMs before creating the nodes
      interconnect: qcom: sc7180: Init BCMs before creating the nodes
      interconnect: qcom: Ensure that the floor bandwidth value is enforced

Greg Kroah-Hartman (1):
      debugfs: remove return value of debugfs_create_devm_seqfile()

Guido G=C3=BCnther (3):
      drm/panel: mantix: Don't dereference NULL mode
      drm/panel: mantix: Fix panel reset
      dt-binding: display: Require two resets on mantix panel

Guillaume Nault (1):
      net/sched: act_mpls: Add softdep on mpls_gso.ko

Gustavo A. R. Silva (18):
      include: jhash/signal: Fix fall-through warnings for Clang
      dmaengine: ti-cppi5: Replace zero-length array with flexible-array me=
mber
      mailbox: zynqmp-ipi-message: Replace zero-length array with
flexible-array member
      platform/chrome: cros_ec_commands: Replace zero-length array
with flexible-array member
      platform/chrome: cros_ec_proto: Replace zero-length array with
flexible-array member
      tracepoint: Replace zero-length array with flexible-array member
      params: Replace zero-length array with flexible-array member
      Bluetooth: Replace zero-length array with flexible-array member
      fs: Replace zero-length array with flexible-array member
      enetc: Replace zero-length array with flexible-array member
      ima: Replace zero-length array with flexible-array member
      scsi: target: tcmu: Replace zero-length array with flexible-array mem=
ber
      Bluetooth: btintel: Replace zero-length array with flexible-array mem=
ber
      gve: Replace zero-length array with flexible-array member
      mei: hw: Replace zero-length array with flexible-array member
      net/mlx5: Replace zero-length array with flexible-array member
      net/smc: Replace zero-length array with flexible-array member
      printk: ringbuffer: Replace zero-length array with flexible-array mem=
ber

Hans de Goede (1):
      ACPI: button: Drop no longer necessary Acer SW5-012 lid_init_state qu=
irk

Harshad Shirwadkar (4):
      ext4: fix double locking in ext4_fc_commit_dentry_updates()
      ext4: make num of fast commit blocks configurable
      ext4: use s_mount_flags instead of s_mount_state for fast commit stat=
e
      ext4: use IS_ERR() for error checking of path

Heiner Kallweit (1):
      r8169: fix issue with forced threading in combination with
shared interrupts

Helge Deller (1):
      scsi: mptfusion: Fix null pointer dereferences in mptscsih_remove()

Hoegeun Kwon (1):
      drm/vc4: drv: Add error handding for bind

Ian Abbott (1):
      staging: comedi: cb_pcidas: Allow 2-channel commands for AO subdevice

Icenowy Zheng (1):
      dt-bindings: sram: sunxi-sram: add V3s compatible string

Ido Schimmel (1):
      mlxsw: core: Fix memory leak on module removal

Jackie Zamow (1):
      PM: sleep: fix typo in kernel/power/process.c

James Smart (4):
      nvme-fc: track error_recovery while connecting
      nvme-fc: remove err_work work item
      nvme-fc: eliminate terminate_io use by nvme_fc_error_recovery
      nvme-fc: remove nvme_fc_terminate_io()

Jan Kara (1):
      ext4: fix mmap write protection for data=3Djournal mode

Jason Gunthorpe (1):
      RDMA: Add rdma_connect_locked()

Jason Wang (3):
      vdpa: introduce config op to get valid iova range
      vhost: vdpa: report iova range
      vdpa_sim: implement get_iova_range()

Jeff Vander Stoep (1):
      vsock: use ns_capable_noaudit() on socket create

Jens Axboe (2):
      io_uring: use type appropriate io_kiocb handler for double poll
      Fix compat regression in process_vm_rw()

Jerome Brunet (2):
      arm64: dts: meson: odroid-n2 plus: fix vddcpu_a pwm
      usb: cdc-acm: fix cooldown mechanism

Jim Mattson (1):
      KVM: selftests: test behavior of unmapped L2 APIC-access address

Jing Xiangfeng (2):
      staging: fieldbus: anybuss: jump to correct label in an error path
      vdpa/mlx5: Fix error return in map_direct_mr()

Jiri Slaby (4):
      x86/unwind/orc: Fix inactive tasks with stack pointer in %sp on
GCC 10 compiled kernels
      vt: keyboard, simplify vt_kdgkbsent
      vt: keyboard, extend func_buf_lock to readers
      vt_ioctl: fix GIO_UNIMAP regression

Jisheng Zhang (2):
      mmc: sdhci: Use Auto CMD Auto Select only when v4_mode is true
      arm64: berlin: Select DW_APB_TIMER_OF

Johannes Thumshirn (1):
      btrfs: don't fallback to buffered read if we don't need to

John Garry (1):
      scsi: hisi_sas: Stop using queue #0 always for v2 hw

Josef Bacik (3):
      btrfs: drop the path before adding block group sysfs files
      btrfs: drop the path before adding qgroup items when enabling qgroups
      btrfs: add a helper to read the tree_root commit root for backref loo=
kup

Juergen Gross (1):
      x86/alternative: Don't call text_poke() in lazy TLB mode

J=C3=A9r=C3=B4me Pouiller (2):
      staging: wfx: fix use of uninitialized pointer
      staging: wfx: fix test on return value of gpiod_get_value()

Kairui Song (2):
      x86/kexec: Use up-to-dated screen_info copy to fill boot params
      hyperv_fb: Update screen_info after removing old framebuffer

Kanchan Joshi (1):
      null_blk: synchronization fix for zoned device

Karol Herbst (2):
      drm/nouveau/gem: fix "refcount_t: underflow; use-after-free"
      drm/nouveau/device: fix changing endianess code to work on older GPUs

Karsten Graul (3):
      net/smc: fix null pointer dereference in smc_listen_decline()
      net/smc: fix suppressed return code
      s390/ism: fix incorrect system EID

Kees Cook (1):
      vmlinux.lds.h: Keep .ctors.* with .ctors

Keith Busch (1):
      nvme: ignore zone validate errors on subsequent scans

Kenneth Feng (1):
      drm/amd/pm: fix the wrong fan speed in fan1_input

Krzysztof Kozlowski (2):
      MAINTAINERS: Move Kukjin Kim to credits
      MAINTAINERS: Move Sangbeom Kim to credits

Laurent Vivier (3):
      vdpa_sim: Fix DMA mask
      vdpasim: fix MAC address configuration
      vdpasim: allow to assign a MAC address

Leon Romanovsky (1):
      net: protect tcf_block_unbind with block lock

Li Jun (1):
      usb: typec: tcpm: reset hard_reset_count for any disconnect

Lijun Pan (1):
      ibmvnic: fix ibmvnic_set_mac

Linus Torvalds (3):
      arch/um: partially revert the conversion to __section() macro
      scsi: qla2xxx: remove incorrect sparse #ifdef
      Linux 5.10-rc2

Lubomir Rintel (2):
      ARM: dts: mmp3: Add power domain for the camera
      ARM: dts: mmp2-olpc-xo-1-75: Use plural form of "-gpios"

Lyude Paul (3):
      drm/nouveau/kms/nv50-: Program notifier offset before requesting disp=
 caps
      drm/nouveau/kms/nv50-: Get rid of bogus nouveau_conn_mode_valid()
      drm/nouveau/kms/nv50-: Fix clock checking algorithm in
nv50_dp_mode_valid()

Madhav Chauhan (1):
      drm/amdgpu: don't map BO in reserved region

Marc Zyngier (4):
      KVM: arm64: Don't corrupt tpidr_el2 on failed HVC call
      KVM: arm64: Remove leftover kern_hyp_va() in nVHE TLB invalidation
      KVM: arm64: Drop useless PAN setting on host EL1 to EL2 transition
      KVM: arm64: Fix AArch32 handling of DBGD{CCINT,SCRext} and DBGVCR

Mark Rutland (3):
      KVM: arm64: Factor out is_{vhe,nvhe}_hyp_code()
      arm64: cpufeature: reorder cpus_have_{const, final}_cap()
      arm64: cpufeature: upgrade hyp caps to final

Martin Blumenstingl (2):
      arm64: dts: amlogic: meson-g12: use the G12A specific dwmac compatibl=
e
      ARM: dts: meson8: remove two invalid interrupt lines from the GPU nod=
e

Martin Leung (1):
      drm/amd/display: adding ddc_gpio_vga_reg_list to ddc reg def'ns

Masahiro Fujiwara (1):
      gtp: fix an use-before-init in gtp_newlink()

Masahiro Yamada (1):
      MAINTAINERS: step down as maintainer of UniPhier SoCs and Denali driv=
er

Mateusz Nosek (1):
      futex: Fix incorrect should_fail_futex() handling

Mathias Nyman (1):
      xhci: Don't create stream debugfs files with spinlock held.

Matthew Auld (1):
      drm/i915/region: fix max size calculation

Matthew Wilcox (Oracle) (1):
      cachefiles: Handle readpage error correctly

Mauro Carvalho Chehab (49):
      drm: kernel-doc: document drm_dp_set_subconnector_property() params
      drm/dp: fix kernel-doc warnings at drm_dp_helper.c
      drm/dp: fix a kernel-doc issue at drm_edid.c
      drm: drm_edid: remove a duplicated kernel-doc declaration
      drm: kernel-doc: add description for a new function parameter
      drm: kernel-doc: drm_dp_helper.h: fix a typo
      drm: drm_print.h: fix kernel-doc markups
      PNP: fix kernel-doc markups
      usb: fix kernel-doc markups
      jbd2: fix a kernel-doc markup
      scripts: get_abi.pl: change script to allow parsing in ReST mode
      scripts: get_abi.pl: fix parsing on ReST mode
      scripts: get_abi.pl: Allow optionally record from where a line came f=
rom
      scripts: get_abi.pl: improve its parser to better catch up indentatio=
n
      scripts: get_abi.pl: cleanup ABI cross-reference logic
      scripts: get_abi.pl: detect duplicated ABI definitions
      scripts: get_abi.pl: output users in ReST format
      scripts: get_abi.pl: prevent duplicated file names
      scripts: get_abi.pl: use bold font for ABI definitions
      scripts: get_abi.pl: auto-generate cross references
      docs: kernellog.py: add support for info()
      docs: kernel_abi.py: add a script to parse ABI documentation
      docs: kernel_abi.py: fix UTF-8 support
      docs: kernel_abi.py: make it compatible with Sphinx 1.7+
      docs: kernel_abi.py: use --enable-lineno for get_abi.pl
      docs: kernel_abi.py: Handle with a lazy Sphinx parser
      docs: add ABI documentation to the admin-guide book
      docs: ABI: README: specify that files should be ReST compatible
      docs: ABI: stable: make files ReST compatible
      docs: ABI: testing: make the files compatible with ReST output
      docs: ABI: sysfs-uevent: make it compatible with ReST output
      docs: ABI: make it parse ABI/stable as ReST-compatible files
      docs: ABI: create a 2-depth index for ABI
      docs: ABI: don't escape ReST-incompatible chars from obsolete and rem=
oved
      docs: abi-testing.rst: enable --rst-sources when building docs
      docs: Kconfig/Makefile: add a check for broken ABI files
      docs: ABI: convert testing/configfs-acpi to ReST
      docs: ABI: fix syntax to be parsed using ReST notation
      docs: ABI: vdso: use the right format for ABI
      docs: ABI: sysfs-bus-nvdimm: use the right format for ABI
      docs: ABI: cleanup several ABI documents
      docs: ABI: change read/write attributes
      docs: ABI: stable: remove a duplicated documentation
      docs: ABI: unify /sys/class/leds/<led>/brightness documentation
      docs: ABI: sysfs-class-power: unify duplicated properties
      docs: ABI: sysfs-c2port: remove a duplicated entry
      docs: ABI: sysfs-class-backlight: unify ABI documentation
      docs: ABI: sysfs-class-led-trigger-pattern: remove hw_pattern duplica=
tion
      scripts: get_abi.pl: assume ReST format by default

Maxime Ripard (6):
      drm/sun4i: frontend: Rework a bit the phase data
      drm/sun4i: frontend: Reuse the ch0 phase for RGB formats
      drm/sun4i: frontend: Fix the scaler phase on A33
      drm/vc4: hdmi: Avoid sleeping in atomic context
      drm/vc4: hdmi: Add a name to the codec DAI component
      drm/vc4: Rework the structure conversion functions

Michael Chan (1):
      bnxt_en: Check abort error state in bnxt_open_nic().

Michael Ellerman (1):
      net: ucc_geth: Drop extraneous parentheses in comparison

Michael S. Tsirkin (1):
      Revert "vhost-vdpa: fix page pinning leakage in error path"

Michael Walle (1):
      mmc: sdhci-of-esdhc: set timeout to max before tuning

Mike Leach (1):
      coresight: Fix uninitialised pointer bug in etm_setup_aux()

Ming Lei (3):
      scsi: core: Don't start concurrent async scan on same host
      nbd: don't update block size after device is started
      blk-mq: mark flush request as IDLE in flush_end_io()

Naohiro Aota (1):
      block: advance iov_iter on bio_add_hw_page failure

Nathan Chancellor (2):
      arm64: vdso32: Allow ld.lld to properly link the VDSO
      arm/build: Always handle .ARM.exidx and .ARM.extab sections

Neil Armstrong (2):
      arm64: dts: meson-axg: add USB nodes
      arm64: dts: meson-axg-s400: enable USB OTG

Pali Roh=C3=A1r (1):
      arm64: dts: marvell: espressobin: Add ethernet switch aliases

Paolo Abeni (1):
      mptcp: add missing memory scheduling in the rx path

Paolo Bonzini (2):
      KVM: x86: replace static const variables with macros
      KVM: vmx: remove unused variable

Parav Pandit (1):
      RDMA/mlx5: Fix devlink deadlock on net namespace deletion

Pascal Paillet (2):
      ARM: dts: stm32: Describe Vin power supply on stm32mp15xx-dkx board
      ARM: dts: stm32: Describe Vin power supply on stm32mp157c-edx board

Pavel Begunkov (7):
      io_uring: remove opcode check on ltimeout kill
      io_uring: don't adjust LINK_HEAD in cancel ltimeout
      io_uring: always clear LINK_TIMEOUT after cancel
      io_uring: don't defer put of cancelled ltimeout
      io_uring: don't miss setting IO_WQ_WORK_CONCURRENT
      io_uring: simplify nxt propagation in io_queue_sqe
      io_uring: simplify __io_queue_sqe()

Pawel Laszczak (2):
      usb: cdns3: Variable 'length' set but not used
      usb: cdns3: Fix on-chip memory overflow issue

Peter Chen (2):
      usb: cdns3: gadget: suspicious implicit sign extension
      usb: cdns3: gadget: own the lock wrongly at the suspend routine

Peter Zijlstra (6):
      lockdep: Fix preemption WARN for spurious IRQ-enable
      x86/debug: Fix BTF handling
      x86/debug: Only clear/set ->virtual_dr6 for userspace #DB
      x86/debug: Fix DR_STEP vs ptrace_get_debugreg(6)
      locking/lockdep: Remove more raw_cpu_read() usage
      lockdep: Fix nr_unused_locks accounting

Pujin Shi (1):
      btrfs: tree-checker: fix incorrect printk format

Qais Yousef (1):
      KVM: arm64: Handle Asymmetric AArch32 systems

Qian Cai (1):
      arm64/smp: Move rcu_cpu_starting() earlier

Quanyang Wang (1):
      time/sched_clock: Mark sched_clock_read_begin/retry() as notrace

Rafael J. Wysocki (5):
      cpufreq: Avoid configuring old governors as default with intel_pstate
      cpufreq: Introduce CPUFREQ_NEED_UPDATE_LIMITS driver flag
      cpufreq: intel_pstate: Avoid missing HWP max updates in passive mode
      cpufreq: Introduce cpufreq_driver_test_flags()
      cpufreq: schedutil: Always call driver if
CPUFREQ_NEED_UPDATE_LIMITS is set

Raju Rangoju (1):
      cxgb4: set up filter action after rewrites

Ralph Campbell (1):
      drm/nouveau/nouveau: fix the start/end range for migration

Ran Wang (1):
      usb: host: fsl-mph-dr-of: check return of dma_set_mask()

Ricardo Ca=C3=B1uelo (3):
      dt-bindings: i2c: convert i2c-cros-ec-tunnel to json-schema
      dt-bindings: input: convert cros-ec-keyb to json-schema
      mfd: google,cros-ec: add missing properties

Rob Herring (5):
      dt-bindings: More whitespace clean-ups in schema files
      dt-bindings: Explicitly allow additional properties in board/SoC sche=
mas
      dt-bindings: Another round of adding missing
'additionalProperties/unevalutatedProperties'
      arm64: Add part number for Arm Cortex-A77
      arm64: Add workaround for Arm Cortex-A77 erratum 1508412

Russell King (1):
      tty: serial: 21285: fix lockup on open

Sandeep Singh (1):
      usb: xhci: Workaround for S3 issue on AMD SNPS 3.0 xHC

Santosh Shukla (1):
      KVM: arm64: Force PTE mapping on fault resulting in a device mapping

Sascha Hauer (1):
      ata: sata_nv: Fix retrieving of active qcs

Scott K Logan (1):
      arm64: dts: meson: add missing g12 rng clock

Seung-Woo Kim (1):
      staging: mmal-vchiq: Fix memory leak for vchiq_instance

Shannon Nelson (3):
      ionic: clean up sparse complaints
      ionic: no rx flush in deinit
      ionic: fix mem leak in rx_empty

Stephen Boyd (1):
      KVM: arm64: ARM_SMCCC_ARCH_WORKAROUND_1 doesn't return
SMCCC_RET_NOT_REQUIRED

Steven Rostedt (VMware) (1):
      tracing, synthetic events: Replace buggy strcat() with seq_buf operat=
ions

Sudeep Dutt (1):
      misc: mic: remove the MIC drivers

Sudeep Holla (1):
      firmware: arm_scmi: Add missing Rx size re-initialisation

Sumit Garg (1):
      tee: client UUID: Skip REE kernel login method as well

Suzuki K Poulose (1):
      coresight: cti: Initialize dynamic sysfs attributes

Takashi Iwai (4):
      drm/amd/display: Fix kernel panic by dal_gpio_open() error
      drm/amd/display: Don't invoke kgdb_breakpoint() unconditionally
      drm/amd/display: Clean up debug macros
      KVM: x86: Fix NULL dereference at kvm_msr_ignored_check()

Tang Bin (1):
      usb: host: ehci-tegra: Fix error handling in tegra_ehci_probe()

Tero Kristo (1):
      soc: ti: ti_sci_pm_domains: check for proper args count in xlate

Theodore Ts'o (1):
      ext4: indicate that fast_commit is available via /sys/fs/ext4/feature=
/...

Thomas Bogendoerfer (1):
      ibmveth: Fix use of ibmveth in a bridge.

Tianci.Yin (2):
      drm/amdgpu: disable DCN and VCN for navi10 blockchain SKU(v3)
      drm/amdgpu: add DID for navi10 blockchain SKU

Tom Rix (1):
      cpufreq: speedstep: remove unneeded semicolon

Tung Nguyen (1):
      tipc: fix memory leak caused by tipc_buf_append()

Tyrel Datwyler (1):
      scsi: ibmvscsi: Fix potential race after loss of transport

Vasily Gorbik (1):
      s390: correct __bootdata / __bootdata_preserved macros

Vasundhara Volam (4):
      bnxt_en: Fix regression in workqueue cleanup logic in bnxt_remove_one=
().
      bnxt_en: Invoke cancel_delayed_work_sync() for PFs also.
      bnxt_en: Re-write PCI BARs after PCI fatal error.
      bnxt_en: Send HWRM_FUNC_RESET fw command unconditionally.

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Restore ILK-M RPS support
      drm/i915: Reject 90/270 degree rotated initial fbs

Vinay Kumar Yadav (3):
      chelsio/chtls: fix tls record info to user
      chelsio/chtls: fix deadlock issue
      chelsio/chtls: fix memory leaks in CPL handlers

Vincent Whitchurch (1):
      of: Fix reserved-memory overlap detection

Vincenzo Frascino (6):
      kselftest/arm64: Fix check_buffer_fill test
      kselftest/arm64: Fix check_tags_inclusion test
      kselftest/arm64: Fix check_child_memory test
      kselftest/arm64: Fix check_mmap_options test
      kselftest/arm64: Fix check_ksm_options test
      kselftest/arm64: Fix check_user_mem test

Vitaly Kuznetsov (1):
      KVM: VMX: eVMCS: make evmcs_sanitize_exec_ctrls() work again

Vladimir Oltean (1):
      tty: serial: fsl_lpuart: LS1021A has a FIFO size of 16 words, like LS=
1028A

Will Deacon (2):
      KVM: arm64: Allocate stage-2 pgd pages with GFP_KERNEL_ACCOUNT
      KVM: arm64: Fix masks in stage2_pte_cacheable()

Yangbo Lu (1):
      mmc: sdhci-of-esdhc: make sure delay chain locked for HS400

YueHaibing (2):
      hrtimer: Remove unused inline function debug_hrtimer_free()
      timers: Remove unused inline funtion debug_timer_free()

Zeng Tao (1):
      time: Prevent undefined behaviour in timespec64_to_ns()

Zenghui Yu (1):
      net: hns3: Clear the CMDQ registers before unmapping BAR region

Zhang Qilong (2):
      cpufreq: e_powersaver: remove unreachable break
      ACPI: NFIT: Fix comparison to '-ENXIO'

Zhu Lingshan (1):
      vdpa: handle irq bypass register failure case

Zong Li (1):
      stop_machine, rcu: Mark functions as notrace

yangerkun (1):
      ext4: do not use extent after put_bh

zhenwei pi (1):
      nvme-rdma: handle unexpected nvme completion data length
