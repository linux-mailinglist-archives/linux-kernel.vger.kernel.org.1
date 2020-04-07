Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29CEC1A03F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 03:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDGBHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 21:07:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35190 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726230AbgDGBHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=6a9s/fdXhXhr0rEJPGJmBFwAnv2nxzLfPNhDXGBMyP4=;
        b=C/uLkEL6NEO2B4Pebvg228RDLZ+5Mmv9SB8ahyngAP+3d8PnpQ1xKxlm3CvCy2tBgNsl+n
        OGx7/hUziXQbxBMKtSiI1ZhC/iIBFZmYFcLanfmUzl6DiDuVBHWI2uXGMNgbHm+sy0C2Mg
        pcXRGSwzi8ToFYSwq+g2swny7vgYOYM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-QPO1UQjVNpeCBMJIqovCdQ-1; Mon, 06 Apr 2020 21:07:29 -0400
X-MC-Unique: QPO1UQjVNpeCBMJIqovCdQ-1
Received: by mail-wr1-f69.google.com with SMTP id w12so830031wrl.23
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=6a9s/fdXhXhr0rEJPGJmBFwAnv2nxzLfPNhDXGBMyP4=;
        b=ZWsZxgMTXSpqkp9KBtWP61N0VfK5wxWS17xJ+QKG30FJmzqYRxWtkgIdqCXcQanEeO
         Us+3h5ocuHsNQHbcIbtF/8xeZAln6PPLuT93bWUl3hTEiU6oEok4hILmitx23Pw2M6jR
         gmNc7YKPWRG+swaL8npqYevykK5tKOk+4pFP9ux0qIO5dOrR3E4HrEIVmPIKgaSBNLFt
         DwBVnqdBGgjZmdALYG5f6bXzQBBAXh+kDY+FnjEoaEC9JndBnR8iGkQW4axQnYaYaUZ0
         wOjPTdr+GAbJnwDa4HH0WjefP4isSadzJXUiuH64ID6WezzJWsizpyY74FnlJHM1PFwX
         tfxA==
X-Gm-Message-State: AGi0Puar6nc4gSaj32S0OT3/ODr2RrxjQhSmoAtKWptcuP+Zyfove5pL
        uw/4M2E1CiCROTzq3uP2zjlq403SdILHAyxkjJBcr9ascw9qDRfeZcL+hqlfl2UAN2TV9v/OUX4
        cV3WcozEcBvkwHBLRN7HcevTX
X-Received: by 2002:a5d:4284:: with SMTP id k4mr1984362wrq.310.1586221647825;
        Mon, 06 Apr 2020 18:07:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypKlMkqLINdJhCGYv2Qk4fO+xFXGdmU5QpsZgjrm5bDk2WKSorJ+Q/rr5UKyt/6CeuOKCP2dYw==
X-Received: by 2002:a5d:4284:: with SMTP id k4mr1984350wrq.310.1586221647616;
        Mon, 06 Apr 2020 18:07:27 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id b82sm97981wme.25.2020.04.06.18.07.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:26 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/19] virtio: alignment issues
Message-ID: <20200407010700.446571-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is an alternative to
	vhost: force spec specified alignment on types
which is a bit safer as it does not change UAPI.
I still think it's best to change the UAPI header as well,
we can do that as a follow-up cleanup.

changes from v6:
	add missing header includes all over the place
changes from v5:
	ack for mellanox patch
	fixup to remoteproc
changes from v4:
	fixup to issues reported by kbuild
changes from v3:
	tools/virtio fixes
	a bunch more cleanups that now become possible

Changes from v2:
	don't change struct name, instead add ifndef
	so kernel does not see the legacy UAPI version.

Jason, can you pls ack one of the approaches?


Matej Genci (1):
  virtio: add VIRTIO_RING_NO_LEGACY

Michael S. Tsirkin (18):
  tools/virtio: define aligned attribute
  tools/virtio: make asm/barrier.h self contained
  tools/virtio: define __KERNEL__
  virtgpu: pull in uaccess.h
  virtio-rng: pull in slab.h
  remoteproc: pull in slab.h
  virtio_input: pull in slab.h
  virtio: stop using legacy struct vring in kernel
  vhost: force spec specified alignment on types
  virtio: add legacy init/size APIs
  virtio_ring: switch to virtio_legacy_init/size
  tools/virtio: switch to virtio_legacy_init/size
  vop: switch to virtio_legacy_init/size
  remoteproc: switch to virtio_legacy_init/size
  mellanox: switch to virtio_legacy_init/size
  vhost: option to fetch descriptors through an independent struct
  vhost: use batched version by default
  vhost: batching fetches

 drivers/block/virtio_blk.c               |   1 +
 drivers/char/hw_random/virtio-rng.c      |   1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   |   1 +
 drivers/misc/mic/vop/vop_main.c          |   5 +-
 drivers/misc/mic/vop/vop_vringh.c        |   8 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c |   6 +-
 drivers/remoteproc/remoteproc_core.c     |   2 +-
 drivers/remoteproc/remoteproc_sysfs.c    |   1 +
 drivers/remoteproc/remoteproc_virtio.c   |   2 +-
 drivers/vhost/test.c                     |   2 +-
 drivers/vhost/vhost.c                    | 271 +++++++++++++++--------
 drivers/vhost/vhost.h                    |  23 +-
 drivers/virtio/virtio_input.c            |   1 +
 drivers/virtio/virtio_pci_modern.c       |   1 +
 drivers/virtio/virtio_ring.c             |  15 +-
 include/linux/virtio.h                   |   1 -
 include/linux/virtio_ring.h              |  46 ++++
 include/linux/vringh.h                   |   1 +
 include/uapi/linux/virtio_ring.h         |  30 ++-
 tools/virtio/Makefile                    |   2 +-
 tools/virtio/asm/barrier.h               |   1 +
 tools/virtio/linux/compiler.h            |   1 +
 tools/virtio/ringtest/virtio_ring_0_9.c  |   6 +-
 tools/virtio/virtio_test.c               |   6 +-
 tools/virtio/vringh_test.c               |  18 +-
 25 files changed, 311 insertions(+), 141 deletions(-)

-- 
MST

