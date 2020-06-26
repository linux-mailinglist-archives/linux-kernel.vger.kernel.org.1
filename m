Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A4D20BAE4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 23:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFZVDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 17:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZVDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:03:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC67C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:03:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so9990483wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vy/ATAOFX7hbrWnTtmOf9WcoxFFYxh+7iBRu7AfkTYw=;
        b=xTFOm6hMZFZbuppmRkJTMHqPXMzmAubWeSMzxBy7lrBIXmkyL9a6JFdkYDAuC9nn/W
         OgMTb/szyuAj+UEEJV6cLWlVf/IdSET9LEtaewKMpkCURkv7/4RAIzLBFmScn9JJW/9R
         D0OGE5V3a7cOsP4Xt0zGQGf41zSNkKFQtICsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vy/ATAOFX7hbrWnTtmOf9WcoxFFYxh+7iBRu7AfkTYw=;
        b=L3R1rB9qr3H5fBJeE10N1BuaV7P8WPyyh5n2g1vVXVhz9nZnYniNfhF4FcM6YApRC3
         NwHHejE2GNEd/1Ov5V2CM0relc8ClT2l8DMyWu5dSu4PvOqraKr0dLfDdWyGU17IlNP3
         xjFDAA6kT8861rPBcMTDv0/8btBOSAqlfygFcdMuoMV1wNDfUUEFe3nSUIQVU+m9tL8Z
         74RLHVfFMlZtE3LfGa7yLzUDVXKWVE98d8D0fLcF08fLsoPYV6r49tAVtXy33S6GY3Y8
         mhgByFX9eS4EunRDwHb3YXEwn4kcJ4rQL51KqmlTnnFMEHpraRijSq2g28ywTDU9ZCzm
         TQbg==
X-Gm-Message-State: AOAM531zG/lEVnHEqhFJ7moFJvvmVUeB8ufYn0edIuYX24Yt+XGYsljd
        VZJVU5yp8YrG/EvfH6ewNYRJtg==
X-Google-Smtp-Source: ABdhPJxGkzKg+v+1VtCr3Q2WGSAzD+kLcRZYjMGgxMzklkxXqbllXB2rdz+l2+MTPnkb0ndF461zYQ==
X-Received: by 2002:a1c:ac81:: with SMTP id v123mr5146884wme.159.1593205398177;
        Fri, 26 Jun 2020 14:03:18 -0700 (PDT)
Received: from localhost.localdomain (88-144-169-139.host.pobb.as13285.net. [88.144.169.139])
        by smtp.gmail.com with ESMTPSA id 138sm20024203wma.23.2020.06.26.14.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:03:17 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        dm-crypt@saout.de, linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, ebiggers@kernel.org,
        Damien.LeMoal@wdc.com, mpatocka@redhat.com,
        herbert@gondor.apana.org.au, kernel-team@cloudflare.com
Subject: [PATCH v2] dm crypt: add flags to optionally bypass dm-crypt workqueues
Date:   Fri, 26 Jun 2020 22:03:02 +0100
Message-Id: <20200626210302.1813-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up from [1]. Consider the following script:

sudo modprobe brd rd_nr=1 rd_size=4194304

echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0' | \
sudo dmsetup create eram0

echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0 1 no_write_workqueue' | \
sudo dmsetup create eram0-inline-write

echo '0 8388608 crypt capi:ecb(cipher_null) - 0 /dev/ram0 0 1 no_read_workqueue' | \
sudo dmsetup create eram0-inline-read

devices="/dev/ram0 /dev/mapper/eram0 /dev/mapper/eram0-inline-read "
devices+="/dev/mapper/eram0-inline-write"

for dev in $devices; do
  echo "reading from $dev"
  sudo fio --filename=$dev --readwrite=read --bs=4k --direct=1 \
  --loops=1000000 --runtime=3m --name=plain | grep READ
done

for dev in $devices; do
  echo "writing to $dev"
  sudo fio --filename=$dev --readwrite=write --bs=4k --direct=1 \
  --loops=1000000 --runtime=3m --name=plain | grep WRITE
done

