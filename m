Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A7B1F7081
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 00:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFKWnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 18:43:39 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:39680 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726159AbgFKWni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:43:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3ECB3181CB14C;
        Thu, 11 Jun 2020 22:43:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:69:355:379:800:960:966:967:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1431:1437:1515:1516:1518:1535:1593:1594:1605:1730:1747:1777:1792:1981:2194:2196:2198:2199:2200:2201:2393:2525:2568:2629:2682:2685:2731:2828:2859:2894:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3167:3865:3866:3867:3868:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4043:4052:4120:4321:4384:4385:4395:4559:4659:5007:6117:6119:7514:7809:7904:8568:8660:9010:9025:9072:9149:9388:9592:10004:10049:10848:11026:11232:11257:11657:11658:11896:11914:12043:12114:12291:12297:12438:12555:12683:12760:13148:13230:13439:14096:14097:14106:14659:21080:21212:21325:21433:21451:21611:21627:21691:21740:21781:21939:30019:30034:30054:30056:30064,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: twig57_1e0970d26dd7
X-Filterd-Recvd-Size: 9660
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jun 2020 22:43:36 +0000 (UTC)
Message-ID: <2f77e88e02ba81f0496dba778854fae8d0b5e862.camel@perches.com>
Subject: request: run scripts/parse-maintainers.pl  just before every -rc1
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Jun 2020 15:43:34 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the last major reordering of the MAINTAINERS file
did not create many issues for downstream branches.

Keeping these sections and file lists ordered has some utility.

It seems that patches to the MAINTAINERS file frequently cause
out-of-order sections and file entries as submitters aren't
very good at alphabetizing.

Right now running:

$ ./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order

produces this diff:
---
 MAINTAINERS | 102 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b4e836543a3..756a95d403a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -900,11 +900,6 @@ F:	drivers/gpu/drm/amd/include/v9_structs.h
 F:	drivers/gpu/drm/amd/include/vi_structs.h
 F:	include/uapi/linux/kfd_ioctl.h
 
-AMD SPI DRIVER
-M:	Sanjay R Mehta <sanju.mehta@amd.com>
-S:	Maintained
-F:	drivers/spi/spi-amd.c
-
 AMD MP2 I2C DRIVER
 M:	Elie Morisse <syniurge@gmail.com>
 M:	Nehal Shah <nehal-bakulchandra.shah@amd.com>
@@ -927,6 +922,11 @@ M:	Tom Lendacky <thomas.lendacky@amd.com>
 S:	Supported
 F:	arch/arm64/boot/dts/amd/
 
+AMD SPI DRIVER
+M:	Sanjay R Mehta <sanju.mehta@amd.com>
+S:	Maintained
+F:	drivers/spi/spi-amd.c
+
 AMD XGBE DRIVER
 M:	Tom Lendacky <thomas.lendacky@amd.com>
 L:	netdev@vger.kernel.org
@@ -1046,10 +1046,10 @@ F:	drivers/iio/imu/adis16460.c
 ANALOG DEVICES INC ADIS16475 DRIVER
 M:	Nuno Sa <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
-W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
-F:	drivers/iio/imu/adis16475.c
+W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
+F:	drivers/iio/imu/adis16475.c
 
 ANALOG DEVICES INC ADM1177 DRIVER
 M:	Beniamin Bia <beniamin.bia@analog.com>
@@ -3943,10 +3943,10 @@ CCTRNG ARM TRUSTZONE CRYPTOCELL TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
 M:	Hadar Gat <hadar.gat@arm.com>
 L:	linux-crypto@vger.kernel.org
 S:	Supported
+W:	https://developer.arm.com/products/system-ip/trustzone-cryptocell/cryptocell-700-family
+F:	Documentation/devicetree/bindings/rng/arm-cctrng.txt
 F:	drivers/char/hw_random/cctrng.c
 F:	drivers/char/hw_random/cctrng.h
