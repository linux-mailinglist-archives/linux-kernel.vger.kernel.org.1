Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF412A3F0D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgKCIim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:38:42 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:64576 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgKCIil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:38:41 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201103083838epoutp029f3e7c33f341b1c85089a72cc56e82f3~D8q1NxaxL2703627036epoutp02B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 08:38:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201103083838epoutp029f3e7c33f341b1c85089a72cc56e82f3~D8q1NxaxL2703627036epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604392718;
        bh=2slUiaMyn0QDJdipUDeb4qUXXKNFI4uPO4BiSpLVKtM=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=M83qgVoTI3yoQNHAkIoIhoGLU7ikhFm1QQB9cEvD7ZG6gy4SnOzcIi8dcyihBTxWs
         AnoWD8Us4CUdqYo39Gyql4uK27cYndxtPE8sZDLUkO3lZW1CVGXUf/W8fWGrwK5O2h
         rF6czHqhne92sIx1ZITyreun7rnbwkwWbk3B0LjU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20201103083837epcas2p2275f8f3c3d9d291f115133ccbbe03421~D8q0jKCHs2885028850epcas2p2-;
        Tue,  3 Nov 2020 08:38:37 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CQNV34kcKzMqYm1; Tue,  3 Nov
        2020 08:38:35 +0000 (GMT)
X-AuditID: b6c32a48-50fff7000000cd1f-0e-5fa11708496c
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        65.DF.52511.80711AF5; Tue,  3 Nov 2020 17:38:32 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] f2fs: change write_hint for hot/warm nodes
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        Daejun Park <daejun7.park@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Chao Yu <yuchao0@huawei.com>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Jieon Seol <jieon.seol@samsung.com>,
        Sang-yoon Oh <sangyoon.oh@samsung.com>,
        Mankyu PARK <manq.park@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>,
        SEUNGUK SHIN <seunguk.shin@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Jaemyung Lee <jaemyung.lee@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20201103083832epcms2p6c8b0e4470f1392772317ab2b25256b3d@epcms2p6>
Date:   Tue, 03 Nov 2020 17:38:32 +0900
X-CMS-MailID: 20201103083832epcms2p6c8b0e4470f1392772317ab2b25256b3d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmmS6H+MJ4gwVzzCxOTz3LZPHykKbF
        qgfhFr39W9ksnqyfxWyx+eAGZottnwUtjp98x2hxaZG7xeVdc9gsOi59ZrKY8HIJi8XtLVwW
        ndPXsFgsWribxWLq47WsDgIeLUfesnpsWtXJ5rF7wWcmj74tqxg9Pm+SC2CNyrHJSE1MSS1S
        SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpXSaEsMacUKBSQWFys
        pG9nU5RfWpKqkJFfXGKrlFqQklNgaFigV5yYW1yal66XnJ9rZWhgYGQKVJmQk/FmqkbBG4mK
        dSvfszYwLhXoYuTkkBAwkVi38gRTFyMXh5DADkaJz63XGbsYOTh4BQQl/u4QBqkRFrCT2PL4
        OguILSSgJLH+4ix2iLiexK2HaxhBbDYBHYnpJ+6DxUUEaiSuP3vJBjKTWWADi8TE7xPZIZbx
        Ssxof8oCYUtLbF++lRHC1pD4sayXGcIWlbi5+i07jP3+2HyoGhGJ1ntnoWoEJR783A0Vl5Q4
        tvsDE4RdL7H1zi9GkMUSAj2MEod33mKFSOhLXOvYCLaYV8BX4sPZNWBxFgFViemta6BqXCRW
        3poCtoBZQF5i+9s5zKCAYBbQlFi/Sx/ElBBQljhyiwXmlYaNv9nR2cwCfBIdh//CxXfMewJ1
        mprEup/rmSDGyEjcmsc4gVFpFiKgZyFZOwth7QJG5lWMYqkFxbnpqcVGBSbIUbuJEZxwtTx2
        MM5++0HvECMTB+MhRgkOZiUR3prIefFCvCmJlVWpRfnxRaU5qcWHGE2BHp7ILCWanA9M+Xkl
        8YamRmZmBpamFqZmRhZK4ryhK/vihQTSE0tSs1NTC1KLYPqYODilGpiWVM5NnFAkOm/2+8Ij
        DbwP5aZ682YU3eq9Uy7ePi9z/SnWq98yGM8+Oa4zU/Munz3Tu1zBj3U8yWtDzzbzGMotcXl2
        72alaFRJqZ97cu8k20lRtV8Dtxy1tv5i9Yrddy07u+2Z0I6pQp3/S10meTUfS/Bgvld9myNx
        C9vOqxncfBoRXvbcOycWxu24ILfk1lmX7FXno08+/nCn4krDae2Lio4pi5IlXwiHaXLXMfqe
        nuRvGfHD0+CITGnbPyNZF507y4/9YDuy8U1lo1jbv9uhAje39ygWT729TUf519tAk3vdnlw7
        Ly3REd8lGZ4pdu3Q5s+ptXfUm24UHD09w76r+qaGitrbPQpb3rCwTFNiKc5INNRiLipOBABY
        ftT5QQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201103083832epcms2p6c8b0e4470f1392772317ab2b25256b3d
