Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247B027C00E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgI2Iv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:51:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35402 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2IvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:51:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08T8j38T084020;
        Tue, 29 Sep 2020 08:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=c2YLPyDXwfRnYYC9GXwYOS9VlCxlBWS/t7RvlFJ3MW0=;
 b=BMVvcltB4OpB1LZG10uXP4w4mA3r7V10zXKpsHferOi1SHTSJK3Wl8mcFc/gEMge+HC/
 1hV2jFx7KQ/E9s0p6t/trSn5CD5+cygDrNB1cMtpcWhCG0uG3e+AC/Qvge55Dl+Gt82k
 8YSvZCGDUHaQiTGCYtwFNy7r+WDZgFnXRaUZJSWNXwgZjNiM2c8CPOzVTEgIe2E6Vf5+
 cO4oAxtcwxR3iCdJq3ZrjNWsTDu8BF52JYIi0Rx0+PBeLc0vvBBvx6HGWZEbNgx614mS
 ApmRrYvYlLHmwnTNkWkf5qSDUnqxnDgracVdEiMb3/3GJo5PxtaLIAOGx1XUcZOeBf6g 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33sx9n1c0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 08:51:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08T8mj3l185278;
        Tue, 29 Sep 2020 08:51:00 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33tfdrmfc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 08:51:00 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08T8ouxY028328;
        Tue, 29 Sep 2020 08:50:56 GMT
Received: from localhost.localdomain (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 01:50:56 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.0.3.2.33\))
Subject: Re: [PATCH v2 00/12] Overhaul multi-page lookups for THP
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200914130042.11442-1-willy@infradead.org>
Date:   Tue, 29 Sep 2020 02:50:55 -0600
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D4D7EBEC-920F-4DCE-9023-A7BB3BFD3137@oracle.com>
References: <20200914130042.11442-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mailer: Apple Mail (2.3654.0.3.2.33)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290080
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9758 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009290080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me; I really like the addition of the "end" parameter to
find_get_entries() and the conversion of pagevec_lookup_entries().=03=03

For the series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>

> On Sep 14, 2020, at 7:00 AM, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> The critical patch to review here is patch 11, "Handle truncates that
> split THPs".  This code is shared with shmem, and while xfstests =
passes
> (both with the tmpfs filesystem and with THPs enabled for XFS), it is
> terribly subtle.
>=20
> I posted a similar patch series a few weeks ago [1], but this goes a =
few
> steps further than that one did.  In addition to the unification of
> find_get_entries() and pagevec_lookup_entries(), this patch series
> includes:
>=20
> - Only return the head pages from tagged lookups
> - Factor a lot of common code out of the various batch lookup routines
> - Add mapping_seek_hole_data()
> - Only return head pages from find_get_entries
>=20
> I also have a patch to iomap to use mapping_seek_hole_data(), but I'm
> not including that as part of this batch of patches -- I'll send it
> through the iomap tree once mapping_seek_hole_data() lands upstream.
>=20
> [1] =
https://lore.kernel.org/linux-mm/20200819184850.24779-1-willy@infradead.or=
g/
>=20
> Matthew Wilcox (Oracle) (12):
>  mm: Make pagecache tagged lookups return only head pages
>  mm/shmem: Use pagevec_lookup in shmem_unlock_mapping
>  mm/filemap: Add helper for finding pages
>  mm/filemap: Add mapping_seek_hole_data
>  mm: Add and use find_lock_entries
>  mm: Add an 'end' parameter to find_get_entries
>  mm: Add an 'end' parameter to pagevec_lookup_entries
>  mm: Remove nr_entries parameter from pagevec_lookup_entries
>  mm: Pass pvec directly to find_get_entries
>  mm: Remove pagevec_lookup_entries
>  mm/truncate,shmem: Handle truncates that split THPs
>  mm/filemap: Return only head pages from find_get_entries
>=20
> include/linux/pagemap.h |   5 +-
> include/linux/pagevec.h |   4 -
> mm/filemap.c            | 267 +++++++++++++++++++++++++++-------------
> mm/internal.h           |   5 +
> mm/shmem.c              | 214 +++++++-------------------------
> mm/swap.c               |  38 +-----
> mm/truncate.c           | 249 ++++++++++++++-----------------------
> 7 files changed, 329 insertions(+), 453 deletions(-)
>=20
> --=20
> 2.28.0
>=20

