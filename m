Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B08F268249
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 03:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgINBeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 21:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgINBer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 21:34:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4382CC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 18:34:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so11194687pfn.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 18:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=pfr4no5fI2xZcGf8Do2t8M0yMHyLGYzF/R0Jt7hSkhc=;
        b=AKLWzcItOLhkBJH032hL2xmKdVkz8p+NcUYVNz9B3PNSIVtWcjLBTVco2XuIxjKh64
         lijszIG0WQAyrLuFQ26+bxK8JZOayt/Wv8B/lsbaOQmu3TgL6rpoEceJkSV658ipwGUD
         5zNsio5yoe/X1aA+QFusC69TE8Y0bgvQgFDqZrIk5iEhPxmvItyd2PzDh9k7Cd0WQ3LN
         avGHXVU7eLSk45X+GmqdUPYZtNTWvFmr3VdUUKi7RsSgzwsAHAQzN/21fcDUewYgaeCE
         OmwnCPsHM8l5xpC2UQYEuhmvrTGs7ozIT1BjjpL3npImikbav4VQyqwNBL/nx5rd4aZO
         g5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=pfr4no5fI2xZcGf8Do2t8M0yMHyLGYzF/R0Jt7hSkhc=;
        b=Tie5wbKQCppLrvcYihflhGEXel4HYkr3aAoa+BM9bMOyeTpTKgx1btHwYnvREsCJ2M
         0OXi2pgBVfTcnY4Yy1AfKqP4jS3zlQGzJqTIbbMQyXlmnM0Coa3ukbHs7gW7rGv3QzIG
         XhO6lbiXUaTPVhqv4Ruq/Ug1X4iUFYrW5gtu0Kaa2QoqIYwVf26IHhBFDmZBI/zBVDgB
         iQQTmL2DWW85J9ZXQBqrfFoCyQSvhTTdNBHtqKql9vIZcQYD3l0JPY3r0QU/oWRV948Y
         0+ESLr9FvgQMBoFPAJwCYO6am8hU5/CUjlxrvzXNcu0BuUbvZEsVh9yAQuPL5QYC8kgY
         p19A==
X-Gm-Message-State: AOAM532rZ8iPiW+8kIGNc5Yxk/UIf3Qo0zxyDXzjhZtz9TToDIGYznic
        L6svIaiD6JPQQODAND+R8IERrP/F27U=
X-Google-Smtp-Source: ABdhPJy0EvHOA/jLShzRkPuun0apxa+S7ILCLR1yXnbFNZKHyFBjqNepICBhzl1rz5Qdv+LW3C8Bow==
X-Received: by 2002:aa7:8aca:0:b029:13e:d13d:a13e with SMTP id b10-20020aa78aca0000b029013ed13da13emr11552705pfd.38.1600047285407;
        Sun, 13 Sep 2020 18:34:45 -0700 (PDT)
