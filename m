Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8D9276DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgIXJtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:49:13 -0400
Received: from mail-eopbgr30095.outbound.protection.outlook.com ([40.107.3.95]:9614
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgIXJtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:49:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAUTSYWiTHK1PKBdyyuV1yiVIeu3cwsiRp6zb+5qpfmo7R23tWpjxrk5s6NZA1LQZFS8Ybzgm0AG1ZVdarb1IQ5xKq083lExhHHcjgyMfSqKv4yDvXkNurQ5LFIe43VBnliNSpYcFYw2IgzvIYjAYyX6j6kKVDbEarXd7GJqqWvIJa3BAN7DTPAPoDHfQY/NdI9dVBOLaAyHIxx2Qa0NusU7DvA7Nbxc3VZ29iwyg15EUdFid0+NkafMr/0kNSxYupZayc1yFGxl50pT4y6KlE7+6D9099R2b5JLglbhXlLk14YOtSkmjYHvER4Lr7vRpLGVz++TMXu1HXgJFLSoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hukn/JD4oITsQURViHpoCASLFZIBSq6hgAULG/73YaA=;
 b=L3+Mcz1hmsCuDtWsFSWXwRtxc87w8rpqObFePTlF3uqT3GLHjzAFGQlodMV4N/flMA3jNOZk4gocVVUKbvBVtCz/koqDDM4eI3g/C7PYOT+QMQ6RyNRRvgyaPVxVw2cFzA3LnvKHF+WbuHbVucWj38ZqqGlk8QTuGpbzPPCi1juCDDqaYedHcDek/tv1wVT9WVFJzisxMhEYrvnJPBg0GJzyYe7hP+7H3Q5XvLJwxGXtPsuAOAronJrkWiE1dm0MYioE9xDDnZoXw+P7LNuiBR3/mn/QZjFIExj/IhIhtlf8QXzIOHsfd2VBkWYvKACpZhXnk9xV0Nn2ksSG7NPIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hukn/JD4oITsQURViHpoCASLFZIBSq6hgAULG/73YaA=;
 b=elxrdQRupyymmkgDCbuofo2XQvj+ufFUQdVBJsi4puY8CxwWrN+/kFv4+6L+aELJ5jRbRdo9X+CwfmBX7fQa2riBU9KRVyso1TJ+vFKqJULJr+UBsyCobZTJX6LfH3l2UO5ImFpKaRygWTUck9BzzClzTxr8DdY7oY+D3Eij5Go=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB2628.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:12f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 09:49:09 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acf4:4f51:6c3a:8cbc]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acf4:4f51:6c3a:8cbc%5]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 09:49:09 +0000
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200923151129.GC6442@alley> <20200924054058.GE577@jagdpanzerIV.localdomain>
 <20200924084555.GJ6442@alley> <20200924085343.GB541@jagdpanzerIV.localdomain>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <a3a29f06-9ecc-ae21-c0fe-2f86fe31f780@prevas.dk>
