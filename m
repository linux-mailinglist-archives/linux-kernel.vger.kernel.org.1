Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FF82CF5AD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgLDUbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:31:06 -0500
Received: from mail-am7eur06olkn2082.outbound.protection.outlook.com ([40.92.16.82]:33888
        "EHLO EUR06-AM7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726441AbgLDUbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:31:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoCCi1hpURS/5rg8UVxb3Sztvo18rsGCmuyxruWOedKB3HMa1985u8VALsp8zEjW+VtfC9bUnsEZCiuQGJRY3RhFh3aK9h5si/PVOMtIa0tNUiVyN/DrVxtCe4ovbwKYYS+iMLmQkPpMmMFeLl6AetxZWvB+z7zdah7Spbeh8DOeCUMNA0hCPPN31MHLSyUJyFMdc0u9/YAR0BEwAsyqqXFO8Kts77wRA+QmS8qe9Cwj6HETsFgT4B3aukLNhP650q9Z67PVxbrrN69R66bTF4Zypj/hodHn90MFheX/Ud9dp0u1iMHuY1U3DSbFFL+s2XXBo9O16Lyq5hIMDAskqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE7M5vdF0vcPdSFz2U5avQtQiB721nIcwRtNCgTUl88=;
 b=DByy/xjEPFNBAvwc5v6p+jO8tr6U8Wg0EEIhprZ9DXmmeHMSVbaUqvz6iBSo7prZRk56nluLe/CFzdfBWGG8WZbAlvp1slXKZb/OwQwwre8vL830QS7ZuHRnUt+/hwcPqJwXb5JZGUOHyS+ZbshKPPqfL5lNQ57S12tNjJ5Ofr3K7DbcXg2dZF5VPw7bucgRff+M7hiQO2umnbkqkXHvWkNJpuTtRql5z22uU1nQz5W0olTcFPg+yQCrDQbrrRMlKwf1vX7hocyfsq+kJItY/4SmxkagKJKzzzaKD4vCgACEbNBYE/z8CpjTHgnlZEr7rmPj7wTa6YFdU7ZGP5ehIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM7EUR06FT012.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc36::52) by
 AM7EUR06HT116.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc36::66)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 20:30:16 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc36::4d) by AM7EUR06FT012.mail.protection.outlook.com
 (2a01:111:e400:fc36::338) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 20:30:16 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:A6D5C57CDFBE412AC350190761E9970FD93644C156236F659B0CFFC020EC0D9E;UpperCasedChecksum:4B24C68F26565FBD7052482855AC3E398C3BD8CB7F334DAB87016DC3360782B3;SizeAsReceived:9602;Count:48
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::184e:5e8c:db8f:a596]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::184e:5e8c:db8f:a596%5]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 20:30:16 +0000
Subject: Re: [PATCH 3/3] exec: Transform exec_update_mutex into a rw_semaphore
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
 <87ft4mbqen.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
 <875z5h4b7a.fsf@x220.int.ebiederm.org>
 <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB51704629E50F6280A52D9FAFE4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Fri, 4 Dec 2020 21:30:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [L5kjuUw4qepxhpP0LljBXDsaVHJUJ3H1]
