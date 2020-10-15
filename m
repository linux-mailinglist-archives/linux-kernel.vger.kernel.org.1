Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E4228F61E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389826AbgJOPtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389816AbgJOPtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:49:40 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CB4C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 08:49:39 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id l18so818554ooa.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 08:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FjO4vSCHKe1q1cfco6cbt4rcEvxJmCkzXFBf5iwxYjM=;
        b=Z2jf/ID8Gbxv9zBI+wl5d2483T6jM4XdDQKeXXnt7wQzoo1woC1myXGg8072Nbs4hU
         79jmU8DHW4mGT22IhKn1HGyYMkzQBrq89w4XJZ/hf9tO7/pTcSulZS9eraxLAywVtIVD
         2o68B0j7Gla6AMKEiWCA3/Qicv4aqeQxJnZU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FjO4vSCHKe1q1cfco6cbt4rcEvxJmCkzXFBf5iwxYjM=;
        b=qFJT7dQ2dSVM3/XyzszQBTEwzHurVIZMDduKLoPFc98XTjRpmw6AfdDewCxcAU0/oz
         KDJGJPcQSR8u4G7pG9ZIbedJjqsjhMVLsi1218IUiq350v3ndvBBFhQ0eO7TY1+fUp2I
         sGYIX37XUIAajaHx/y7sDsKtrW92ExV0EFy+7KodF61vIsy8UFCHjM5YqvcWUEPd36TX
         f7YiGYpRQTUoJfVDpM2Q9GTz+RW2VcqloTosFS++8LjRNkkOMNnrY+DmFKgrD1n0SwKf
         nh2OVt6qYVWPnyLdH9IbBUa/fChbePqyQ/4IyqjKq8yv7jkoSqQ4Ddpg84+rFLZsxqDF
         wrcQ==
X-Gm-Message-State: AOAM532GQ4jCs37PlOv38gPl1UiQ69R6DQ2TiUHlQSZ4BFy9Bz8kvzqA
        DmpXDTn3tmbS8Dl/DZa/qL/rTy+lykS8N0PAHdrtLg==
X-Google-Smtp-Source: ABdhPJxo+3Cpx1dVX7s7w7p9YJD+4S7A7ysyDNH3caWpM2QtO4jnK0h4WmvBOQpjDdU3U1Bcybw/i2fv8rza57iQ/wM=
X-Received: by 2002:a4a:e1d7:: with SMTP id n23mr2854432oot.85.1602776974060;
 Thu, 15 Oct 2020 08:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 15 Oct 2020 17:49:23 +0200
Message-ID: <CAKMK7uH1uh+cO2=5ojtBhNYQmsrNOcM1qM8rsoHFaifx6v3dYA@mail.gmail.com>
Subject: Re: [PATCH v6 00/80] htmldoc build fixes with Sphinx 2.x and 3.x
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexander Aring <alex.aring@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Gross <agross@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Benson Leung <bleung@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Colin Cross <ccross@android.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Jason Wessel <jason.wessel@windriver.com>,
        Jeff Dike <jdike@addtoit.com>, Jens Axboe <axboe@kernel.dk>,
        Joerg Reuter <jreuter@yaina.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jyri Sarha <jsarha@ti.com>, Kees Cook <keescook@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Sean Young <sean@mess.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Tejun Heo <tj@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 01:53:15PM +0200, Mauro Carvalho Chehab wrote:
> This series actually folds the previous Sphinx 3.x patch series
> with the other patches I sent fixing warnings with Sphinx
> 2.x and with kernel-doc and that weren't merged yet via
> some other tree.
>
> It is based on the top of upstream, plus the media
> pull request I sent yesterday:
>
>       https://lore.kernel.org/lkml/20201012134139.0d58f5d7@coco.lan/
>
> My plan is to send a pull request with those patches after Thursday's
> linux next release.
>
> On this series, I removed the patches that depend on material
> currently found only at linux-next.

Was a bit tricky to find the cover letter here and that you plan to
send these out this merge window. I think we'll have some confusion
now with Alex from amd having picked up a few already.

