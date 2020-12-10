Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CFD2D53BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 07:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbgLJGUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 01:20:01 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:54537 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733162AbgLJGTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 01:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1607581111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uiwv1rN0pWQzVonqVfNMSr72oMovgylbm6ZauNfKR/k=;
        b=QDYQWnSZMcorsQOpQnFynv7uUoN/2KYST7OweFhN8GbwmNd+Wusola4Lc4c/+H0nYCV2bq
        ssxKyEsu/bTrMPW8vKbOlgy983kqrqCp+GPzjzmZE271Z+jdCHK/RzD+DXB/+JrwI8hiQH
        hhjXYb/aZyB3bIxAy3yBINV7JLN2IxA=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-_9m19YGqNNyrIvjBfMTSeg-1; Thu, 10 Dec 2020 07:18:29 +0100
X-MC-Unique: _9m19YGqNNyrIvjBfMTSeg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpQDLkUscdGzGPprIew6rH1AjWOVwTKriG9+hotIC6Lk/1KCwKF7NbX53JTOWY3PTlXlDcxzuP2vwF41P6zqNKRKJBCJdzMpOaHS4teLwy6ykZuuNvKSXG8UENIEdssjgleozoHzYxkWG0LbH19uKMNQOwDeu21m0viW20rQkAah5JPWEAvQVG6iShQnWTp98fuFoqTqjaGjVKiTej60eSI8u9ajcx6negeb6/YE4HsqT1jPGUuaMvGpq3tXGn2B+gnJqoBfgzwx0RfaGCwL2+hNlmfsnM9lYuxKZgYUu7wzfzXNp1+jnUcMlYiZZKXMi83V4EE6W7nR/oX8SZxyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiwv1rN0pWQzVonqVfNMSr72oMovgylbm6ZauNfKR/k=;
 b=iIE05hFHYnlObxWeTDKubNwleK1U2ztd71che0YPaL/q0/vcQm+HoHiAHh4e5BRyUeM88UoXy+yciJG9+hgKCZdrxPLgmfiUvf8WfrtOrjqpvVJn3DGdwwl2VXfpNW6cq1HLbXguZs7WAMuLMQEf7uACskApxNOUcVkNctBKoR9cQrwrAx6X1aq2Z36OoaJCjtHcOuLC4FRER3PPCDp6Q3nARCV2TI6+Ga/e3WR6x1t8KMCgIdiz7WUxxv3dlHo9oGwsfJF3vZZq1Jq/0ACVauceWPFYAvv+eP/uQOQ4hvhjRR09NQfE9J3pPeGg/CFf+lh8O/WeX6O0/RlHuqKMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5177.eurprd04.prod.outlook.com (2603:10a6:10:20::21)
 by DB8PR04MB7019.eurprd04.prod.outlook.com (2603:10a6:10:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 10 Dec
 2020 06:18:26 +0000
Received: from DB7PR04MB5177.eurprd04.prod.outlook.com
 ([fe80::7585:5b21:1072:f5ff]) by DB7PR04MB5177.eurprd04.prod.outlook.com
 ([fe80::7585:5b21:1072:f5ff%7]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 06:18:26 +0000
Date:   Thu, 10 Dec 2020 14:18:15 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <maz@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: "irq 4: Affinity broken due to vector space exhaustion." warning
 on restart of ttyS0 console
Message-ID: <20201210061815.GJ23060@syu-laptop>
References: <3ba26c8d-04ac-1822-d5c2-4a8906f7fd9a@redhat.com>
 <871rh1gcck.fsf@nanos.tec.linutronix.de>
 <20201209063304.GF23060@syu-laptop>
 <87wnxqzvdq.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wnxqzvdq.fsf@nanos.tec.linutronix.de>
X-Originating-IP: [2401:e180:8831:a6ea:292f:caf6:d122:174f]
X-ClientProxiedBy: AM0PR03CA0094.eurprd03.prod.outlook.com
 (2603:10a6:208:69::35) To DB7PR04MB5177.eurprd04.prod.outlook.com
 (2603:10a6:10:20::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from syu-laptop (2401:e180:8831:a6ea:292f:caf6:d122:174f) by AM0PR03CA0094.eurprd03.prod.outlook.com (2603:10a6:208:69::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 06:18:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60b08bee-2db5-413b-3f68-08d89cd367cb
X-MS-TrafficTypeDiagnostic: DB8PR04MB7019:
X-Microsoft-Antispam-PRVS: <DB8PR04MB7019607754E70F4A8AC2FB64BFCB0@DB8PR04MB7019.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAFs3yM4/8KueJ+94ymibBA3Ck8HHOz55D9+r+kkOYaxNy3H9Ab6B0U1OEKZSfFYdQGCLSN/nERFh0VroiKl1NumUkJn4u+RGxePdg4OE0lKbI6+CTQvWqOG15Kj1B7LbRisBJUvpnhenbAT/FATHoRAIG5wLQ5JYmC0LIWxcWxGKSMMc5DKINOoVXg1QOVmZTADAQrxO02U0r3Ne4Pam0kALNT9xUbmeCPENGwEWWVJPffs+SC6KDI1OJaAlQjYOsQHw0TuiaBrnSIVZIKB9FG4kWfqpTVPRbxbwFgCwR7TdaTripy0ujyPO4kg9VVS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5177.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(33716001)(5660300002)(2906002)(8936002)(8676002)(66946007)(86362001)(6916009)(66556008)(7416002)(66476007)(6496006)(55016002)(508600001)(54906003)(16526019)(9686003)(83380400001)(52116002)(186003)(558084003)(6666004)(33656002)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YWNrOEFjNGNtZVg5U1hDSnoxSW9ueFMrbnJHR3J0aDg3b1JpTTBFdGVLdFJV?=
 =?utf-8?B?ZnJlcFdJczJWOXczQ0R0aTlVdyt0MitBYUdsbUt3TnlhLzN6Y25wbnRvL0Fp?=
 =?utf-8?B?V3JPS3FXaU1nam9HeXZ6SDhUeEdTblFkUWpLVXE3VXJqSVF5aWM2amZ0UkJj?=
 =?utf-8?B?WmYxOVd1NkhQZmFCUFhrekg4Mk1BODUrb3htbU9HSFhGMnhJYVEweGtkaUZ0?=
 =?utf-8?B?eGZuVFhFY1V4akFnd3ZIOW90R0tYanpIMWovRkkxWFlJZndPaEpYWjc3bzdw?=
 =?utf-8?B?Qllaa2FJdEQ3UUdIU2J0dTRRSXhlRU9Dc1JGRmlBZkZhNk9pTVpoSndIVDZ4?=
 =?utf-8?B?MmRFNUlaaFVFZnEwWjF6WU1GaU5DRC9TbU1RQ3lGYlphWlU4Zkp2N0RIa3dE?=
 =?utf-8?B?d0R0aEdHakRMSk5jTzlZcmR2cEZPNVB2eHB3OHlLTDJNanhkZGhjZlRvN1p3?=
 =?utf-8?B?ZzhKSmxNVWxLMy9JRjgvWUxQTFRYSWRIRm9TenZCOWhGeWkrVzlENzdRRE5S?=
 =?utf-8?B?MzQ3MFFNeVIzT3Vpeis0WTdIZFJxdHlXTllpQThZdUV5Y212SitmMUNaVnND?=
 =?utf-8?B?dDkyRkhlT2kxT2lLOG5WeTZ5MUJtMUhTSEI2b3FDK2p0RWptcUlmN0dkeVVI?=
 =?utf-8?B?RU1zNTJVV3ppWUNldVREdzZqdnpVV1M5NDVMeDJIdEF6VnZRaktDY2puL0s2?=
 =?utf-8?B?bmFIQ1lnU0RBK2NWRzErV2x4VlJhSUFVdTlQbHZGeTYwZkFLVkpvczVaRFlt?=
 =?utf-8?B?SndrWFJBa2w4d3U2TlhoT1RteWRNMjRXVFRUZUR6QWZXSE9VUzY4Yjd5MmRC?=
 =?utf-8?B?MmVnU1lrbFYxcWdiN0hSbEZjRkp6S0d3a3ZHRUl6RFJVMVlpS0g5VFVZbHhZ?=
 =?utf-8?B?SzAySWVKa2dUeTZhTWhvQ2RGRjlNYlA5MUJWK0F4cGRSa0dqRWJKMlozSjZy?=
 =?utf-8?B?d2NwcWoxTnB2YmlwTE9rNUJXL0QvdHVVbk1iTDYvWjh3azdpTjFqbHc4UEVC?=
 =?utf-8?B?ekVEYUNQNG5DcmtzQnIrMXNZZEdBejZJeWFwMUFYYlR4YnpDd3VqMW1sbndt?=
 =?utf-8?B?dGlwRUJPMHl5UVQ5V1NnZWQrNWRkY3JVV29VQVZ5ZWNEWlVKdk5jUnIzUG50?=
 =?utf-8?B?RFpva2I5ZCtjUzhUSFBPVEVLUHd1QXYvdUIrWlRJQlZYL293T2lyMktjZTEz?=
 =?utf-8?B?SThpTXJPYUVOM0JONHU5T295UmdoS0hJdU1Eb1JrcDcyWTVvOURiaWd1dGdY?=
 =?utf-8?B?Uld4UFBnc3RsYnlsa2R4TTVLTFpzTEx0SE1NVWxFaVp2cklZRGI4WFpQcGNY?=
 =?utf-8?B?eVJrTGpWVGFiemxmcWQ1MVI4bFJMZHh1bUpkQVBpVmcwTURaTVQyeHVBbTNo?=
 =?utf-8?B?TVJEV3VIZ2pwOUE0YjdadUhsc2FCYjcyZUZqQmRvaEtpaG5oMzdmYUlhc3dr?=
 =?utf-8?Q?Z977zanK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 06:18:26.5381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b08bee-2db5-413b-3f68-08d89cd367cb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDUAySAi58ZiDYqcMcc2wo6e+aBl6CArVAVctUy4G442lNTNOjH6hswjZ7IRogtRS5qppjxrQEmBrInp6U7kYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7019
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 07:28:49PM +0100, Thomas Gleixner wrote:
> But the fix is not to tone down the warning. The proper fix is to do the
> search in the correct order.
Agree. Thank you for the speedy fix!

Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

