Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7AB27E34D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgI3IGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:06:31 -0400
Received: from mail-eopbgr10113.outbound.protection.outlook.com ([40.107.1.113]:27677
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbgI3IGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:06:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euX2XiEwpeRq8RVV0a2cItkL0/XMgsK68oCeasxcuslDU/Sm0FPPXGEXVUEpe4f2HyOVfzTkI/di9Yp5browZs7+FZV3MlfQMreOMmSnsfk/P5vkUXKpWD1oatefEQHkL0OUhIwj0wUme91QEmGCGhbRYUcXlEiuN+aCPItPwIvFCcdBFNiwEsWkQmqYBvuCa9pqQ8Q05Rvq/atzFV+xgwRmaGOAoiPu2jLbBjAR4Lsi2XRDw6Ug+W+l/T3DbSMwlvKQv73RIkc/BMEvm6JReCJglERc2zroNn7YlIU/GoPT4h6xhLz3t+Zv587hK+/7MBTlD0MdQ1yIERAMDhf3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHucWlTZMp3eIwUFs2xIGel38B2EkUErZqIwmlhQLFw=;
 b=QoZeckdPlhJ5oQuYgOpC0J+QKCCeHvBnFA/iZAKbTlsBcQJUDnDm52IvRDS2jMw3otDfU7aYqKGuGQFFj2DCr8LmvOAqPgLapZBLXnfxVnVjKc9v2lZFpUz9+7AgOJVHJgbFtT1I5EoZICXYg/+QKOpa+uGdwIbVNBZJ8J16tTGHRsoWIyn3U00bOW7eNqKKmtGePkSXESYqMrUZcSZTBMis9tm2Fc/QQiaaMOBQrYAMECxWYGqpmTGmkxYKbNE+IFyHNk5eUIDPi+0HWz2p9f958ZfLmcEfcRjqvhawYcRwvtMAeTvD5M93WDG9rCCsWsukHZMmwVFdC4W5E+oUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHucWlTZMp3eIwUFs2xIGel38B2EkUErZqIwmlhQLFw=;
 b=McTQGEBCi/jZoYeAtIyCOli2n7zY9f4RCvmi2YQ35h+wojWr02X0RlVUK3bJWGqp3Sd6OJMCsQ3lG2+Sbbt1NyZWhxDv+BbM4d040r+A+xCSWMsshS/AI45SN7eVds8ZvuCMOGUdzbS1bkA8xj2t4vaRElDP1gSoSqCfWua5lC8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM8PR10MB4227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Wed, 30 Sep
 2020 08:06:27 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acf4:4f51:6c3a:8cbc]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acf4:4f51:6c3a:8cbc%5]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 08:06:27 +0000
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200923151129.GC6442@alley>
 <aef3626f-56a0-9040-fc0e-224ada032d02@prevas.dk>
 <2c95c16b-03e7-eadd-d3af-bedc6b0b471e@prevas.dk>
 <20200925082822.GL29288@alley>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <4e36f308-a435-f9c1-2d4f-362e797c764e@prevas.dk>
