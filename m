Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31089212830
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgGBPmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 11:42:20 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:57175 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbgGBPmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:42:17 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200702154214epoutp01c4cd1fdbfbd21b836609172d8fb70991~d_dSOk8hE2079620796epoutp011
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 15:42:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200702154214epoutp01c4cd1fdbfbd21b836609172d8fb70991~d_dSOk8hE2079620796epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593704534;
        bh=w3gBvUllQl4Xfn65TlaPAu9PKFeAfpv83AwoDs7hlJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=izOV2O0L4wILjoFYQI+d0xXkCPjLIbAcB3a2i5giVdNsMRQ2+tn3IU9y5QYyGiZSY
         s/dRUyerU0sw9gaV3phv6DfEVFaMEqhlZpm2k7rzdVYbGnTcW0Hztj1Q578KyBcNV+
         dzIJ2sFMv6wIxA/oCXQV1/4Wjs8Q0kplG9g3QBNM=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200702154213epcas5p1f4178438e4510c09856fef9c2f0de250~d_dRcZZsu0362503625epcas5p1_;
        Thu,  2 Jul 2020 15:42:13 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.93.09475.5500EFE5; Fri,  3 Jul 2020 00:42:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200702154213epcas5p4e8d42861cb5ae91ddeccf1ed73107304~d_dQ5Eh3q0916109161epcas5p4B;
        Thu,  2 Jul 2020 15:42:13 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200702154213epsmtrp2f4499e948140739dda8d46395b2bdbfe~d_dQ4QIwZ1523715237epsmtrp2L;
        Thu,  2 Jul 2020 15:42:13 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-1d-5efe0055dc8e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.3D.08303.4500EFE5; Fri,  3 Jul 2020 00:42:12 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200702154210epsmtip1efde914ac48c288c309f028a5df2305c~d_dO15mG-3197931979epsmtip1I;
        Thu,  2 Jul 2020 15:42:10 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     axboe@kernel.dk, kbusch@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@lst.de, Damien.LeMoal@wdc.com,
        Kanchan Joshi <joshi.k@samsung.com>,
        Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: [PATCH 2/2] block: enable zone-append for iov_iter of bvec type
Date:   Thu,  2 Jul 2020 21:08:50 +0530
Message-Id: <1593704330-11540-3-git-send-email-joshi.k@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593704330-11540-1-git-send-email-joshi.k@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7bCmlm4ow784g09HFSx+T5/CarH6bj+b
        RWv7NyaLlauPMlk8vvOZ3eLo/7dsFpMOXWO02HtL2+LyrjlsFtt+z2e2uDJlEbPF6x8n2Rx4
        PC6fLfXYtKqTzWP3zQY2j74tqxg9Pm+S82g/0M0UwBbFZZOSmpNZllqkb5fAlXH47D6WghUC
        FX2PZrE1MO7k7WLk5JAQMJH4vKydsYuRi0NIYDejxK7V11ggnE+MEld3zGSCcD4zShzpecwC
        07LpzRSoxC5GiQ+3vrDCVd3ofQw0jIODTUBT4sLkUpAGEQE1ib2LPrGB1DALtDFJzFpxnR0k
        ISzgIXF0zw8mEJtFQFXi7Jv3bCA2r4CzxP+VD6G2yUncPNfJDGJzCrhIfJ3bCHafhMBHdont
        6+dBFblIrNv8lhXCFpZ4dXwLO4QtJfH53V42CLtY4tedo8wQzR2MEtcbZkI120tc3POXCeRq
        ZqCr1+/SBwkzC/BJ9P5+AhaWEOCV6GgTgqhWlLg36SnUKnGJhzOWQNkeElMXLIIGxHRGie/T
        T7JOYJSdhTB1ASPjKkbJ1ILi3PTUYtMC47zUcr3ixNzi0rx0veT83E2M4KSh5b2D8dGDD3qH
        GJk4GA8xSnAwK4nwnjb4FSfEm5JYWZValB9fVJqTWnyIUZqDRUmcV+nHmTghgfTEktTs1NSC
        1CKYLBMHp1QDk2WFfL6yloqawrK/1zauOXZT/pPittM6DmY3ChY/OsHta/HvnviNrs6HX8RY
        2X8/klB6x/BDxSLDvjPOSWpjHN897pcf6jLn/e27XulzkVnSR9XBUd8tY9Wrzn/Mt3ImSvzr
        23lL9L3OiymzzGt+OMluqDOZwSj/WjpDZEbP+U/8+tIv1VNyhF9Mr7vKs2Z3yjeZ7DsPbLW2
        m+gx701oOdyU8vL6rBUlJ5K8/SclX8/m+TqB+6VChmBOU3TIjmL+JV8TKiI3+hdqfGM8078/
        4H0Ro6oYc0uu+N1f/EY1x15sZNlltTTgb8TNr5m7FBw7vi+QXqMneMW9ZI+10B69nSevqQlM
        LRGvM16mK+6kxFKckWioxVxUnAgA0ynZQokDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSnG4Iw784g8lHzCx+T5/CarH6bj+b
        RWv7NyaLlauPMlk8vvOZ3eLo/7dsFpMOXWO02HtL2+LyrjlsFtt+z2e2uDJlEbPF6x8n2Rx4
        PC6fLfXYtKqTzWP3zQY2j74tqxg9Pm+S82g/0M0UwBbFZZOSmpNZllqkb5fAlXH47D6WghUC
        FX2PZrE1MO7k7WLk5JAQMJHY9GYKE4gtJLCDUeLvFi2IuLhE87Uf7BC2sMTKf8+BbC6gmo+M
        EtPW3GHrYuTgYBPQlLgwuRSkRkRAQ2LF52VMIDXMAn1MEkvezQBrFhbwkDi65wfYAhYBVYmz
        b96zgdi8As4S/1c+ZIFYICdx81wnM4jNKeAi8XVuIwvEQc4S29+0sE9g5FvAyLCKUTK1oDg3
        PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4WLW0djDuWfVB7xAjEwfjIUYJDmYlEd7TBr/ihHhT
        EiurUovy44tKc1KLDzFKc7AoifN+nbUwTkggPbEkNTs1tSC1CCbLxMEp1cBkKXc398SuzJeN
        MhWHfBYZC6xXLjK4Y/nfKdTJtdrhgJPD391anq/fTMpfN8dwp/efOUde5rTJGlp6RVetqi15
        t+ismDd3d/LGvwIhismcp+PK3/cVWah56Pp+cFpRE3ukte7gn0PaFopPTyrErWb/nNQax/lP
        Wpf5zd+KxXlWb1Pr0ja37vGfyN5VIhtwQHGdNotVINflvJD/XXLXbzAI1E9cFLJ6/4qQ31vU
        WqKtm3dq2XQyzw4wu5sb9bNBJtHS/19Z6xJVqdv9Bc/fCXOnVfcXBKdeP5Cr6jV9uQnn1CWe
        ZzZ/OPzl3oGjLh7NnDZfSgIWnzEvi9zT97D2w/JXwimSQrMbeVa/1tzgpsRSnJFoqMVcVJwI
        AIiLEaLFAgAA
