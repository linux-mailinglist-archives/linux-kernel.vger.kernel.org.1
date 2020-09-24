Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2748A277113
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgIXMc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:32:58 -0400
Received: from mail-db8eur05on2098.outbound.protection.outlook.com ([40.107.20.98]:28800
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727663AbgIXMc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:32:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXwWDYWU9HpSNKgwTwWRUNNpKvXbUn60mPXq4+cX5+2wInOpVbSz441G0AGqCtW3yArrlDcjUAbStzZkoUD2VTqziyBiAkx/M72tNp7nUaeqMdwrRySl9w0Ks7YJjImmxaxXNJ+pe6aFqHAg6aE4mtqJLRVwkFZSUL0JHR0n5eOeTS4cjXSIgbITcTjsQGGtKmmJ3hNC/vJQb7V61eX75HCxZioW2hjC16o1rvFqrOqqInxQjTqj+8fLLZ7Gk/d5tokq+n/l07F8R/u0EsP1osDCSFkJq33yRBUf67Vw+l+8egWFYDZtYhPOLxtCMRol1FD9h34D+fC4up+UadlzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTl5iN8k6KrA1h5GNgewDAe0p/WfwDyVg6etHZYLr4o=;
 b=FrOFa1EB2lZPukWUc4Dn6l8c8Z+Cxb2axQFJHQI2EubrXk/9afjt17MPpCecGsB0CsV1regE/SOkWY3Pw6aofVcBZCsGkLtuuIJfnzjulegWpjG4ZBi6v9x3S0aJoJBG8wiyItkzQ7z0AM8I4BxWZmIRzJlJYDvONxhIyC+KcV+FF0bGNMa+HtKT+L3ZyAVaKylbWdNSEWD/6j7XuHm3lkz+1h8aFfC5tfcnbUn9SA0x3GmODIvGmp0Ss3AlaIQEgR8Uzu4JKh4X4Fi2krAhC7T4m1AAFx4sk9dZ4ZYkUQVore3SsDl+SfOzFAc4p5k2clzmWQxskDBTBwLql9byFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTl5iN8k6KrA1h5GNgewDAe0p/WfwDyVg6etHZYLr4o=;
 b=IIyquaEDQbEwG5hsdc1Nx1N/aVC2gK0M29wYUW/nPjBwqYc2Q/b8/zCbFz6D7ocF1TKzJSNQITMCAWb+TCbqXSd3xbDXHIk5JhmbmaofnozywM05n53ceZwQvG3qyT6wn7sdvHKX8B8rVy5qmQ6KOfxgYaV7G2t/cziVTITzdPk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB3171.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 12:32:51 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acf4:4f51:6c3a:8cbc]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acf4:4f51:6c3a:8cbc%5]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 12:32:51 +0000
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Message-ID: <2c95c16b-03e7-eadd-d3af-bedc6b0b471e@prevas.dk>
Date:   Thu, 24 Sep 2020 14:32:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <aef3626f-56a0-9040-fc0e-224ada032d02@prevas.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0077.eurprd03.prod.outlook.com
 (2603:10a6:208:69::18) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM0PR03CA0077.eurprd03.prod.outlook.com (2603:10a6:208:69::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 12:32:50 +0000
X-Originating-IP: [81.216.59.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cde831f-69a7-4361-f464-08d86085f3ca
X-MS-TrafficTypeDiagnostic: AM0PR10MB3171:
X-Microsoft-Antispam-PRVS: <AM0PR10MB3171A6183610B67C7B3A60AB93390@AM0PR10MB3171.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zMKrcW13hlpVVNYIvM2c2P/ZE1CMCAf9xS+gtGCLE6p71n4EFqo0R6sI3RLMt4wMx0FBTE9j2jdVpuMgdqj7N6ebATSmqpcoyham4aDzwmoFB4MuoITUrrIBJJ9V4qDCHVJaG+N7FJGNe4ff/jeTgsIPeVt4hDN1BIzTwTnOyQusKGgdR1mKrfFjIXJ3gTw1qv3mWcmKUWswgmsx/AjVfz6ol3++kzF7vIgJFhAbqpNfrAueeSmuIrnP1XkzwBLFTCNdMzZ4UQnlJTmyA3syuwprOyzq4NbFo2nX4GMZ/Q5tKQ1Yn0sBykpjUg5XVrQz0gcDWkO4MEXxGhdC/S5BDCGuFQmTREDPC4YL+jI4M4jAOtZ9+/inIwvkAyM/x2NA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(39850400004)(376002)(136003)(346002)(52116002)(16576012)(478600001)(36756003)(86362001)(26005)(4326008)(31686004)(110136005)(6486002)(16526019)(8976002)(316002)(186003)(5660300002)(2906002)(66476007)(54906003)(44832011)(83380400001)(8676002)(66556008)(956004)(31696002)(66946007)(8936002)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: TNNqJkx1+YQNSAQ/MAPYqj+E0LgAJyU8GTeIrii3dv2bkK3HgkDYm3GHU5P2wclXssiHVhfZYN8phNK6OmG4JpDfC7Pasr4M8wFK0rdSRQzUopneh/pqZYCKzbkd09xbcHziEk6L7QYt61J9uwt0D6d+CDRbdI2kHpfNV0f0q5bD/ArSdrZONSFE7uqvW8A6AJXQyYr98IYakfStveV4mFn6MEYX3vlKMnEQ1+sOE4AUV9JW5IROkRPteVIG/ITmNU9X+U5o2NM8zUCHfOkqT52C5EW2rfzlOdIpdlfr+EvkRh8g8z4Z3VUSPjSuIMtmVF1X72OKMXAAbr4pRYJlmA8zODkJyTZQDNMxAZT6KD4ou8ha8dkGTZeiqpUI/aCS7KUz+qSlMEapwPzH5cmFi9s20S7xIZdT3FdRZisgQ7BPoBDR1jyVJIzRODU3M03MPPJBn50+zeRTm9FPvMqrLs5iko4XioDn1n2JkFL3UUsaNWbo2KjmeAc75qSuhE1n22dxUOLbpGmMM8xLbvdKnZ5TxA1u2JTWSYk682qXARzv+HBCBxLSoCpE4Y6k//xTvSFzu+P/x8wgx69pn080/bhOXsthy9uPTxzl5Kor3LJyEnYq1VnW/U2mEcQGmFYpKJSXCWymPbsIDom7MGJeBg==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cde831f-69a7-4361-f464-08d86085f3ca
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 12:32:51.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cSnYGhxZdat6r7G8qI+4mQxWju8ZAfT2LqGi+9ioW1M/alzf+145T/tt5pTXh+bC9eU35VC4WjWVH+9zYa/UrlveZNHEkjRuu3B374/34M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3171
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2020 11.54, Rasmus Villemoes wrote:
> On 23/09/2020 17.11, Petr Mladek wrote:
>> On Tue 2020-09-22 17:44:14, John Ogness wrote:
>>> vprintk_store() is using a single static buffer as a temporary
>>> sprint buffer for the message text. This will not work once
>>> @logbuf_lock is removed. Replace the single static buffer with a
>>> pool of buffers.
>>
>> The buffer is used because we do not know the length of the
>> formatted message to reserve the right space in the ring buffer
>> in advance.
>>
>> There was the idea to call vsprintf(NULL, fmt, args) to count
>> the length in advance.
> 
> sprintf is dog slow. If you do this, perhaps say "we can afford to use
> 128 bytes of stack" and do vsprintf(stackbuf, 128, fmt, args) to do the
> counting, and in the vast majority of cases where the text fits we don't
> need to do vsprintf() again.

Or, since 128 bytes of stack may be too much, combine the "pre-allocate
a few buffers" with "but fall back to vsprintf(NULL) if we can't get
one". That should allow choosing the X in X*1024 smaller than what
worst-case requires (which will never actually be used, assuming the
machine is doing something useful rather than just printk'ing all day
long) and still works even when a tmp buffer can't be obtained.

Rasmus
