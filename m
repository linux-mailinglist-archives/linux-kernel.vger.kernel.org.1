Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4016E1A040A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 03:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDGBIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 21:08:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55118 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726722AbgDGBIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TEc48I7L40swgY91SNpoqqlFJs2YDtsi09a3nE4rzt0=;
        b=cXxH43w5Cc6pFr9t2lsNkaU+Z8dR64slAdziCM3MmrEgzi9owsZJSsa7zLVuGNIU1rDauu
        eESvXKBZ6/HHdm1kLcNyOBXN37R6jGLycVyNwxoEg6/oKvsq2PNxb+8Ky8inSosO5uItA3
        X/QNHIeqGh5mCympd2tUngoyuS+OYJs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-7S2f3RybPSaAOk9UEJ7sSQ-1; Mon, 06 Apr 2020 21:08:04 -0400
X-MC-Unique: 7S2f3RybPSaAOk9UEJ7sSQ-1
Received: by mail-wr1-f72.google.com with SMTP id u16so850184wrp.14
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TEc48I7L40swgY91SNpoqqlFJs2YDtsi09a3nE4rzt0=;
        b=kv2lxjsqMS7BqiAlQh6Zyvsx2dHGxQxn97xUQii06jWK6tw3h1g2NPHmLhHoTfuys7
         QmV/F4yj7bN2cU4TuoVzYz6XQndgsW5pdXOfS7fPehOd3D91IQRpjBxC0fsDJ1iExJnP
         LEHrsgYTHEf7dJ1GvIk7/xOPGfFC1rzvhcLJApP7/+7IckLVcmc07pRXP8NSYh8QppRN
         BGUJ5oXzT7lKRM/puLj1IGYvDw9IjwFS9tHfITs/aszxkLUHoCuIK3nKA+WiPJYkUxlp
         V/oduOsWrraeu28zhEFqAXfAe3DjaKtHcbZZ7/8UhH6XMMZGM0l5qLKcgbM5iLLHmmTY
         LAPg==
X-Gm-Message-State: AGi0PuaVnZG2Y6OjmSmhHUkTROfmdizQCIKnpYS9AX4MUYLEq9680PDH
        bJF9pjRykm7DBZ5SadVpXGpQdAd3hJlhfspKM2lx6xA5n52CVKg+9B2/k7acm8krmDASTTos45g
        oePJ4ApNBT9smbUptcTMpzBwm
X-Received: by 2002:a5d:4602:: with SMTP id t2mr2198718wrq.347.1586221683275;
        Mon, 06 Apr 2020 18:08:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypLjsZp3Jur6V5gr6xde4lqll9z+2UAisG1khAzGUcGAVVebzXO8Lvset44/DEyvZePjCpSAJg==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr2198705wrq.347.1586221683081;
        Mon, 06 Apr 2020 18:08:03 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id r14sm118800wmg.0.2020.04.06.18.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:08:02 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:08:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v7 15/19] remoteproc: switch to virtio_legacy_init/size
Message-ID: <20200407010700.446571-16-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are used for legacy ring format, switch to APIs that make this
explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/remoteproc/remoteproc_core.c   | 2 +-
 drivers/remoteproc/remoteproc_virtio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e4f1f3..c350a01e6c4e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -322,7 +322,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	struct rproc_mem_entry *mem;
 
 	/* actual size of vring (in bytes) */
-	size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
+	size = PAGE_ALIGN(vring_legacy_size(rvring->len, rvring->align));
 
 	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
 
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 8c07cb2ca8ba..35b02468197a 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -95,7 +95,7 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 	len = rvring->len;
 
 	/* zero vring */
-	size = vring_size(len, rvring->align);
+	size = vring_legacy_size(len, rvring->align);
 	memset(addr, 0, size);
 
 	dev_dbg(dev, "vring%d: va %pK qsz %d notifyid %d\n",
-- 
MST