-F:	Documentation/devicetree/bindings/rng/arm-cctrng.txt
-W:	https://developer.arm.com/products/system-ip/trustzone-cryptocell/cryptocell-700-family
 
 CEC FRAMEWORK
 M:	Hans Verkuil <hverkuil-cisco@xs4all.nl>
@@ -4700,6 +4700,12 @@ S:	Orphan
 W:	http://www.cyclades.com/
 F:	drivers/net/wan/pc300*
 
+CYPRESS CY8CTMA140 TOUCHSCREEN DRIVER
+M:	Linus Walleij <linus.walleij@linaro.org>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	drivers/input/touchscreen/cy8ctma140.c
+
 CYPRESS_FIRMWARE MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
@@ -4710,12 +4716,6 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/common/cypress_firmware*
 
-CYPRESS CY8CTMA140 TOUCHSCREEN DRIVER
-M:	Linus Walleij <linus.walleij@linaro.org>
-L:	linux-input@vger.kernel.org
-S:	Maintained
-F:	drivers/input/touchscreen/cy8ctma140.c
-
 CYTTSP TOUCHSCREEN DRIVER
 M:	Ferruh Yigit <fery@cypress.com>
 L:	linux-input@vger.kernel.org
@@ -5399,10 +5399,10 @@ F:	include/uapi/drm/i810_drm.h
 DRM DRIVER FOR LVDS PANELS
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
 L:	dri-devel@lists.freedesktop.org
-T:	git git://anongit.freedesktop.org/drm/drm-misc
 S:	Maintained
-F:	drivers/gpu/drm/panel/panel-lvds.c
+T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/panel/lvds.yaml
+F:	drivers/gpu/drm/panel/panel-lvds.c
 
 DRM DRIVER FOR MATROX G200/G400 GRAPHICS CARDS
 S:	Orphan / Obsolete
