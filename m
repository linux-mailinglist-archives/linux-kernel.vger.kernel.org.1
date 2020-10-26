Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AC7298D16
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775450AbgJZMtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:49:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31864 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1768773AbgJZMtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:49:16 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QCVXgJ064124;
        Mon, 26 Oct 2020 08:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=bqwTbaY0zoK0LnzolQoSvx8nZf5VrMi+TXH1mZIm1BY=;
 b=EAdhfrPjN/L1fnbf7kipSJTrwOILJKkY6Gi7QbIUCIVRWLdCWc76SX/0aHxMvKIt4x1Z
 YnT5MywVU2agvsQHKlx1KY/9pfXMzRpzHkjZX8OS55+T9GUMsHCixPhEXivImOZRgEVR
 dLCKHnz7DYMPYBaaLbXRMgjwHU+74LF++lLeXaHAh88p++fsjxLQ3HqAtgXPaMmIa5N/
 crpWlqOoiV00NHaR/HrzDqaxoig2M+4B9x3zRxnOhmFYaR0dinF2leAXgkQzdlKTU9+/
 pZoEwZIeRuW8T8TVkS4aiZhZw+l98IJf2cguHNlYbQTs865Aar35rVRhmWKUcO1Umz8O Zg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34dw512xj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 08:49:11 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09QCkdUB020076;
        Mon, 26 Oct 2020 12:49:09 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 34cbw7t7gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 12:49:09 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09QCn7GY23396770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 12:49:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 476864C044;
        Mon, 26 Oct 2020 12:49:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1FAA4C046;
        Mon, 26 Oct 2020 12:49:06 +0000 (GMT)
Received: from localhost (unknown [9.145.93.124])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 26 Oct 2020 12:49:06 +0000 (GMT)
Date:   Mon, 26 Oct 2020 13:49:05 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-s390@vger.kernel.org, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [Regression] s390x build broken with 5.10-rc1 (bisected)
Message-ID: <cover.thread-96dc81.your-ad-here.call-01603716370-ext-5478@work.hours>
References: <20201026104811.22ta4pby2chmz4pv@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201026104811.22ta4pby2chmz4pv@lion.mk-sys.cz>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_06:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=2
 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=687 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 11:48:11AM +0100, Michal Kubecek wrote:
> Hello,
> 
> 5.10-rc1 builds on s390x fail with
> 
>   make -f ./scripts/Makefile.build obj=arch/s390/boot arch/s390/boot/bzImage
>   make -f ./scripts/Makefile.modpost
>   make -f ./scripts/Makefile.modfinal
>   make -f ./scripts/Makefile.build obj=arch/s390/boot/compressed arch/s390/boot/compressed/vmlinux
>           s1=`s390x-suse-linux-objdump -t -j ".boot.data" "vmlinux" | sort | sed -n "/0000000000000000/! s/.*\s.boot.data\s\+//p" | sha256sum`; s2=`s390x-suse-linux-objdump -t -j ".boot.data" "arch/s390/boot/compressed/vmlinux" | sort | sed -n "/0000000000000000/! s/.*\s.boot.data\s\+//p" | sha256sum`; if [ "$s1" != "$s2" ]; then echo "error: section .boot.data differs between vmlinux and arch/s390/boot/compressed/vmlinux" >&2; exit 1; fi; touch arch/s390/boot/section_cmp.boot.data
>           s1=`s390x-suse-linux-objdump -t -j ".boot.preserved.data" "vmlinux" | sort | sed -n "/0000000000000000/! s/.*\s.boot.preserved.data\s\+//p" | sha256sum`; s2=`s390x-suse-linux-objdump -t -j ".boot.preserved.data" "arch/s390/boot/compressed/vmlinux" | sort | sed -n "/0000000000000000/! s/.*\s.boot.preserved.data\s\+//p" | sha256sum`; if [ "$s1" != "$s2" ]; then echo "error: section .boot.preserved.data differs between vmlinux and arch/s390/boot/compressed/vmlinux" >&2; exit 1; fi; touch arch/s390/boot/section_cmp.boot.preserved.data
>   error: section .boot.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
>   make[1]: *** [arch/s390/boot/Makefile:65: arch/s390/boot/section_cmp.boot.data] Error 1
>   make[1]: *** Waiting for unfinished jobs....
>   error: section .boot.preserved.data differs between vmlinux and arch/s390/boot/compressed/vmlinux
>   make[1]: *** [arch/s390/boot/Makefile:65: arch/s390/boot/section_cmp.boot.preserved.data] Error 1
>   make: *** [arch/s390/Makefile:153: bzImage] Error 2
>   make: *** Waiting for unfinished jobs....
> 
> Bisect identified commit 33def8498fdd ("treewide: Convert macro and uses
> of __section(foo) to __section("foo")"), i.e. the very last commit
> before tagging v5.10-rc1.
> 
> I can reproduce this with e.g. defconfig and both native s390x build and
> build on x86_64 using cross compiler. I used gcc 10.2.1 and binutils 2.34.
> 
> Michal

Hello Michal,

I've already fixed that. The fix will appear shortly on s390/fixes
Thank you for reporting!

Vasily Gorbik (1):
  s390: correct __bootdata / __bootdata_preserved macros

 arch/s390/include/asm/sections.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.4
