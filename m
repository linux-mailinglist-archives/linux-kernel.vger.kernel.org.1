Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3906C27FA00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbgJAHPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:15:48 -0400
Received: from mail-eopbgr140139.outbound.protection.outlook.com ([40.107.14.139]:63662
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbgJAHPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:15:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5yitLyKasulzYqefJQr1vODJ2QeWzR/d3JWewJYBQwBIOJ9eg8MOsqDvbZb+d+7tS5+/htgx/E9Cjb+lS15C5PkmsWfhpJUnCRcOeVKaBBLuKjmgjs1Qg6/01fMoFw4MbxTBkx/dr3hLnXjkH68lmWTBMLgFJfI/WipwNZ2SEUk7G/3jkND7vwo/mQMW3Aa2naiVo7bDv17xGK1T5Cc/m/idaga4QwgLGnvRVfaQBVpPWUQxtCVMqLGHNeqfQodiCMld4xorsGlluDmxAtseilfDnpprZFkc1tDyuNmGTtsFyezntchMRY7xd3SNThQYU8cQfpOYHoUpBZ1ZJcmnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz22di4ppG3e3TFwDmg+5FpkUggpwxae0ESkA+kVY2g=;
 b=ZygJYxzr210pXdcTBmgDHA1mu3fvPBFJekW31lW2gSclalpGa0elOuai+6l1XVYBA5fv2+0I7D51SXx+X6/8rXfgCCdmazJxwyU32ptYgx2/mgXYa5a1uMQDtDjyWn58QsdqoUE1fEWF36JHhbH84eXYESrlpw7h/eZ+3HknAjViH5FQuO2LBqliirl/HPJIOw9PSd9Efqz9+BpEPf9LCL6QYC7h+6afzi4rYzGVIk8MWFRt9uv61gqAQIDM/3ekHwGfA7yD4zbU2L4GPxkSE4AvtVyDsSXy6RDG1bvvm4Lqju2gJb2SWf8RnuEsr1kb2Nvv1mG82xs6Me82Lo4B/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz22di4ppG3e3TFwDmg+5FpkUggpwxae0ESkA+kVY2g=;
 b=LKLEKKorTMeeNpLugJW4xIl7J967DXb192zurfHezVuChXsBk6iahPleu+/uJ0jQ2yFahqM7FlfhyAnZYh++RcSbaSqg37z9KLHaM2y4IZHFDq4U0KtguivNjtpYyj7GXaRGU1cTqrrttXVxgafWZP2hmzJ2LO41eqgWcm+RqbI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM4PR1001MB1345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 07:15:42 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acf4:4f51:6c3a:8cbc]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acf4:4f51:6c3a:8cbc%5]) with mapi id 15.20.3433.037; Thu, 1 Oct 2020
 07:15:42 +0000
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
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
 <4e36f308-a435-f9c1-2d4f-362e797c764e@prevas.dk>
 <20200930093552.3684aee1@gandalf.local.home>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <de1b6e44-bbd7-6264-d354-4f9d76bd2870@prevas.dk>
