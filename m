Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E0F27B3F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgI1SCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:24 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:37469 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbgI1SBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:19 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5B2A9E3B;
        Mon, 28 Sep 2020 13:55:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=yT8BqugvTfzX9
        L+ABEmA5mKWIFrSrhshFc+djKx/V3o=; b=aGKrAuFETfvFo4s3uBM7F78Ud8X7/
        xkgCTUDMcd/tBhOn3y4M2odiBIVc+w0gnHamHUE7/pmQCVRkxwQx0xrVBRtaZFSd
        SYRu78pFlEIy59DpizHiI/ivIx3zR3piW2nuHavWVXcoYOVIdmQgK/Fmh9VVVmbW
        3MN3fZoFbfvsr5Nh0T9nbx4IXc1gG2tOqBE1gVDZ1uUPZfpjKaZ5/1ulENnYq1Eh
        gREN3MAcLIOcUF12c0W4q2AV3JlCAp2GOFR6jnZ93A1ySOmn3TwNqu8YYReHLl81
        MGdfCTyDMdZZbXPvbaxiIsfWkU8cEdU5NOePBq35hzjKsTq7vp8JoIj+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=yT8BqugvTfzX9L+ABEmA5mKWIFrSrhshFc+djKx/V3o=; b=Rmjfm5wt
        kVGtJQ24G9TjUoQR/Oq6OBke3QE1yzYEVXda6XuNBCCNyrwr1Z/QesQKOVxm7rtA
        w7N4pMnJ4YrYKof4L2avf4X5X98uJvIwC/s/3Fcp3+G9VsLBqchhS34/yOTSSnD0
        L4sh0vaaX6xtYxfygSZLi3eAt9ic1OSPm61gTGYFWiAS41OrvgZ5jvL5qaLeX7Y7
        NWB7sKeYl2yQy0Rn3oc0KiQ077MKSQ7dkYF7taEkgXidwU3Gz8pxMMissx/1nfKo
        AhyiUFAckTiYQER28ehsjj87Z9i4OtqcsEFPE1eYaotoVe44AWBd34ttZS6qKAtN
        rtbFpVqoHU9tgw==
X-ME-Sender: <xms:iSNyX-QkCbdH0zcIv-3BIYRQn1BzeVZ68dJGK6o2Q45pCrkZ03mQTQ>
    <xme:iSNyXzypLyh69aWMoa6CxHufBeBKhwXwsSFO648eCSL2efwhUbjVEme7ygdhs8Xit
    xePdowy8XJQYbw07A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcujggr
    nhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfffve
    ektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphepuddv
    rdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:iSNyX71OB_Gpun-WetBbpT5lF3m7TAeixz3HQLKCwfA6HBVMalQ50g>
    <xmx:iSNyX6DA-fGE9ENKN-wtzQI66MHXXsMcE-3HWDbVWNaHISH_bjuKFg>
    <xmx:iSNyX3iIKvpV5RGG2T9kilKGy7Cj8o2bnmsVAkI9ApNgzKRIo671FQ>
    <xmx:iSNyX37SQhwSr4Z2I0MQh9wdxPzw_CtJHh2HgtGmkk6BlmyDtLeqwVvHT8c>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id 763C8306468B;
        Mon, 28 Sep 2020 13:55:21 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH v2 10/30] fs: proc: add PUD THP kpageflag.
Date:   Mon, 28 Sep 2020 13:54:08 -0400
Message-Id: <20200928175428.4110504-11-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928175428.4110504-1-zi.yan@sent.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Bit 27 is used to identify PUD THP.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 fs/proc/page.c                         | 2 ++
 include/uapi/linux/kernel-page-flags.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index f3b39a7d2bf3..e4e2ad3612c9 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -161,6 +161,8 @@ u64 stable_page_flags(struct page *page)
 			u |= BIT_ULL(KPF_ZERO_PAGE);
 			u |= BIT_ULL(KPF_THP);
 		}
+		if (compound_order(head) == HPAGE_PUD_ORDER)
+			u |= 1 << KPF_PUD_THP;
 	} else if (is_zero_pfn(page_to_pfn(page)))
 		u |= BIT_ULL(KPF_ZERO_PAGE);
 
diff --git a/include/uapi/linux/kernel-page-flags.h b/include/uapi/linux/kernel-page-flags.h
index 6f2f2720f3ac..62c5fc70909b 100644
--- a/include/uapi/linux/kernel-page-flags.h
+++ b/include/uapi/linux/kernel-page-flags.h
@@ -36,5 +36,6 @@
 #define KPF_ZERO_PAGE		24
 #define KPF_IDLE		25
 #define KPF_PGTABLE		26
+#define KPF_PUD_THP		27
 
 #endif /* _UAPILINUX_KERNEL_PAGE_FLAGS_H */
-- 
2.28.0

