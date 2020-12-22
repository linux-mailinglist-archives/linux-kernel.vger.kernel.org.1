Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276CF2E06E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 08:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgLVHs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 02:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgLVHs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:48:57 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07332C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 23:48:17 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id v3so6986007plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 23:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=i3bfHEMTyy3RMCDYIydmrpz6KtdROg7RvoHxWojHkr0=;
        b=D1GHHgB6ojK9kFQC/HqZtz1VG49st4P/x1r7Gk2gUQTRxEFN899dkPc7TLy4YHxKwt
         UyZA9j9NI9zEHmeu2BOHZbb59/+OmLAzjp6tU9y7bHvcku937QY7HLIdHqr6azr0VZp2
         Hvi+wQQXKbxX4gBZNp3ZAZ/u8Q8KNSkv3a9EjKiuKOvVMHDGkq32mMcvVB3ktpdNUiJ4
         v4UnYrMYZANTliJLq/rOqgBGCxDghtjPlHSABDP7j4ez9OqB+toNiEbojmRIihIWPPd4
         SSD6YYG+N1Myh0gfkdPkSOPdl/C3NSmvu6/JB8IqIlEp3q662kKLVkik5X5aaTrO8Lpn
         PEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=i3bfHEMTyy3RMCDYIydmrpz6KtdROg7RvoHxWojHkr0=;
        b=pyNXfNOj1+ZNMHal9KNEYgu3UiJbUMjmoiKwYkjO+kFCF3ULLRwuus1HW18vfv+epA
         KmS4/cMLowOstt2y3FQ49QTwGHxx03d8EBB7uaKzemAjA1Ukur/mdiPgKY0hLve3mO27
         npfV19qMNBrKglhloalmTix/iTmPY1kqpgFW0HQGrL+ysbTUb6f5uzvnEkV+rzdOj0FK
         1G1JUAE+fx3FuTlZxFpgiDZDPhaZqAI8+JxxJ+7Es9Heb9/7sr2lWZRhs8DtLIk4s/pG
         FAP9z3JKn0m0Yn2TsbahalWgFcRIoEt1e3NdSquap/wsqtiaAqsDbpW5VZXDKf4//1Ty
         Rr4g==
X-Gm-Message-State: AOAM5322dRLYcEdHBsqbTLYM1i5Mgs299JkSOUeUZDZfZcuFLv3yl1ZC
        G5sM3unytWECMVqBA58xs8c=
X-Google-Smtp-Source: ABdhPJze6WndpyzBv8oA+rCboDsQWgmQOwnmfLMGSWq7A6Jn6aYr6PdovCpLTkyvj0c+KuPIFMKxaQ==
X-Received: by 2002:a17:902:6b89:b029:da:fc41:baec with SMTP id p9-20020a1709026b89b02900dafc41baecmr20012241plk.39.1608623296624;
        Mon, 21 Dec 2020 23:48:16 -0800 (PST)
Received: from open-light-1.localdomain (66.98.113.28.16clouds.com. [66.98.113.28])
        by smtp.gmail.com with ESMTPSA id 36sm12872029pgr.56.2020.12.21.23.48.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Dec 2020 23:48:16 -0800 (PST)
From:   Liang Li <liliang.opensource@gmail.com>
X-Google-Original-From: Liang Li <liliangleo@didiglobal.com>
Date:   Tue, 22 Dec 2020 02:48:13 -0500
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liang Li <liliang324@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Subject: [RFC PATCH 2/3] virtio-balloon: add support for providing free huge
 page reports to host
Message-ID: <20201222074810.GA30047@open-light-1.localdomain>
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liang Li <liliang324@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
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
A new feature bit and a new vq is added for this new feature.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Hildenbrand <david@redhat.com>  
Cc: Michal Hocko <mhocko@suse.com> 
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Liang Li <liliang324@gmail.com>
Signed-off-by: Liang Li <liliangleo@didiglobal.com>
---
 drivers/virtio/virtio_balloon.c     | 61 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_balloon.h |  1 +
 2 files changed, 62 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index a298517079bb..61363dfd3c2d 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -52,6 +52,7 @@ enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_STATS,
 	VIRTIO_BALLOON_VQ_FREE_PAGE,
 	VIRTIO_BALLOON_VQ_REPORTING,