Received: from ArchLinux (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id s4sm8673789pfu.107.2020.09.13.18.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 18:34:44 -0700 (PDT)
Date:   Mon, 14 Sep 2020 07:04:34 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ... and it built and boots without fuss!! Linux 5.9-rc5
Message-ID: <20200914013434.GA658855@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjLVdzdX09kS324Q=GoRn0uPCnr-sovqVCdJcUxVdkJCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjLVdzdX09kS324Q=GoRn0uPCnr-sovqVCdJcUxVdkJCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16:31 Sun 13 Sep 2020, Linus Torvalds wrote:
>Things look fairly normal (except when I look out the window, and the
>world is all gray from the wildfires) and nothing huge here stands
>out. The most noticeable change in the diffstat is likely the revert
>of some i915 relocation changs that caused problems, along with some
>regulator core locking fixes. And they look big only in comparison to
>the rest of it.
>
>Other than that this is just a fair amount - about par for the course
>for the rc5 timeframe -  of small stuff. About three quarters of it to
>drivers or dts files.
>
>Outside of that, there's some arch updates (much of it kvm-related),
>along with some documentation fixes and minor filesystem fixes. It all
>looks pretty harmless and small. The appended shortlog gives a
>(boring) overview of the details.
>
>So aside from the smoke from the fires, and a performance regression
>I'm still looking at, things look normal.
>
>[ I feel like I should insert the "This is fine" dog cartoon meme here
>as the world burns around me ]
>
>Stay inside (if you're on the US West coast, at least), stay safe, but
>please test,
>
>                   Linus
>

Well, something trivial for your eyes!!

[    2.851853] tsc: Refined TSC clocksource calibration: 2194.888 MHz
[    2.852776] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fa=
355a8f1c, max_idle_ns: 440795271007 ns
[    2.853783] clocksource: Switched to clocksource tsc
[    3.247152] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/=
i8042/serio1/input/input3
[    3.251100] md: Waiting for all devices to be available before autodetect
[    3.251507] md: If you don't use raid, use raid=3Dnoautodetect
[    3.252480] md: Autodetecting RAID arrays.
[    3.252798] md: autorun ...
[    3.252988] md: ... autorun DONE.
[    3.463803] EXT4-fs (sda): recovery complete
[    3.484251] EXT4-fs (sda): mounted filesystem with ordered data mode. Op=
ts: (null)
[    3.485597] ext4 filesystem being mounted at /root supports timestamps u=
ntil 2038 (0x7fffffff)
[    3.486295] VFS: Mounted root (ext4 filesystem) on device 8:0.
[    3.491421] devtmpfs: mounted
[    3.554477] Freeing unused kernel image (initmem) memory: 1176K
[    3.555308] Write protecting the kernel read-only data: 20480k
[    3.559032] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    3.560507] Freeing unused kernel image (rodata/data gap) memory: 744K
[    3.561272] Run /sbin/init as init process
[    3.742209] EXT4-fs (sda): re-mounted. Opts: (null)
[    3.743052] ext4 filesystem being remounted at / supports timestamps unt=
il 2038 (0x7fffffff)
[    3.898416] hostname (75) used greatest stack depth: 14336 bytes left
Starting syslogd: OK
Starting klogd: OK
Running sysctl: [    4.388271] find (87) used greatest stack depth: 14216 b=
ytes left
[    4.390651] S02sysctl (86) used greatest stack depth: 13816 bytes left
OK
Initializing random number generator: OK
Saving random seed: [    4.731786] random: crng init done
[    4.778229] dd (101) used greatest stack depth: 13496 bytes left
OK
Starting network: OK

Welcome to Buildroot_Linux
Bhaskar_Thinkpad_x250 login: root
# uname -a
Linux Bhaskar_Thinkpad_x250 5.9.0-rc5-ArchLinux #1 SMP Mon Sep 14 06:31:41 =
IST 2020 x86_64 GNU/Linux


~Bhaskar


>---
>
>Adam Ford (4):
>      ARM: dts: logicpd-torpedo-baseboard: Fix broken audio
>      ARM: dts: logicpd-som-lv-baseboard: Fix broken audio
>      ARM: dts: logicpd-som-lv-baseboard: Fix missing video
>      ARM: dts: imx6q-logicpd: Fix broken PWM
>
>Adrian Hunter (1):
>      mmc: sdio: Use mmc_pre_req() / mmc_post_req()
>
>Aleksander Morgado (1):
>      USB: serial: option: add support for SIM7070/SIM7080/SIM7090 modules
>
>Alexandru Elisei (1):
>      KVM: arm64: Update page shift if stage 2 block mapping not supported
>
>Amit Kucheria (1):
>      powercap: make documentation reflect code
>
>Amjad Ouled-Ameur (1):
>      Revert "usb: dwc3: meson-g12a: fix shared reset control use"
>
>Andrew Jones (6):
>      KVM: arm64: pvtime: steal-time is only supported when configured
>      KVM: arm64: pvtime: Fix potential loss of stolen time
>      KVM: arm64: Drop type input from kvm_put_guest
>      KVM: arm64: pvtime: Fix stolen time accounting across migration
>      KVM: Documentation: Minor fixups
>      arm64/x86: KVM: Introduce steal-time cap
>
>Andy Shevchenko (2):
>      kobject: Restore old behaviour of kobject_del(NULL)
>      kobject: Drop unneeded conditional in __kobject_del()
>
>Angelo Compagnucci (2):
>      iio: adc: mcp3422: fix locking scope
>      iio: adc: mcp3422: fix locking on error path
>
>Anson Huang (1):
>      ARM: dts: imx7ulp: Correct gpio ranges
>
>Axel Lin (1):
>      regulator: cros-ec-regulator: Add NULL test for devm_kmemdup call
>
>Bj=C3=B8rn Mork (1):
>      USB: serial: option: support dynamic Quectel USB compositions
>
>Chenyi Qiang (1):
>      KVM: nVMX: Fix the update value of nested load
>IA32_PERF_GLOBAL_CTRL control
>
>Chris Healy (2):
>      ARM: dts: vfxxx: Add syscon compatible with OCOTP
>      ARM: dts: imx7d-zii-rmu2: fix rgmii phy-mode for ksz9031 phy
>
>Chris Packham (1):
>      mmc: sdhci-of-esdhc: Don't walk device-tree on every interrupt
>
>Christoph Hellwig (1):
>      block: restore a specific error code in bdev_del_partition
>
>Chuck Lever (2):
>      xprtrdma: Release in-flight MRs on disconnect
>      NFS: Zero-stateid SETATTR should first return delegation
>
>Colin Ian King (1):
>      regulator: fix spelling mistake "Cant" -> "Can't"
>
>Coly Li (1):
>      dax: fix detection of dax support for non-persistent memory block de=
vices
>
>Dan Carpenter (3):
>      staging: greybus: audio: Uninitialized variable in
>gbaudio_remove_controls()
>      counter: microchip-tcb-capture: check the correct variable
>      spi: stm32: fix pm_runtime_get_sync() error checking
>
>Daniel Jordan (1):
>      padata: fix possible padata_works_lock deadlock
>
>Dave Airlie (3):
>      Revert "drm/i915: Remove i915_gem_object_get_dirty_page()"
>      Revert "drm/i915/gem: Async GPU relocations only"
>      Revert "drm/i915/gem: Delete unused code"
>
>David Milburn (3):
>      nvme-fc: cancel async events before freeing event struct
>      nvme-rdma: cancel async events before freeing event struct
>      nvme-tcp: cancel async events before freeing event struct
>
>David Rientjes (1):
>      KVM: SVM: Periodically schedule when unregistering regions on destroy
>
>David Shah (1):
>      ARM: dts: omap5: Fix DSI base address and clocks
>
>Dinghao Liu (2):
>      RDMA/rxe: Fix memleak in rxe_mem_init_user
>      scsi: pm8001: Fix memleak in pm8001_exec_internal_task_abort
>
>Dinh Nguyen (1):
>      ARM: dts: socfpga: fix register entry for timer3 on Arria10
>
>Dmitry Osipenko (1):
>      regulator: core: Fix slab-out-of-bounds in regulator_unlock_recursiv=
e()
>
>Douglas Anderson (1):
>      mmc: sdhci-msm: Add retries when all tuning phases are found valid
>
>Evan Nimmo (1):
>      i2c: algo: pca: Reapply i2c bus settings after reset
>
>Fabio Estevam (2):
>      ARM: dts: imx6qdl-gw51xx: Remove unneeded #address-cells/#size-cells
>      ARM: dts: imx6q-prtwd2: Remove unneeded i2c unit name
>
>Filipe Manana (1):
>      btrfs: fix NULL pointer dereference after failure to create snapshot
>
>Florian Fainelli (5):
>      dt-bindings: spi: Fix spi-bcm-qspi compatible ordering
>      ARM: dts: bcm: HR2: Fixed QSPI compatible string
>      ARM: dts: NSP: Fixed QSPI compatible string
>      ARM: dts: BCM5301X: Fixed QSPI compatible string
>      arm64: dts: ns2: Fixed QSPI compatible string
>
>Fugang Duan (1):
>      ARM: dts: imx6sx: fix the pad QSPI1B_SCLK mux mode for uart3
>
>Gabriel Krisman Bertazi (1):
>      f2fs: Return EOF on unaligned end of file DIO read
>
>Gerd Hoffmann (2):
>      drm/virtio: fix unblank
>      drm/virtio: drop virtio_gpu_output->enabled
>
>Greg Kroah-Hartman (2):
>      Revert "dyndbg: fix problem parsing format=3D"foo bar""
>      Revert "dyndbg: accept query terms like file=3Dbar and module=3Dfoo"
>
>Gurchetan Singh (1):
>      drm/virtio: Revert "drm/virtio: Call the right shmem helpers"
>
>Gustav Wiklander (1):
>      spi: Fix memory leak on splited transfers
>
>Gwendal Grignou (1):
>      iio: cros_ec: Set Gyroscope default frequency to 25Hz
>
>Haiwei Li (1):
>      KVM: Check the allocation of pv cpu mask
>
>Heikki Krogerus (1):
>      usb: typec: ucsi: acpi: Check the _DEP dependencies
>
>Hou Pu (1):
>      scsi: target: iscsi: Fix hang in iscsit_access_np() when getting
>tpg->np_login_sem
>
>Huacai Chen (1):
>      KVM: MIPS: Change the definition of kvm type
>
>Ilya Dryomov (1):
>      rbd: require global CAP_SYS_ADMIN for mapping and unmapping
>
>J. Bruce Fields (1):
>      SUNRPC: stop printk reading past end of string
>
>James Smart (5):
>      scsi: lpfc: Fix setting IRQ affinity with an empty CPU mask
>      scsi: lpfc: Fix FLOGI/PLOGI receive race condition in pt2pt discovery
>      scsi: lpfc: Extend the RDF FPIN Registration descriptor for
>additional events
>      scsi: lpfc: Update lpfc version to 12.8.0.4
>      nvme: Revert: Fix controller creation races with teardown flow
>
>Javed Hasan (1):
>      scsi: libfc: Fix for double free()
>
>Jernej Skrabec (1):
>      drm/sun4i: Fix DE2 YVU handling
>
>Jim Cromie (3):
>      dyndbg: give %3u width in pr-format, cosmetic only
>      dyndbg: refine export, rename to dynamic_debug_exec_queries()
>      dyndbg: fix problem parsing format=3D"foo bar"
>
>Jing Xiangfeng (1):
>      ARM: OMAP2+: Fix an IS_ERR() vs NULL check in _get_pwrdm()
>
>Jonathan Cameron (13):
>      iio: accel: kxsd9: Fix alignment of local buffer.
>      iio:accel:mma8452: Fix timestamp alignment and prevent data leak.
>      iio:accel:bmc150-accel: Fix timestamp alignment and prevent data lea=
k.
>      iio:accel:mma7455: Fix timestamp alignment and prevent data leak.
>      iio:proximity:mb1232: Fix timestamp alignment and prevent data leak.
>      iio:chemical:ccs811: Fix timestamp alignment and prevent data leak.
>      iio:light:max44000 Fix timestamp alignment and prevent data leak.
>      iio:light:ltr501 Fix timestamp alignment issue.
>      iio:magnetometer:ak8975 Fix alignment and data leak issues.
>      iio:adc:ti-adc081c Fix alignment and data leak issues
>      iio:adc:ti-adc084s021 Fix alignment and data leak issues.
>      iio:adc:ina2xx Fix timestamp alignment issue.
>      iio:adc:max1118 Fix alignment of timestamp and data leak issues
>
>Jordan Crouse (4):
>      drm/msm: Split the a5xx preemption record
>      drm/msm: Enable expanded apriv support for a650
>      drm/msm: Disable preemption on all 5xx targets
>      drm/msm: Disable the RPTR shadow
>
>Josef Bacik (2):
>      btrfs: fix lockdep splat in add_missing_dev
>      btrfs: free data reloc tree on failed mount
>
>Josh Poimboeuf (1):
>      Revert "kbuild: use -flive-patching when CONFIG_LIVEPATCH is enabled"
>
>Kai Vehmanen (1):
>      drm/i915: fix regression leading to display audio probe failure on G=
LK
>
>Kamal Heib (2):
>      RDMA/rxe: Fix panic when calling kmem_cache_create()
>      RDMA/core: Fix reported speed and width
>
>Kees Cook (1):
>      test_firmware: Test platform fw loading on non-EFI systems
>
>Krzysztof Kozlowski (7):
>      arm64: dts: xilinx: Align IOMMU nodename with dtschema
>      arm64: defconfig: Enable USB gadget with configfs
>      arm64: defconfig: Enable ptn5150 extcon driver
>      arm64: dts: imx8mq: Fix TMU interrupt property
>      dma-buf: Fix kerneldoc of dma_buf_set_name()
>      dma-buf: fence-chain: Document missing dma_fence_chain_init()
>parameter in kerneldoc
>      MAINTAINERS: Add the security document to SECURITY CONTACT
>
>Lai Jiangshan (1):
>      kvm x86/mmu: use KVM_REQ_MMU_SYNC to sync when needed
>
>Laurent Pinchart (3):
>      arm64: dts: zynqmp: Add GTR transceivers
>      rapidio: Replace 'select' DMAENGINES 'with depends on'
>      drm: xlnx: dpsub: Fix DMADEVICES Kconfig dependency
>
>Linus Torvalds (1):
>      Linux 5.9-rc5
>
>Linus Walleij (2):
>      ARM: configs: Update Integrator defconfig
>      drm/tve200: Stabilize enable/disable
>
>Luo Jiaxing (1):
>      scsi: libsas: Set data_dir as DMA_NONE if libata marks qc as NODATA
>
>Madhusudanarao Amara (1):
>      usb: typec: intel_pmc_mux: Un-register the USB role switch
>
>Marc Zyngier (2):
>      KVM: arm64: Do not try to map PUDs when they are folded into PMD
>      KVM: arm64: Fix address truncation in traces
>
>Marek Vasut (1):
>      spi: stm32: Rate-limit the 'Communication suspended' message
>
>Mark Bloch (1):
>      RDMA/mlx4: Read pkey table length instead of hardcoded value
>
>Martin Blumenstingl (1):
>      iio: adc: meson-saradc: Use the parent device to look up the calib d=
ata
>
>Mathias Nyman (1):
>      usb: Fix out of sync data toggle if a configured device is reconfigu=
red
>
>Matthias Kaehlcke (1):
>      interconnect: Show bandwidth for disabled paths as zero in debugfs
>
>Matthias Schiffer (1):
>      ARM: dts: ls1021a: fix QuadSPI-memory reg range
>
>Maxim Kochetkov (1):
>      iio: adc: ti-ads1015: fix conversion when CONFIG_PM is not set
>
>Maxim Levitsky (4):
>      SVM: nSVM: correctly restore GIF on vmexit from nesting after migrat=
ion
>      SVM: nSVM: setup nested msr permission bitmap on nested state load
>      KVM: nSVM: more strict SMM checks when returning to nested guest
>      KVM: emulator: more strict rsm checks.
>
>Maxime Ripard (2):
>      drm/sun4i: backend: Support alpha property on lowest plane
>      drm/sun4i: backend: Disable alpha on the lowest plane on the A20
>
>Md Haris Iqbal (2):
>      RDMA/rtrs-srv: Replace device_register with device_initialize
>and device_add
>      RDMA/rtrs-srv: Set .release function for rtrs srv device during
>device init
>
>Michael Walle (1):
>      iio: adc: rockchip_saradc: select IIO_TRIGGERED_BUFFER
>
>Micha=C5=82 Miros=C5=82aw (8):
>      regulator: push allocation in regulator_init_coupling() outside of l=
ock
>      regulator: push allocation in regulator_ena_gpio_request() out of lo=
ck
>      regulator: push allocations in create_regulator() outside of lock
>      regulator: push allocation in set_consumer_device_supply() out of lo=
ck
>      regulator: plug of_node leak in regulator_register()'s error path
>      regulator: cleanup regulator_ena_gpio_free()
>      regulator: remove superfluous lock in regulator_resolve_coupling()
>      driver code: print symbolic error code
>
>Mika Westerberg (1):
>      thunderbolt: Use maximum USB3 link rate when reclaiming if link is n=
ot up
>
>Mike Tipton (1):
>      interconnect: qcom: Fix small BW votes being truncated to zero
>
>Moti Haimovski (1):
>      habanalabs: prevent user buff overflow
>
>Naresh Kumar PBS (3):
>      RDMA/bnxt_re: Static NQ depth allocation
>      RDMA/bnxt_re: Restrict the max_gids to 256
>      RDMA/bnxt_re: Fix driver crash on unaligned PSN entry address
>
>Nikunj A. Dadhania (1):
>      thunderbolt: Disable ports that are not implemented
>
>Ofir Bitton (1):
>      habanalabs: fix report of RAZWI initiator coordinates
>
>Olga Kornievskaia (1):
>      NFSv4.1 handle ERR_DELAY error reclaiming locking state on
>delegation recall
>
>Omar Sandoval (1):
>      block: only call sched requeue_request() for scheduled requests
>
>Ondrej Jirman (1):
>      drm/sun4i: Fix dsi dcs long write function
>
>Patrick Riphagen (1):
>      USB: serial: ftdi_sio: add IDs for Xsens Mti USB converter
>
>Paul Cercueil (2):
>      drm/ingenic: Fix leak of device_node pointer
>      drm/ingenic: Fix driver not probing when IPU port is missing
>
>Peter Oberparleiter (1):
>      gcov: add support for GCC 10.1
>
>Peter Shier (1):
>      KVM: nVMX: Update VMCS02 when L2 PAE PDPTE updates detected
>
>Pierre-Louis Bossart (1):
>      soundwire: bus: fix typo in comment on INTSTAT registers
>
>Po-Hsu Lin (1):
>      selftests/timers: Turn off timeout setting
>
>Prateek Sood (1):
>      firmware_loader: fix memory leak for paged buffer
>
>Qu Wenruo (1):
>      btrfs: require only sector size alignment for parent eb bytenr
>
>Randy Dunlap (3):
>      Documentation: fix dma-buf.rst underline length warning
>      PM: <linux/device.h>: fix @em_pd kernel-doc warning
>      PM: <linux/device.h>: fix @em_pd kernel-doc warning
>
>Raul E Rangel (1):
>      mmc: sdhci-acpi: Clear amd_sdhci_host on reset
>
>Ren=C3=A9 Rebe (1):
>      scsi: qla2xxx: Fix regression on sparc64
>
>Ritesh Harjani (1):
>      block: Set same_page to false in __bio_try_merge_page if ret is false
>
>Rob Herring (1):
>      arm64: dts: imx: Add missing imx8mm-beacon-kit.dtb to build
>
>Robin Gong (1):
>      arm64: dts: imx8mp: correct sdma1 clk setting
>
>Roger Quadros (1):
>      phy: omap-usb2-phy: disable PHY charger detect
>
>Ronnie Sahlberg (1):
>      cifs: fix DFS mount with cifsacl/modefromsid
>
>Rustam Kovhaev (3):
>      staging: wlan-ng: fix out of bounds read in prism2sta_probe_usb()
>      scripts/tags.sh: exclude tools directory from tags generation
>      KVM: fix memory leak in kvm_io_bus_unregister_dev()
>
>Sagi Grimberg (2):
>      nvme-fabrics: allow to queue requests for live queues
>      IB/isert: Fix unaligned immediate-data handling
>
>Sahitya Tummala (1):
>      f2fs: fix indefinite loop scanning for free nid
>
>Saravana Kannan (1):
>      driver core: Fix device_pm_lock() locking for device links
>
>Selvin Xavier (3):
>      RDMA/bnxt_re: Do not report transparent vlan from QP1
>      RDMA/bnxt_re: Fix the qp table indexing
>      RDMA/bnxt_re: Remove the qp from list only if the qp destroy succeeds
>
>Shin'ichiro Kawasaki (1):
>      f2fs: Fix type of section block count variables
>
>Sivaprakash Murugesan (1):
>      phy: qcom-qmp: Use correct values for ipq8074 PCIe Gen2 PHY init
>
>Stafford Horne (3):
>      openrisc: Reserve memblock for initrd
>      openrisc: Fix cache API compile issue when not inlining
>      openrisc: Fix issue with get_user for 64-bit values
>
>Tali Perry (1):
>      i2c: npcm7xx: Fix timeout calculation
>
>Tetsuo Handa (1):
>      video: fbdev: fix OOB read in vga_8planes_imageblit()
>
>Tom Rix (1):
>      soundwire: fix double free of dangling pointer
>
>Tomas Henzl (2):
>      scsi: megaraid_sas: Don't call disable_irq from process IRQ poll
>      scsi: mpt3sas: Don't call disable_irq from IRQ poll handler
>
>Tycho Andersen (3):
>      seccomp: don't leak memory when filter install races
>      mailmap, MAINTAINERS: move to tycho.pizza
>      seccomp: don't leave dangling ->notif if file allocation fails
>
>Ulf Hansson (1):
>      mmc: mmc_spi: Allow the driver to be built when CONFIG_HAS_DMA is un=
set
>
>Utkarsh Patel (2):
>      usb: typec: intel_pmc_mux: Do not configure Altmode HPD High
>      usb: typec: intel_pmc_mux: Do not configure SBU and HSL
>Orientation in Alternate modes
>
>Vadym Kochan (1):
>      misc: eeprom: at24: register nvmem only after eeprom is ready to use
>
>Vaibhav Agarwal (1):
>      staging: greybus: audio: fix uninitialized value issue
>
>Varun Prakash (1):
>      scsi: target: iscsi: Fix data digest calculation
>
>Vignesh Raghavendra (2):
>      spi: spi-cadence-quadspi: Populate get_name() interface
>      spi: spi-cadence-quadspi: Fix mapping of buffers for DMA reads
>
>Vincent Whitchurch (2):
>      regulator: pwm: Fix machine constraints application
>      spi: spi-loopback-test: Fix out-of-bounds read
>
>Vitaly Kuznetsov (3):
>      KVM: x86: always allow writing '0' to MSR_KVM_ASYNC_PF_EN
>      x86/kvm: properly use DEFINE_IDTENTRY_SYSVEC() macro
>      x86/kvm: don't forget to ACK async PF IRQ
>
>Vladimir Oltean (1):
>      MAINTAINERS: add myself as maintainer for spi-fsl-dspi driver
>
>Vladis Dronov (1):
>      debugfs: Fix module state check condition
>
>Wanpeng Li (2):
>      KVM: SVM: avoid emulation with stale next_rip
>      KVM: VMX: Don't freeze guest when event delivery causes an
>APIC-access exit
>
>Wei Yongjun (1):
>      phy: qualcomm: fix return value check in qcom_ipq806x_usb_phy_probe()
>
>Xi Wang (1):
>      RDMA/core: Fix unsafe linked list traversal after failing to allocat=
e CQ
>
>Yi Zhang (1):
>      RDMA/rxe: Fix the parent sysfs read when the interface has 15 chars
>
>Yu Kuai (1):
>      drm/sun4i: add missing put_device() call in sun8i_r40_tcon_tv_set_mu=
x()
>
>YueHaibing (2):
>      phy: qualcomm: fix platform_no_drv_owner.cocci warnings
>      RDMA/bnxt_re: Remove set but not used variable 'qplib_ctx'
>
>Zeng Tao (1):
>      usb: core: fix slab-out-of-bounds Read in read_descriptors
>
>Zhang Rui (3):
>      powercap/intel_rapl: add support for TigerLake Desktop
>      powercap/intel_rapl: add support for RocketLake
>      powercap/intel_rapl: add support for AlderLake

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9eyKcACgkQsjqdtxFL
KRXw/ggAkmskjT8gT0hXPIXpwTL04wsqPhvAbHmP1uMPF1aChrNBNhKoDDYSt5iz
Gm4Z9Kk7Q7Kpfn2BBbvRnN227bqX1YOxFZ0OrN+Q2JInPC447enAnJkfxLrx4CZO
ERVWyit002A2Kbtd3/lXlYzpdzdRnYCbZMxBfQjN9jXriRAjw8wjQCrwn4PiZKmw
esJET9SyxvdCVMy560Lzmw/1lYIGSB1MOxlkuA6oCghXwbfcFBvryHO0H/xCNjhG
DwDeyHsj/OUZEBtxdPZLf7miejhmYl1/jhogqb8ELMKV2sItQCG2f2Oc1okNx0IM
Xo9jP18weq76UvUh8HC2Lq1nJkHCEg==
=i+QB
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
