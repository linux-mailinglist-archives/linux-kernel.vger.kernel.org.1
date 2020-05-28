Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432951E5E35
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 13:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbgE1L1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 07:27:41 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51930 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388270AbgE1L1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:27:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590665259; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=PxcTF5qcXa2+jnUc/8q+qdeZeapYDpOgOomfvwsus1c=; b=pmXxheEzenpAj/GEmT8iUBWrn8/H4z+dnYwDe8REjIpx0fBES6lvsvQccQOtfRyE30HKFVcp
 mjSiiu8XGHUio7AI5OO2JRkEdOCG57WLS3dHE2aH2y+PSysk/e1qKOYum9ZA7TG3kjNTc6W0
 9lfoEHGcV6JrzyejbIL5DLiz3+0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ecfa01f3131442d9512b868 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 11:27:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D040C43387; Thu, 28 May 2020 11:27:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from zijuhu-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 69921C433C6;
        Thu, 28 May 2020 11:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 69921C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=zijuhu@codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org, mka@chromium.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org
Subject: [PATCH v3] bluetooth: hci_qca: Fix QCA6390 memdump failure
Date:   Thu, 28 May 2020 19:27:19 +0800
Message-Id: <1590665239-18993-1-git-send-email-zijuhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCA6390 memdump VSE sometimes come to bluetooth driver
with wrong sequence number as illustrated as follows:
frame # in DEC: frame data in HEX
1396: ff fd 01 08 74 05 00 37 8f 14
1397: ff fd 01 08 75 05 00 ff bf 38
1414: ff fd 01 08 86 05 00 fb 5e 4b
1399: ff fd 01 08 77 05 00 f3 44 0a
1400: ff fd 01 08 78 05 00 ca f7 41
it is mistook for controller missing packets, so results
in page fault after overwriting memdump buffer allocated.

it is fixed by ignoring QCA6390 sequence number error
and checking buffer space before writing.

Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e4a6823..f5f4508 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -114,6 +114,7 @@ struct qca_memdump_data {
 	char *memdump_buf_tail;
 	u32 current_seq_no;
 	u32 received_dump;
+	u32 ram_dump_size;
 };
 
 struct qca_memdump_event_hdr {
@@ -976,6 +977,8 @@ static void qca_controller_memdump(struct work_struct *work)
 	char nullBuff[QCA_DUMP_PACKET_SIZE] = { 0 };
 	u16 seq_no;
 	u32 dump_size;
+	u32 rx_size;
+	enum qca_btsoc_type soc_type = qca_soc_type(hu);
 
 	while ((skb = skb_dequeue(&qca->rx_memdump_q))) {
 
@@ -1029,6 +1032,7 @@ static void qca_controller_memdump(struct work_struct *work)
 
 			skb_pull(skb, sizeof(dump_size));
 			memdump_buf = vmalloc(dump_size);
+			qca_memdump->ram_dump_size = dump_size;
 			qca_memdump->memdump_buf_head = memdump_buf;
 			qca_memdump->memdump_buf_tail = memdump_buf;
 		}
@@ -1052,25 +1056,52 @@ static void qca_controller_memdump(struct work_struct *work)
 		 * packets in the buffer.
 		 */
 		while ((seq_no > qca_memdump->current_seq_no + 1) &&
+		       (soc_type != QCA_QCA6390) &&
 			seq_no != QCA_LAST_SEQUENCE_NUM) {
 			bt_dev_err(hu->hdev, "QCA controller missed packet:%d",
 				   qca_memdump->current_seq_no);
+			rx_size = qca_memdump->received_dump;
+			rx_size += QCA_DUMP_PACKET_SIZE;
+			if (rx_size > qca_memdump->ram_dump_size) {
+				bt_dev_err(hu->hdev,
+					   "QCA memdump received %d, no space for missed packet",
+					   qca_memdump->received_dump);
+				break;
+			}
 			memcpy(memdump_buf, nullBuff, QCA_DUMP_PACKET_SIZE);
 			memdump_buf = memdump_buf + QCA_DUMP_PACKET_SIZE;
 			qca_memdump->received_dump += QCA_DUMP_PACKET_SIZE;
 			qca_memdump->current_seq_no++;
 		}
 
-		memcpy(memdump_buf, (unsigned char *) skb->data, skb->len);
-		memdump_buf = memdump_buf + skb->len;
-		qca_memdump->memdump_buf_tail = memdump_buf;
-		qca_memdump->current_seq_no = seq_no + 1;
-		qca_memdump->received_dump += skb->len;
+		rx_size = qca_memdump->received_dump + skb->len;
+		if (rx_size <= qca_memdump->ram_dump_size) {
+			if ((seq_no != QCA_LAST_SEQUENCE_NUM) &&
+			    (seq_no != qca_memdump->current_seq_no))
+				bt_dev_err(hu->hdev,
+					   "QCA memdump unexpected packet %d",
+					   seq_no);
+			bt_dev_dbg(hu->hdev,
+				   "QCA memdump packet %d with length %d",
+				   seq_no, skb->len);
+			memcpy(memdump_buf, (unsigned char *)skb->data,
+			       skb->len);
+			memdump_buf = memdump_buf + skb->len;
+			qca_memdump->memdump_buf_tail = memdump_buf;
+			qca_memdump->current_seq_no = seq_no + 1;
+			qca_memdump->received_dump += skb->len;
+		} else {
+			bt_dev_err(hu->hdev,
+				   "QCA memdump received %d, no space for packet %d",
+				   qca_memdump->received_dump, seq_no);
+		}
 		qca->qca_memdump = qca_memdump;
 		kfree_skb(skb);
 		if (seq_no == QCA_LAST_SEQUENCE_NUM) {
-			bt_dev_info(hu->hdev, "QCA writing crash dump of size %d bytes",
-				   qca_memdump->received_dump);
+			bt_dev_info(hu->hdev,
+				    "QCA memdump Done, received %d, total %d",
+				    qca_memdump->received_dump,
+				    qca_memdump->ram_dump_size);
 			memdump_buf = qca_memdump->memdump_buf_head;
 			dev_coredumpv(&hu->serdev->dev, memdump_buf,
 				      qca_memdump->received_dump, GFP_KERNEL);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