@@ -7100,32 +7100,32 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
 F:	Documentation/locking/*futex*
+F:	Documentation/locking/*futex*
 F:	include/asm-generic/futex.h
 F:	include/linux/futex.h
 F:	include/uapi/linux/futex.h
 F:	kernel/futex.c
 F:	tools/perf/bench/futex*
-F:	Documentation/locking/*futex*
+
+GASKET DRIVER FRAMEWORK
+M:	Rob Springer <rspringer@google.com>
+M:	Todd Poynor <toddpoynor@google.com>
+M:	Ben Chan <benchan@chromium.org>
+M:	Richard Yeh <rcy@google.com>
+S:	Maintained
+F:	drivers/staging/gasket/
 
 GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
 M:	Tim Harvey <tharvey@gateworks.com>
 M:	Robert Jones <rjones@gateworks.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
-F:	drivers/mfd/gateworks-gsc.c
-F:	include/linux/mfd/gsc.h
 F:	Documentation/hwmon/gsc-hwmon.rst
 F:	drivers/hwmon/gsc-hwmon.c
+F:	drivers/mfd/gateworks-gsc.c
+F:	include/linux/mfd/gsc.h
 F:	include/linux/platform_data/gsc_hwmon.h
 
-GASKET DRIVER FRAMEWORK
-M:	Rob Springer <rspringer@google.com>
-M:	Todd Poynor <toddpoynor@google.com>
-M:	Ben Chan <benchan@chromium.org>
-M:	Richard Yeh <rcy@google.com>
-S:	Maintained
-F:	drivers/staging/gasket/
-
 GCC PLUGINS
 M:	Kees Cook <keescook@chromium.org>
 R:	Emese Revfy <re.emese@gmail.com>
@@ -9031,8 +9031,8 @@ M:	Corey Minyard <minyard@acm.org>
 L:	openipmi-developer@lists.sourceforge.net (moderated for non-subscribers)
 S:	Supported
 W:	http://openipmi.sourceforge.net/
-F:	Documentation/driver-api/ipmi.rst
 F:	Documentation/devicetree/bindings/ipmi/
+F:	Documentation/driver-api/ipmi.rst
 F:	drivers/char/ipmi/
 F:	include/linux/ipmi*
 F:	include/uapi/linux/ipmi*
@@ -9855,9 +9855,9 @@ F:	include/uapi/linux/lightnvm.h
 LINEAR RANGES HELPERS
 M:	Mark Brown <broonie@kernel.org>
 R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+F:	include/linux/linear_range.h
 F:	lib/linear_ranges.c
 F:	lib/test_linear_ranges.c
-F:	include/linux/linear_range.h
 
 LINUX FOR POWER MACINTOSH
 M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
@@ -13831,8 +13831,8 @@ M:	Colin Cross <ccross@android.com>
 M:	Tony Luck <tony.luck@intel.com>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
-F:	Documentation/admin-guide/ramoops.rst
 F:	Documentation/admin-guide/pstore-blk.rst
+F:	Documentation/admin-guide/ramoops.rst
 F:	Documentation/devicetree/bindings/reserved-memory/ramoops.txt
 F:	drivers/acpi/apei/erst.c
 F:	drivers/firmware/efi/efi-pstore.c
@@ -14852,9 +14852,9 @@ M:	Gerald Schaefer <gerald.schaefer@de.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
+F:	Documentation/s390/pci.rst
 F:	arch/s390/pci/
 F:	drivers/pci/hotplug/s390_pci_hpc.c
-F:	Documentation/s390/pci.rst
 
 S390 VFIO AP DRIVER
 M:	Tony Krowiak <akrowiak@linux.ibm.com>
@@ -15288,6 +15288,15 @@ F:	block/sed*
 F:	include/linux/sed*
 F:	include/uapi/linux/sed*
 
+SECURE MONITOR CALL(SMC) CALLING CONVENTION (SMCCC)
+M:	Mark Rutland <mark.rutland@arm.com>
+M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+M:	Sudeep Holla <sudeep.holla@arm.com>
+L:	linux-arm-kernel@lists.infradead.org
+S:	Maintained
+F:	drivers/firmware/smccc/
+F:	include/linux/arm-smccc.h
+
 SECURITY CONTACT
 M:	Security Officers <security@kernel.org>
 S:	Supported
@@ -15656,15 +15665,6 @@ M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Odd Fixes
 F:	drivers/net/ethernet/smsc/smc91x.*
 
-SECURE MONITOR CALL(SMC) CALLING CONVENTION (SMCCC)
-M:	Mark Rutland <mark.rutland@arm.com>
-M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
-M:	Sudeep Holla <sudeep.holla@arm.com>
-L:	linux-arm-kernel@lists.infradead.org
-S:	Maintained
-F:	drivers/firmware/smccc/
-F:	include/linux/arm-smccc.h
-
 SMIA AND SMIA++ IMAGE SENSOR DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
@@ -18085,6 +18085,16 @@ F:	net/vmw_vsock/virtio_transport_common.c
 F:	net/vmw_vsock/vsock_loopback.c
 F:	tools/testing/vsock/
 
+VIRTIO BALLOON
+M:	"Michael S. Tsirkin" <mst@redhat.com>
+M:	David Hildenbrand <david@redhat.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/virtio/virtio_balloon.c
+F:	include/linux/balloon_compaction.h
+F:	include/uapi/linux/virtio_balloon.h
+F:	mm/balloon_compaction.c
+
 VIRTIO BLOCK AND SCSI DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
@@ -18122,16 +18132,6 @@ F:	include/linux/virtio*.h
 F:	include/uapi/linux/virtio_*.h
 F:	tools/virtio/
 
-VIRTIO BALLOON
-M:	"Michael S. Tsirkin" <mst@redhat.com>
-M:	David Hildenbrand <david@redhat.com>
-L:	virtualization@lists.linux-foundation.org
-S:	Maintained
-F:	drivers/virtio/virtio_balloon.c
-F:	include/uapi/linux/virtio_balloon.h
-F:	include/linux/balloon_compaction.h
-F:	mm/balloon_compaction.c
-
 VIRTIO CRYPTO DRIVER
 M:	Gonglei <arei.gonglei@huawei.com>
 L:	virtualization@lists.linux-foundation.org


