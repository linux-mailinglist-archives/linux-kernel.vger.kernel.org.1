Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574F82997CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgJZURo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:17:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgJZURo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:17:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QK4Fxh104612;
        Mon, 26 Oct 2020 16:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=3W7VBlAWZqf5IJnHH5lVy1IrTIWI9VbzrkSRoY7HNsY=;
 b=rzYdtO+SzxPSirq0VmZzyDLZKYR5mppSQc40evXNG1eRhmsQWsbNPnRL7jH1vRyEdnDi
 cKpilxrnpDI0FuIPNgT+vCjz9aOrZR7pJz+aH3LHiVYtlprauyLNIy855M98rKybRSJL
 6yoXFhvjiz3Zc4vjur6DD4+OhInWQjCdSjHtg9dEk9AUo31Cyb3Ec2qgQpBXmK+MSz7Y
 KMVS+ft2oJohkwYyovYxEJGZ8F31y1L44/nzRQIFAmnbyk4ehASUHH8OG+5ObPniaGb+
 VnF+wOt3eHU/zp8qq2LyieTF9uniXXpTgownxzppae30xTbYVIjnC4F5XkADjDZII2YD vA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34e4jvh52a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 16:17:32 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09QKHSVY032600;
        Mon, 26 Oct 2020 20:17:31 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma05wdc.us.ibm.com with ESMTP id 34cbw8t8kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 20:17:31 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09QKHUC653346612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 20:17:30 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9EE36A04F;
        Mon, 26 Oct 2020 20:17:30 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 822AD6A04D;
        Mon, 26 Oct 2020 20:17:30 +0000 (GMT)
Received: from localhost (unknown [9.65.225.148])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 26 Oct 2020 20:17:30 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v5.10-rc1
In-Reply-To: <CAMuHMdXbsJPnsXg6bA_e32zJkBG1Zzqj-ja5WzHDKL0d9OcfPg@mail.gmail.com>
References: <20201026081811.3934205-1-geert@linux-m68k.org> <CAMuHMdXbsJPnsXg6bA_e32zJkBG1Zzqj-ja5WzHDKL0d9OcfPg@mail.gmail.com>
Date:   Mon, 26 Oct 2020 15:17:29 -0500
Message-ID: <87tuugkahy.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_14:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=2 impostorscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> On Mon, Oct 26, 2020 at 10:46 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Below is the list of build error/warning regressions/improvements in
>> v5.10-rc1[1] compared to v5.9[2].
>>
>> Summarized:
>>   - build errors: +3/-7
>>   - build warnings: +26/-28
>>
>> Happy fixing! ;-)
>>
>> Thanks to the linux-next team for providing the build service.
>>
>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3650b228f83adda7e5ee532e2b90429c03f7b9ec/ (all 192 configs)
>> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bbf5c979011a099af5dc76498918ed7df445635b/ (all 192 configs)
>>
>>
>> *** ERRORS ***
>>
>> 3 error regressions:
>>   + /kisskb/src/arch/um/kernel/skas/clone.c: error: expected declaration specifiers or '...' before string constant:  => 24:16
>
> um-all{mod,yes}config
>
>>   + error: hotplug-memory.c: undefined reference to `of_drconf_to_nid_single':  => .text+0x5e0)
>
> powerpc-gcc5/pseries_le_defconfig+NO_NUMA

Probably introduced by:

commit 72cdd117c449896c707fc6cfe5b90978160697d0
Author: Scott Cheloha <cheloha@linux.ibm.com>
Date:   Wed Sep 16 09:51:22 2020 -0500

    pseries/hotplug-memory: hot-add: skip redundant LMB lookup

Scott?
