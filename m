Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8629C2D25CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgLHIZg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Dec 2020 03:25:36 -0500
Received: from mgw-02.mpynet.fi ([82.197.21.91]:47840 "EHLO mgw-02.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgLHIZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:25:35 -0500
Received: from pps.filterd (mgw-02.mpynet.fi [127.0.0.1])
        by mgw-02.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 0B88LgdQ032402;
        Tue, 8 Dec 2020 10:24:03 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-02.mpynet.fi with ESMTP id 357xryaceb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 10:24:03 +0200
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Dec 2020 10:24:03 +0200
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.006; Tue, 8 Dec 2020 10:24:03 +0200
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Zheng Zengkai <zhengzengkai@huawei.com>
Subject: Re: [PATCH -next] fs/ntfs: fix set but not used variable
 'log_page_mask'
Thread-Topic: [PATCH -next] fs/ntfs: fix set but not used variable
 'log_page_mask'
Thread-Index: AQHV+CW2KXvc7M5VpE2Aohqtho6jyqnuZSUA
Date:   Tue, 8 Dec 2020 08:24:02 +0000
Message-ID: <94ED375C-C57C-464B-A1CA-BFB1EEF71BB2@tuxera.com>
References: <20200312041353.19877-1-zhengzengkai@huawei.com>
In-Reply-To: <20200312041353.19877-1-zhengzengkai@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [86.166.43.145]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8651C485F171134CAB5309A902F3298E@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_03:2020-12-04,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=942 spamscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012080052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Can you please apply this?

Thanks a lot in advance!

Hi Zheng,

Thank you for the patch!

Best regards,

	Anton

> On 12 Mar 2020, at 04:13, Zheng Zengkai <zhengzengkai@huawei.com> wrote:
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> fs/ntfs/logfile.c: In function ntfs_check_logfile:
> fs/ntfs/logfile.c:481:21:
> warning: variable log_page_mask set but not used [-Wunused-but-set-variable]
> 
> Actually log_page_mask can be used to replace 'log_page_size - 1' as it is set.
> 
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> Acked-by: Anton Altaparmakov <anton@tuxera.com>
> ---
> fs/ntfs/logfile.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs/logfile.c b/fs/ntfs/logfile.c
> index a0c40f1be7ac..c35fcf389369 100644
> --- a/fs/ntfs/logfile.c
> +++ b/fs/ntfs/logfile.c
> @@ -507,7 +507,7 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
> 	 * optimize log_page_size and log_page_bits into constants.
> 	 */
> 	log_page_bits = ntfs_ffs(log_page_size) - 1;
> -	size &= ~(s64)(log_page_size - 1);
> +	size &= ~(s64)(log_page_mask);
> 	/*
> 	 * Ensure the log file is big enough to store at least the two restart
> 	 * pages and the minimum number of log record pages.
> -- 
> 2.20.1
> 


-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