This script creates a ramdisk (to eliminate hardware bias in the benchmark) and
three dm-crypt instances on top. All dm-crypt instances use the NULL cipher
to eliminate potentially expensive crypto bias (the NULL cipher just uses memcpy
for "encyption"). The first instance is the current dm-crypt implementation from
5.8-rc2, the two others have new optional flags enabled, which bypass kcryptd
workqueues for reads and writes respectively and write sorting for writes. On
my VM (Debian in VirtualBox with 4 cores on 2.8 GHz Quad-Core Intel Core i7) I
get the following output (formatted for better readability):

reading from /dev/ram0
   READ: bw=508MiB/s (533MB/s), 508MiB/s-508MiB/s (533MB/s-533MB/s), io=89.3GiB (95.9GB), run=180000-180000msec

reading from /dev/mapper/eram0
   READ: bw=80.6MiB/s (84.5MB/s), 80.6MiB/s-80.6MiB/s (84.5MB/s-84.5MB/s), io=14.2GiB (15.2GB), run=180000-180000msec

reading from /dev/mapper/eram0-inline-read
   READ: bw=295MiB/s (309MB/s), 295MiB/s-295MiB/s (309MB/s-309MB/s), io=51.8GiB (55.6GB), run=180000-180000msec

reading from /dev/mapper/eram0-inline-write
   READ: bw=114MiB/s (120MB/s), 114MiB/s-114MiB/s (120MB/s-120MB/s), io=20.1GiB (21.5GB), run=180000-180000msec

writing to /dev/ram0
  WRITE: bw=516MiB/s (541MB/s), 516MiB/s-516MiB/s (541MB/s-541MB/s), io=90.7GiB (97.4GB), run=180001-180001msec

writing to /dev/mapper/eram0
  WRITE: bw=40.4MiB/s (42.4MB/s), 40.4MiB/s-40.4MiB/s (42.4MB/s-42.4MB/s), io=7271MiB (7624MB), run=180001-180001msec

writing to /dev/mapper/eram0-inline-read
  WRITE: bw=38.9MiB/s (40.8MB/s), 38.9MiB/s-38.9MiB/s (40.8MB/s-40.8MB/s), io=7000MiB (7340MB), run=180001-180001msec

writing to /dev/mapper/eram0-inline-write
  WRITE: bw=277MiB/s (290MB/s), 277MiB/s-277MiB/s (290MB/s-290MB/s), io=48.6GiB (52.2GB), run=180000-180000msec

Current dm-crypt implementation creates a significant IO performance overhead
(at least on small IO block sizes) for both latency and throughput. We suspect
offloading IO request processing into workqueues and async threads is more
harmful these days with the modern fast storage. I also did some digging into
the dm-crypt git history and much of this async processing is not needed
anymore, because the reasons it was added are mostly gone from the kernel. More
details can be found in [2] (see "Git archeology" section).

This change adds no_(read|write)_workqueue flags separately for read and write
BIOs, which direct dm-crypt not to offload crypto operations into kcryptd
workqueues and process everything inline. In addition, writes are not buffered
to be sorted in the dm-crypt red-black tree, but dispatched immediately. For
cases, where crypto operations cannot happen inline (hard interrupt context,
for example the read path of some NVME drivers), we offload the work to a
tasklet rather than a workqueue.

These flags ensure inline BIO processing in the dm-crypt module only. It is
worth noting that some Crypto API implementations may offload encryption into
their own workqueues, which are independent of the dm-crypt and its
configuration. However upon enabling no_(read|write)_workqueue flags dm-crypt
will instruct Crypto API not to backlog crypto requests.

