Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1F12705BF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIRTmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:42:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35304 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgIRTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:42:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IJYWMF127873;
        Fri, 18 Sep 2020 19:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gLLLt/l3LL1FLtWMg/vik542PfBSMzOtT2lQkvyS+sY=;
 b=Zm0Wnr1RmE9Xyflr7V0GPma/1SRUrV9wXf62a72scGadz7UMSebqt9V3RnRNpitmKv2w
 uMrjjQqdkEJ7e5duoqkAGDMZY2evdCkjwlxU2aEXOWKHJj9v/vKCRnVXTW9M++laeEDE
 WTzCP4VW82OUl0/yyZqDa0V/p7W1H9oSz0a77ryyuiPUVvIVwzF8ljw+r0dBwBWvZ6I7
 79gHe043KhqdXzJlwimikOcSsagUlcpzsUPA9ZrefFrKxoLxvtEcbuq4Lq3TV308nF/l
 IRReAAI+rpKDsOd/ZFZnmZ2R604ZKePYBvfZsxHbVP+AeOQN48F1YPoc6euI6p9za46N 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 33gnrrh5hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 19:42:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IJe68r030016;
        Fri, 18 Sep 2020 19:42:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33hm37cur6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 19:42:29 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08IJgPxP013051;
        Fri, 18 Sep 2020 19:42:25 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Sep 2020 19:42:25 +0000
Subject: Re: KASAN: null-ptr-deref Read in PageHuge
To:     syzbot <syzbot+3a21fd5ecfc677248e77@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>
References: <0000000000000cea4605af946f8c@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3747b978-77d7-93b3-eca4-28010fab5d01@oracle.com>
Date:   Fri, 18 Sep 2020 12:42:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0000000000000cea4605af946f8c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9748 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9748 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/20 4:02 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6b02addb Add linux-next specific files for 20200915
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17a7441d900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7086d0e9e44d4a14
> dashboard link: https://syzkaller.appspot.com/bug?extid=3a21fd5ecfc677248e77
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141489f1900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1694fd55900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3a21fd5ecfc677248e77@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:71 [inline]
> BUG: KASAN: null-ptr-deref in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
> BUG: KASAN: null-ptr-deref in PageCompound include/linux/page-flags.h:196 [inline]
> BUG: KASAN: null-ptr-deref in PageHuge+0x19/0x170 mm/hugetlb.c:1551
> Read of size 8 at addr 0000000000000000 by task syz-executor410/6864
> 
> CPU: 1 PID: 6864 Comm: syz-executor410 Not tainted 5.9.0-rc5-next-20200915-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x198/0x1fb lib/dump_stack.c:118
>  __kasan_report mm/kasan/report.c:549 [inline]
>  kasan_report.cold+0x5/0x37 mm/kasan/report.c:562
>  check_memory_region_inline mm/kasan/generic.c:186 [inline]
>  check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
>  instrument_atomic_read include/linux/instrumented.h:71 [inline]
>  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:134 [inline]
>  PageCompound include/linux/page-flags.h:196 [inline]
>  PageHuge+0x19/0x170 mm/hugetlb.c:1551
>  find_subpage include/linux/pagemap.h:410 [inline]
>  find_get_incore_page+0x165/0x2e0 mm/swap_state.c:435
>  mincore_page+0x1e/0x310 mm/mincore.c:62
>  __mincore_unmapped_range+0x171/0x2c0 mm/mincore.c:82
>  mincore_pte_range+0x69f/0x980 mm/mincore.c:125
>  walk_pmd_range mm/pagewalk.c:89 [inline]
>  walk_pud_range mm/pagewalk.c:160 [inline]
>  walk_p4d_range mm/pagewalk.c:193 [inline]
>  walk_pgd_range mm/pagewalk.c:229 [inline]
>  __walk_page_range+0xeed/0x22c0 mm/pagewalk.c:331
>  walk_page_range+0x20d/0x400 mm/pagewalk.c:427
>  do_mincore mm/mincore.c:199 [inline]
>  __do_sys_mincore+0x279/0x7a0 mm/mincore.c:264
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x440329
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffe6fca7ae8 EFLAGS: 00000246 ORIG_RAX: 000000000000001b
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440329
> RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000000020001000
> RBP: 00000000006ca018 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000401b30
> R13: 0000000000401bc0 R14: 0000000000000000 R15: 0000000000000000
> ==================================================================

I assume this would also be fixed by 5d1903f712ac
("mm-convert-find_get_entry-to-return-the-head-page-fix")

-- 
Mike Kravetz
