Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C080E276DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgIXJyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:54:09 -0400
Received: from mail-db8eur05on2116.outbound.protection.outlook.com ([40.107.20.116]:37217
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgIXJyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:54:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YS5h1NzTYX8M2FE8uhpyLaINAm6iWD/OSZoG2pRNqPR/6/vx78e7gRSydkkygEJIX6s9V4L5KHJhm9N2IEI6tdXBYnHW8+xtCqs5LrDB8bTls8LrSfmG69AxOhB9kw+wYES1CoGhWKuPmhB+cjOkTr3L+vdp6M3tUFWQt7XIWoF1AZ5yl+JIO+jFTtTswqZHzcH8scZn0YN9QN0LbBxCMPOoLFfnBfShKN3SaQkBM4r1xW443YHeuuONRZKBpYogPanNebEopSL2PHsLGXa3xcQrOAfjGEdxzRA4tND3f1m/uDYPyGJJ9p6CCzwzOVHwb8pr3ewmbMxx5NIuYFzi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec6ztxZRyHm3UMFo5CdGTbN2iud47Q99WwaDo7oQBXU=;
 b=m2HW0YMCsmGV9PNnBIpvPe3gt7wldfaRy/TYtIdrFQ5UZrRsXmNRGHSXVBq/bz3DVAYwj/SaTqCbN3wb7TxXBm++J0w1EgC0qt4rNZVuQM8UCDFjlSnz6UnZOhe++zUfTCW5Mmsqk3LOdFTrmh2Hd1d9OYlnpqAoAUJQ8BXeFusbk1nnAyoiE3WRRQmIe5rM4QT1mucJ1dbufz9xN9G+4oaW9b5XKB7RamfAVd6azXLQp2bp5NV/7iS+qCjxX40YRnBMqnFRKBEZr81+W1t4iBf2fCm3pvM7+sLc5ucF8rYBYYb8pMhPjyxHJL2G2sOFZ6hV+Gp3iVVibOvrp0S/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec6ztxZRyHm3UMFo5CdGTbN2iud47Q99WwaDo7oQBXU=;
 b=lG77YTjy6TIUASW/sWUkgcHs8u46xoIgRuFu9X6RF0wngYLx/fkxCuipZsRWP5ZHoU0cLINn60Jb+Ej4oe3YSi0woameF4N/trmJm+Hb9lftwApKO6YVgsqudZvsrDxDkBEzzBP5WL8NstNmlzVHCyOW3fBgz+kVQfWVBtefGbE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM9PR10MB3989.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Thu, 24 Sep
 2020 09:54:05 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acf4:4f51:6c3a:8cbc]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acf4:4f51:6c3a:8cbc%5]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 09:54:05 +0000
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
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
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <aef3626f-56a0-9040-fc0e-224ada032d02@prevas.dk>
Date:   Thu, 24 Sep 2020 11:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200923151129.GC6442@alley>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0097.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::38) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM0PR01CA0097.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 09:54:04 +0000
X-Originating-IP: [81.216.59.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5795a959-da76-4fb7-7666-08d8606fc650
X-MS-TrafficTypeDiagnostic: AM9PR10MB3989:
X-Microsoft-Antispam-PRVS: <AM9PR10MB3989BC06E2821A833EBCD52993390@AM9PR10MB3989.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Je8X2oVNk4BeA3gqhy62nFcEd0y5EWn6lFEmY+VGjYJjZJGWE6rSNEuTmqPTyA5pDoYApUct/8Zq3X97L2BFvf325WuRhJL6YnunQzYvjCeSFFDcUUhCDvi8gTxjXkwNKhx/GTWBlnfGlA7cMSTn6v4NYymjdbkRvCG1fNj7fA3R2qWF8k0zMHqeGyG96ZRvo7UALgKR2DXWBapGj4SkT9n8HiWvebFlvrABqydZxZ3/IiuczCWq0RsWPNkKyL45xDCP8wpqXoJ0MUy8fa1iXZqAPZph61DVclIpFGY4iPmUAjQXIN+GxpIi/TB5zACmGyP+f6FH1gid0ARgV93Nn8DT4Ifaq5LTtQHfxAgkXmfuAKRm/eMCJmuMe3+MEfh5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(366004)(346002)(396003)(136003)(66476007)(83380400001)(4326008)(44832011)(66946007)(31686004)(16576012)(110136005)(2906002)(6486002)(316002)(54906003)(186003)(8976002)(8936002)(956004)(52116002)(478600001)(66556008)(36756003)(26005)(8676002)(4744005)(2616005)(5660300002)(86362001)(16526019)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: vVnEy3XCA9Ih0W7mjadAxTdmU+0tzjmlxZysJkBzMDbSBVu1zmuiG91i2U+A8XoE5DYmPvAGzgsDRRsdJI48dv0eu8J46nzprp3NxTzqMp6cpTXd/7bpwdZ9LFDuff0R80KFPH2CrP328nd9oLhCIlWC3Ic2xXMmuLU4TnW689kmIbcVb01tBgEZtefS+AP/FZfNlV0clN3LEWjvGTW3dv4HNYWtdB+1FgWBWWulHdq81J7mo1T1m/UoPay3WB/vb4dQcF0dHsZxsTGx2gQpdgz/4EjARi2YSyxcHRXsLaCcbpBCy7nPLHJrSBAtWBtYDHcbgPZl2Y2FjKvvFtNOn7N2mu7clKNCblL9Un2pX2qhQytel4YzroEfkTIKxYzAAwvy0H4TeCsypDCCiQqOKboDeINMSqbFwUaYIHL31FKUL5yK/aQDXGW44OHnTlK4JeXkeJdiJrFPNIYEZ8g0mlff5I46/V10/Fm8IJmcqHjCFmhyCFrv/qUJF1z88CQaUSAkSgX8TY0rSznEVBMTcwfWfqnkBDbB1KlTaQjdo3OJ68+ne0w4HTk500jzvNB5kiCyFrZ0JmMpS6GKmsWhVdDVJ4TMNWgxQDIbNzFAhKCIGofdScLCyWuOSvJUpyXsgsg3wLfJ68OnwxiqKUaqgA==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5795a959-da76-4fb7-7666-08d8606fc650
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 09:54:05.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 715ODeKxkipxZYvVktSZacjyWOuHfa0v/d1DU3zJG/P7L7DGLbAMs/3+ZkP9HRJdWDk27w+pT/Ghbz+uXoTfaiI+o/hkJK0JCtLuG0ShdzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB3989
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2020 17.11, Petr Mladek wrote:
> On Tue 2020-09-22 17:44:14, John Ogness wrote:
>> vprintk_store() is using a single static buffer as a temporary
>> sprint buffer for the message text. This will not work once
>> @logbuf_lock is removed. Replace the single static buffer with a
>> pool of buffers.
> 
> The buffer is used because we do not know the length of the
> formatted message to reserve the right space in the ring buffer
> in advance.
> 
> There was the idea to call vsprintf(NULL, fmt, args) to count
> the length in advance.

sprintf is dog slow. If you do this, perhaps say "we can afford to use
128 bytes of stack" and do vsprintf(stackbuf, 128, fmt, args) to do the
counting, and in the vast majority of cases where the text fits we don't
need to do vsprintf() again.

Rasmus
