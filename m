Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAF42A3CE8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 07:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgKCGkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 01:40:47 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:47257 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgKCGkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 01:40:46 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201103064043epoutp01a790fcbdfeb694940d95660ee49fda75~D7D4eDere0920209202epoutp01y
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 06:40:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201103064043epoutp01a790fcbdfeb694940d95660ee49fda75~D7D4eDere0920209202epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604385643;
        bh=7kVoSdrz3LX9VAMCcKcXmj5eb5nlXWXkYaj3ILgRMkc=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=LjbaOj9OVSG8KLXVqLiG5to6J5ptrIT/Mj2uzFQJMF1VeggjkB8KnXbCpcxx5TRNn
         YXhRRWx/lMXt1DDyJ/KkLr0bwdGE5hDEy0fr+Ng43LVJR8AXD+ftr3CjWkSRmtTeJ4
         Gd9p1P3NDjFi76eaHxYvZcvDyQtur5nEpXrO8Wyg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20201103064042epcas2p4b23909d8d07423d4fbd34795faa4f3b5~D7D3jwbUM1771517715epcas2p4u;
        Tue,  3 Nov 2020 06:40:42 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.184]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CQKt03jzWzMqYly; Tue,  3 Nov
        2020 06:40:40 +0000 (GMT)
X-AuditID: b6c32a46-1d9ff7000000dbf8-b9-5fa0fb672736
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.64.56312.76BF0AF5; Tue,  3 Nov 2020 15:40:40 +0900 (KST)
Mime-Version: 1.0
Subject: [f2fs-dev] [PATCH] f2fs: change write_hint for hot/warm nodes
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>
CC:     "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SEUNGUK SHIN <seunguk.shin@samsung.com>,
        Sang-yoon Oh <sangyoon.oh@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Jieon Seol <jieon.seol@samsung.com>,
        Mankyu PARK <manq.park@samsung.com>,
        Jaemyung Lee <jaemyung.lee@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20201103064039epcms2p30ecac0e7cefff0d50745f2e2e61ce38e@epcms2p3>
Date:   Tue, 03 Nov 2020 15:40:39 +0900
X-CMS-MailID: 20201103064039epcms2p30ecac0e7cefff0d50745f2e2e61ce38e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmqW7G7wXxBntvMFmcnnqWyeLlIU2L
        VQ/CLXr7t7JZPFk/i9li88ENzBbbPgtaHD/5jtHi0iJ3i8u75rBZdFz6zGQx4eUSFovbW7gs
        OqevYbFYtHA3iwO/x6ZVnWweuxd8ZvLo27KK0ePzJrkAlqgcm4zUxJTUIoXUvOT8lMy8dFsl
        7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygI5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ
        +cUltkqpBSk5BYaGBXrFibnFpXnpesn5uVaGBgZGpkCVCTkZO5eHFVzmqbj2YgNrA+NSri5G
        Tg4JAROJL3MOsncxcnEICexglDgzYyFjFyMHB6+AoMTfHcIgNcICbhKbH/9lAbGFBJQk1l+c
        xQ4R15O49XANI4jNJqAjMf3EfbC4iECIxOvJLUwgM5kFdrFI7G7eyQSxjFdiRvtTFghbWmL7
        8q2MELaGxI9lvcwQtqjEzdVv2WHs98fmQ9WISLTeOwtVIyjx4OduqLikxLHdH6Dm10tsvfOL
        EWSxhEAPo8ThnbdYIRL6Etc6NoIt5hXwldj89iJYnEVAVWJmy1ImkIclBFwkuhdKgISZBeQl
        tr+dwwwSZhbQlFi/Sx+iQlniyC0WmE8aNv5mR2czC/BJdBz+CxffMe8J1GVqEut+rodaJCNx
        ax7jBEalWYhwnoVk7SyEtQsYmVcxiqUWFOempxYbFRghx+wmRnBq1XLbwTjl7Qe9Q4xMHIyH
        GCU4mJVEeGsi58UL8aYkVlalFuXHF5XmpBYfYjQF+ncis5Rocj4wueeVxBuaGpmZGViaWpia
        GVkoifOGruyLFxJITyxJzU5NLUgtgulj4uCUamDaIXwuUcuG03rdzLAl5+RYZUq6pGLNihf8
        3Oa5a0FqErNkwkKNde9sW47zRd5Z1HTBQ/ny+bZ2Jf6wTY3pwcWzm9iW13Kc/ObjmTJvx2Y3
        jW9RBZNtt9RunLDZ0Sjo/kXOQs5pd5lvMT6ZWl7ufS8sr9y0rndy+7r6N8ufZDP6Cui9+9XN
        9kLvSJf1qiM/59Rstaq7f276ouqlh3027rKtnL2EZUm633KtP8wc+1zZDAKc6hIrmY5oMB5d
        e2B7VNGCTVkZ50MSm+PKVY/uar6jGBr6+YKwntv2e2/83h8v0DjsLf5jUkV6tofD6eqXm/3O
        +O++lblxLUd7Z9m9FsUkDqWK3EphrTdMAotPNCuxFGckGmoxFxUnAgAC32gTNgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201103064039epcms2p30ecac0e7cefff0d50745f2e2e61ce38e
References: <CGME20201103064039epcms2p30ecac0e7cefff0d50745f2e2e61ce38e@epcms2p3>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 818a76a9aee5bf225565264274d211edb07bae7d Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Tue, 3 Nov 2020 15:30:26 +0900


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
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1596502f7375..7b42bb10c6c3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
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

