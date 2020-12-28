Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4D82E34AB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 08:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgL1HP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 02:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgL1HP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 02:15:28 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990ABC061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 23:14:47 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id i20so8547267qvk.18
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 23:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc;
        bh=+w8BZ65tjlpdxVh8d2na0pdcvFUUAjnRCf3t4vTPoxA=;
        b=v05ZhOmzB4jgkv9Mp/LjpdSAk/+B/kUwqpY5Mw+l4+0XqMVdbQo7J9aS0jB+KcWCPB
         jrA8bunL1xLLcX0S3vx5bQm6xfCHypGU7RYR3eBexx/7SMsChZi5VbXyqKa2oNsilyP9
         k5EJM/tw4224icKTaKeMNr7mpQLf0NINzBsp26WszuKNtVwObKqXQxvFJmO0Ae3E2Woh
         VUUs5tyn14tsCtVuzumJb/UDR+c8hYhQb6UWOeXRiajt//70S1kzj1s42wlj6ih3istd
         5UDYU9e3j6L5l1Yh3yYEm5VaNZJfS/lsBwE1DhT0XNhOamXU0Jyo4t05PbdyHAtbqAGM
         Y5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc;
        bh=+w8BZ65tjlpdxVh8d2na0pdcvFUUAjnRCf3t4vTPoxA=;
        b=ilEjFwTQeMNOH4P0twGqbZ/LNqL86maFsk/15m5bht+X066EEtbWihAO9gXcpmKKvh
         +cWIV3kZm+6QzS/QlSFR6tzXgvUAaxRCdWRUg3C+7FxswC/v4HCPe4h6PqsWqMLqFu7D
         0L5zDlCgdZPUwiTxssa8y7OzBkdi9aPwGpIgKois5VNczk+/8E7k0pNE8fxcR3sVe9Yu
         5og2QZnoQgJy2ybux9IuR7rqqJVLHZJPVnwG1Kpm5ghGevlgDStv8PxnaJBM6nmqB+oh
         N+p3EykaQsvo+mix4PfODkbJuA2CyNC353JpMe7IivxcCSE4YgEJl5EJ+sud5cpcOcDF
         p00g==
X-Gm-Message-State: AOAM532YBsT2EI1VzzrcdE/uYRNbWYzc+1GkCeoeM/FwMKU/eyWBhhoe
        oO43nKy2woJAQqxE4UFEmvQbf0YtyEz48Q==
X-Google-Smtp-Source: ABdhPJwYhYXH7IdJV7dMiy+2k7Wa6r+n6ZiCaXAaglrarLLDjIRb1AN6v/I7xiaOhU5MdtB2k6dgZbDAGEARfg==
Sender: "akailash via sendgmr" <akailash@akailash.c.googlers.com>
X-Received: from akailash.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1e6])
 (user=akailash job=sendgmr) by 2002:a05:6214:1754:: with SMTP id
 dc20mr45736851qvb.7.1609139686600; Sun, 27 Dec 2020 23:14:46 -0800 (PST)
Date:   Mon, 28 Dec 2020 07:14:07 +0000
Message-Id: <ecb35731d19b41984dd7157d48661f5297a1b668.1609119545.git.akailash@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] dm-snapshot: Flush merged data before committing metadata
From:   Akilesh Kailash <akailash@google.com>
Cc:     akailash@google.com, dvander@google.com, kernel-team@android.com,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the origin device has a volatile write-back
cache and the following events occur:

1: After finishing merge operation of one set of exceptions,
   merge_callback() is invoked.
2: Update the metadata in COW device tracking the merge completion.
   This update to COW device is flushed cleanly.
3: System crashes and the origin device's cache where the recent
   merge was completed has not been flushed.

During the next cycle when we read the metadata from the COW device,
we will skip reading those metadata whose merge was completed in
step (1). This will lead to data loss/corruption.

To address this, flush the origin device post merge IO before
updating the metadata.

Signed-off-by: Akilesh Kailash <akailash@google.com>
---
 drivers/md/dm-snap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 4668b2cd98f4..11890db71f3f 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -141,6 +141,11 @@ struct dm_snapshot {
 	 * for them to be committed.
 	 */
 	struct bio_list bios_queued_during_merge;
+
+	/*
+	 * Flush data after merge.
+	 */
+	struct bio flush_bio;
 };
 
 /*
@@ -1121,6 +1126,17 @@ static void snapshot_merge_next_chunks(struct dm_snapshot *s)
 
 static void error_bios(struct bio *bio);
 
+static int flush_data(struct dm_snapshot *s)
+{
+	struct bio *flush_bio = &s->flush_bio;
+
+	bio_reset(flush_bio);
+	bio_set_dev(flush_bio, s->origin->bdev);
+	flush_bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
+
+	return submit_bio_wait(flush_bio);
+}
+
 static void merge_callback(int read_err, unsigned long write_err, void *context)
 {
 	struct dm_snapshot *s = context;
@@ -1134,6 +1150,11 @@ static void merge_callback(int read_err, unsigned long write_err, void *context)
 		goto shut;
 	}
 
+	if (flush_data(s) < 0) {
+		DMERR("Flush after merge failed: shutting down merge");
+		goto shut;
+	}
+
 	if (s->store->type->commit_merge(s->store,
 					 s->num_merging_chunks) < 0) {
 		DMERR("Write error in exception store: shutting down merge");
@@ -1318,6 +1339,7 @@ static int snapshot_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	s->first_merging_chunk = 0;
 	s->num_merging_chunks = 0;
 	bio_list_init(&s->bios_queued_during_merge);
+	bio_init(&s->flush_bio, NULL, 0);
 
 	/* Allocate hash table for COW data */
 	if (init_hash_tables(s)) {
@@ -1504,6 +1526,8 @@ static void snapshot_dtr(struct dm_target *ti)
 
 	dm_exception_store_destroy(s->store);
 
+	bio_uninit(&s->flush_bio);
+
 	dm_put_device(ti, s->cow);
 
 	dm_put_device(ti, s->origin);
-- 
2.29.2.729.g45daf8777d-goog