References: <CGME20201103083832epcms2p6c8b0e4470f1392772317ab2b25256b3d@epcms2p6>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the fs-based mode of F2FS, the mapping of hot/warm node to
WRITE_LIFE_NOT_SET should be changed to WRITE_LIFE_SHORT.

As a result of analyzing the write pattern of f2fs using real workload,
hot/warm nodes have high update ratio close to hot data.[*]
However, F2FS passes write hints for hot/warm nodes as WRITE_LIFE_NOT_SET.

Furthermore, WRITE_LIFE_NOT_SET is a default value of write hint when it is
not provided from the file system.
In storage, write_hint is used to distinguish streams (e.g. NVMe).
So, the hot/warm node of F2FS is not distinguished from other write_hints,
which can make the wrong stream seperation.

* Liang, Yu, et al. "An empirical study of F2FS on mobile devices." 2017
IEEE 23rd International Conference on Embedded and Real-Time Computing
Systems and Applications (RTCSA).

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
v2: update documentation and comments
---
 Documentation/filesystems/f2fs.rst | 4 ++--
 fs/f2fs/segment.c                  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index b8ee761c9922..afa3da7cfade 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -717,8 +717,8 @@ WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
 ===================== ======================== ===================
 User                  F2FS                     Block
 ===================== ======================== ===================
-                      META                     WRITE_LIFE_MEDIUM;
-                      HOT_NODE                 WRITE_LIFE_NOT_SET
+                      META                     WRITE_LIFE_MEDIUM
+                      HOT_NODE                 WRITE_LIFE_SHORT
                       WARM_NODE                "
                       COLD_NODE                WRITE_LIFE_NONE
 ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1596502f7375..577ab7516c6b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3160,8 +3160,8 @@ int f2fs_rw_hint_to_seg_type(enum rw_hint hint)
  *
  * User                  F2FS                     Block
  * ----                  ----                     -----
- *                       META                     WRITE_LIFE_MEDIUM;
- *                       HOT_NODE                 WRITE_LIFE_NOT_SET
+ *                       META                     WRITE_LIFE_MEDIUM
+ *                       HOT_NODE                 WRITE_LIFE_SHORT
  *                       WARM_NODE                "
  *                       COLD_NODE                WRITE_LIFE_NONE
  * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
@@ -3208,7 +3208,7 @@ enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 				return WRITE_LIFE_EXTREME;
 		} else if (type == NODE) {
 			if (temp == WARM || temp == HOT)
-				return WRITE_LIFE_NOT_SET;
+				return WRITE_LIFE_SHORT;
 			else if (temp == COLD)
 				return WRITE_LIFE_NONE;
 		} else if (type == META) {
-- 
2.25.1