Date:   Thu, 1 Oct 2020 09:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200930093552.3684aee1@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM5PR0101CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::45) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM5PR0101CA0032.eurprd01.prod.exchangelabs.com (2603:10a6:206:16::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Thu, 1 Oct 2020 07:15:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 700017bd-4aaf-446e-6f13-08d865d9cee8
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1345:
X-Microsoft-Antispam-PRVS: <AM4PR1001MB134576DE722D64D62C4B55D193300@AM4PR1001MB1345.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhqBXs3ProXQmKi7QoalyOjP85ttzRZjd4B0X6kO7acRBYm/9ZOdnW/PTEyIFfO3w8W6yj42tpmFGcl+5oskCFto7XlrL8AAd523uHsntxklVd+QnVwAnU491gy06dxuzVENH0fusFGIqWxZaYlz3d074NYIcBYbRB8fIv2jYpPzOqgsNS3RVqnYTQdJE2yiGhWM8Sg7aNR92Ikj/8OxOXxh/ixsrcbLfWZO/AoHTqgmBTyyKa17+NeWcGN+Uv3NS9oMi4tCHGYMmRglwMpt2UoP0TgsAE5lC5FEcF6rsTlk18dctFmXxJDA1/VXeltAoMW+b8esBEspp3y55LcEAWZGAprZPzZMCdF+cGM4XWByfcJQQ3rHx7cnvC1HMFaU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39840400004)(366004)(396003)(83380400001)(26005)(2906002)(66946007)(66556008)(8676002)(5660300002)(16526019)(186003)(66476007)(2616005)(956004)(52116002)(8976002)(4326008)(6916009)(31686004)(6486002)(8936002)(478600001)(31696002)(86362001)(16576012)(316002)(54906003)(36756003)(44832011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: DdAae5GfEKAUOEHEJmDumCajon9Bhx+aftpEuqwfvgvkJs/63guQSkPavU0uy6K54IFvCdMgdHIxne4XOUiQcbjbSHZATXeItDbusBL50ciAKtWNhneyqjASPMdJyQ+2Hu0ohNjNk//KimCsxXXjShjyXIjRfiysRL2ufgTN0wkRdzhbDh4NFV0A4xkqUK2A8OG9cypIGoD5z4Y/5Cj5vud2wHaH+hvCzkiKvSsvSgS+Bn7NUsnV7nPbxvJNGyLU1BAdcbLjBm9YHBAr1rSSF4bwykC6cCry9xtyRg3H52r1VCQfIWx0MAn7xQuNvsdQm1msTpq89kcjoauzVZqSeZzfJy0K2fN1CF64eJU7bzHNvChKmoE5X2S+wqDRvea8ZCR4FSa9hZslFBLKQbuCRwPn4VKCO3O2NVBQOENYVrkIzBQ8XL7kIIo78nx0L3TSxFSQOQyva5/sqyi722MmnO8/V6glpPdAovc+CojNLQHfyDcyRWR+ao/AalRdRAbYCFPgtCvtCHzIFSipNWIWgQm0lpjvQVmV/noswBi4OM4q6F0rRbn7h2/v1KYINjuO43IDa3gCGQLWXXlHhKiiDv/ZS6XoVTmalwf82WeTmJKxopr595U3GLfe3i/FoHjoVAwPMPkEa1WqPdYbdeNxzA==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 700017bd-4aaf-446e-6f13-08d865d9cee8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 07:15:42.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eBxsppxRNekzN6y1jOa0jh28Il1tX8MUc9JDZcyX666g8z/wMi/jDrgmx/m0m+lrkVJ5/LCXVaU7NOqIN9w9USagKC6GTbk6NL5mwrU8EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1345
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2020 15.35, Steven Rostedt wrote:
> On Wed, 30 Sep 2020 10:06:24 +0200
> Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
> 
>> True. But remember that printk is called from _everywhere_, with all
>> sorts of locks held and/or preemption disabled or whatnot, and every
>> cycle spent in printk makes those windows wider. Doubling the cost of
>> every single printk by unconditionally doing vsnprintf() twice is a bad
>> idea.
> 
> But the console output is usually magnitudes more expensive than the
> vsnprintf(), would doing it twice really make a difference?

AFAIU, not every message gets printed to the console directly - syslog(2):

   /proc/sys/kernel/printk
       /proc/sys/kernel/printk is a writable file containing four
integer val‐
       ues that influence kernel printk() behavior when  printing  or
logging
       error messages.  The four values are:

       console_loglevel
              Only  messages  with  a  log level lower than this value
will be
              printed to the console.  The default value  for  this
field  is
              DEFAULT_CONSOLE_LOGLEVEL  (7),  but it is set to 4 if the
kernel
              command line contains the word "quiet",

So the normal state of things is that you don't pay the cost of printing
to the console for all the pr_debug (ok, they may be compiled out or
run-time disabled depending on DYNAMIC_DEBUG etc.), nor info, notice,
warn. For those messages that are not directly written to the console,
the vsnprintf() is a large part of the cost (not exactly half, of
course, so doubling is an exaggeration, but whether it's 70% or 100%
doesn't really matter).

I'm not at all concerned about pr_err and above becoming more expensive,
they are rare. But random drivers are filled with random pr_info in
random contexts - just a small selection from dmesg -x shows these
really important things:

kern  :info  : [ 4631.338105] ax88179_178a 3-13.2.3.3:1.0 eth0: ax88179
- Link status is: 1
kern  :info  : [ 4642.218100] ax88179_178a 3-13.2.3.3:1.0 eth0: ax88179
- Link status is: 0
kern  :info  : [ 4643.882038] ax88179_178a 3-13.2.3.3:1.0 eth0: ax88179
- Link status is: 1
kern  :info  : [ 4667.562011] ax88179_178a 3-13.2.3.3:1.0 eth0: ax88179
- Link status is: 0
...
kern  :info  : [ 9149.215456] [drm] ring test on 1 succeeded in 1 usecs
kern  :info  : [ 9149.215459] [drm] ring test on 2 succeeded in 1 usecs
kern  :info  : [ 9149.215466] [drm] ring test on 3 succeeded in 4 usecs

and if I'm reading the code correctly, the former is even an example of
something that happens in irq context.

Rasmus
