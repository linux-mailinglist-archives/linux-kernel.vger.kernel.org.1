Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AE02A8C9A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgKFCRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:17:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725817AbgKFCRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604629039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=foOZy0tCz1jxCbpETG5UIW0qij0a04UpX6miBXh7+Dc=;
        b=A3ARGtpaAWUUdSpYWZ1ObfRrtmKblhcVjrv5oan9h4gEy1KS3YxaNVS4sm4Pl/0870UmS1
        NwDZD6osRfEQcVD/7W2ntvKmgZMngRWe+BNYBHoCYVfhzDIKqAlqnbYlc7BXNbu/ZTBPOW
        BrzWOLzjf9Nrbsk5hUqN9sxGc51skf4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-F8xvFPLyOtSVxM7yn2OqVg-1; Thu, 05 Nov 2020 21:17:16 -0500
X-MC-Unique: F8xvFPLyOtSVxM7yn2OqVg-1
Received: by mail-qt1-f198.google.com with SMTP id l67so2175955qte.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=foOZy0tCz1jxCbpETG5UIW0qij0a04UpX6miBXh7+Dc=;
        b=t13Gxm6hT1OV2X1wyEk/nYgdYh8wSm+p3yOlWZcDSxRBa+8dNmQSHf1DQDHeoBpm0m
         UdPeymfjC7hDYe2/S/xD32++IRzARUcMQ9b/oWjbgWDlgxzSGgyhnY7k7ZslsPR3VVD7
         heVce2Z+Qeq57Ph4ysqvKcVu2j+hZ5Q10Lov6Yf+t0aR2ClGK6cBShUekyg/QXkTpfDL
         SET/Tm/bxd4fwEm/3bB/du7zYD7XS2h/3tCKbSTMo5AqMCgfFoPtRPYMBwWn1/a9IkcK
         aH1pp5JH5f+hCUjnXQGQ7whWt/jmy87T2awIyFhJGqO2uOJObOvluuKHL57rr5fZUZ4C
         lz2Q==
X-Gm-Message-State: AOAM530w334gXLBRHYXWo+5djX7fpCuEBt34hVRk3shtdI/yCu6iZF7j
        UA5eq0/iKKU54l8bGM7PjKOSJiV+Lu3RIXP8vQOwUO+/iehym53cvDotxP1KMwCEI42NRcLmjYG
        YmSKhLAn3hPsf9H6tIqHHGOii
X-Received: by 2002:ae9:e41a:: with SMTP id q26mr5377501qkc.246.1604629035529;
        Thu, 05 Nov 2020 18:17:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCTjSjLVyCDBJFvGLtaXnVkIu5zI2SCdofvNmrjaLm638Fyz54c5K9EVsapniDZXfPi9W0kQ==
X-Received: by 2002:ae9:e41a:: with SMTP id q26mr5377490qkc.246.1604629035317;
        Thu, 05 Nov 2020 18:17:15 -0800 (PST)
Received: from xps13.jcline.org ([2605:a601:a639:f01:1ac8:8e0c:f1cc:7a29])
        by smtp.gmail.com with ESMTPSA id q20sm2195301qtn.80.2020.11.05.18.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:17:14 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>
Subject: [PATCH 0/3] drm/nouveau: extend the lifetime of nouveau_drm
Date:   Thu,  5 Nov 2020 21:16:53 -0500
Message-Id: <20201106021656.40743-1-jcline@redhat.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Currently, when the device is removed (or the driver is unbound) the
nouveau_drm structure de-allocated. However, it's still accessible from
and used by some DRM layer callbacks. For example, file handles can be
closed after the device has been removed (physically or otherwise). This
series converts the Nouveau device structure to be allocated and
de-allocated with the devm_drm_dev_alloc() API.

In the future, additional resources that should be bound to the lifetime
of the drm_device can be added, and the drmm_add_action() APIs offer a
nice hook for arbitrary cleanup actions before the drm_device is
destroyed, so I suspect much of the current cleanup code in Nouveau
would benefit from some refactoring to use this.

Finally, although not *strictly* necessary for this series, I included
some documentation for structures I investigated for this work.

Jeremy Cline (3):
  drm/nouveau: Use helper to convert nouveau_drm to drm_device
  drm/nouveau: manage nouveau_drm lifetime with devres
  drm/nouveau: begin documenting core nouveau structures

 drivers/gpu/drm/nouveau/dispnv04/crtc.c     |  10 +-
 drivers/gpu/drm/nouveau/dispnv50/base.c     |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/base507c.c |   7 +-
 drivers/gpu/drm/nouveau/dispnv50/core.c     |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/core507d.c |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/curs.c     |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/curs507a.c |   5 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  17 +--
 drivers/gpu/drm/nouveau/dispnv50/oimm.c     |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/oimm507b.c |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/ovly.c     |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/ovly507e.c |   5 +-
 drivers/gpu/drm/nouveau/dispnv50/wimm.c     |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/wimmc37b.c |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c     |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/wndwc37e.c |   5 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c        |  16 ++-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c   |   9 +-
 drivers/gpu/drm/nouveau/nouveau_display.c   |  16 +--
 drivers/gpu/drm/nouveau/nouveau_dmem.c      |  17 +--
 drivers/gpu/drm/nouveau/nouveau_drm.c       |  41 ++++----
 drivers/gpu/drm/nouveau/nouveau_drv.h       | 111 +++++++++++++++++++-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c     |  19 ++--
 drivers/gpu/drm/nouveau/nouveau_gem.c       |   8 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c       |   4 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c       |   4 +-
 drivers/gpu/drm/nouveau/nouveau_vga.c       |   8 +-
 27 files changed, 216 insertions(+), 106 deletions(-)

-- 
2.28.0