X-ClientProxiedBy: AM4PR0902CA0023.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::33) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <01f6e16d-4a7b-948a-6e3d-038a7b7f3cc7@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (84.57.57.184) by AM4PR0902CA0023.eurprd09.prod.outlook.com (2603:10a6:200:9b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 20:30:14 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 15e6ca6c-6a0e-4e97-cf71-08d898936868
X-MS-TrafficTypeDiagnostic: AM7EUR06HT116:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htIGu6Dck39qBVkBRYxNakpN2BWu3XMV6Lv16HpA6Jbu2ve082y2BcOyIwADienlzYN2b5dPGpeIkEyorlsZW5dbA4uAXtrmqnPg0OtrGqVBrtOGoE/Sl+EeF2qLHLP1yI2tRbKLR7R/AXVH6/736EtxQQ5PMEgbNRHS7fK3tMe5NvmhBHbe2G+MsQt7PumQyvQFcI75T05/UcjqywL9yA==
X-MS-Exchange-AntiSpam-MessageData: 1sI8ycCVT5pfHARymF4/voZhVHRp5UGaW7239TJqqGJMYr6WQBvz4/BLP7rU7GahKJgNmhWh9oLOGfpcM/Z3Tmv/hQyzMNO2mh+FXCs5bll1ZWi7EGiH4JDerUzSuG2ff2AKL3Gka93g1K2GrlK4dg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e6ca6c-6a0e-4e97-cf71-08d898936868
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 20:30:15.9664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR06FT012.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7EUR06HT116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/20 9:10 PM, Linus Torvalds wrote:
> On Fri, Dec 4, 2020 at 11:35 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> From a deadlock perspective the change is strictly better than what we
>> have today.  The readers will no longer block on each other.
> 
> No, agreed, it's better regardless.
> 
>> For the specific case that syzbot reported it is readers who were
>> blocking on each other so that specific case if fixed.
> 
> So the thing is, a reader can still block another reader if a writer
> comes in between them. Which is why I was thinking that the same
> deadlock could happen if somebody does an execve at just the right
> point.
> 
>> On the write side of exec_update_lock we have:
>>
>> cred_guard_mutex -> exec_update_lock
>>
>> Which means that to get an ABBA deadlock cred_guard_mutex would need to
>> be involved
> 
> No, see above: you can get a deadlock with
> 
>  - first reader gets exec_update_lock
> 
>  - writer on exec_update_lock blocks on first reader (this is exec)
> 
>  - second reader of exec_update_lock now blocks on the writer.
> 
> So if that second reader holds something that the first one wants to
> get (or is the same thread as the first one), you have a deadlock: the
> first reader will never make any progress, will never release the
> lock, and the writer will never get it, and the second reader will
> forever wait for the writer that is ahead of it in the queue.
> 
> cred_guard_mutex is immaterial, it's not involved in the deadlock.
> Yes, the writer holds it, but it's not relevant for anything else.
> 
> And that deadlock looks very much like what syzcaller detected, in
> exactly that scenario:
> 
>   Chain exists of:
>     &sig->exec_update_mutex --> sb_writers#4 --> &p->lock
> 
>    Possible unsafe locking scenario:
> 
>          CPU0                    CPU1
>          ----                    ----
>     lock(&p->lock);
>                                  lock(sb_writers#4);
>                                  lock(&p->lock);
>     lock(&sig->exec_update_mutex);
> 
>    *** DEADLOCK ***
> 
> No?  The only thing that is missing is that writer that causes the
> exec_update_mutex readers to block each other - exactly like they did
> when it was a mutex.
> 
> But I may be missing something entirely obvious that keeps this from happening.
> 

I think you convinced me:

>    perf_event_open  (exec_update_mutex -> ovl_i_mutex)
>    chown            (ovl_i_mutex       -> sb_writes)
>    sendfile         (sb_writes         -> p->lock)
>      by reading from a proc file and writing to overlayfs
>    proc_pid_syscall (p->lock           -> exec_update_mutex)


We need just 5 Philosophers (A-E):

Philosopher A calls proc_pid_syscall, takes p->lock, and falls asleep for a while now.

Philosphper B calls sendfile, takes sb_writes, and has to wait on p->lock.

Philosopher C calls chown, takes ovl_i_mutes, and has to wait on sb_writes.

Philosopher D calls perf_event_open, takes down_read(exec_mutex_lock), and has to wait on ovl_i_mutex.

Philosopher E calls exec, and wants to take down_write(exec_mutex_lock), has to wait for Philosopher D.

Now Philosopher A wakes up from his sleep, and wants to take down_read(exec_mutex_lock), but due
to fairness reasons, he has to wait until Philosopher E gets and releases his write lock again.

If Philosopher A is now blocked, we have a deadlock, right?


Bernd.



>          Linus
> 
