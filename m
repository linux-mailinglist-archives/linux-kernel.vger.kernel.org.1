Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7452FC618
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbhATAuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:50:13 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:31477 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbhATArB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 19:47:01 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 7EA2AA13B0;
        Wed, 20 Jan 2021 01:37:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:message-id:mime-version:reply-to:subject:subject
        :to:to; s=srmailgate02; bh=g3peVLu/aEuE3zFN78uiHYXZs/lCyoR9D8SzT
        duAw8k=; b=mkyAGhl2jWeIn8aNb2TP5Oss8ufW4W6HuAgCnNCr52wtQe6hCk7Uy
        UN+7gIj3g6rJ4rJtak9LTd/DdfJ2tMOMGIGnnmAMs7JcwiobToyTL7jueJTw/AG/
        WXWL1HmD2MYs3SdbRT6l7NkdNAZWCdjsQSvcnEEhfEo7VX4PErCdCW7L4BPdoU3E
        9vtgkwxnOJIt3B0dwAEE2RZxRyVFdWuqHNHstVuI2b6+qMOO9UF7+8NXsSaCqDmg
        kx7o+Yc5678s8egVNx9eqbHB63YxyaNW5PeRfuMTghWEFPkakGtFi5dD5jEJQlm4
        f3dp2nRG+cnTlUq7St2vk3ZarHWvZ96Ng==
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
To:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Jason Wang <jasowang@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/7] ALSA: add virtio sound driver
Date:   Wed, 20 Jan 2021 01:36:28 +0100
Message-ID: <20210120003638.3339987-1-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements a driver part of the virtio sound device
specification v8 [1].

The driver supports PCM playback and capture substreams, jack and
channel map controls. A message-based transport is used to write/read
PCM frames to/from a device.

The series is based (and was actually tested) on Linus's master
branch [2], on top of

commit 1e2a199f6ccd ("Merge tag 'spi-fix-v5.11-rc4' of ...")

As a device part was used OpenSynergy proprietary implementation.

Any comments are very welcome.

[1] https://lists.oasis-open.org/archives/virtio-dev/202003/msg00185.html
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git


Anton Yakovlev (7):
  uapi: virtio_ids: add a sound device type ID from OASIS spec
  uapi: virtio_snd: add the sound device header file
  ALSA: virtio: add virtio sound driver
  ALSA: virtio: handling control and I/O messages for the PCM device
  ALSA: virtio: PCM substream operators
  ALSA: virtio: introduce jack support
  ALSA: virtio: introduce device suspend/resume support

 MAINTAINERS                     |   8 +
 include/uapi/linux/virtio_ids.h |   1 +
 include/uapi/linux/virtio_snd.h | 361 +++++++++++++++++++
 sound/Kconfig                   |   2 +
 sound/Makefile                  |   3 +-
 sound/virtio/Kconfig            |  10 +
 sound/virtio/Makefile           |  13 +
 sound/virtio/virtio_card.c      | 593 ++++++++++++++++++++++++++++++++
 sound/virtio/virtio_card.h      | 121 +++++++
 sound/virtio/virtio_chmap.c     | 237 +++++++++++++
 sound/virtio/virtio_ctl_msg.c   | 293 ++++++++++++++++
 sound/virtio/virtio_ctl_msg.h   | 122 +++++++
 sound/virtio/virtio_jack.c      | 255 ++++++++++++++
 sound/virtio/virtio_pcm.c       | 582 +++++++++++++++++++++++++++++++
 sound/virtio/virtio_pcm.h       | 132 +++++++
 sound/virtio/virtio_pcm_msg.c   | 317 +++++++++++++++++
 sound/virtio/virtio_pcm_ops.c   | 524 ++++++++++++++++++++++++++++
 17 files changed, 3573 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/virtio_snd.h
 create mode 100644 sound/virtio/Kconfig
 create mode 100644 sound/virtio/Makefile
 create mode 100644 sound/virtio/virtio_card.c
 create mode 100644 sound/virtio/virtio_card.h
 create mode 100644 sound/virtio/virtio_chmap.c
 create mode 100644 sound/virtio/virtio_ctl_msg.c
 create mode 100644 sound/virtio/virtio_ctl_msg.h
 create mode 100644 sound/virtio/virtio_jack.c
 create mode 100644 sound/virtio/virtio_pcm.c
 create mode 100644 sound/virtio/virtio_pcm.h
 create mode 100644 sound/virtio/virtio_pcm_msg.c
 create mode 100644 sound/virtio/virtio_pcm_ops.c

-- 
2.30.0


