Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967132D510E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgLJCw4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Dec 2020 21:52:56 -0500
Received: from mgw-01.mpynet.fi ([82.197.21.90]:50744 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbgLJCw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:52:56 -0500
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 0BA2al1U015078;
        Thu, 10 Dec 2020 04:51:18 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 35b9r801es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 10 Dec 2020 04:51:18 +0200
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Dec 2020 04:51:17 +0200
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.006; Thu, 10 Dec 2020 04:51:17 +0200
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
Thread-Index: AQHV+CW2KXvc7M5VpE2Aohqtho6jyqnuZSUAgALDiICAAAQoAA==
Date:   Thu, 10 Dec 2020 02:51:17 +0000
Message-ID: <C1D18C59-3E1B-4825-881C-B7AE6FACF4D7@tuxera.com>
References: <20200312041353.19877-1-zhengzengkai@huawei.com>
 <94ED375C-C57C-464B-A1CA-BFB1EEF71BB2@tuxera.com>
 <20201209183623.b26e90de3d0aa92a72010ff0@linux-foundation.org>
In-Reply-To: <20201209183623.b26e90de3d0aa92a72010ff0@linux-foundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [86.134.252.216]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C28FABD37D07B4CA17E13423600CA60@ex13.tuxera.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_19:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Ah, oops!  Thank you and apologies.  Quite right the alternative patch was even better.  No need to apply this patch after all...

Zheng, the log_page_mask variable was removed altogether so your patch no longer makes sense.

Best regards,

	Anton

> On 10 Dec 2020, at 02:36, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> On Tue, 8 Dec 2020 08:24:02 +0000 Anton Altaparmakov <anton@tuxera.com> wrote:
> 
>> Can you please apply this?
>> 
>> ...
>> 
>>> --- a/fs/ntfs/logfile.c
>>> +++ b/fs/ntfs/logfile.c
>>> @@ -507,7 +507,7 @@ bool ntfs_check_logfile(struct inode *log_vi, RESTART_PAGE_HEADER **rp)
>>> 	 * optimize log_page_size and log_page_bits into constants.
>>> 	 */
>>> 	log_page_bits = ntfs_ffs(log_page_size) - 1;
>>> -	size &= ~(s64)(log_page_size - 1);
>>> +	size &= ~(s64)(log_page_mask);
>>> 	/*
>>> 	 * Ensure the log file is big enough to store at least the two restart
>>> 	 * pages and the minimum number of log record pages.
> 
> https://lore.kernel.org/lkml/1604821092-54631-1-git-send-email-alex.shi@linux.alibaba.com/
> addressed this?
> 


-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

