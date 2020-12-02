Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E512CBBF4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbgLBLxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:53:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729736AbgLBLxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606909914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=eZnLI0Wik0eaxTfaNNAVKLQ21xyT2CoTcJpXnx1wngM=;
        b=OIa98lUe8TKjCR8mdTz0Fd/3UHc3YAyATCGuSW4Cwcic29lZZeoJEVVW4uUQUfvA2kIu22
        VVkNxij9JHYiaDqeFevBRfnzzEgSvUR2ZzDv+RfOEEsyTlIc8By4TCmrtNn4XK3MwQkO5+
        yjdjLHQPPj3+e6FrxRu0orL3Q5wsbzk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-m-9STX6hOZuGjsupLRrM1Q-1; Wed, 02 Dec 2020 06:51:52 -0500
X-MC-Unique: m-9STX6hOZuGjsupLRrM1Q-1
Received: by mail-wm1-f70.google.com with SMTP id v5so3267911wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 03:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eZnLI0Wik0eaxTfaNNAVKLQ21xyT2CoTcJpXnx1wngM=;
        b=LudDzoqJOfX3VJA3rrmqrsFSGM1Ln9O5blc7EDK8r2YtbuqQhyVrK5He8vtdba8UuE
         +MKlrvylGVCETylb8f0k7b691LxCrqZ2X1us4w8w1EnTMEhqhwJfKuKMBGIvMVWFND0n
         1eQicFLiE0gNbukaovepKRst/JiFhIMUilAMSM3rICbLKWqCLyOh46syWCPxIXk3XLpc
         5q02QAJRLAoO48MNQGDXNslYfr7aGS0ruyDsk+ADrpY0XJEeepNtB5z20+MGw2nfgK0y
         8680qwIbAV68hNcJbtRadHWbfg/uj+OPnL2RPKb/WPV250gEzegT8agYVgTuNq9l9cYW
         TrGg==
X-Gm-Message-State: AOAM533Oxn5Knkv6vdvqxxSL96ymQoDKIJH7IZm+Mo0y13RuGh+oWKw8
        TfKuKs2mhopVjqt3pER+Gh++1ri74j/MfdxYCUn45XIuJk0Iqpz4/jtWFobnr9ZWxVcLfOi77UH
        iUyzyEphEHb5MoYTLf7QwwmWr
X-Received: by 2002:a05:600c:2106:: with SMTP id u6mr1002270wml.4.1606909911245;
        Wed, 02 Dec 2020 03:51:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDk/79fb5VUyBoaUX2SQVUTrvAjsll90UI65W+kVpuHWCvrrBFwGplb9GAKNlrMm4UMxEqKg==
X-Received: by 2002:a05:600c:2106:: with SMTP id u6mr1002258wml.4.1606909911075;
        Wed, 02 Dec 2020 03:51:51 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id f7sm1766312wmc.1.2020.12.02.03.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 03:51:50 -0800 (PST)
Date:   Wed, 2 Dec 2020 06:51:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, eli@mellanox.com, jasowang@redhat.com,
        leonro@nvidia.com, lkp@intel.com, mst@redhat.com,
        parav@mellanox.com, rdunlap@infradead.org, saeedm@nvidia.com
Subject: [GIT PULL] vdpa: last minute bugfixes
Message-ID: <20201202065147-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of patches of the obviously correct variety.

The following changes since commit ad89653f79f1882d55d9df76c9b2b94f008c4e27:

  vhost-vdpa: fix page pinning leakage in error path (rework) (2020-11-25 04:29:07 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 2c602741b51daa12f8457f222ce9ce9c4825d067:

  vhost_vdpa: return -EFAULT if copy_to_user() fails (2020-12-02 04:36:40 -0500)

----------------------------------------------------------------
vdpa: last minute bugfixes

A couple of fixes that surfaced at the last minute.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dan Carpenter (1):
      vhost_vdpa: return -EFAULT if copy_to_user() fails

Randy Dunlap (1):
      vdpa: mlx5: fix vdpa/vhost dependencies

 drivers/Makefile     | 1 +
 drivers/vdpa/Kconfig | 1 +
 drivers/vhost/vdpa.c | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