Anyway Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch> for the
remaining drm patches. Although I can also pick them up to
drm-misc-next (but that's going to be 5.11 or so).
-Daniel


>
> Mauro Carvalho Chehab (79):
>   scripts: kernel-doc: add support for typedef enum
>   scripts: kernel-doc: make it more compatible with Sphinx 3.x
>   scripts: kernel-doc: use a less pedantic markup for funcs on Sphinx
>     3.x
>   scripts: kernel-doc: fix troubles with line counts
>   scripts: kernel-doc: reimplement -nofunction argument
>   scripts: kernel-doc: fix typedef identification
>   scripts: kernel-doc: don't mangle with parameter list
>   scripts: kernel-doc: allow passing desired Sphinx C domain dialect
>   scripts: kernel-doc: fix line number handling
>   scripts: kernel-doc: try to use c:function if possible
>   docs: cdomain.py: add support for a new Sphinx 3.1+ tag
>   docs: cdomain.py: extend it to handle new Sphinx 3.x tags
>   docs: kerneldoc.py: append the name of the parsed doc file
>   docs: kerneldoc.py: add support for kerneldoc -nosymbol
>   media: docs: make CEC documents compatible with Sphinx 3.1+
>   media: docs: make V4L documents more compatible with Sphinx 3.1+
>   media: docs: make DVB documents more compatible with Sphinx 3.1+
>   media: docs: make MC documents more compatible with Sphinx 3.1+
>   media: docs: make RC documents more compatible with Sphinx 3.1+
>   media: cec-core.rst: don't use c:type for structs
>   docs: remove some replace macros like |struct foo|
>   docs: get rid of :c:type explicit declarations for structs
>   docs: trace-uses.rst: remove bogus c-domain tags
>   docs: it_IT: fix namespace collisions at locking.rst
>   docs: net: ieee802154.rst: fix C expressions
>   docs: genericirq.rst: don't document chip.c functions twice
>   docs: kernel-api.rst: drop kernel/irq/manage.c kernel-doc tag
>   docs: remove sound API duplication
>   docs: basics.rst: move kernel-doc workqueue markups to workqueue.rst
>   docs: scsi: target.rst: remove iSCSI transport class kernel-doc markup
>   docs: device_link.rst: remove duplicated kernel-doc include
>   docs: basics.rst: get rid of rcu kernel-doc macros
>   docs: pstore-blk.rst: fix kernel-doc tags
>   docs: fs: fscrypt.rst: get rid of :c:type: tags
>   docs: devices.rst: get rid of :c:type macros
>   docs: sound: writing-an-alsa-driver.rst: get rid of :c:type
>   docs: block: blk-mq.rst: get rid of :c:type
>   docs: writing-an-alsa-driver.rst: fix some bad c:func: markups
>   docs: fpga: replace :c:member: macros
>   docs: kgdb.rst: fix :c:type: usages
>   docs: libata.rst: fix a wrong usage of :c:type: tag
>   docs: infrastructure.rst: don't include firmware kernel-doc
>   docs: gpu: i915.rst: Fix several C duplication warnings
>   docs: devices.rst: fix a C reference markup
>   docs: it_IT: hacking.rst: fix a typo on a markup
>   docs: mei.rst: fix a C expression markup
>   docs: basics.rst: avoid duplicated C function declaration
>   docs: conf.py: fix c:function support with Sphinx 3.x
>   docs: conf.py: change the Sphinx 3.x+ text
>   docs: infrastructure.rst: exclude device_link_state from device.h
>   docs: zh_CN: amu.rst: fix document title markup
>   media: uAPI: buffer.rst: remove a left-over documentation
>   math64.h: kernel-docs: Convert some markups into normal comments
>   memblock: get rid of a :c:type leftover
>   dt-bindings: fix references to files converted to yaml
>   net: appletalk: Kconfig: Fix docs location
>   drivers: net: hamradio: fix document location
>   docs: powerpc: syscall64-abi.rst: fix a malformed table
>   block: bio: fix a warning at the kernel-doc markups
>   kunit: test.h: solve kernel-doc warnings
>   docs: bio: fix a kerneldoc markup
>   drivers: core: fix kernel-doc markup for dev_err_probe()
>   kunit: test.h: fix a bad kernel-doc markup
>   docs: amdgpu: fix a warning when building the documentation
>   locking/refcount: document the new "oldp" pointer value
>   usb: docs: document altmode register/unregister functions
>   nl80211: docs: add a description for s1g_cap parameter
>   IB/srpt: docs: add a description for cq_size member
>   rcu/tree: docs: document bkvcache new members at struct kfree_rcu_cpu
>   Input: sparse-keymap: add a description for @sw
>   drm/amd/display: kernel-doc: document force_timing_sync
>   drm: kernel-doc: drm_dp_helper.h: fix a typo
>   gpu: docs: amdgpu.rst: get rid of wrong kernel-doc markups
>   drm: kernel-doc: add description for a new function parameter
>   docs: virt: user_mode_linux_howto_v2.rst: fix a literal block markup
>   workqueue: fix a kernel-doc warning
>   mm/doc: fix a literal block markup
>   drm: drm_edid: remove a duplicated kernel-doc declaration
>   PM / devfreq: remove a duplicated kernel-doc markup
>
> N=C3=ADcolas F. R. A. Prado (1):
>   docs: automarkup.py: make it ready for Sphinx 3.1+
>
>  Documentation/admin-guide/pm/cpufreq.rst      |  11 +-
>  Documentation/admin-guide/pstore-blk.rst      |  10 +-
>  Documentation/block/blk-mq.rst                |  12 +-
>  Documentation/block/inline-encryption.rst     |   8 +-
>  Documentation/conf.py                         |  65 +++-
>  Documentation/core-api/genericirq.rst         |   2 +
>  Documentation/core-api/kernel-api.rst         |   6 -
>  Documentation/core-api/workqueue.rst          |   2 +
>  Documentation/dev-tools/kgdb.rst              |   6 +-
>  .../bindings/display/tilcdc/tilcdc.txt        |   2 +-
>  .../bindings/mailbox/omap-mailbox.txt         |   2 +-
>  .../devicetree/bindings/media/i2c/tvp5150.txt |   2 +-
>  .../bindings/pwm/google,cros-ec-pwm.yaml      |   2 +-
>  .../bindings/soc/qcom/qcom,smd-rpm.yaml       |   2 +-
>  .../bindings/sound/google,cros-ec-codec.yaml  |   2 +-
>  Documentation/doc-guide/kernel-doc.rst        |   8 +
>  Documentation/driver-api/basics.rst           |  19 +-
>  Documentation/driver-api/device_link.rst      |  13 +-
>  Documentation/driver-api/fpga/fpga-bridge.rst |   4 +-
>  Documentation/driver-api/fpga/fpga-mgr.rst    |   6 +-
>  .../driver-api/fpga/fpga-programming.rst      |   2 +-
>  Documentation/driver-api/fpga/fpga-region.rst |   6 +-
>  Documentation/driver-api/iio/buffers.rst      |   2 +-
>  Documentation/driver-api/iio/core.rst         |   6 +-
>  Documentation/driver-api/iio/hw-consumer.rst  |   2 +-
>  .../driver-api/iio/triggered-buffers.rst      |   2 +-
>  Documentation/driver-api/iio/triggers.rst     |   4 +-
>  Documentation/driver-api/index.rst            |   1 -
>  Documentation/driver-api/infrastructure.rst   |   4 +-
>  Documentation/driver-api/libata.rst           |   2 +-
>  Documentation/driver-api/media/cec-core.rst   |   2 +-
>  .../driver-api/media/dtv-frontend.rst         |   4 +-
>  Documentation/driver-api/media/mc-core.rst    |  24 +-
>  .../driver-api/media/v4l2-controls.rst        |   2 +-
>  Documentation/driver-api/media/v4l2-dev.rst   |   8 +-
>  .../driver-api/media/v4l2-device.rst          |   6 +-
>  Documentation/driver-api/media/v4l2-event.rst |  10 +-
>  Documentation/driver-api/media/v4l2-fh.rst    |  16 +-
>  .../driver-api/media/v4l2-subdev.rst          |   2 +-
>  Documentation/driver-api/mei/mei.rst          |   2 +-
>  Documentation/driver-api/pm/cpuidle.rst       |  65 ++--
>  Documentation/driver-api/pm/devices.rst       |  26 +-
>  Documentation/driver-api/regulator.rst        |   4 +-
>  Documentation/driver-api/sound.rst            |  54 ----
>  Documentation/driver-api/target.rst           |  12 -
>  Documentation/driver-api/usb/URB.rst          |   2 +-
>  Documentation/driver-api/usb/gadget.rst       |  10 +-
>  Documentation/driver-api/usb/hotplug.rst      |   2 +-
>  Documentation/driver-api/usb/typec_bus.rst    |   8 +-
>  Documentation/filesystems/fscrypt.rst         |  61 ++--
>  Documentation/filesystems/fsverity.rst        |   2 +-
>  Documentation/gpu/amdgpu.rst                  |  11 +-
>  Documentation/gpu/i915.rst                    |  29 +-
>  Documentation/networking/ieee802154.rst       |  18 +-
>  Documentation/powerpc/syscall64-abi.rst       |  32 +-
>  Documentation/sound/designs/tracepoints.rst   |  22 +-
>  .../sound/kernel-api/alsa-driver-api.rst      |   1 +
>  .../kernel-api/writing-an-alsa-driver.rst     | 110 +++----
>  Documentation/sphinx/automarkup.py            |  69 +++-
>  Documentation/sphinx/cdomain.py               |  93 +++++-
>  Documentation/sphinx/kerneldoc.py             |  15 +-
>  Documentation/sphinx/parse-headers.pl         |   2 +-
>  Documentation/trace/ftrace-uses.rst           |  12 +-
>  .../it_IT/kernel-hacking/hacking.rst          |   2 +-
>  .../it_IT/kernel-hacking/locking.rst          |   2 +
>  .../translations/zh_CN/arm64/amu.rst          |   4 +-
>  .../media/cec/cec-func-close.rst              |  10 +-
>  .../media/cec/cec-func-ioctl.rst              |  11 +-
>  .../userspace-api/media/cec/cec-func-open.rst |  10 +-
>  .../userspace-api/media/cec/cec-func-poll.rst |  14 +-
>  .../media/cec/cec-ioc-adap-g-caps.rst         |  10 +-
>  .../media/cec/cec-ioc-adap-g-conn-info.rst    |  11 +-
>  .../media/cec/cec-ioc-adap-g-log-addrs.rst    |  20 +-
>  .../media/cec/cec-ioc-adap-g-phys-addr.rst    |  15 +-
>  .../media/cec/cec-ioc-dqevent.rst             |  15 +-
>  .../media/cec/cec-ioc-g-mode.rst              |  16 +-
>  .../media/cec/cec-ioc-receive.rst             |  18 +-
>  .../dvb/audio-bilingual-channel-select.rst    |   7 +-
>  .../media/dvb/audio-channel-select.rst        |   8 +-
>  .../media/dvb/audio-clear-buffer.rst          |   8 +-
>  .../media/dvb/audio-continue.rst              |   7 +-
>  .../userspace-api/media/dvb/audio-fclose.rst  |   7 +-
>  .../userspace-api/media/dvb/audio-fopen.rst   |   7 +-
>  .../userspace-api/media/dvb/audio-fwrite.rst  |   7 +-
>  .../media/dvb/audio-get-capabilities.rst      |   8 +-
>  .../media/dvb/audio-get-status.rst            |   8 +-
>  .../userspace-api/media/dvb/audio-pause.rst   |   9 +-
>  .../userspace-api/media/dvb/audio-play.rst    |   7 +-
>  .../media/dvb/audio-select-source.rst         |   8 +-
>  .../media/dvb/audio-set-av-sync.rst           |   8 +-
>  .../media/dvb/audio-set-bypass-mode.rst       |   9 +-
>  .../userspace-api/media/dvb/audio-set-id.rst  |   9 +-
>  .../media/dvb/audio-set-mixer.rst             |   9 +-
>  .../media/dvb/audio-set-mute.rst              |   8 +-
>  .../media/dvb/audio-set-streamtype.rst        |  10 +-
>  .../userspace-api/media/dvb/audio-stop.rst    |   9 +-
>  .../userspace-api/media/dvb/ca-fclose.rst     |   7 +-
>  .../userspace-api/media/dvb/ca-fopen.rst      |   7 +-
>  .../userspace-api/media/dvb/ca-get-cap.rst    |   8 +-
>  .../media/dvb/ca-get-descr-info.rst           |   9 +-
>  .../userspace-api/media/dvb/ca-get-msg.rst    |  10 +-
>  .../media/dvb/ca-get-slot-info.rst            |   9 +-
>  .../userspace-api/media/dvb/ca-reset.rst      |   9 +-
>  .../userspace-api/media/dvb/ca-send-msg.rst   |   9 +-
>  .../userspace-api/media/dvb/ca-set-descr.rst  |   8 +-
>  .../userspace-api/media/dvb/dmx-add-pid.rst   |  10 +-
>  .../userspace-api/media/dvb/dmx-expbuf.rst    |  11 +-
>  .../userspace-api/media/dvb/dmx-fclose.rst    |   9 +-
>  .../userspace-api/media/dvb/dmx-fopen.rst     |   5 +-
>  .../userspace-api/media/dvb/dmx-fread.rst     |   7 +-
>  .../userspace-api/media/dvb/dmx-fwrite.rst    |   6 +-
>  .../media/dvb/dmx-get-pes-pids.rst            |  12 +-
>  .../userspace-api/media/dvb/dmx-get-stc.rst   |  12 +-
>  .../userspace-api/media/dvb/dmx-mmap.rst      |  15 +-
>  .../userspace-api/media/dvb/dmx-munmap.rst    |  14 +-
>  .../userspace-api/media/dvb/dmx-qbuf.rst      |  17 +-
>  .../userspace-api/media/dvb/dmx-querybuf.rst  |   9 +-
>  .../media/dvb/dmx-remove-pid.rst              |  10 +-
>  .../userspace-api/media/dvb/dmx-reqbufs.rst   |   9 +-
>  .../media/dvb/dmx-set-buffer-size.rst         |  10 +-
>  .../media/dvb/dmx-set-filter.rst              |  12 +-
>  .../media/dvb/dmx-set-pes-filter.rst          |  13 +-
>  .../userspace-api/media/dvb/dmx-start.rst     |  11 +-
>  .../userspace-api/media/dvb/dmx-stop.rst      |   9 +-
>  .../media/dvb/fe-diseqc-recv-slave-reply.rst  |   9 +-
>  .../media/dvb/fe-diseqc-reset-overload.rst    |   9 +-
>  .../media/dvb/fe-diseqc-send-burst.rst        |  10 +-
>  .../media/dvb/fe-diseqc-send-master-cmd.rst   |   9 +-
>  .../dvb/fe-dishnetwork-send-legacy-cmd.rst    |  10 +-
>  .../media/dvb/fe-enable-high-lnb-voltage.rst  |  10 +-
>  .../userspace-api/media/dvb/fe-get-event.rst  |  12 +-
>  .../media/dvb/fe-get-frontend.rst             |  12 +-
>  .../userspace-api/media/dvb/fe-get-info.rst   |  11 +-
>  .../media/dvb/fe-get-property.rst             |  15 +-
>  .../userspace-api/media/dvb/fe-read-ber.rst   |   9 +-
>  .../media/dvb/fe-read-signal-strength.rst     |   9 +-
>  .../userspace-api/media/dvb/fe-read-snr.rst   |   9 +-
>  .../media/dvb/fe-read-status.rst              |  11 +-
>  .../media/dvb/fe-read-uncorrected-blocks.rst  |   9 +-
>  .../media/dvb/fe-set-frontend-tune-mode.rst   |  10 +-
>  .../media/dvb/fe-set-frontend.rst             |  11 +-
>  .../userspace-api/media/dvb/fe-set-tone.rst   |  10 +-
>  .../media/dvb/fe-set-voltage.rst              |  10 +-
>  .../media/dvb/frontend_f_close.rst            |   8 +-
>  .../media/dvb/frontend_f_open.rst             |  10 +-
>  .../userspace-api/media/dvb/net-add-if.rst    |   9 +-
>  .../userspace-api/media/dvb/net-get-if.rst    |  10 +-
>  .../userspace-api/media/dvb/net-remove-if.rst |  10 +-
>  .../media/dvb/video-clear-buffer.rst          |   8 +-
>  .../userspace-api/media/dvb/video-command.rst |  10 +-
>  .../media/dvb/video-continue.rst              |   8 +-
>  .../media/dvb/video-fast-forward.rst          |  10 +-
>  .../userspace-api/media/dvb/video-fclose.rst  |   6 +-
>  .../userspace-api/media/dvb/video-fopen.rst   |   6 +-
>  .../userspace-api/media/dvb/video-freeze.rst  |   8 +-
>  .../userspace-api/media/dvb/video-fwrite.rst  |   6 +-
>  .../media/dvb/video-get-capabilities.rst      |   8 +-
>  .../media/dvb/video-get-event.rst             |   8 +-
>  .../media/dvb/video-get-frame-count.rst       |   8 +-
>  .../userspace-api/media/dvb/video-get-pts.rst |   8 +-
>  .../media/dvb/video-get-size.rst              |   8 +-
>  .../media/dvb/video-get-status.rst            |   7 +-
>  .../userspace-api/media/dvb/video-play.rst    |   8 +-
>  .../media/dvb/video-select-source.rst         |   7 +-
>  .../media/dvb/video-set-blank.rst             |   8 +-
>  .../media/dvb/video-set-display-format.rst    |   8 +-
>  .../media/dvb/video-set-format.rst            |   9 +-
>  .../media/dvb/video-set-streamtype.rst        |   8 +-
>  .../media/dvb/video-slowmotion.rst            |  10 +-
>  .../media/dvb/video-stillpicture.rst          |   8 +-
>  .../userspace-api/media/dvb/video-stop.rst    |   8 +-
>  .../media/dvb/video-try-command.rst           |   8 +-
>  .../media/mediactl/media-func-close.rst       |  10 +-
>  .../media/mediactl/media-func-ioctl.rst       |  10 +-
>  .../media/mediactl/media-func-open.rst        |  10 +-
>  .../media/mediactl/media-ioc-device-info.rst  |  13 +-
>  .../mediactl/media-ioc-enum-entities.rst      |  11 +-
>  .../media/mediactl/media-ioc-enum-links.rst   |  13 +-
>  .../media/mediactl/media-ioc-g-topology.rst   |  14 +-
>  .../mediactl/media-ioc-request-alloc.rst      |  11 +-
>  .../media/mediactl/media-ioc-setup-link.rst   |  10 +-
>  .../mediactl/media-request-ioc-queue.rst      |   7 +-
>  .../mediactl/media-request-ioc-reinit.rst     |   8 +-
>  .../media/mediactl/request-api.rst            |   5 +-
>  .../media/mediactl/request-func-close.rst     |   8 +-
>  .../media/mediactl/request-func-ioctl.rst     |   8 +-
>  .../media/mediactl/request-func-poll.rst      |  12 +-
>  .../media/rc/lirc-get-features.rst            |   9 +-
>  .../media/rc/lirc-get-rec-mode.rst            |  12 +-
>  .../media/rc/lirc-get-rec-resolution.rst      |   8 +-
>  .../media/rc/lirc-get-send-mode.rst           |  14 +-
>  .../media/rc/lirc-get-timeout.rst             |  13 +-
>  .../userspace-api/media/rc/lirc-read.rst      |  10 +-
>  .../rc/lirc-set-measure-carrier-mode.rst      |   8 +-
>  .../media/rc/lirc-set-rec-carrier-range.rst   |   6 +-
>  .../media/rc/lirc-set-rec-carrier.rst         |   8 +-
>  .../media/rc/lirc-set-rec-timeout-reports.rst |   8 +-
>  .../media/rc/lirc-set-rec-timeout.rst         |  13 +-
>  .../media/rc/lirc-set-send-carrier.rst        |   8 +-
>  .../media/rc/lirc-set-send-duty-cycle.rst     |   8 +-
>  .../media/rc/lirc-set-transmitter-mask.rst    |   8 +-
>  .../media/rc/lirc-set-wideband-receiver.rst   |   8 +-
>  .../userspace-api/media/rc/lirc-write.rst     |   7 +-
>  .../userspace-api/media/v4l/buffer.rst        |  28 +-
>  .../userspace-api/media/v4l/dev-capture.rst   |   7 +-
>  .../userspace-api/media/v4l/dev-output.rst    |   7 +-
>  .../userspace-api/media/v4l/dev-raw-vbi.rst   |  19 +-
>  .../userspace-api/media/v4l/dev-rds.rst       |  12 +-
>  .../media/v4l/dev-sliced-vbi.rst              |  31 +-
>  .../userspace-api/media/v4l/diff-v4l.rst      |  39 +--
>  .../userspace-api/media/v4l/dmabuf.rst        |   8 +-
>  .../userspace-api/media/v4l/format.rst        |   7 +-
>  .../userspace-api/media/v4l/func-close.rst    |   8 +-
>  .../userspace-api/media/v4l/func-ioctl.rst    |  10 +-
>  .../userspace-api/media/v4l/func-mmap.rst     |  18 +-
>  .../userspace-api/media/v4l/func-munmap.rst   |  14 +-
>  .../userspace-api/media/v4l/func-open.rst     |  14 +-
>  .../userspace-api/media/v4l/func-poll.rst     |  40 ++-
>  .../userspace-api/media/v4l/func-read.rst     |  39 ++-
>  .../userspace-api/media/v4l/func-select.rst   |  42 ++-
>  .../userspace-api/media/v4l/func-write.rst    |  13 +-
>  .../userspace-api/media/v4l/hist-v4l2.rst     |  70 +---
>  Documentation/userspace-api/media/v4l/io.rst  |   6 +-
>  .../media/v4l/libv4l-introduction.rst         |  30 +-
>  .../userspace-api/media/v4l/mmap.rst          |  26 +-
>  .../userspace-api/media/v4l/open.rst          |  15 +-
>  Documentation/userspace-api/media/v4l/rw.rst  |  18 +-
>  .../userspace-api/media/v4l/streaming-par.rst |   5 +-
>  .../userspace-api/media/v4l/userp.rst         |  11 +-
>  .../media/v4l/vidioc-create-bufs.rst          |  11 +-
>  .../media/v4l/vidioc-cropcap.rst              |  11 +-
>  .../media/v4l/vidioc-dbg-g-chip-info.rst      |  13 +-
>  .../media/v4l/vidioc-dbg-g-register.rst       |  18 +-
>  .../media/v4l/vidioc-decoder-cmd.rst          |  19 +-
>  .../media/v4l/vidioc-dqevent.rst              |  19 +-
>  .../media/v4l/vidioc-dv-timings-cap.rst       |  17 +-
>  .../media/v4l/vidioc-encoder-cmd.rst          |  25 +-
>  .../media/v4l/vidioc-enum-dv-timings.rst      |  16 +-
>  .../media/v4l/vidioc-enum-fmt.rst             |  12 +-
>  .../media/v4l/vidioc-enum-frameintervals.rst  |  15 +-
>  .../media/v4l/vidioc-enum-framesizes.rst      |  16 +-
>  .../media/v4l/vidioc-enum-freq-bands.rst      |  12 +-
>  .../media/v4l/vidioc-enumaudio.rst            |  10 +-
>  .../media/v4l/vidioc-enumaudioout.rst         |  10 +-
>  .../media/v4l/vidioc-enuminput.rst            |  14 +-
>  .../media/v4l/vidioc-enumoutput.rst           |  13 +-
>  .../media/v4l/vidioc-enumstd.rst              |  23 +-
>  .../userspace-api/media/v4l/vidioc-expbuf.rst |  14 +-
>  .../media/v4l/vidioc-g-audio.rst              |  18 +-
>  .../media/v4l/vidioc-g-audioout.rst           |  16 +-
>  .../userspace-api/media/v4l/vidioc-g-crop.rst |  16 +-
>  .../userspace-api/media/v4l/vidioc-g-ctrl.rst |  16 +-
>  .../media/v4l/vidioc-g-dv-timings.rst         |  26 +-
>  .../userspace-api/media/v4l/vidioc-g-edid.rst |  25 +-
>  .../media/v4l/vidioc-g-enc-index.rst          |  13 +-
>  .../media/v4l/vidioc-g-ext-ctrls.rst          |  21 +-
>  .../userspace-api/media/v4l/vidioc-g-fbuf.rst |  18 +-
>  .../userspace-api/media/v4l/vidioc-g-fmt.rst  |  22 +-
>  .../media/v4l/vidioc-g-frequency.rst          |  16 +-
>  .../media/v4l/vidioc-g-input.rst              |  15 +-
>  .../media/v4l/vidioc-g-jpegcomp.rst           |  17 +-
>  .../media/v4l/vidioc-g-modulator.rst          |  17 +-
>  .../media/v4l/vidioc-g-output.rst             |  15 +-
>  .../userspace-api/media/v4l/vidioc-g-parm.rst |  30 +-
>  .../media/v4l/vidioc-g-priority.rst           |  16 +-
>  .../media/v4l/vidioc-g-selection.rst          |  15 +-
>  .../media/v4l/vidioc-g-sliced-vbi-cap.rst     |  12 +-
>  .../userspace-api/media/v4l/vidioc-g-std.rst  |  24 +-
>  .../media/v4l/vidioc-g-tuner.rst              |  19 +-
>  .../media/v4l/vidioc-log-status.rst           |  10 +-
>  .../media/v4l/vidioc-overlay.rst              |  10 +-
>  .../media/v4l/vidioc-prepare-buf.rst          |  10 +-
>  .../userspace-api/media/v4l/vidioc-qbuf.rst   |  17 +-
>  .../media/v4l/vidioc-query-dv-timings.rst     |  15 +-
>  .../media/v4l/vidioc-querybuf.rst             |  10 +-
>  .../media/v4l/vidioc-querycap.rst             |  16 +-
>  .../media/v4l/vidioc-queryctrl.rst            |  22 +-
>  .../media/v4l/vidioc-querystd.rst             |  15 +-
>  .../media/v4l/vidioc-reqbufs.rst              |  10 +-
>  .../media/v4l/vidioc-s-hw-freq-seek.rst       |  11 +-
>  .../media/v4l/vidioc-streamon.rst             |  14 +-
>  .../v4l/vidioc-subdev-enum-frame-interval.rst |  10 +-
>  .../v4l/vidioc-subdev-enum-frame-size.rst     |  11 +-
>  .../v4l/vidioc-subdev-enum-mbus-code.rst      |  10 +-
>  .../media/v4l/vidioc-subdev-g-crop.rst        |  16 +-
>  .../media/v4l/vidioc-subdev-g-fmt.rst         |  17 +-
>  .../v4l/vidioc-subdev-g-frame-interval.rst    |  16 +-
>  .../media/v4l/vidioc-subdev-g-selection.rst   |  17 +-
>  .../media/v4l/vidioc-subdev-querycap.rst      |   9 +-
>  .../media/v4l/vidioc-subscribe-event.rst      |  17 +-
>  .../virt/uml/user_mode_linux_howto_v2.rst     |   1 +
>  Documentation/vm/hmm.rst                      |   2 +-
>  Documentation/vm/ksm.rst                      |   2 +-
>  Documentation/vm/memory-model.rst             |   6 +-
>  MAINTAINERS                                   |  16 +-
>  block/bio.c                                   |   4 +-
>  drivers/base/core.c                           |   7 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +
>  drivers/gpu/drm/drm_prime.c                   |   1 +
>  drivers/infiniband/ulp/srpt/ib_srpt.h         |   1 +
>  drivers/net/appletalk/Kconfig                 |   2 +-
>  drivers/net/hamradio/scc.c                    |   2 +-
>  include/drm/drm_dp_helper.h                   |   2 +-
>  include/drm/drm_edid.h                        |   7 -
>  include/kunit/test.h                          |  16 +-
>  include/linux/devfreq.h                       |   7 +-
>  include/linux/input/sparse-keymap.h           |   1 +
>  include/linux/math64.h                        |   8 +-
>  include/linux/refcount.h                      |   7 +
>  include/linux/usb/typec_altmode.h             |  16 +
>  include/net/cfg80211.h                        |   1 +
>  kernel/rcu/tree.c                             |  14 +-
>  kernel/workqueue.c                            |   3 +
>  mm/ksm.c                                      |   2 +-
>  mm/memblock.c                                 |   8 +-
>  scripts/kernel-doc                            | 303 +++++++++++++-----
>  316 files changed, 1921 insertions(+), 2285 deletions(-)
>  delete mode 100644 Documentation/driver-api/sound.rst
>
> --
> 2.26.2
>
>

--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