[1]: https://www.spinics.net/lists/dm-crypt/msg07516.html
[2]: https://blog.cloudflare.com/speeding-up-linux-disk-encryption/

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 drivers/md/dm-crypt.c | 68 +++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 000ddfab5ba0..6924eb49b1df 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -69,6 +69,7 @@ struct dm_crypt_io {
 	u8 *integrity_metadata;
 	bool integrity_metadata_from_pool;
 	struct work_struct work;
+	struct tasklet_struct tasklet;
 
 	struct convert_context ctx;
 
@@ -127,7 +128,8 @@ struct iv_elephant_private {
  * and encrypts / decrypts at the same time.
  */
 enum flags { DM_CRYPT_SUSPENDED, DM_CRYPT_KEY_VALID,
-	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD };
+	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD,
+	     DM_CRYPT_NO_READ_WORKQUEUE, DM_CRYPT_NO_WRITE_WORKQUEUE };
 
 enum cipher_flags {
 	CRYPT_MODE_INTEGRITY_AEAD,	/* Use authenticated mode for cihper */
@@ -1449,7 +1451,7 @@ static void kcryptd_async_done(struct crypto_async_request *async_req,
 			       int error);
 
 static void crypt_alloc_req_skcipher(struct crypt_config *cc,
-				     struct convert_context *ctx)
+				     struct convert_context *ctx, bool nobacklog)
 {
 	unsigned key_index = ctx->cc_sector & (cc->tfms_count - 1);
 
@@ -1463,12 +1465,12 @@ static void crypt_alloc_req_skcipher(struct crypt_config *cc,
 	 * requests if driver request queue is full.
 	 */
 	skcipher_request_set_callback(ctx->r.req,
-	    CRYPTO_TFM_REQ_MAY_BACKLOG,
+	    nobacklog ? 0 : CRYPTO_TFM_REQ_MAY_BACKLOG,
 	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));
 }
 
 static void crypt_alloc_req_aead(struct crypt_config *cc,
-				 struct convert_context *ctx)
+				 struct convert_context *ctx, bool nobacklog)
 {
 	if (!ctx->r.req_aead)
 		ctx->r.req_aead = mempool_alloc(&cc->req_pool, GFP_NOIO);
@@ -1480,17 +1482,17 @@ static void crypt_alloc_req_aead(struct crypt_config *cc,
 	 * requests if driver request queue is full.
 	 */
 	aead_request_set_callback(ctx->r.req_aead,
-	    CRYPTO_TFM_REQ_MAY_BACKLOG,
+	    nobacklog ? 0 : CRYPTO_TFM_REQ_MAY_BACKLOG,
 	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req_aead));
 }
 
 static void crypt_alloc_req(struct crypt_config *cc,
-			    struct convert_context *ctx)
+			    struct convert_context *ctx, bool nobacklog)
 {
 	if (crypt_integrity_aead(cc))
-		crypt_alloc_req_aead(cc, ctx);
+		crypt_alloc_req_aead(cc, ctx, nobacklog);
 	else
-		crypt_alloc_req_skcipher(cc, ctx);
+		crypt_alloc_req_skcipher(cc, ctx, nobacklog);
 }
 
 static void crypt_free_req_skcipher(struct crypt_config *cc,
@@ -1523,7 +1525,7 @@ static void crypt_free_req(struct crypt_config *cc, void *req, struct bio *base_
  * Encrypt / decrypt data from one bio to another one (can be the same one)
  */
 static blk_status_t crypt_convert(struct crypt_config *cc,
-			 struct convert_context *ctx)
+			 struct convert_context *ctx, bool noresched)
 {
 	unsigned int tag_offset = 0;
 	unsigned int sector_step = cc->sector_size >> SECTOR_SHIFT;
@@ -1533,7 +1535,7 @@ static blk_status_t crypt_convert(struct crypt_config *cc,
 
 	while (ctx->iter_in.bi_size && ctx->iter_out.bi_size) {
 
-		crypt_alloc_req(cc, ctx);
+		crypt_alloc_req(cc, ctx, noresched);
 		atomic_inc(&ctx->cc_pending);
 
 		if (crypt_integrity_aead(cc))
@@ -1566,7 +1568,8 @@ static blk_status_t crypt_convert(struct crypt_config *cc,
 			atomic_dec(&ctx->cc_pending);
 			ctx->cc_sector += sector_step;
 			tag_offset++;
-			cond_resched();
+			if (!noresched)
+				cond_resched();
 			continue;
 		/*
 		 * There was a data integrity error.
@@ -1879,6 +1882,9 @@ static void kcryptd_crypt_write_io_submit(struct dm_crypt_io *io, int async)
 	unsigned long flags;
 	sector_t sector;
 	struct rb_node **rbp, *parent;
+	bool nosort =
+			(likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags)) ||
+			test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);
 
 	if (unlikely(io->error)) {
 		crypt_free_buffer_pages(cc, clone);
@@ -1892,7 +1898,7 @@ static void kcryptd_crypt_write_io_submit(struct dm_crypt_io *io, int async)
 
 	clone->bi_iter.bi_sector = cc->start + io->sector;
 
-	if (likely(!async) && test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags)) {
+	if (nosort) {
 		generic_make_request(clone);
 		return;
 	}
@@ -1941,7 +1947,7 @@ static void kcryptd_crypt_write_convert(struct dm_crypt_io *io)
 	sector += bio_sectors(clone);
 
 	crypt_inc_pending(io);
-	r = crypt_convert(cc, &io->ctx);
+	r = crypt_convert(cc, &io->ctx, test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags));
 	if (r)
 		io->error = r;
 	crypt_finished = atomic_dec_and_test(&io->ctx.cc_pending);
@@ -1971,7 +1977,7 @@ static void kcryptd_crypt_read_convert(struct dm_crypt_io *io)
 	crypt_convert_init(cc, &io->ctx, io->base_bio, io->base_bio,
 			   io->sector);
 
-	r = crypt_convert(cc, &io->ctx);
+	r = crypt_convert(cc, &io->ctx, test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags));
 	if (r)
 		io->error = r;
 
@@ -2031,9 +2037,29 @@ static void kcryptd_crypt(struct work_struct *work)
 		kcryptd_crypt_write_convert(io);
 }
 
+static void kcryptd_crypt_tasklet(unsigned long work)
+{
+	kcryptd_crypt((struct work_struct *)work);
+}
+
 static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 {
 	struct crypt_config *cc = io->cc;
+	bool noworkqueue =
+			(bio_data_dir(io->base_bio) == READ && test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags)) ||
+			(bio_data_dir(io->base_bio) == WRITE && test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags));
+
+	if (noworkqueue) {
+		if (in_irq()) {
+			/* Crypto API's "skcipher_walk_first() refuses to work in hard IRQ context */
+			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
+			tasklet_schedule(&io->tasklet);
+			return;
+		}
+
+		kcryptd_crypt(&io->work);
+		return;
+	}
 
 	INIT_WORK(&io->work, kcryptd_crypt);
 	queue_work(cc->crypt_queue, &io->work);
@@ -2838,7 +2864,7 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
 	struct crypt_config *cc = ti->private;
 	struct dm_arg_set as;
 	static const struct dm_arg _args[] = {
-		{0, 6, "Invalid number of feature args"},
+		{0, 8, "Invalid number of feature args"},
 	};
 	unsigned int opt_params, val;
 	const char *opt_string, *sval;
@@ -2868,6 +2894,10 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
 
 		else if (!strcasecmp(opt_string, "submit_from_crypt_cpus"))
 			set_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags);
+		else if (!strcasecmp(opt_string, "no_read_workqueue"))
+			set_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags);
+		else if (!strcasecmp(opt_string, "no_write_workqueue"))
+			set_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);
 		else if (sscanf(opt_string, "integrity:%u:", &val) == 1) {
 			if (val == 0 || val > MAX_TAG_SIZE) {
 				ti->error = "Invalid integrity arguments";
@@ -3196,6 +3226,8 @@ static void crypt_status(struct dm_target *ti, status_type_t type,
 		num_feature_args += !!ti->num_discard_bios;
 		num_feature_args += test_bit(DM_CRYPT_SAME_CPU, &cc->flags);
 		num_feature_args += test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags);
+		num_feature_args += test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags);
+		num_feature_args += test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);
 		num_feature_args += cc->sector_size != (1 << SECTOR_SHIFT);
 		num_feature_args += test_bit(CRYPT_IV_LARGE_SECTORS, &cc->cipher_flags);
 		if (cc->on_disk_tag_size)
@@ -3208,6 +3240,10 @@ static void crypt_status(struct dm_target *ti, status_type_t type,
 				DMEMIT(" same_cpu_crypt");
 			if (test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags))
 				DMEMIT(" submit_from_crypt_cpus");
+			if (test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags))
+				DMEMIT(" no_read_workqueue");
+			if (test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))
+				DMEMIT(" no_write_workqueue");
 			if (cc->on_disk_tag_size)
 				DMEMIT(" integrity:%u:%s", cc->on_disk_tag_size, cc->cipher_auth);
 			if (cc->sector_size != (1 << SECTOR_SHIFT))
@@ -3320,7 +3356,7 @@ static void crypt_io_hints(struct dm_target *ti, struct queue_limits *limits)
 
 static struct target_type crypt_target = {
 	.name   = "crypt",
-	.version = {1, 21, 0},
+	.version = {1, 22, 0},
 	.module = THIS_MODULE,
 	.ctr    = crypt_ctr,
 	.dtr    = crypt_dtr,
-- 
2.20.1