+	VIRTIO_BALLOON_VQ_HPG_REPORTING,
 	VIRTIO_BALLOON_VQ_MAX
 };
 
@@ -126,6 +127,10 @@ struct virtio_balloon {
 	/* Free page reporting device */
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
+
+	/* Free hugepage reporting device */
+	struct virtqueue *hpg_reporting_vq;
+	struct page_reporting_dev_info hpr_dev_info;
 };
 
 static const struct virtio_device_id id_table[] = {
@@ -192,6 +197,33 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
 	return 0;
 }
 
+static int virtballoon_free_hugepage_report(struct page_reporting_dev_info *hpr_dev_info,
+				   struct scatterlist *sg, unsigned int nents)
+{
+	struct virtio_balloon *vb =
+		container_of(hpr_dev_info, struct virtio_balloon, hpr_dev_info);
+	struct virtqueue *vq = vb->hpg_reporting_vq;
+	unsigned int unused, err;
+
+	/* We should always be able to add these buffers to an empty queue. */
+	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT | __GFP_NOWARN);
+
+	/*
+	 * In the extremely unlikely case that something has occurred and we
+	 * are able to trigger an error we will simply display a warning
+	 * and exit without actually processing the pages.
+	 */
+	if (WARN_ON_ONCE(err))
+		return err;
+
+	virtqueue_kick(vq);
+
+	/* When host has read buffer, this completes via balloon_ack */
+	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
+
+	return 0;
+}
+
 static void set_page_pfns(struct virtio_balloon *vb,
 			  __virtio32 pfns[], struct page *page)
 {
@@ -515,6 +547,7 @@ static int init_vqs(struct virtio_balloon *vb)
 	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
 	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
 	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
+	names[VIRTIO_BALLOON_VQ_HPG_REPORTING] = NULL;
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
@@ -531,6 +564,11 @@ static int init_vqs(struct virtio_balloon *vb)
 		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
 	}
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HPG_REPORTING)) {
+		names[VIRTIO_BALLOON_VQ_HPG_REPORTING] = "hpg_reporting_vq";
+		callbacks[VIRTIO_BALLOON_VQ_HPG_REPORTING] = balloon_ack;
+	}
+
 	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
 					 vqs, callbacks, names, NULL, NULL);
 	if (err)
@@ -566,6 +604,8 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
 		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HPG_REPORTING))
+		vb->hpg_reporting_vq = vqs[VIRTIO_BALLOON_VQ_HPG_REPORTING];
 	return 0;
 }
 
@@ -1001,6 +1041,24 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 	}
 
+	vb->hpr_dev_info.report = virtballoon_free_hugepage_report;
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HPG_REPORTING)) {
+		unsigned int capacity;
+
+		capacity = virtqueue_get_vring_size(vb->hpg_reporting_vq);
+		if (capacity < PAGE_REPORTING_CAPACITY) {
+			err = -ENOSPC;
+			goto out_unregister_oom;
+		}
+
+		vb->hpr_dev_info.mini_order = 0;
+		vb->hpr_dev_info.batch_size = 2 * 1024 * 1024; /* 2M */
+		vb->hpr_dev_info.delay_jiffies = 1 * HZ; /* 1 seconds */
+		err = hugepage_reporting_register(&vb->hpr_dev_info);
+		if (err)
+			goto out_unregister_oom;
+	}
+
 	virtio_device_ready(vdev);
 
 	if (towards_target(vb))
@@ -1053,6 +1111,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
 		page_reporting_unregister(&vb->pr_dev_info);
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HPG_REPORTING))
+		hugepage_reporting_unregister(&vb->hpr_dev_info);
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		unregister_oom_notifier(&vb->oom_nb);
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
@@ -1133,6 +1193,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
+	VIRTIO_BALLOON_F_HPG_REPORTING,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ddaa45e723c4..8ca8f89d95c6 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -37,6 +37,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_HPG_REPORTING	6 /* Huge page reporting virtqueue */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
-- 
2.18.2

