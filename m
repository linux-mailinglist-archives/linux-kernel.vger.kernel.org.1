Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F3F2CBB7C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbgLBLWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:22:18 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:47093 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgLBLWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:22:17 -0500
Received: from orion.localdomain ([77.7.48.174]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDPuq-1krXiV0F7u-00AUXr; Wed, 02 Dec 2020 12:19:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 1/2] uapi: virtio_ids.h: consistent indentions
Date:   Wed,  2 Dec 2020 12:19:30 +0100
Message-Id: <20201202111931.31953-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:852JpSmEowTFGghovvL6enFRY4Vm18lONnR++sjGcGSNUZsO8fB
 EbG7NGwqUNuwPT8uPVliTsgDtZ7gXZEvIvMKldIMfbDQHxyv9YcxkVyIafnUolVZcFjPe/j
 xJf5LqXW9m84K0N5H4eeqkPXb2M8M/MyRZGEFRZ8b1xeWKRUI6H0oMGs4lfsQWSaLUCIh/d
 JUkKOje0+/p4OYcoCeF/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SK3xeZ9OKgE=:IgjO3DkBVe/T98WtgqKZry
 PQnlRoFkoM4+X3jlqUxBb6WIH4ZD5wF3+Mg0WkDMhwAWyBHjAOZb3UqoWvrXW6zYDtthRsAgw
 84JPT7m1eA9Gl66m3wLGsgq+uNNHWhXlY1bDvRYDVyuMsfshIGAYPPhc5hWz4RsBu0rc+de0b
 wxQ23mzpAwGSp8uexYJ0ZKchCN6X3HBbFZD8wvVKLnFLVn+4DakXVAbOy/N8FzfutspmeYsBK
 Ckl8HmPlgl1hLJnNZTQesGdwjs5WJaAbG9r7uiO4icdSRp01X9SSWxPCn/zlrh8cThSSKj4Vq
 dUnDBCDHRBEji8lcbnKO3Kh5AnbzS1spPxCDC38a5BNkvln+IVVM9XJbFSO23BzgDZUdRQFkt
 aJmLxILWAwBn1VZnD9HdCCOrrdGk9qS1vE2UIhiF+a9o4tn3GLHE8UpWVkZUC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing the differing indentions to be consistent and properly aligned.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 include/uapi/linux/virtio_ids.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index b052355ac7a3..3cb55e5277a1 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -29,24 +29,24 @@
  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
  * SUCH DAMAGE. */
 
-#define VIRTIO_ID_NET		1 /* virtio net */
-#define VIRTIO_ID_BLOCK		2 /* virtio block */
-#define VIRTIO_ID_CONSOLE	3 /* virtio console */
-#define VIRTIO_ID_RNG		4 /* virtio rng */
-#define VIRTIO_ID_BALLOON	5 /* virtio balloon */
-#define VIRTIO_ID_RPMSG		7 /* virtio remote processor messaging */
-#define VIRTIO_ID_SCSI		8 /* virtio scsi */
-#define VIRTIO_ID_9P		9 /* 9p virtio console */
-#define VIRTIO_ID_RPROC_SERIAL 11 /* virtio remoteproc serial link */
-#define VIRTIO_ID_CAIF	       12 /* Virtio caif */
-#define VIRTIO_ID_GPU          16 /* virtio GPU */
-#define VIRTIO_ID_INPUT        18 /* virtio input */
-#define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
-#define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
-#define VIRTIO_ID_IOMMU        23 /* virtio IOMMU */
-#define VIRTIO_ID_MEM          24 /* virtio mem */
-#define VIRTIO_ID_FS           26 /* virtio filesystem */
-#define VIRTIO_ID_PMEM         27 /* virtio pmem */
-#define VIRTIO_ID_MAC80211_HWSIM 29 /* virtio mac80211-hwsim */
+#define VIRTIO_ID_NET			1 /* virtio net */
+#define VIRTIO_ID_BLOCK			2 /* virtio block */
+#define VIRTIO_ID_CONSOLE		3 /* virtio console */
+#define VIRTIO_ID_RNG			4 /* virtio rng */
+#define VIRTIO_ID_BALLOON		5 /* virtio balloon */
+#define VIRTIO_ID_RPMSG			7 /* virtio remote processor messaging */
+#define VIRTIO_ID_SCSI			8 /* virtio scsi */
+#define VIRTIO_ID_9P			9 /* 9p virtio console */
+#define VIRTIO_ID_RPROC_SERIAL		11 /* virtio remoteproc serial link */
+#define VIRTIO_ID_CAIF			12 /* Virtio caif */
+#define VIRTIO_ID_GPU			16 /* virtio GPU */
+#define VIRTIO_ID_INPUT			18 /* virtio input */
+#define VIRTIO_ID_VSOCK			19 /* virtio vsock transport */
+#define VIRTIO_ID_CRYPTO		20 /* virtio crypto */
+#define VIRTIO_ID_IOMMU			23 /* virtio IOMMU */
+#define VIRTIO_ID_MEM			24 /* virtio mem */
+#define VIRTIO_ID_FS			26 /* virtio filesystem */
+#define VIRTIO_ID_PMEM			27 /* virtio pmem */
+#define VIRTIO_ID_MAC80211_HWSIM	29 /* virtio mac80211-hwsim */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
-- 
2.11.0

