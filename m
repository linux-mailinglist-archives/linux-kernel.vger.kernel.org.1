Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE1828FEF0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 09:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404486AbgJPHK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 03:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404477AbgJPHK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 03:10:57 -0400
Received: from coco.lan (ip5f5ad5ad.dynamic.kabel-deutschland.de [95.90.213.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1774620720;
        Fri, 16 Oct 2020 07:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602832256;
        bh=0/Y7GXnBCgwZGITpUgIGF8pANj8GsvXkWenTv+Z0NyM=;
        h=Date:From:To:Cc:Subject:From;
        b=wFQAzcOBaHZ/1jcqNQSOBfOTgiDm38Tm6iIUgnoDIDgs8T9csZ+nUIOs11IiNNCid
         8+Dx9TYoA+4K60p01ClYjTelTImVFRgM1UY9wIDkO4QdE/yLNSxJAOEBJL4GPxmDp9
         ejwssVsdyIowKQDsXAx8u8vN7Zmx+s1ZxEVZaWB0=
Date:   Fri, 16 Oct 2020 09:10:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Docs Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [GIT PULL for v5.10-rc1] docs: fix building warnings and add
 support for Sphinx 3.1+
Message-ID: <20201016091048.574b2eeb@coco.lan>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git tag=
s/docs/v5.10-1

For a series of patches addressing warnings produced by make htmldocs.
This includes:

- kernel-doc markup fixes;
- ReST fixes;
- Updates at the build system in order to support newer versions of the
  docs build toolchain (Sphinx).

After this series, the number of html build warnings should reduce
significantly, and building with Sphinx 3.1 or later should now
be supported (although it is still recommended to use Sphinx 2.4.4).

As agreed with Jon, I should be sending you a late pull request by
the end of the merge window addressing remaining issues with docs
build, as there are a number of warning fixes that depends on
pull requests that should be happening along the merge window.

The end goal is to have a clean htmldocs build on Kernel 5.10.

PS.: It should be noticed that Sphinx 3.0 is not currently
supported, as it lacks support for C domain namespaces.
Such feature, needed in order to document uAPI system calls
with Sphinx 3.x, was added only on Sphinx 3.1.

Regards,
Mauro

-

The following changes since commit 3e4fb4346c781068610d03c12b16c0cfb0fd24a3:

  Merge tag 'spdx-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/gregkh/spdx (2020-10-14 16:19:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media.git tag=
s/docs/v5.10-1

for you to fetch changes up to 3e2ac9798e13ad1f52d735ea2ea1d252cb140ae5:

  PM / devfreq: remove a duplicated kernel-doc markup (2020-10-16 07:28:20 =
+0200)

----------------------------------------------------------------
docs updates for v5.10-rc1

----------------------------------------------------------------
Mauro Carvalho Chehab (71):
      scripts: kernel-doc: add support for typedef enum
      scripts: kernel-doc: make it more compatible with Sphinx 3.x
      scripts: kernel-doc: use a less pedantic markup for funcs on Sphinx 3=
.x
      scripts: kernel-doc: fix troubles with line counts
      scripts: kernel-doc: reimplement -nofunction argument
      scripts: kernel-doc: fix typedef identification
      scripts: kernel-doc: don't mangle with parameter list
      scripts: kernel-doc: allow passing desired Sphinx C domain dialect
      scripts: kernel-doc: fix line number handling
      scripts: kernel-doc: try to use c:function if possible
      docs: cdomain.py: add support for a new Sphinx 3.1+ tag
      docs: cdomain.py: extend it to handle new Sphinx 3.x tags
      docs: kerneldoc.py: append the name of the parsed doc file
      docs: kerneldoc.py: add support for kerneldoc -nosymbol
      media: docs: make CEC documents compatible with Sphinx 3.1+
      media: docs: make V4L documents more compatible with Sphinx 3.1+
      media: docs: make DVB documents more compatible with Sphinx 3.1+
      media: docs: make MC documents more compatible with Sphinx 3.1+
      media: docs: make RC documents more compatible with Sphinx 3.1+
      media: cec-core.rst: don't use c:type for structs
      docs: remove some replace macros like |struct foo|
      docs: get rid of :c:type explicit declarations for structs
      docs: trace-uses.rst: remove bogus c-domain tags
      docs: it_IT: fix namespace collisions at locking.rst
      docs: net: ieee802154.rst: fix C expressions
      docs: genericirq.rst: don't document chip.c functions twice
      docs: kernel-api.rst: drop kernel/irq/manage.c kernel-doc tag
      docs: remove sound API duplication
      docs: basics.rst: move kernel-doc workqueue markups to workqueue.rst
      docs: scsi: target.rst: remove iSCSI transport class kernel-doc markup
      docs: device_link.rst: remove duplicated kernel-doc include
      docs: basics.rst: get rid of rcu kernel-doc macros
      docs: pstore-blk.rst: fix kernel-doc tags
      docs: fs: fscrypt.rst: get rid of :c:type: tags
      docs: devices.rst: get rid of :c:type macros
      docs: sound: writing-an-alsa-driver.rst: get rid of :c:type
      docs: block: blk-mq.rst: get rid of :c:type
      docs: writing-an-alsa-driver.rst: fix some bad c:func: markups
      docs: fpga: replace :c:member: macros
      docs: kgdb.rst: fix :c:type: usages
      docs: libata.rst: fix a wrong usage of :c:type: tag
      docs: infrastructure.rst: don't include firmware kernel-doc
      docs: gpu: i915.rst: Fix several C duplication warnings
      docs: devices.rst: fix a C reference markup
      docs: it_IT: hacking.rst: fix a typo on a markup
      docs: mei.rst: fix a C expression markup
      docs: basics.rst: avoid duplicated C function declaration
      docs: conf.py: fix c:function support with Sphinx 3.x
      docs: conf.py: change the Sphinx 3.x+ text
      docs: infrastructure.rst: exclude device_link_state from device.h
      docs: zh_CN: amu.rst: fix document title markup
      media: uAPI: buffer.rst: remove a left-over documentation
      math64.h: kernel-docs: Convert some markups into normal comments
      memblock: get rid of a :c:type leftover
      dt-bindings: fix references to files converted to yaml
      net: appletalk: Kconfig: Fix docs location
      drivers: net: hamradio: fix document location
      docs: powerpc: syscall64-abi.rst: fix a malformed table
      block: bio: fix a warning at the kernel-doc markups
      kunit: test.h: solve kernel-doc warnings
      docs: bio: fix a kerneldoc markup
      drivers: core: fix kernel-doc markup for dev_err_probe()
      kunit: test.h: fix a bad kernel-doc markup
      usb: docs: document altmode register/unregister functions
      nl80211: docs: add a description for s1g_cap parameter
      rcu/tree: docs: document bkvcache new members at struct kfree_rcu_cpu
      Input: sparse-keymap: add a description for @sw
      docs: virt: user_mode_linux_howto_v2.rst: fix a literal block markup
      workqueue: fix a kernel-doc warning
      mm/doc: fix a literal block markup
      PM / devfreq: remove a duplicated kernel-doc markup

N=C3=ADcolas F. R. A. Prado (4):
      docs: automarkup.py: Use new C roles in Sphinx 3
      docs: automarkup.py: Fix regexes to solve sphinx 3 warnings
      docs: automarkup.py: Skip C reserved words when cross-referencing
      docs: automarkup.py: Add cross-reference for parametrized C macros

 Documentation/admin-guide/pm/cpufreq.rst           |  11 +-
 Documentation/admin-guide/pstore-blk.rst           |  10 +-
 Documentation/block/blk-mq.rst                     |  12 +-
 Documentation/block/inline-encryption.rst          |   8 +-
 Documentation/conf.py                              |  65 ++++-
 Documentation/core-api/genericirq.rst              |   2 +
 Documentation/core-api/kernel-api.rst              |   6 -
 Documentation/core-api/workqueue.rst               |   2 +
 Documentation/dev-tools/kgdb.rst                   |   6 +-
 .../devicetree/bindings/display/tilcdc/tilcdc.txt  |   2 +-
 .../devicetree/bindings/mailbox/omap-mailbox.txt   |   2 +-
 .../devicetree/bindings/media/i2c/tvp5150.txt      |   2 +-
 .../bindings/pwm/google,cros-ec-pwm.yaml           |   2 +-
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   2 +-
 .../bindings/sound/google,cros-ec-codec.yaml       |   2 +-
 Documentation/doc-guide/kernel-doc.rst             |   8 +
 Documentation/driver-api/basics.rst                |  19 +-
 Documentation/driver-api/device_link.rst           |  13 +-
 Documentation/driver-api/fpga/fpga-bridge.rst      |   4 +-
 Documentation/driver-api/fpga/fpga-mgr.rst         |   6 +-
 Documentation/driver-api/fpga/fpga-programming.rst |   2 +-
 Documentation/driver-api/fpga/fpga-region.rst      |   6 +-
 Documentation/driver-api/iio/buffers.rst           |   2 +-
 Documentation/driver-api/iio/core.rst              |   6 +-
 Documentation/driver-api/iio/hw-consumer.rst       |   2 +-
 Documentation/driver-api/iio/triggered-buffers.rst |   2 +-
 Documentation/driver-api/iio/triggers.rst          |   4 +-
 Documentation/driver-api/index.rst                 |   1 -
 Documentation/driver-api/infrastructure.rst        |   4 +-
 Documentation/driver-api/libata.rst                |   2 +-
 Documentation/driver-api/media/cec-core.rst        |   2 +-
 Documentation/driver-api/media/dtv-frontend.rst    |   4 +-
 Documentation/driver-api/media/mc-core.rst         |  24 +-
 Documentation/driver-api/media/v4l2-controls.rst   |   2 +-
 Documentation/driver-api/media/v4l2-dev.rst        |   8 +-
 Documentation/driver-api/media/v4l2-device.rst     |   6 +-
 Documentation/driver-api/media/v4l2-event.rst      |  10 +-
 Documentation/driver-api/media/v4l2-fh.rst         |  16 +-
 Documentation/driver-api/media/v4l2-subdev.rst     |   2 +-
 Documentation/driver-api/mei/mei.rst               |   2 +-
 Documentation/driver-api/pm/cpuidle.rst            |  65 ++---
 Documentation/driver-api/pm/devices.rst            |  26 +-
 Documentation/driver-api/regulator.rst             |   4 +-
 Documentation/driver-api/sound.rst                 |  54 ----
 Documentation/driver-api/target.rst                |  12 -
 Documentation/driver-api/usb/URB.rst               |   2 +-
 Documentation/driver-api/usb/gadget.rst            |  10 +-
 Documentation/driver-api/usb/hotplug.rst           |   2 +-
 Documentation/driver-api/usb/typec_bus.rst         |   8 +-
 Documentation/filesystems/fscrypt.rst              |  74 +++--
 Documentation/filesystems/fsverity.rst             |   2 +-
 Documentation/gpu/i915.rst                         |  29 +-
 Documentation/networking/ieee802154.rst            |  18 +-
 Documentation/powerpc/syscall64-abi.rst            |  32 +--
 Documentation/sound/designs/tracepoints.rst        |  22 +-
 Documentation/sound/kernel-api/alsa-driver-api.rst |   1 +
 .../sound/kernel-api/writing-an-alsa-driver.rst    | 110 ++++----
 Documentation/sphinx/automarkup.py                 | 108 +++++++-
 Documentation/sphinx/cdomain.py                    |  93 ++++++-
 Documentation/sphinx/kerneldoc.py                  |  15 +-
 Documentation/sphinx/parse-headers.pl              |   2 +-
 Documentation/trace/ftrace-uses.rst                |  12 +-
 .../translations/it_IT/kernel-hacking/hacking.rst  |   2 +-
 .../translations/it_IT/kernel-hacking/locking.rst  |   2 +
 Documentation/translations/zh_CN/arm64/amu.rst     |   4 +-
 .../userspace-api/media/cec/cec-func-close.rst     |  10 +-
 .../userspace-api/media/cec/cec-func-ioctl.rst     |  11 +-
 .../userspace-api/media/cec/cec-func-open.rst      |  10 +-
 .../userspace-api/media/cec/cec-func-poll.rst      |  14 +-
 .../media/cec/cec-ioc-adap-g-caps.rst              |  10 +-
 .../media/cec/cec-ioc-adap-g-conn-info.rst         |  11 +-
 .../media/cec/cec-ioc-adap-g-log-addrs.rst         |  20 +-
 .../media/cec/cec-ioc-adap-g-phys-addr.rst         |  15 +-
 .../userspace-api/media/cec/cec-ioc-dqevent.rst    |  15 +-
 .../userspace-api/media/cec/cec-ioc-g-mode.rst     |  16 +-
 .../userspace-api/media/cec/cec-ioc-receive.rst    |  18 +-
 .../media/dvb/audio-bilingual-channel-select.rst   |   7 +-
 .../media/dvb/audio-channel-select.rst             |   8 +-
 .../userspace-api/media/dvb/audio-clear-buffer.rst |   8 +-
 .../userspace-api/media/dvb/audio-continue.rst     |   7 +-
 .../userspace-api/media/dvb/audio-fclose.rst       |   7 +-
 .../userspace-api/media/dvb/audio-fopen.rst        |   7 +-
 .../userspace-api/media/dvb/audio-fwrite.rst       |   7 +-
 .../media/dvb/audio-get-capabilities.rst           |   8 +-
 .../userspace-api/media/dvb/audio-get-status.rst   |   8 +-
 .../userspace-api/media/dvb/audio-pause.rst        |   9 +-
 .../userspace-api/media/dvb/audio-play.rst         |   7 +-
 .../media/dvb/audio-select-source.rst              |   8 +-
 .../userspace-api/media/dvb/audio-set-av-sync.rst  |   8 +-
 .../media/dvb/audio-set-bypass-mode.rst            |   9 +-
 .../userspace-api/media/dvb/audio-set-id.rst       |   9 +-
 .../userspace-api/media/dvb/audio-set-mixer.rst    |   9 +-
 .../userspace-api/media/dvb/audio-set-mute.rst     |   8 +-
 .../media/dvb/audio-set-streamtype.rst             |  10 +-
 .../userspace-api/media/dvb/audio-stop.rst         |   9 +-
 .../userspace-api/media/dvb/ca-fclose.rst          |   7 +-
 Documentation/userspace-api/media/dvb/ca-fopen.rst |   7 +-
 .../userspace-api/media/dvb/ca-get-cap.rst         |   8 +-
 .../userspace-api/media/dvb/ca-get-descr-info.rst  |   9 +-
 .../userspace-api/media/dvb/ca-get-msg.rst         |  10 +-
 .../userspace-api/media/dvb/ca-get-slot-info.rst   |   9 +-
 Documentation/userspace-api/media/dvb/ca-reset.rst |   9 +-
 .../userspace-api/media/dvb/ca-send-msg.rst        |   9 +-
 .../userspace-api/media/dvb/ca-set-descr.rst       |   8 +-
 .../userspace-api/media/dvb/dmx-add-pid.rst        |  10 +-
 .../userspace-api/media/dvb/dmx-expbuf.rst         |  11 +-
 .../userspace-api/media/dvb/dmx-fclose.rst         |   9 +-
 .../userspace-api/media/dvb/dmx-fopen.rst          |   5 +-
 .../userspace-api/media/dvb/dmx-fread.rst          |   7 +-
 .../userspace-api/media/dvb/dmx-fwrite.rst         |   6 +-
 .../userspace-api/media/dvb/dmx-get-pes-pids.rst   |  12 +-
 .../userspace-api/media/dvb/dmx-get-stc.rst        |  12 +-
 Documentation/userspace-api/media/dvb/dmx-mmap.rst |  15 +-
 .../userspace-api/media/dvb/dmx-munmap.rst         |  14 +-
 Documentation/userspace-api/media/dvb/dmx-qbuf.rst |  17 +-
 .../userspace-api/media/dvb/dmx-querybuf.rst       |   9 +-
 .../userspace-api/media/dvb/dmx-remove-pid.rst     |  10 +-
 .../userspace-api/media/dvb/dmx-reqbufs.rst        |   9 +-
 .../media/dvb/dmx-set-buffer-size.rst              |  10 +-
 .../userspace-api/media/dvb/dmx-set-filter.rst     |  12 +-
 .../userspace-api/media/dvb/dmx-set-pes-filter.rst |  13 +-
 .../userspace-api/media/dvb/dmx-start.rst          |  11 +-
 Documentation/userspace-api/media/dvb/dmx-stop.rst |   9 +-
 .../media/dvb/fe-diseqc-recv-slave-reply.rst       |   9 +-
 .../media/dvb/fe-diseqc-reset-overload.rst         |   9 +-
 .../media/dvb/fe-diseqc-send-burst.rst             |  10 +-
 .../media/dvb/fe-diseqc-send-master-cmd.rst        |   9 +-
 .../media/dvb/fe-dishnetwork-send-legacy-cmd.rst   |  10 +-
 .../media/dvb/fe-enable-high-lnb-voltage.rst       |  10 +-
 .../userspace-api/media/dvb/fe-get-event.rst       |  12 +-
 .../userspace-api/media/dvb/fe-get-frontend.rst    |  12 +-
 .../userspace-api/media/dvb/fe-get-info.rst        |  11 +-
 .../userspace-api/media/dvb/fe-get-property.rst    |  15 +-
 .../userspace-api/media/dvb/fe-read-ber.rst        |   9 +-
 .../media/dvb/fe-read-signal-strength.rst          |   9 +-
 .../userspace-api/media/dvb/fe-read-snr.rst        |   9 +-
 .../userspace-api/media/dvb/fe-read-status.rst     |  11 +-
 .../media/dvb/fe-read-uncorrected-blocks.rst       |   9 +-
 .../media/dvb/fe-set-frontend-tune-mode.rst        |  10 +-
 .../userspace-api/media/dvb/fe-set-frontend.rst    |  11 +-
 .../userspace-api/media/dvb/fe-set-tone.rst        |  10 +-
 .../userspace-api/media/dvb/fe-set-voltage.rst     |  10 +-
 .../userspace-api/media/dvb/frontend_f_close.rst   |   8 +-
 .../userspace-api/media/dvb/frontend_f_open.rst    |  10 +-
 .../userspace-api/media/dvb/net-add-if.rst         |   9 +-
 .../userspace-api/media/dvb/net-get-if.rst         |  10 +-
 .../userspace-api/media/dvb/net-remove-if.rst      |  10 +-
 .../userspace-api/media/dvb/video-clear-buffer.rst |   8 +-
 .../userspace-api/media/dvb/video-command.rst      |  10 +-
 .../userspace-api/media/dvb/video-continue.rst     |   8 +-
 .../userspace-api/media/dvb/video-fast-forward.rst |  10 +-
 .../userspace-api/media/dvb/video-fclose.rst       |   6 +-
 .../userspace-api/media/dvb/video-fopen.rst        |   6 +-
 .../userspace-api/media/dvb/video-freeze.rst       |   8 +-
 .../userspace-api/media/dvb/video-fwrite.rst       |   6 +-
 .../media/dvb/video-get-capabilities.rst           |   8 +-
 .../userspace-api/media/dvb/video-get-event.rst    |   8 +-
 .../media/dvb/video-get-frame-count.rst            |   8 +-
 .../userspace-api/media/dvb/video-get-pts.rst      |   8 +-
 .../userspace-api/media/dvb/video-get-size.rst     |   8 +-
 .../userspace-api/media/dvb/video-get-status.rst   |   7 +-
 .../userspace-api/media/dvb/video-play.rst         |   8 +-
 .../media/dvb/video-select-source.rst              |   7 +-
 .../userspace-api/media/dvb/video-set-blank.rst    |   8 +-
 .../media/dvb/video-set-display-format.rst         |   8 +-
 .../userspace-api/media/dvb/video-set-format.rst   |   9 +-
 .../media/dvb/video-set-streamtype.rst             |   8 +-
 .../userspace-api/media/dvb/video-slowmotion.rst   |  10 +-
 .../userspace-api/media/dvb/video-stillpicture.rst |   8 +-
 .../userspace-api/media/dvb/video-stop.rst         |   8 +-
 .../userspace-api/media/dvb/video-try-command.rst  |   8 +-
 .../media/mediactl/media-func-close.rst            |  10 +-
 .../media/mediactl/media-func-ioctl.rst            |  10 +-
 .../media/mediactl/media-func-open.rst             |  10 +-
 .../media/mediactl/media-ioc-device-info.rst       |  13 +-
 .../media/mediactl/media-ioc-enum-entities.rst     |  11 +-
 .../media/mediactl/media-ioc-enum-links.rst        |  13 +-
 .../media/mediactl/media-ioc-g-topology.rst        |  14 +-
 .../media/mediactl/media-ioc-request-alloc.rst     |  11 +-
 .../media/mediactl/media-ioc-setup-link.rst        |  10 +-
 .../media/mediactl/media-request-ioc-queue.rst     |   7 +-
 .../media/mediactl/media-request-ioc-reinit.rst    |   8 +-
 .../userspace-api/media/mediactl/request-api.rst   |   5 +-
 .../media/mediactl/request-func-close.rst          |   8 +-
 .../media/mediactl/request-func-ioctl.rst          |   8 +-
 .../media/mediactl/request-func-poll.rst           |  12 +-
 .../userspace-api/media/rc/lirc-get-features.rst   |   9 +-
 .../userspace-api/media/rc/lirc-get-rec-mode.rst   |  12 +-
 .../media/rc/lirc-get-rec-resolution.rst           |   8 +-
 .../userspace-api/media/rc/lirc-get-send-mode.rst  |  14 +-
 .../userspace-api/media/rc/lirc-get-timeout.rst    |  13 +-
 Documentation/userspace-api/media/rc/lirc-read.rst |  10 +-
 .../media/rc/lirc-set-measure-carrier-mode.rst     |   8 +-
 .../media/rc/lirc-set-rec-carrier-range.rst        |   6 +-
 .../media/rc/lirc-set-rec-carrier.rst              |   8 +-
 .../media/rc/lirc-set-rec-timeout-reports.rst      |   8 +-
 .../media/rc/lirc-set-rec-timeout.rst              |  13 +-
 .../media/rc/lirc-set-send-carrier.rst             |   8 +-
 .../media/rc/lirc-set-send-duty-cycle.rst          |   8 +-
 .../media/rc/lirc-set-transmitter-mask.rst         |   8 +-
 .../media/rc/lirc-set-wideband-receiver.rst        |   8 +-
 .../userspace-api/media/rc/lirc-write.rst          |   7 +-
 Documentation/userspace-api/media/v4l/buffer.rst   |  28 +-
 .../userspace-api/media/v4l/dev-capture.rst        |   7 +-
 .../userspace-api/media/v4l/dev-output.rst         |   7 +-
 .../userspace-api/media/v4l/dev-raw-vbi.rst        |  19 +-
 Documentation/userspace-api/media/v4l/dev-rds.rst  |  12 +-
 .../userspace-api/media/v4l/dev-sliced-vbi.rst     |  31 +--
 Documentation/userspace-api/media/v4l/diff-v4l.rst |  39 +--
 Documentation/userspace-api/media/v4l/dmabuf.rst   |   8 +-
 Documentation/userspace-api/media/v4l/format.rst   |   7 +-
 .../userspace-api/media/v4l/func-close.rst         |   8 +-
 .../userspace-api/media/v4l/func-ioctl.rst         |  10 +-
 .../userspace-api/media/v4l/func-mmap.rst          |  18 +-
 .../userspace-api/media/v4l/func-munmap.rst        |  14 +-
 .../userspace-api/media/v4l/func-open.rst          |  14 +-
 .../userspace-api/media/v4l/func-poll.rst          |  40 ++-
 .../userspace-api/media/v4l/func-read.rst          |  39 ++-
 .../userspace-api/media/v4l/func-select.rst        |  42 ++-
 .../userspace-api/media/v4l/func-write.rst         |  13 +-
 .../userspace-api/media/v4l/hist-v4l2.rst          |  70 +----
 Documentation/userspace-api/media/v4l/io.rst       |   6 +-
 .../media/v4l/libv4l-introduction.rst              |  30 +-
 Documentation/userspace-api/media/v4l/mmap.rst     |  26 +-
 Documentation/userspace-api/media/v4l/open.rst     |  15 +-
 Documentation/userspace-api/media/v4l/rw.rst       |  18 +-
 .../userspace-api/media/v4l/streaming-par.rst      |   5 +-
 Documentation/userspace-api/media/v4l/userp.rst    |  11 +-
 .../userspace-api/media/v4l/vidioc-create-bufs.rst |  11 +-
 .../userspace-api/media/v4l/vidioc-cropcap.rst     |  11 +-
 .../media/v4l/vidioc-dbg-g-chip-info.rst           |  13 +-
 .../media/v4l/vidioc-dbg-g-register.rst            |  18 +-
 .../userspace-api/media/v4l/vidioc-decoder-cmd.rst |  19 +-
 .../userspace-api/media/v4l/vidioc-dqevent.rst     |  19 +-
 .../media/v4l/vidioc-dv-timings-cap.rst            |  17 +-
 .../userspace-api/media/v4l/vidioc-encoder-cmd.rst |  25 +-
 .../media/v4l/vidioc-enum-dv-timings.rst           |  16 +-
 .../userspace-api/media/v4l/vidioc-enum-fmt.rst    |  12 +-
 .../media/v4l/vidioc-enum-frameintervals.rst       |  15 +-
 .../media/v4l/vidioc-enum-framesizes.rst           |  16 +-
 .../media/v4l/vidioc-enum-freq-bands.rst           |  12 +-
 .../userspace-api/media/v4l/vidioc-enumaudio.rst   |  10 +-
 .../media/v4l/vidioc-enumaudioout.rst              |  10 +-
 .../userspace-api/media/v4l/vidioc-enuminput.rst   |  14 +-
 .../userspace-api/media/v4l/vidioc-enumoutput.rst  |  13 +-
 .../userspace-api/media/v4l/vidioc-enumstd.rst     |  23 +-
 .../userspace-api/media/v4l/vidioc-expbuf.rst      |  14 +-
 .../userspace-api/media/v4l/vidioc-g-audio.rst     |  18 +-
 .../userspace-api/media/v4l/vidioc-g-audioout.rst  |  16 +-
 .../userspace-api/media/v4l/vidioc-g-crop.rst      |  16 +-
 .../userspace-api/media/v4l/vidioc-g-ctrl.rst      |  16 +-
 .../media/v4l/vidioc-g-dv-timings.rst              |  26 +-
 .../userspace-api/media/v4l/vidioc-g-edid.rst      |  25 +-
 .../userspace-api/media/v4l/vidioc-g-enc-index.rst |  13 +-
 .../userspace-api/media/v4l/vidioc-g-ext-ctrls.rst |  21 +-
 .../userspace-api/media/v4l/vidioc-g-fbuf.rst      |  18 +-
 .../userspace-api/media/v4l/vidioc-g-fmt.rst       |  22 +-
 .../userspace-api/media/v4l/vidioc-g-frequency.rst |  16 +-
 .../userspace-api/media/v4l/vidioc-g-input.rst     |  15 +-
 .../userspace-api/media/v4l/vidioc-g-jpegcomp.rst  |  17 +-
 .../userspace-api/media/v4l/vidioc-g-modulator.rst |  17 +-
 .../userspace-api/media/v4l/vidioc-g-output.rst    |  15 +-
 .../userspace-api/media/v4l/vidioc-g-parm.rst      |  30 +-
 .../userspace-api/media/v4l/vidioc-g-priority.rst  |  16 +-
 .../userspace-api/media/v4l/vidioc-g-selection.rst |  15 +-
 .../media/v4l/vidioc-g-sliced-vbi-cap.rst          |  12 +-
 .../userspace-api/media/v4l/vidioc-g-std.rst       |  24 +-
 .../userspace-api/media/v4l/vidioc-g-tuner.rst     |  19 +-
 .../userspace-api/media/v4l/vidioc-log-status.rst  |  10 +-
 .../userspace-api/media/v4l/vidioc-overlay.rst     |  10 +-
 .../userspace-api/media/v4l/vidioc-prepare-buf.rst |  10 +-
 .../userspace-api/media/v4l/vidioc-qbuf.rst        |  17 +-
 .../media/v4l/vidioc-query-dv-timings.rst          |  15 +-
 .../userspace-api/media/v4l/vidioc-querybuf.rst    |  10 +-
 .../userspace-api/media/v4l/vidioc-querycap.rst    |  16 +-
 .../userspace-api/media/v4l/vidioc-queryctrl.rst   |  22 +-
 .../userspace-api/media/v4l/vidioc-querystd.rst    |  15 +-
 .../userspace-api/media/v4l/vidioc-reqbufs.rst     |  10 +-
 .../media/v4l/vidioc-s-hw-freq-seek.rst            |  11 +-
 .../userspace-api/media/v4l/vidioc-streamon.rst    |  14 +-
 .../v4l/vidioc-subdev-enum-frame-interval.rst      |  10 +-
 .../media/v4l/vidioc-subdev-enum-frame-size.rst    |  11 +-
 .../media/v4l/vidioc-subdev-enum-mbus-code.rst     |  10 +-
 .../media/v4l/vidioc-subdev-g-crop.rst             |  16 +-
 .../media/v4l/vidioc-subdev-g-fmt.rst              |  17 +-
 .../media/v4l/vidioc-subdev-g-frame-interval.rst   |  16 +-
 .../media/v4l/vidioc-subdev-g-selection.rst        |  17 +-
 .../media/v4l/vidioc-subdev-querycap.rst           |   9 +-
 .../media/v4l/vidioc-subscribe-event.rst           |  17 +-
 .../virt/uml/user_mode_linux_howto_v2.rst          |   1 +
 Documentation/vm/hmm.rst                           |   2 +-
 Documentation/vm/ksm.rst                           |   2 +-
 Documentation/vm/memory-model.rst                  |   6 +-
 MAINTAINERS                                        |  16 +-
 block/bio.c                                        |   4 +-
 drivers/base/core.c                                |   7 +-
 drivers/net/appletalk/Kconfig                      |   2 +-
 drivers/net/hamradio/scc.c                         |   2 +-
 include/kunit/test.h                               |  14 +-
 include/linux/devfreq.h                            |   7 +-
 include/linux/input/sparse-keymap.h                |   1 +
 include/linux/math64.h                             |   8 +-
 include/linux/usb/typec_altmode.h                  |  16 ++
 include/net/cfg80211.h                             |   1 +
 kernel/rcu/tree.c                                  |  14 +-
 kernel/workqueue.c                                 |   3 +
 mm/ksm.c                                           |   2 +-
 mm/memblock.c                                      |   8 +-
 scripts/kernel-doc                                 | 305 +++++++++++++++--=
----
 309 files changed, 1952 insertions(+), 2275 deletions(-)
 delete mode 100644 Documentation/driver-api/sound.rst

