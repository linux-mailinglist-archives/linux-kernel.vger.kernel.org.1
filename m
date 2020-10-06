Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A14284CEA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJFOEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgJFOD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:03:58 -0400
Received: from mail.kernel.org (ip5f5ad5bd.dynamic.kabel-deutschland.de [95.90.213.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CA28221EA;
        Tue,  6 Oct 2020 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601993035;
        bh=nZsxA2i77xzKYGtRBt8K0A9hamED4cCKJZPn3sXJhUM=;
        h=From:To:Cc:Subject:Date:From;
        b=DQLkzOcVTiu2UU5z7pVtJAlGtcdZJHEcgP3urBNfVNMB3NAVe2uP2ROtJNzBJhEkk
         aLqUaU+VobMj+cu3GA/EFNT7HzDPq4FakIb38+LppT1uUxSaLtEUv8wB1ZhDvH/jaZ
         mJMyZnVU+keikxcG6HYCwZHszy4wi4U96Pn6O4A0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kPnZG-0019EW-WF; Tue, 06 Oct 2020 16:03:51 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexander Aring <alex.aring@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jakub Kicinski <kuba@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Jason Wessel <jason.wessel@windriver.com>,
        Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Sean Young <sean@mess.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v5 00/52] Fix html build with Sphinx  3.1 and above
Date:   Tue,  6 Oct 2020 16:02:57 +0200
Message-Id: <cover.1601992016.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add proper support for Sphinx 3.1 and above for building the html docs.

This version is the same as the one previously submitted, with the following
differences:

- It is rebased on the top of next-2021006 + my Sphinx 2.x warning fix series;
- One patch from v4 was already merged;
- There is a new patch adding "--sphinx-ver" to the scripts,  as requested at
  v4 review;
- Added acked-by/reviewed by that was got during v4 review.

The full series of htmldocs warn fixes is available at:

	https://git.linuxtv.org/mchehab/experimental.git/log/?h=sphinx3-fixes-v5

After the series, there's just one warning with Sphinx 2.x:
	https://lore.kernel.org/lkml/20201006151915.77d044a4@coco.lan/T/#u

With Sphinx 3, there are 6 additional warnings - all like this one:
	WARNING: Duplicate C declaration, also defined in 'driver-api/usb/usb'.

They're because there's a function with the same name of a struct or enum.

Btw, while Sphinx < 3 doesn't report such issue, this actually causes cross-references
to those symbols to be broken. 

There is an opened Sphinx issue, asking for a fix on some Sphinx future version.

Mauro Carvalho Chehab (52):
  docs: cdomain.py: add support for a new Sphinx 3.1+ tag
  docs: cdomain.py: extend it to handle new Sphinx 3.x tags
  docs: conf.py: disable automarkup for Sphinx 3.x
  scripts: kernel-doc: make it more compatible with Sphinx 3.x
  scripts: kernel-doc: use a less pedantic markup for funcs on Sphinx
    3.x
  scripts: kernel-doc: fix troubles with line counts
  scripts: kernel-doc: reimplement -nofunction argument
  scripts: kernel-doc: fix typedef identification
  scripts: kernel-doc: don't mangle with parameter list
  scripts: kernel-doc: allow passing desired Sphinx C domain dialect
  docs: kerneldoc.py: append the name of the parsed doc file
  docs: kerneldoc.py: add support for kerneldoc -nosymbol
  media: docs: make CEC documents compatible with Sphinx 3.1+
  media: docs: make V4L documents more compatible with Sphinx 3.1+
  media: docs: make DVB documents more compatible with Sphinx 3.1+
  media: docs: make MC documents more compatible with Sphinx 3.1+
  media: docs: make RC documents more compatible with Sphinx 3.1+
  media: cec-core.rst: don't use c:type for structs
  math64.h: kernel-docs: Convert some markups into normal comments
  memblock: get rid of a :c:type leftover
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
  docs: net: statistics.rst: remove a duplicated kernel-doc
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
  workqueue: fix a kernel-doc warning
  scripts: kernel-doc: try to use c:function if possible
  docs: conf.py: fix c:function support with Sphinx 3.x
  docs: conf.py: change the Sphinx 3.x+ text

 Documentation/admin-guide/pm/cpufreq.rst      |  11 +-
 Documentation/admin-guide/pstore-blk.rst      |  10 +-
 Documentation/block/blk-mq.rst                |  12 +-
 Documentation/block/inline-encryption.rst     |   8 +-
 Documentation/conf.py                         |  68 ++++-
 Documentation/core-api/genericirq.rst         |   2 +
 Documentation/core-api/kernel-api.rst         |   6 -
 Documentation/core-api/workqueue.rst          |   2 +
 Documentation/dev-tools/kgdb.rst              |   6 +-
 Documentation/doc-guide/kernel-doc.rst        |   8 +
 Documentation/driver-api/basics.rst           |  19 +-
 Documentation/driver-api/device_link.rst      |  13 +-
 Documentation/driver-api/fpga/fpga-bridge.rst |   4 +-
 Documentation/driver-api/fpga/fpga-mgr.rst    |   6 +-
 .../driver-api/fpga/fpga-programming.rst      |   2 +-
 Documentation/driver-api/fpga/fpga-region.rst |   6 +-
 Documentation/driver-api/iio/buffers.rst      |   2 +-
 Documentation/driver-api/iio/core.rst         |   6 +-
 Documentation/driver-api/iio/hw-consumer.rst  |   2 +-
 .../driver-api/iio/triggered-buffers.rst      |   2 +-
 Documentation/driver-api/iio/triggers.rst     |   4 +-
 Documentation/driver-api/index.rst            |   1 -
 Documentation/driver-api/infrastructure.rst   |   3 -
 Documentation/driver-api/libata.rst           |   2 +-
 Documentation/driver-api/media/cec-core.rst   |   2 +-
 .../driver-api/media/dtv-frontend.rst         |   4 +-
 Documentation/driver-api/media/mc-core.rst    |  24 +-
 .../driver-api/media/v4l2-controls.rst        |   2 +-
 Documentation/driver-api/media/v4l2-dev.rst   |   8 +-
 .../driver-api/media/v4l2-device.rst          |   6 +-
 Documentation/driver-api/media/v4l2-event.rst |  10 +-
 Documentation/driver-api/media/v4l2-fh.rst    |  16 +-
 .../driver-api/media/v4l2-subdev.rst          |   2 +-
 Documentation/driver-api/mei/mei.rst          |   2 +-
 Documentation/driver-api/pm/cpuidle.rst       |  65 ++---
 Documentation/driver-api/pm/devices.rst       |  26 +-
 Documentation/driver-api/regulator.rst        |   4 +-
 Documentation/driver-api/sound.rst            |  54 ----
 Documentation/driver-api/target.rst           |  12 -
 Documentation/driver-api/usb/URB.rst          |   2 +-
 Documentation/driver-api/usb/gadget.rst       |  10 +-
 Documentation/driver-api/usb/hotplug.rst      |   2 +-
 Documentation/filesystems/fscrypt.rst         |  61 ++--
 Documentation/filesystems/fsverity.rst        |   2 +-
 Documentation/gpu/i915.rst                    |  29 +-
 Documentation/networking/ieee802154.rst       |  18 +-
 Documentation/networking/statistics.rst       |   3 +-
 Documentation/sound/designs/tracepoints.rst   |  22 +-
 .../sound/kernel-api/alsa-driver-api.rst      |   1 +
 .../kernel-api/writing-an-alsa-driver.rst     | 110 ++++---
 Documentation/sphinx/cdomain.py               |  93 +++++-
 Documentation/sphinx/kerneldoc.py             |  15 +-
 Documentation/sphinx/parse-headers.pl         |   2 +-
 Documentation/trace/ftrace-uses.rst           |  12 +-
 .../it_IT/kernel-hacking/hacking.rst          |   2 +-
 .../it_IT/kernel-hacking/locking.rst          |   2 +
 .../media/cec/cec-func-close.rst              |  10 +-
 .../media/cec/cec-func-ioctl.rst              |  11 +-
 .../userspace-api/media/cec/cec-func-open.rst |  10 +-
 .../userspace-api/media/cec/cec-func-poll.rst |  14 +-
 .../media/cec/cec-ioc-adap-g-caps.rst         |  10 +-
 .../media/cec/cec-ioc-adap-g-conn-info.rst    |  11 +-
 .../media/cec/cec-ioc-adap-g-log-addrs.rst    |  20 +-
 .../media/cec/cec-ioc-adap-g-phys-addr.rst    |  15 +-
 .../media/cec/cec-ioc-dqevent.rst             |  15 +-
 .../media/cec/cec-ioc-g-mode.rst              |  16 +-
 .../media/cec/cec-ioc-receive.rst             |  18 +-
 .../dvb/audio-bilingual-channel-select.rst    |   7 +-
 .../media/dvb/audio-channel-select.rst        |   8 +-
 .../media/dvb/audio-clear-buffer.rst          |   8 +-
 .../media/dvb/audio-continue.rst              |   7 +-
 .../userspace-api/media/dvb/audio-fclose.rst  |   7 +-
 .../userspace-api/media/dvb/audio-fopen.rst   |   7 +-
 .../userspace-api/media/dvb/audio-fwrite.rst  |   7 +-
 .../media/dvb/audio-get-capabilities.rst      |   8 +-
 .../media/dvb/audio-get-status.rst            |   8 +-
 .../userspace-api/media/dvb/audio-pause.rst   |   9 +-
 .../userspace-api/media/dvb/audio-play.rst    |   7 +-
 .../media/dvb/audio-select-source.rst         |   8 +-
 .../media/dvb/audio-set-av-sync.rst           |   8 +-
 .../media/dvb/audio-set-bypass-mode.rst       |   9 +-
 .../userspace-api/media/dvb/audio-set-id.rst  |   9 +-
 .../media/dvb/audio-set-mixer.rst             |   9 +-
 .../media/dvb/audio-set-mute.rst              |   8 +-
 .../media/dvb/audio-set-streamtype.rst        |  10 +-
 .../userspace-api/media/dvb/audio-stop.rst    |   9 +-
 .../userspace-api/media/dvb/ca-fclose.rst     |   7 +-
 .../userspace-api/media/dvb/ca-fopen.rst      |   7 +-
 .../userspace-api/media/dvb/ca-get-cap.rst    |   8 +-
 .../media/dvb/ca-get-descr-info.rst           |   9 +-
 .../userspace-api/media/dvb/ca-get-msg.rst    |  10 +-
 .../media/dvb/ca-get-slot-info.rst            |   9 +-
 .../userspace-api/media/dvb/ca-reset.rst      |   9 +-
 .../userspace-api/media/dvb/ca-send-msg.rst   |   9 +-
 .../userspace-api/media/dvb/ca-set-descr.rst  |   8 +-
 .../userspace-api/media/dvb/dmx-add-pid.rst   |  10 +-
 .../userspace-api/media/dvb/dmx-expbuf.rst    |  11 +-
 .../userspace-api/media/dvb/dmx-fclose.rst    |   9 +-
 .../userspace-api/media/dvb/dmx-fopen.rst     |   5 +-
 .../userspace-api/media/dvb/dmx-fread.rst     |   7 +-
 .../userspace-api/media/dvb/dmx-fwrite.rst    |   6 +-
 .../media/dvb/dmx-get-pes-pids.rst            |  12 +-
 .../userspace-api/media/dvb/dmx-get-stc.rst   |  12 +-
 .../userspace-api/media/dvb/dmx-mmap.rst      |  15 +-
 .../userspace-api/media/dvb/dmx-munmap.rst    |  14 +-
 .../userspace-api/media/dvb/dmx-qbuf.rst      |  17 +-
 .../userspace-api/media/dvb/dmx-querybuf.rst  |   9 +-
 .../media/dvb/dmx-remove-pid.rst              |  10 +-
 .../userspace-api/media/dvb/dmx-reqbufs.rst   |   9 +-
 .../media/dvb/dmx-set-buffer-size.rst         |  10 +-
 .../media/dvb/dmx-set-filter.rst              |  12 +-
 .../media/dvb/dmx-set-pes-filter.rst          |  13 +-
 .../userspace-api/media/dvb/dmx-start.rst     |  11 +-
 .../userspace-api/media/dvb/dmx-stop.rst      |   9 +-
 .../media/dvb/fe-diseqc-recv-slave-reply.rst  |   9 +-
 .../media/dvb/fe-diseqc-reset-overload.rst    |   9 +-
 .../media/dvb/fe-diseqc-send-burst.rst        |  10 +-
 .../media/dvb/fe-diseqc-send-master-cmd.rst   |   9 +-
 .../dvb/fe-dishnetwork-send-legacy-cmd.rst    |  10 +-
 .../media/dvb/fe-enable-high-lnb-voltage.rst  |  10 +-
 .../userspace-api/media/dvb/fe-get-event.rst  |  12 +-
 .../media/dvb/fe-get-frontend.rst             |  12 +-
 .../userspace-api/media/dvb/fe-get-info.rst   |  11 +-
 .../media/dvb/fe-get-property.rst             |  15 +-
 .../userspace-api/media/dvb/fe-read-ber.rst   |   9 +-
 .../media/dvb/fe-read-signal-strength.rst     |   9 +-
 .../userspace-api/media/dvb/fe-read-snr.rst   |   9 +-
 .../media/dvb/fe-read-status.rst              |  11 +-
 .../media/dvb/fe-read-uncorrected-blocks.rst  |   9 +-
 .../media/dvb/fe-set-frontend-tune-mode.rst   |  10 +-
 .../media/dvb/fe-set-frontend.rst             |  11 +-
 .../userspace-api/media/dvb/fe-set-tone.rst   |  10 +-
 .../media/dvb/fe-set-voltage.rst              |  10 +-
 .../media/dvb/frontend_f_close.rst            |   8 +-
 .../media/dvb/frontend_f_open.rst             |  10 +-
 .../userspace-api/media/dvb/net-add-if.rst    |   9 +-
 .../userspace-api/media/dvb/net-get-if.rst    |  10 +-
 .../userspace-api/media/dvb/net-remove-if.rst |  10 +-
 .../media/dvb/video-clear-buffer.rst          |   8 +-
 .../userspace-api/media/dvb/video-command.rst |  10 +-
 .../media/dvb/video-continue.rst              |   8 +-
 .../media/dvb/video-fast-forward.rst          |  10 +-
 .../userspace-api/media/dvb/video-fclose.rst  |   6 +-
 .../userspace-api/media/dvb/video-fopen.rst   |   6 +-
 .../userspace-api/media/dvb/video-freeze.rst  |   8 +-
 .../userspace-api/media/dvb/video-fwrite.rst  |   6 +-
 .../media/dvb/video-get-capabilities.rst      |   8 +-
 .../media/dvb/video-get-event.rst             |   8 +-
 .../media/dvb/video-get-frame-count.rst       |   8 +-
 .../userspace-api/media/dvb/video-get-pts.rst |   8 +-
 .../media/dvb/video-get-size.rst              |   8 +-
 .../media/dvb/video-get-status.rst            |   7 +-
 .../userspace-api/media/dvb/video-play.rst    |   8 +-
 .../media/dvb/video-select-source.rst         |   7 +-
 .../media/dvb/video-set-blank.rst             |   8 +-
 .../media/dvb/video-set-display-format.rst    |   8 +-
 .../media/dvb/video-set-format.rst            |   9 +-
 .../media/dvb/video-set-streamtype.rst        |   8 +-
 .../media/dvb/video-slowmotion.rst            |  10 +-
 .../media/dvb/video-stillpicture.rst          |   8 +-
 .../userspace-api/media/dvb/video-stop.rst    |   8 +-
 .../media/dvb/video-try-command.rst           |   8 +-
 .../media/mediactl/media-func-close.rst       |  10 +-
 .../media/mediactl/media-func-ioctl.rst       |  10 +-
 .../media/mediactl/media-func-open.rst        |  10 +-
 .../media/mediactl/media-ioc-device-info.rst  |  13 +-
 .../mediactl/media-ioc-enum-entities.rst      |  11 +-
 .../media/mediactl/media-ioc-enum-links.rst   |  13 +-
 .../media/mediactl/media-ioc-g-topology.rst   |  14 +-
 .../mediactl/media-ioc-request-alloc.rst      |  11 +-
 .../media/mediactl/media-ioc-setup-link.rst   |  10 +-
 .../mediactl/media-request-ioc-queue.rst      |   7 +-
 .../mediactl/media-request-ioc-reinit.rst     |   8 +-
 .../media/mediactl/request-api.rst            |   5 +-
 .../media/mediactl/request-func-close.rst     |   8 +-
 .../media/mediactl/request-func-ioctl.rst     |   8 +-
 .../media/mediactl/request-func-poll.rst      |  12 +-
 .../media/rc/lirc-get-features.rst            |   9 +-
 .../media/rc/lirc-get-rec-mode.rst            |  12 +-
 .../media/rc/lirc-get-rec-resolution.rst      |   8 +-
 .../media/rc/lirc-get-send-mode.rst           |  14 +-
 .../media/rc/lirc-get-timeout.rst             |  13 +-
 .../userspace-api/media/rc/lirc-read.rst      |  10 +-
 .../rc/lirc-set-measure-carrier-mode.rst      |   8 +-
 .../media/rc/lirc-set-rec-carrier-range.rst   |   6 +-
 .../media/rc/lirc-set-rec-carrier.rst         |   8 +-
 .../media/rc/lirc-set-rec-timeout-reports.rst |   8 +-
 .../media/rc/lirc-set-rec-timeout.rst         |  13 +-
 .../media/rc/lirc-set-send-carrier.rst        |   8 +-
 .../media/rc/lirc-set-send-duty-cycle.rst     |   8 +-
 .../media/rc/lirc-set-transmitter-mask.rst    |   8 +-
 .../media/rc/lirc-set-wideband-receiver.rst   |   8 +-
 .../userspace-api/media/rc/lirc-write.rst     |   7 +-
 .../userspace-api/media/v4l/buffer.rst        |  14 +-
 .../userspace-api/media/v4l/dev-capture.rst   |   7 +-
 .../userspace-api/media/v4l/dev-output.rst    |   7 +-
 .../userspace-api/media/v4l/dev-raw-vbi.rst   |  19 +-
 .../userspace-api/media/v4l/dev-rds.rst       |  12 +-
 .../media/v4l/dev-sliced-vbi.rst              |  31 +-
 .../userspace-api/media/v4l/diff-v4l.rst      |  39 +--
 .../userspace-api/media/v4l/dmabuf.rst        |   8 +-
 .../userspace-api/media/v4l/format.rst        |   7 +-
 .../userspace-api/media/v4l/func-close.rst    |   8 +-
 .../userspace-api/media/v4l/func-ioctl.rst    |  10 +-
 .../userspace-api/media/v4l/func-mmap.rst     |  18 +-
 .../userspace-api/media/v4l/func-munmap.rst   |  14 +-
 .../userspace-api/media/v4l/func-open.rst     |  14 +-
 .../userspace-api/media/v4l/func-poll.rst     |  40 ++-
 .../userspace-api/media/v4l/func-read.rst     |  39 ++-
 .../userspace-api/media/v4l/func-select.rst   |  42 ++-
 .../userspace-api/media/v4l/func-write.rst    |  13 +-
 .../userspace-api/media/v4l/hist-v4l2.rst     |  70 +----
 Documentation/userspace-api/media/v4l/io.rst  |   6 +-
 .../media/v4l/libv4l-introduction.rst         |  30 +-
 .../userspace-api/media/v4l/mmap.rst          |  26 +-
 .../userspace-api/media/v4l/open.rst          |  15 +-
 Documentation/userspace-api/media/v4l/rw.rst  |  18 +-
 .../userspace-api/media/v4l/streaming-par.rst |   5 +-
 .../userspace-api/media/v4l/userp.rst         |  11 +-
 .../media/v4l/vidioc-create-bufs.rst          |  11 +-
 .../media/v4l/vidioc-cropcap.rst              |  11 +-
 .../media/v4l/vidioc-dbg-g-chip-info.rst      |  13 +-
 .../media/v4l/vidioc-dbg-g-register.rst       |  18 +-
 .../media/v4l/vidioc-decoder-cmd.rst          |  19 +-
 .../media/v4l/vidioc-dqevent.rst              |  19 +-
 .../media/v4l/vidioc-dv-timings-cap.rst       |  17 +-
 .../media/v4l/vidioc-encoder-cmd.rst          |  25 +-
 .../media/v4l/vidioc-enum-dv-timings.rst      |  16 +-
 .../media/v4l/vidioc-enum-fmt.rst             |  12 +-
 .../media/v4l/vidioc-enum-frameintervals.rst  |  15 +-
 .../media/v4l/vidioc-enum-framesizes.rst      |  16 +-
 .../media/v4l/vidioc-enum-freq-bands.rst      |  12 +-
 .../media/v4l/vidioc-enumaudio.rst            |  10 +-
 .../media/v4l/vidioc-enumaudioout.rst         |  10 +-
 .../media/v4l/vidioc-enuminput.rst            |  14 +-
 .../media/v4l/vidioc-enumoutput.rst           |  13 +-
 .../media/v4l/vidioc-enumstd.rst              |  23 +-
 .../userspace-api/media/v4l/vidioc-expbuf.rst |  14 +-
 .../media/v4l/vidioc-g-audio.rst              |  18 +-
 .../media/v4l/vidioc-g-audioout.rst           |  16 +-
 .../userspace-api/media/v4l/vidioc-g-crop.rst |  16 +-
 .../userspace-api/media/v4l/vidioc-g-ctrl.rst |  16 +-
 .../media/v4l/vidioc-g-dv-timings.rst         |  26 +-
 .../userspace-api/media/v4l/vidioc-g-edid.rst |  25 +-
 .../media/v4l/vidioc-g-enc-index.rst          |  13 +-
 .../media/v4l/vidioc-g-ext-ctrls.rst          |  21 +-
 .../userspace-api/media/v4l/vidioc-g-fbuf.rst |  18 +-
 .../userspace-api/media/v4l/vidioc-g-fmt.rst  |  22 +-
 .../media/v4l/vidioc-g-frequency.rst          |  16 +-
 .../media/v4l/vidioc-g-input.rst              |  15 +-
 .../media/v4l/vidioc-g-jpegcomp.rst           |  17 +-
 .../media/v4l/vidioc-g-modulator.rst          |  17 +-
 .../media/v4l/vidioc-g-output.rst             |  15 +-
 .../userspace-api/media/v4l/vidioc-g-parm.rst |  30 +-
 .../media/v4l/vidioc-g-priority.rst           |  16 +-
 .../media/v4l/vidioc-g-selection.rst          |  15 +-
 .../media/v4l/vidioc-g-sliced-vbi-cap.rst     |  12 +-
 .../userspace-api/media/v4l/vidioc-g-std.rst  |  24 +-
 .../media/v4l/vidioc-g-tuner.rst              |  19 +-
 .../media/v4l/vidioc-log-status.rst           |  10 +-
 .../media/v4l/vidioc-overlay.rst              |  10 +-
 .../media/v4l/vidioc-prepare-buf.rst          |  10 +-
 .../userspace-api/media/v4l/vidioc-qbuf.rst   |  17 +-
 .../media/v4l/vidioc-query-dv-timings.rst     |  15 +-
 .../media/v4l/vidioc-querybuf.rst             |  10 +-
 .../media/v4l/vidioc-querycap.rst             |  16 +-
 .../media/v4l/vidioc-queryctrl.rst            |  22 +-
 .../media/v4l/vidioc-querystd.rst             |  15 +-
 .../media/v4l/vidioc-reqbufs.rst              |  10 +-
 .../media/v4l/vidioc-s-hw-freq-seek.rst       |  11 +-
 .../media/v4l/vidioc-streamon.rst             |  14 +-
 .../v4l/vidioc-subdev-enum-frame-interval.rst |  10 +-
 .../v4l/vidioc-subdev-enum-frame-size.rst     |  11 +-
 .../v4l/vidioc-subdev-enum-mbus-code.rst      |  10 +-
 .../media/v4l/vidioc-subdev-g-crop.rst        |  16 +-
 .../media/v4l/vidioc-subdev-g-fmt.rst         |  17 +-
 .../v4l/vidioc-subdev-g-frame-interval.rst    |  16 +-
 .../media/v4l/vidioc-subdev-g-selection.rst   |  17 +-
 .../media/v4l/vidioc-subdev-querycap.rst      |   9 +-
 .../media/v4l/vidioc-subscribe-event.rst      |  17 +-
 Documentation/vm/ksm.rst                      |   2 +-
 Documentation/vm/memory-model.rst             |   6 +-
 include/linux/math64.h                        |   8 +-
 kernel/workqueue.c                            |   3 +
 mm/ksm.c                                      |   2 +-
 mm/memblock.c                                 |   8 +-
 scripts/kernel-doc                            | 275 +++++++++++++-----
 287 files changed, 1742 insertions(+), 2182 deletions(-)
 delete mode 100644 Documentation/driver-api/sound.rst

-- 
2.26.2


