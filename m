Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41652B6D92
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgKQSjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:39:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgKQSjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:39:47 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AHIWOw7149360;
        Tue, 17 Nov 2020 13:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=T6Ye0CKhENIxOnxeqWCOYLZpFw1tGya9HrUY+2DOlMg=;
 b=kAvEr5rC8uQ3wB1V6PUhwhpvWnXmCy4CYG8uz0tV5Fm0AskFbU8ePQP5yjKUFt5vVY4+
 hJGtJCrXJNfeQie/ys6uX9USfIVedXrq83m3I1XOHDphmG35vPd8snJeldaMeXICT6IR
 gKm/uX4FfQ6Kh0Eb8Wyhn7MkVCALZlSG5ETYexoGMw2GxfEqXw4p+8J6JhuNtPHIAw/W
 BI0HeQfa/3kx3Cu6En/UFiqE78fezS86h/Rr7tBk5zYchviamMEnIX3zEA0vYJigojAF
 lwABJWztXGvPRmFXlpZpKzpQLuLHaZBB5dxUhwYHH97AgEZE5Wbcnv3de+kIBvBUApIc ew== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34vb0vu0se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 13:39:33 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AHISkGI006341;
        Tue, 17 Nov 2020 18:39:30 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 34t6v8bcaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 18:39:30 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AHIdRBb1245722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Nov 2020 18:39:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8C8752051;
        Tue, 17 Nov 2020 18:39:27 +0000 (GMT)
Received: from osiris (unknown [9.171.25.24])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 22B5252052;
        Tue, 17 Nov 2020 18:39:27 +0000 (GMT)
Date:   Tue, 17 Nov 2020 19:39:25 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: irq-loongson-pch-pic.c:undefined reference to `of_iomap'
Message-ID: <20201117183925.GC4746@osiris>
References: <202011140757.5QyVghe2-lkp@intel.com>
 <4f6f2244-033c-8413-818d-0b9c1b0b33ae@infradead.org>
 <CAK8P3a0w5MpvExp1jShAhqZ3Z08HjMALic6x2K+1_0eqFUi5QA@mail.gmail.com>
 <CAMuHMdU2L5GcEHdCHh_1-WaVVQNGkm0-CwFW5D1KS0dkqBQ3zw@mail.gmail.com>
 <CAK8P3a2+DvA4zwRBh_0cCuXJWxsg3SX8rQRZYfgB=8We9R6uiQ@mail.gmail.com>
 <20201117183455.GA101572@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117183455.GA101572@kozik-lap>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_07:2020-11-17,2020-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=886
 malwarescore=0 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 07:34:55PM +0100, Krzysztof Kozlowski wrote:
> > Looking a bit further, I now find that we ended up disabling CONFIG_COMPILE_TEST
> > entirely for arch/um, which is clearly an option that would also work for s390.
> 
> Yes, that was the easier solution than to spread "depends on HAS_IOMEM"
> all over Kconfigs.
> 
> +Cc Greg KH,
> 
> I got similar report around phy drivers:
> https://lore.kernel.org/lkml/202011140335.tceVqHmN-lkp@intel.com/
> 
> When reproducing this, I saw multiple unmet dependencies on s390 for
> MFD_SYSCON and MFD_STM32_TIMERS.
> 
> I suppose there is no point to fix them all because this will be
> basically UML case, so HAS_IOMEM all over the tree.

FWIW, I just replied a couple of minutes, but you might have missed
that:
---
I'll add a patch to the s390 tree which disables CONFIG_COMPILE_TEST
for s390. I wouldn't like to start again chasing/adding missing
'select' or 'depends on' statements in various config files.
---
