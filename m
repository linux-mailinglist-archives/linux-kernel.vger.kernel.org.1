Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDC62B3DA8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgKPHaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:30:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49562 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbgKPHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:30:21 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AG722CR079802;
        Mon, 16 Nov 2020 02:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=VHNxyxnhRygWhPh7u6PPy+e4MDCuK+5zMCSvg6qk98U=;
 b=tgpcn+OSZvDwpur5i1ZEG2klUSl8atqs0f1HAPGnAw6hcYETKysmzhy400ICRh0EFcGl
 3GPxy+ZHgwQJB4egCmjcquxY0YRmzuPL/Jz0Mw8FY46NPyB9tT/nyC31FUAefZ/emWDJ
 2/x+8K0fqKeIzpDYp0cYlHNGenLcBC42xilAmAQox+/sPo84yS/HA5ILS5UNZx3pvOE9
 vIhF638IlqiyktAat1ekeRnetsRhbEUlOjCrqtaut05m2YeERwUC2rRAczJrmpGQxabS
 ukL1wiLzo/SLJzTHCjM5Qfvnd7yK9IwIhFNKm0SjUS11vOZ36htJAjggByvgvptWw54x 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34umkf8qsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 02:30:17 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AG7DLmu122803;
        Mon, 16 Nov 2020 02:30:16 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34umkf8qru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 02:30:16 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AG7SSfI005052;
        Mon, 16 Nov 2020 07:30:15 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 34t6v88x6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 07:30:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AG7UC1D3605234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 07:30:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBC59A406A;
        Mon, 16 Nov 2020 07:30:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 789E0A4062;
        Mon, 16 Nov 2020 07:30:10 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.92.115])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Nov 2020 07:30:10 +0000 (GMT)
Subject: Re: [PATCH] md: dm-writeback: add __noreturn to BUG-ging function
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20201113225228.20563-1-rdunlap@infradead.org>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com>
Date:   Mon, 16 Nov 2020 08:30:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201113225228.20563-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-16_01:2020-11-13,2020-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011160039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.11.20 23:52, Randy Dunlap wrote:
> Building on arch/s390/ flags this as an error, so add the
> __noreturn attribute modifier to prevent the build error.
> 
> cc1: some warnings being treated as errors
> ../drivers/md/dm-writecache.c: In function 'persistent_memory_claim':
> ../drivers/md/dm-writecache.c:323:1: error: no return statement in function returning non-void [-Werror=return-type]

ok with me, but I am asking why

the unreachable macro is not good enough. For x86 it obviously is.

form arch/s390/include/asm/bug.h
#define BUG() do {                                      \
        __EMIT_BUG(0);                                  \
        unreachable();                                  \
} while (0)


> 
> Fixes: 48debafe4f2f ("dm: add writecache target")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: dm-devel@redhat.com
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  drivers/md/dm-writecache.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20201113.orig/drivers/md/dm-writecache.c
> +++ linux-next-20201113/drivers/md/dm-writecache.c
> @@ -317,7 +317,7 @@ err1:
>  	return r;
>  }
>  #else
> -static int persistent_memory_claim(struct dm_writecache *wc)
> +static int __noreturn persistent_memory_claim(struct dm_writecache *wc)
>  {
>  	BUG();
>  }
> 
