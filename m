Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9452922AC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 08:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgJSGy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 02:54:28 -0400
Received: from smtp.h3c.com ([60.191.123.50]:42874 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgJSGy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 02:54:27 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 09J6rqpA087016
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 14:53:52 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Oct 2020 14:53:54 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <rpeterso@redhat.com>, <agruenba@redhat.com>
CC:     <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] gfs2: use helper macro abs()
Date:   Mon, 19 Oct 2020 14:43:49 +0800
Message-ID: <20201019064349.48828-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 09J6rqpA087016
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper macro abs() to simplify the "x >= y || x <= -y" cmp.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 fs/gfs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 9f4d9e7be..05eb709de 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -304,7 +304,7 @@ void gfs2_statfs_change(struct gfs2_sbd *sdp, s64 total, s64 free,
 	if (sdp->sd_args.ar_statfs_percent) {
 		x = 100 * l_sc->sc_free;
 		y = m_sc->sc_free * sdp->sd_args.ar_statfs_percent;
-		if (x >= y || x <= -y)
+		if (abs(x) >= y)
 			need_sync = 1;
 	}
 	spin_unlock(&sdp->sd_statfs_spin);
-- 
2.17.1

