Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468D026FFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 16:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIROVF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Sep 2020 10:21:05 -0400
Received: from mgw-01.mpynet.fi ([82.197.21.90]:44176 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIROVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 10:21:04 -0400
X-Greylist: delayed 1815 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 10:21:03 EDT
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 08IDjwQW105193;
        Fri, 18 Sep 2020 16:50:17 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 33mx0hr06y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 16:50:17 +0300
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Sep 2020 16:50:15 +0300
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.006; Fri, 18 Sep 2020 16:50:15 +0300
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] ntfs: layout.h: delete duplicated words
Thread-Topic: [PATCH RESEND] ntfs: layout.h: delete duplicated words
Thread-Index: AQHWjVno/QViatPVMke4USkB+fdGRKluOEeA
Date:   Fri, 18 Sep 2020 13:50:15 +0000
Message-ID: <7CF99C49-7EB0-455C-808A-72EA117E113B@tuxera.com>
References: <20200918012021.6255-1-rdunlap@infradead.org>
In-Reply-To: <20200918012021.6255-1-rdunlap@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [86.162.107.15]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D7B7EA98255504CB75B25F78D5A4EAA@ex13.tuxera.com>
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

Andrew, please could you add this to your tree for merging with Linus?

Please feel free to add: Acked-by: Anton Altaparmakov <anton@tuxera.com>

Thanks a lot!

Best regards,

	Anton

> On 18 Sep 2020, at 02:20, Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> Drop the repeated words "the" and "in" in comments.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Anton Altaparmakov <anton@tuxera.com>
> Cc: linux-ntfs-dev@lists.sourceforge.net
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> Adding Andrew to recipients, otherwise this patch is lost/ignored.
> 
> fs/ntfs/layout.h |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200917.orig/fs/ntfs/layout.h
> +++ linux-next-20200917/fs/ntfs/layout.h
> @@ -703,7 +703,7 @@ typedef struct {
> /* 14*/	le16 instance;		/* The instance of this attribute record. This
> 				   number is unique within this mft record (see
> 				   MFT_RECORD/next_attribute_instance notes in
> -				   in mft.h for more details). */
> +				   mft.h for more details). */
> /* 16*/	union {
> 		/* Resident attributes. */
> 		struct {
> @@ -1838,7 +1838,7 @@ typedef struct {
>  * Also, each security descriptor is stored twice in the $SDS stream with a
>  * fixed offset of 0x40000 bytes (256kib, the Windows cache manager's max size)
>  * between them; i.e. if a SDS_ENTRY specifies an offset of 0x51d0, then the
> - * the first copy of the security descriptor will be at offset 0x51d0 in the
> + * first copy of the security descriptor will be at offset 0x51d0 in the
>  * $SDS data stream and the second copy will be at offset 0x451d0.
>  */
> typedef struct {


-- 
Anton Altaparmakov <anton at tuxera.com> (replace at with @)
Lead in File System Development, Tuxera Inc., http://www.tuxera.com/
Linux NTFS maintainer