X-CMS-MailID: 20200702154213epcas5p4e8d42861cb5ae91ddeccf1ed73107304
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200702154213epcas5p4e8d42861cb5ae91ddeccf1ed73107304
References: <1593704330-11540-1-git-send-email-joshi.k@samsung.com>
        <CGME20200702154213epcas5p4e8d42861cb5ae91ddeccf1ed73107304@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zone-append with bvec iov_iter gives WARN_ON, and returns -EINVAL.
Add new helper to process such iov_iter and add pages in bio honoring
zone-append specific constraints.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Selvakumar S <selvakuma.s1@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier Gonzalez <javier.gonz@samsung.com>
---
 block/bio.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 0cecdbc..ade9da7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -975,6 +975,30 @@ static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
 	iov_iter_advance(iter, size);
 	return 0;
 }
+static int __bio_iov_bvec_append_add_pages(struct bio *bio, struct iov_iter *iter)
+{
+	const struct bio_vec *bv = iter->bvec;
+	unsigned int len;
+	size_t size;
+	struct request_queue *q = bio->bi_disk->queue;
+	unsigned int max_append_sectors = queue_max_zone_append_sectors(q);
+	bool same_page = false;
+
+	if (WARN_ON_ONCE(!max_append_sectors))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(iter->iov_offset > bv->bv_len))
+		return -EINVAL;
+
+	len = min_t(size_t, bv->bv_len - iter->iov_offset, iter->count);
+	size = bio_add_hw_page(q, bio, bv->bv_page, len,
+				bv->bv_offset + iter->iov_offset,
+				max_append_sectors, &same_page);
+	if (unlikely(size != len))
+		return -EINVAL;
+	iov_iter_advance(iter, size);
+	return 0;
+}
 
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
 
@@ -1105,9 +1129,10 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 
 	do {
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-			if (WARN_ON_ONCE(is_bvec))
-				return -EINVAL;
-			ret = __bio_iov_append_get_pages(bio, iter);
+			if (is_bvec)
+				ret = __bio_iov_bvec_append_add_pages(bio, iter);
+			else
+				ret = __bio_iov_append_get_pages(bio, iter);
 		} else {
 			if (is_bvec)
 				ret = __bio_iov_bvec_add_pages(bio, iter);
-- 
2.7.4

