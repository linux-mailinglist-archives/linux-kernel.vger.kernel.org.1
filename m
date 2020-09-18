Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E2626FFEC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIROcA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Sep 2020 10:32:00 -0400
Received: from mgw-01.mpynet.fi ([82.197.21.90]:45898 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgIROcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:32:00 -0400
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 08IDjvx1105182;
        Fri, 18 Sep 2020 16:51:17 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 33mx0hr07u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 16:51:16 +0300
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Sep 2020 16:51:15 +0300
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.006; Fri, 18 Sep 2020 16:51:15 +0300
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] ntfs: drop unneeded semi-colons
Thread-Topic: [PATCH RESEND] ntfs: drop unneeded semi-colons
Thread-Index: AQHWjVnswLx9rgGqKE+C2Won5QI6nqluOI0A
Date:   Fri, 18 Sep 2020 13:51:14 +0000
Message-ID: <D97E170A-13E7-4263-B590-32D7F85B9AC6@tuxera.com>
References: <20200918012034.6305-1-rdunlap@infradead.org>
In-Reply-To: <20200918012034.6305-1-rdunlap@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [86.162.107.15]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F51FD6D1C4537498A1ABF9928B4181B@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_14:2020-09-16,2020-09-18 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Sorry, I don't know how I missed those originally.

Andrew, please could you add this to your tree for merging with Linus as well?

And again, please feel free to add: Acked-by: Anton Altaparmakov <anton@tuxera.com>

Thanks a lot!

Best regards,

	Anton

> On 18 Sep 2020, at 02:20, Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> Coccinelle scripts report:
> 
> fs/ntfs/lcnalloc.c:902:2-3: Unneeded semicolon
> fs/ntfs/super.c:1615:2-3: Unneeded semicolon
> fs/ntfs/super.c:1684:2-3: Unneeded semicolon
> 
> so remove the extraneous semicolons.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Anton Altaparmakov <anton@tuxera.com>
> Cc: linux-ntfs-dev@lists.sourceforge.net
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> Adding Andrew to recipients, otherwise this patch is lost/ignored.
> 
> fs/ntfs/lcnalloc.c |    2 +-
> fs/ntfs/super.c    |    4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-next-20200917.orig/fs/ntfs/lcnalloc.c
> +++ linux-next-20200917/fs/ntfs/lcnalloc.c
> @@ -899,7 +899,7 @@ s64 __ntfs_cluster_free(ntfs_inode *ni,
> 		}
> 		/* We have freed @to_free real clusters. */
> 		real_freed = to_free;
> -	};
> +	}
> 	/* Go to the next run and adjust the number of clusters left to free. */
> 	++rl;
> 	if (count >= 0)
> --- linux-next-20200917.orig/fs/ntfs/super.c
> +++ linux-next-20200917/fs/ntfs/super.c
> @@ -1612,7 +1612,7 @@ read_partial_attrdef_page:
> 		memcpy((u8*)vol->attrdef + (index++ << PAGE_SHIFT),
> 				page_address(page), size);
> 		ntfs_unmap_page(page);
> -	};
> +	}
> 	if (size == PAGE_SIZE) {
> 		size = i_size & ~PAGE_MASK;
> 		if (size)
> @@ -1681,7 +1681,7 @@ read_partial_upcase_page:
> 		memcpy((char*)vol->upcase + (index++ << PAGE_SHIFT),
> 				page_address(page), size);
> 		ntfs_unmap_page(page);
> -	};
> +	}
> 	if (size == PAGE_SIZE) {
> 		size = i_size & ~PAGE_MASK;
> 		if (size)


-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