Date:   Wed, 30 Sep 2020 10:06:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200925082822.GL29288@alley>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0095.eurprd04.prod.outlook.com
 (2603:10a6:208:be::36) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM0PR04CA0095.eurprd04.prod.outlook.com (2603:10a6:208:be::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Wed, 30 Sep 2020 08:06:26 +0000
X-Originating-IP: [81.216.59.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7515714f-7a53-4ac7-771a-08d86517baf5
X-MS-TrafficTypeDiagnostic: AM8PR10MB4227:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4227EC017319B21C08B2562F93330@AM8PR10MB4227.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GHlH/OcUp3yT277nIHMWLaxawftollq2960C2i2Wbvf/1G13YatuFCkzOeYkWYdDmGEEZYlgbpv+3NPOCWtIm4cEhoXJ/vms5Oxw1zTSQPBqxGkfw6GgTM+vHF8u37rxbGK71bNEkk85Pxns7PDdQtM+cpix/6nFeK1upVa9p+zeaDvyk6V/3V47rG0gMAidNDm6cd2+zOxms+kc4nGeNp6ebHvNLTBB1u8JkDAMJzTw5LeLyetswhO6/s8SXbEGjIr5atnouCF3uA6V/eSnmfHXD7EZ0J0lLkcNjKyCgVszJgBkVyKbO8wOmBZT27GeF+xT750M8tk7YDV5baIbp9LUNULu4pnl7kazm0TEnjkXa92/XsFTJ5imGhYG3ye
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39840400004)(376002)(366004)(136003)(396003)(52116002)(4326008)(8976002)(54906003)(16576012)(316002)(478600001)(66946007)(66556008)(66476007)(16526019)(186003)(6916009)(2906002)(86362001)(36756003)(26005)(44832011)(2616005)(31696002)(8936002)(31686004)(6486002)(956004)(83380400001)(8676002)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: TF53QQafUBs/qRnahszdEmEIWMRUp71BpD7PSDe8WkvkV91pQjRd7OvotE3YhQMTxJfmZkfo00YmO9TEUdAofnzPIqimIN1ecF8mPM0/fx+9Wh4qCfV5nGsMAL3mK2+aUL8BR30hYYZ5kUMGuag8vy4UyzR3Gza1DYPS0vPfixdv29OK/Ck8k1srfJiBLtBTq8uETTGFEX0F8Zwkug/xjM52w+eMUSZPMU3JliNGPaW0iA9uH+wYK9br3GU9JckgPcnFFclf7HZUHuIwNBtuOZtiN3mCWAT6BZ9AAIjNPUZ/akvTvtrHhVbqBvgHTlgW1oAw8jv5hhX0SVW4IlEUm82lOo/KWAhKikfj3wsCKau849BL5wNtyCj1sIR3Y6aG2rkB0vXr6yhAn7DydsHv2uhTxZiNvrOh2Tej7nS6rGb/ukTjzCC8p1df01Dzo7iXmF6ydgbbu2aqVxGseD7LxFzyu2KDdMiRMM2GMne9dLUrt1s9jvKeCSRFfxM0ydpHqVPqNHbClp/iA2uYNo5+FvxuV1Kanadt+knq50O0h0/xKxr0WvT0yLaWvUgB2Dj6rlS9n/jpGChvLgNAwOGtMdthW0NoTmL1ajputLeBCpTsjWTkY+uGiI1xIok1k2P1uh/u348oegW+gGxJTSW2Qw==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7515714f-7a53-4ac7-771a-08d86517baf5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 08:06:27.0266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kj6+bgREQkkD/grw1BhxfCZHOU0PJ5CmiqHNLvi9k+KjdJ0Z0Z7L3XbM1J3g/uxuSyqs8CCBvYD25gkm/L/mpji159PoU8PqhAz2BEdn1J8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4227
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2020 10.28, Petr Mladek wrote:
> On Thu 2020-09-24 14:32:49, Rasmus Villemoes wrote:
>> On 24/09/2020 11.54, Rasmus Villemoes wrote:
>>> On 23/09/2020 17.11, Petr Mladek wrote:
>>>> On Tue 2020-09-22 17:44:14, John Ogness wrote:
>>>>> vprintk_store() is using a single static buffer as a temporary
>>>>> sprint buffer for the message text. This will not work once
>>>>> @logbuf_lock is removed. Replace the single static buffer with a
>>>>> pool of buffers.
>>>>
>>>> The buffer is used because we do not know the length of the
>>>> formatted message to reserve the right space in the ring buffer
>>>> in advance.
>>>>
>>>> There was the idea to call vsprintf(NULL, fmt, args) to count
>>>> the length in advance.
>>>
>>> sprintf is dog slow.
> 
> Well, printk() is a slow path. It has never been too optimized for
> speed. The main purpose is to report problems and eventually some
> interesting information.

True. But remember that printk is called from _everywhere_, with all
sorts of locks held and/or preemption disabled or whatnot, and every
cycle spent in printk makes those windows wider. Doubling the cost of
every single printk by unconditionally doing vsnprintf() twice is a bad
idea.

Rasmus
