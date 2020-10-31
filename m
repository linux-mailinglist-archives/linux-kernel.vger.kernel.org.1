Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67DE2A1A5E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 20:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgJaT7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 15:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728449AbgJaT7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 15:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604174387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=R4s3Ix2b8SBi7OwErNBrHppcL00yyDMg5NuRWIfw+hI=;
        b=GcHeJC6O7eZAKsd8lUTkRXvijCn2c4kx+3OuubScauG7l1neqnducr+26egkI/CAkpR+He
        SpDWgga9G1Iy9BtJlMe4QY3FTqil+LVkEJgg4WG5Pzx2qbCLXa7Uwr+mK31bDX2grMqoZH
        /dG2ppG/zB7OMnYg8go0Q7Wyr8gzzSg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-OU3Bd26iO_uMlKoFAu6ejA-1; Sat, 31 Oct 2020 15:59:45 -0400
X-MC-Unique: OU3Bd26iO_uMlKoFAu6ejA-1
Received: by mail-wr1-f69.google.com with SMTP id w3so2236974wrt.11
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 12:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=R4s3Ix2b8SBi7OwErNBrHppcL00yyDMg5NuRWIfw+hI=;
        b=RccJIBKUhux7D4fcDOY/FKcXppKOLrfMONJ34id9kKUQMJ3rZ4vy0LP5GgZ21nDeti
         AHK7rKVwyPINhY76Y7tsgy+Ihu+tVlKGSz4PQLMf0DTKxk+Xfl9ASdLwZ4riXQADPIqu
         JEzSP4i49A3oH7o2nfbi94veKl6/R0wvnqJYXZ0hFP6QOWwFxbebf2S2yQVhjGOauSDo
         j0klce9d9JABep8c0w0jbBoKFQSNKmQhYeZpBDbYcvp03XU3YJIqx5oOQ++NJjwCR6VR
         I57aisagbHmd0jf6g6VcseNQEwbkDZ40SmJAXV6RG0o4s2vwy4X5Gcskb3rbHBoSHapp
         xz2g==
X-Gm-Message-State: AOAM533QShG7l70San+2q1+dRzB1KE/I31fH9HaO7G3nD6Zwk+XHpVeQ
        QHGImK9HN4gYegn1+bHMi2WEYUUzS2xMVkYIUPj2XiuL7XKWvlKEoOdHtDUBc6oHEZDF8RCm1u+
        lSvdDVv/l0oR+ms/0jqni1c3y
X-Received: by 2002:a1c:e903:: with SMTP id q3mr9643500wmc.42.1604174384685;
        Sat, 31 Oct 2020 12:59:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzzGUw3AXT6Lwe9xl9B0O7EZNb0u7o6fc3rE2pgvBpY6HuMlhM8rpvMYHBBuwHN4UT+dgoKQ==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr9643483wmc.42.1604174384498;
        Sat, 31 Oct 2020 12:59:44 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
        by smtp.gmail.com with ESMTPSA id x18sm16752967wrg.4.2020.10.31.12.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 12:59:43 -0700 (PDT)
Date:   Sat, 31 Oct 2020 15:59:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, elic@nvidia.com, jasowang@redhat.com,
        jingxiangfeng@huawei.com, lingshan.zhu@intel.com, lkp@intel.com,
        lvivier@redhat.com, mst@redhat.com, stable@vger.kernel.org
Subject: [GIT PULL] vhost,vdpa: fixes
Message-ID: <20201031155940-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 88a0d60c6445f315fbcfff3db792021bb3a67b28:

  MAINTAINERS: add URL for virtio-mem (2020-10-21 10:48:11 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 0c86d774883fa17e7c81b0c8838b88d06c2c911e:

  vdpasim: allow to assign a MAC address (2020-10-30 04:04:35 -0400)

----------------------------------------------------------------
vhost,vdpa: fixes

Fixes all over the place. A new UAPI is borderline: can also be
considered a new feature but also seems to be the only way we could come
up with to fix addressing for userspace - and it seems important to
switch to it now before userspace making assumptions about addressing
ability of devices is set in stone.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dan Carpenter (1):
      vhost_vdpa: Return -EFAULT if copy_from_user() fails

Jason Wang (3):
      vdpa: introduce config op to get valid iova range
      vhost: vdpa: report iova range
      vdpa_sim: implement get_iova_range()

Jing Xiangfeng (1):
      vdpa/mlx5: Fix error return in map_direct_mr()

Laurent Vivier (3):
      vdpa_sim: Fix DMA mask
      vdpasim: fix MAC address configuration
      vdpasim: allow to assign a MAC address

Michael S. Tsirkin (1):
      Revert "vhost-vdpa: fix page pinning leakage in error path"

Zhu Lingshan (1):
      vdpa: handle irq bypass register failure case

 drivers/vdpa/mlx5/core/mr.c      |   5 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c |  33 +++++++-
 drivers/vhost/vdpa.c             | 167 ++++++++++++++++++++++-----------------
 include/linux/vdpa.h             |  15 ++++
 include/uapi/linux/vhost.h       |   4 +
 include/uapi/linux/vhost_types.h |   9 +++
 6 files changed, 154 insertions(+), 79 deletions(-)