Date:   Thu, 24 Sep 2020 11:49:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200924085343.GB541@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0111.eurprd04.prod.outlook.com
 (2603:10a6:208:55::16) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM0PR04CA0111.eurprd04.prod.outlook.com (2603:10a6:208:55::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 09:49:08 +0000
X-Originating-IP: [81.216.59.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9da837d8-5516-4e42-a244-08d8606f158c
X-MS-TrafficTypeDiagnostic: AM0PR10MB2628:
X-Microsoft-Antispam-PRVS: <AM0PR10MB262894DDD9A2CD3ACED05B7093390@AM0PR10MB2628.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fh5+vQIbVDhsMBlrZIW4EIq2EHc+0UwMXvbJh0/71g8QwGrh/zoOiDv2ZivmRX8GURNBBaIrc3VA5eGj2vGTtFhk8szLnUklJ883X0YwW7zJMpdR+1/bx+89Gaw7PBWeD5bgj6joGNKLZxOxkRB/GpiuQZeTSTMpbPvpDIiQA2Vmq6VzHZjnr00jIeq1viNqwuj/V/ilGwO34TzhK/0qRZETjiaCj2FKmpwh328krhRONVMDi/CNZU85H1ULXcQ8fvlC+d2lMERRT1yrp/Ex7o/x2hi4hLdNal3FjBQJIxQCnP0V7jnRgnoK+V4KZ2q43Qhqx+Ewd7tLt4i1mFk4NjyZxUE8ZACHNFEYylBgalYjEEWawQGQtRaubL0vuSTM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(39840400004)(346002)(4326008)(36756003)(316002)(956004)(31696002)(52116002)(86362001)(16526019)(31686004)(186003)(478600001)(26005)(44832011)(16576012)(54906003)(110136005)(2616005)(66946007)(5660300002)(66556008)(8976002)(66476007)(2906002)(6486002)(8936002)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vL/fQR+pBQqqDjG9gOm5L4S4ZGfqwQ7zyPR+rtwmkf9YEXH+R4E0bc2IOw9cZbBKYRI2YqaXon7SPYH3OJd3ZoB1SRbKv39G+lF+n+RyJUluMKOpJI6AG+kbNuUUqPephVmXLeUXSgEpN+mHygOPdf3Onsv69HPRjEEDmUNdS5Km09+Qko/5fva1XIBYSTn/w6ncRNhdBzODvRTjNM7JRoJxhd8e13ty3fe7xL5/4HZsiuylFmZ0YWlS74aJR6p9jZXWUADjXwVlyNEOZZ6EupyfZWvIqFtb6dWA8GA6LJUv5TBRYhNmG6iz8l6itaXkVucUcfz8DrAHdcWnM0E0iHZ13NpCwyt1H0fpGEKFBkKFPZKvu/PDS/+tFmDGca70X1nsgk5zcVSPouL9cJkYGmfZBu3oO6OPb+15W4xHX+B5AcnXDdvnto1pYPEtuMO3mvGIDiZd1gKktEbswb9zwp/HCtA0TNfKH7i4uFhjaWoERE2qgK0GxTQ7I0o5Fa37bao1k3g+llabkq8GOAM81stwu7Lz8Ygwiqg/vw/YWU1xpxYIxeMe49mZWhaYBFbIrazGq1dAOzNUtl+5TCAIn0eseSDyGjXk6+6M3jcLikwycZ8iWffinwqrUDMEqPfACk7FZ87n3K4l05c39VobAg==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da837d8-5516-4e42-a244-08d8606f158c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 09:49:09.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBVjDr0C0hQjvMyFYwzI0PU2W16UGiXyBagFlnEJufymyB9GOXN5EpQPTqbwpZbIBlRUpBXTvuLTT2S8veLK2xCMAI0eQiyA2HBmUbbLORI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2628
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2020 10.53, Sergey Senozhatsky wrote:
> On (20/09/24 10:45), Petr Mladek wrote:
>> On Thu 2020-09-24 14:40:58, Sergey Senozhatsky wrote:
>>> On (20/09/23 17:11), Petr Mladek wrote:
>>>>
>>>> AFAIK, there is one catch. We need to use va_copy() around
>>>> the 1st call because va_format can be proceed only once.
>>>>
>>>
>>> Current printk() should be good enough for reporting, say, "Kernel
>>> stack overflow" errors. Is extra pressure that va_copy() adds something
>>> that we need to consider?
>>
>> The thing is that vsprintf() traverses the arguments using va_arg().
>> It modifies internal values so that the next va_arg() will read
>> the next value.
> 
> Yes, I understand the purpose of va_copy(). I'm asking if we are
> always on the safe side doing va_copy for every printk (+ potential
> recursive va_copy-s).

va_copy doesn't really add any extra stack use worth talking about. When
ABI says all arguments are passed on stack, va_list is just a pointer
into the arguments, and va_copy merely copies that pointer. When some
arguments are passed in register, the function prologue sets up a
"register save area" where those registers are stashed, and va_list then
contains two pointers: one to the reg save area, one to the place in the
stack where the rest of the arguments are, plus a bit of control
information on how many of the register arguments have been consumed so
far (and that control info is the only reason one must "reset" a
va_list, or rather use a copy that was made before consumption started).
In either case, an extra va_list doesn't cost more than 24 bytes or so
of stack - even if printk() was called with 100 arguments, those
90-100ish arguments are only stored once on the stack.

Rasmus
