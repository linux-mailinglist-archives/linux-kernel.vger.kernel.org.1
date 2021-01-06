Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD452EB8B2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbhAFDv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhAFDv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:51:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BEAC06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 19:51:17 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id s21so935346pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 19:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=eXrpMrj6YvsHKIRK9+LKKpoAFDK39SfbfHOXlypYzcY=;
        b=RvvSRBJL76JHBWv5Iuo5pbFPOkCRGhaqksMZdVAk3yc+voMyPuThBYLQuC1WqBWUet
         lDoluuYk8qyNnjbsrHBvLEm+r5ZN2NVlldQ0fPVErO5yiDlMCmPqjGCmqn9tdrpDLA1x
         q93rHGhvbSgH3HGS153bt7sjg5jfKMevbILEiujQKrjlFIw3GWYRTCRimjHBDGQwhNEP
         agCrtdxYbNowovcXKfSJ5JeVo3g91u/xu6Id0QxxYfihGyldf9ZujfBdQogUtcHYilXo
         FT9MrM86wlMFkA6n+jzSXjxlnEw74t2HBwgtaQzicWSZNenH4RXpPr8pU0RMB+7h1eQJ
         T5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=eXrpMrj6YvsHKIRK9+LKKpoAFDK39SfbfHOXlypYzcY=;
        b=Hkian5HGaZH6tpEz6FdVQWVsYJifWjlgEhaSBqx59XPAJfZ0YND5Y0Ol37281MG+hc
         /WteMG8bpCWBBGReffzc1rdqMuXdLnODpKnreIKZtNZL+0uCdOT8EuABspLQ6GQXvbmt
         Btl/u+WZG4CJWFHqRsZ7Guz7hnu4Tqyh/ofLK1jFaYYa8KIFD0BnBokG2s0+hmeIJ6St
         HNTU+rJyy1yrYnffjn+qRlABS5Zlpwa7N0qu/QJYFWq/cgK571OafK/Qwvpiedw/b+qp
         qFEtRVjS+4DmsCL2En61kwr/D/kVCe22Qam4sILeV7bwkiC/ig97NEfzahsHVkwH2EKm
         RPRQ==
X-Gm-Message-State: AOAM531sThBLwWm4QKSlmDkU9tNUyBrLmcgCDGpICFqv9jbp2UM+p2SU
        QZYDHieu1d7agkOmMkXbEWU=
X-Google-Smtp-Source: ABdhPJxZms0h1r8psnB+l/5ZJpMwdThWyheWb4JvpjFTF2mk3Cpuyqqc/D0VsAYWKcTPmp6zF3+k1g==
X-Received: by 2002:aa7:96c9:0:b029:1a3:c274:f717 with SMTP id h9-20020aa796c90000b02901a3c274f717mr2214501pfq.38.1609905076918;
        Tue, 05 Jan 2021 19:51:16 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id g75sm743323pfb.2.2021.01.05.19.51.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 19:51:16 -0800 (PST)
From:   Liang Li <liliang324@gmail.com>
X-Google-Original-From: Liang Li <liliangleo@didiglobal.com>
Date:   Tue, 5 Jan 2021 22:51:13 -0500
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Liang Li <liliang324@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 5/6] virtio-balloon: reporting hugetlb free page to host
Message-ID: <20210106035110.GA1170@open-light-1.localdomain>
Mail-Followup-To: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>, Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Free page reporting only supports buddy pages, it can't report the
free pages reserved for hugetlbfs case. On the other hand, hugetlbfs
is a good choice for a system with a huge amount of RAM, because it
can help to reduce the memory management overhead and improve system
performance.  This patch add support for reporting free hugepage to
host when guest use hugetlbfs.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Liang Li <liliang324@gmail.com>
Signed-off-by: Liang Li <liliangleo@didiglobal.com>
---
 drivers/virtio/virtio_balloon.c | 55 +++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 684bcc39ef5a..7bd7fcacee8c 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -126,6 +126,10 @@ struct virtio_balloon {
 	/* Free page reporting device */
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
+
+	/* Free hugepage reporting device */
+	struct page_reporting_dev_info hpr_dev_info;
+	struct mutex mtx_report;
 };
 
 static const struct virtio_device_id id_table[] = {
@@ -173,6 +177,38 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	struct virtqueue *vq = vb->reporting_vq;
 	unsigned int unused, err;
 
+	mutex_lock(&vb->mtx_report);
+	/* We should always be able to add these buffers to an empty queue. */
+	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT | __GFP_NOWARN);
+
+	/*
+	 * In the extremely unlikely case that something has occurred and we
+	 * are able to trigger an error we will simply display a warning
+	 * and exit without actually processing the pages.
+	 */
+	if (WARN_ON_ONCE(err)) {
+		mutex_unlock(&vb->mtx_report);
+		return err;
+	}
+
+	virtqueue_kick(vq);
+
+	/* When host has read buffer, this completes via balloon_ack */
+	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
+	mutex_unlock(&vb->mtx_report);
+
+	return 0;
+}
+
+static int virtballoon_free_hugepage_report(struct page_reporting_dev_info *hpr_dev_info,
+				   struct scatterlist *sg, unsigned int nents)
+{
+	struct virtio_balloon *vb =
+		container_of(hpr_dev_info, struct virtio_balloon, hpr_dev_info);
+	struct virtqueue *vq = vb->reporting_vq;
+	unsigned int unused, err;
+
+	mutex_lock(&vb->mtx_report);
 	/* We should always be able to add these buffers to an empty queue. */
 	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT | __GFP_NOWARN);
 
@@ -181,13 +217,16 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	 * are able to trigger an error we will simply display a warning
 	 * and exit without actually processing the pages.
 	 */
-	if (WARN_ON_ONCE(err))
+	if (WARN_ON_ONCE(err)) {
+		mutex_unlock(&vb->mtx_report);
 		return err;
+	}
 
 	virtqueue_kick(vq);
 
 	/* When host has read buffer, this completes via balloon_ack */
 	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
+	mutex_unlock(&vb->mtx_report);
 
 	return 0;
 }
@@ -984,9 +1023,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	}
 
 	vb->pr_dev_info.report = virtballoon_free_page_report;
+	vb->hpr_dev_info.report = virtballoon_free_hugepage_report;
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
 		unsigned int capacity;
 
+		mutex_init(&vb->mtx_report);
 		capacity = virtqueue_get_vring_size(vb->reporting_vq);
 		if (capacity < PAGE_REPORTING_CAPACITY) {
 			err = -ENOSPC;
@@ -999,6 +1040,14 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		err = page_reporting_register(&vb->pr_dev_info);
 		if (err)
 			goto out_unregister_oom;
+
+		vb->hpr_dev_info.mini_order = MAX_ORDER - 1;
+		vb->hpr_dev_info.batch_size = 16 * 1024 * 1024; /* 16M */
+		vb->hpr_dev_info.delay_jiffies = 2 * HZ; /* 2 seconds */
+		err = hugepage_reporting_register(&vb->hpr_dev_info);
+		if (err)
+			goto out_unregister_oom;
+
 	}
 
 	virtio_device_ready(vdev);
@@ -1051,8 +1100,10 @@ static void virtballoon_remove(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
 
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
 		page_reporting_unregister(&vb->pr_dev_info);
+		hugepage_reporting_unregister(&vb->hpr_dev_info);
+	}
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		unregister_oom_notifier(&vb->oom_nb);
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
-- 
2.18.2

