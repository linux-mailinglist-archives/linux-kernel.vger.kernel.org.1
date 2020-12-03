Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C822CD980
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389256AbgLCOoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:44:06 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:43381 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728249AbgLCOoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1607006575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLwxpf/J1nI85gIaPGUf+z3qtX7zvLbFCu2UtxLhxo4=;
        b=BPlKI/HITVbTKIdcrFRlrfzx5JOWqraK0TZeGR+M6D+dyDiwrRYm2HkTkpPzIQozVYIOAR
        zljQPCMyuPx7+LvG1E3PvP22TiiqdgiI+NTrR3paxKsGX+Nsf+raBU27fvgRLrpkP8Px8r
        WiQWX59k6Xll70c/r0/PPYWblihqH+U=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-IwACD9gNMR2LeNYRj0CXZg-1; Thu, 03 Dec 2020 15:42:53 +0100
X-MC-Unique: IwACD9gNMR2LeNYRj0CXZg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A14xNgvWFrJBtipWo959q1IETIMs1whfxPz39yfHzIqgO0PDAzg5n393rMVbuaELELjGVY6T6+dXp+zlmzS4xuBd5t5wrxX8EUSIx0V6dEV1MyMidcrv5LY7jZc9YyPWPosz9EBw0zhINSGSfe+eg77DtuYWdlrBRGUH2tbKnmoMpeNNmtt1gIlyVcHcMPVk/Xa/AB6Vjz65vrFkYkHJAlQ/M74svsHBtp1CCxr52n+etf2aCHsn8Zym6EVHDuRSBMFbjsVxOasSjQRv9IFJLnrnOz5PAjLuUqvkaVXLH0zEVaGpAx4UH6FpPLQIm6d1vvS2IzL/eiOYspm1nEXSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLwxpf/J1nI85gIaPGUf+z3qtX7zvLbFCu2UtxLhxo4=;
 b=nM4X+nAWZYLdBvHQVbHUTh3ohuIzP573b2ySgWQm/o9lxxUE0zW8Bh8ohQuxL3eRs6AMgI2qNAaNMmqfc1NAmUsKHWdCT9/Pph2kIkZZk/TMSVjqFuapijW0UXdBgIedTv8Nnda949Azyg3bYkNU5veXAg9WtbBKPiimkafsmS7nHYwS8tmdAQXajMd2WfnF8CwOwIBvIWN0pzyS2FV7WPG+f23R2sZ88XqXv5OD+MJTflEv+mN9pqcJkVebTmC/3MYRuTuWaoMi04r8iU9j5cHsw/1JHgfSrmj4dadnuWUaavOjiGl/bJ/ZT32jITBUiZGyq+7yF+YGJvWtM1D3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DB7PR04MB4379.eurprd04.prod.outlook.com (2603:10a6:5:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Thu, 3 Dec
 2020 14:42:42 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::2dbc:de81:6c7a:ac41%8]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 14:42:41 +0000
Subject: Re: [PATCH RFC 1/1] module: delay kobject uevent until after module
 init call
To:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        systemd-devel@lists.freedesktop.org
Cc:     Franck Bui <fbui@suse.com>
References: <20201203135124.16695-1-jeyu@kernel.org>
 <20201203135124.16695-2-jeyu@kernel.org>
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Message-ID: <4418e7a3-39e7-865e-9f2b-56ebf5782ac4@suse.com>
Date:   Thu, 3 Dec 2020 15:42:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <20201203135124.16695-2-jeyu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.220.115.126]
X-ClientProxiedBy: PR3P192CA0015.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::20) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (86.220.115.126) by PR3P192CA0015.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 14:42:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a77e7800-ec15-4dbc-c29a-08d89799afcb
X-MS-TrafficTypeDiagnostic: DB7PR04MB4379:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB43790A3EA6A9B1013FEBEBE2BFF20@DB7PR04MB4379.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +qrVv2OYG+oSfKo68B7xGdO2hmvjPK3lUrNwiERFebS1/A5SrHj14aBXA/oPk1hPEaaF4a6hxPFwj80GGiVY7KTD/vuna2+w3Nem/GE+eZD3Ti+1mqiCiLPCAavb5sN6CB7bQBmB5T/A7sQP24/sVWU4VdXvVhm8I9sWHXP8HvLcPH8QnJWn+1P2F4/CWaePRlxRp43zAlk/uDf1q12dkJ23uBu/ufF9Cmj6JFPzXvxFu5M0oXM3H1kpHXRWGHV9CLilnIgMOT6YP7C/kpi4t+dngJKJah1zdNPdRf1DKnZKf2MIb40Mb02kl90nl4u5Wdc2cAoy2VKrLpuJ2qaVzDo4jH/8gWqzPBVwphJHMrnf4pBEtKDmRzaUeWSPmjQSgITHBniWXAM5ujNqTNU148XpHT22Rc/YHQF2fdmvlNkXgvTIEWbWvkPTMHW835xKljJRVLfBsEr5O+c4dFmyeXk0Ld5EasuqnsX2cbvUKW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(366004)(346002)(396003)(66946007)(5660300002)(16576012)(6486002)(478600001)(52116002)(966005)(8936002)(2616005)(26005)(186003)(8676002)(956004)(16526019)(31686004)(4326008)(107886003)(316002)(31696002)(86362001)(53546011)(2906002)(36756003)(83380400001)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?anEyZGovbm40dUZNNUNCUXJDWlhiZGJyMmVUQ0EyWGt3MjR4TEtDcFFsVFZH?=
 =?utf-8?B?dEJtMFRMUnJ4bXduTEdYUnFSWlA2R3huN0ZvT1VySVBxL2ptS09GZDdMeFph?=
 =?utf-8?B?T1h0c2hqSmxtYW9IZUdDVjBYa3hTT0xNTFZDQTNYZVorZXl3RVJjN0pPbk1s?=
 =?utf-8?B?dHc1L3M4ZjJPYzYveDJYREV6cEdiaGhGaURiZzFHSHNPWEFidWs2WUdjYVd3?=
 =?utf-8?B?REJFUGtMRi9kbGhRZHkwVDhTeTVLcUZwcHhxOG9oNC9EZmtyVHFDTjFDeTVx?=
 =?utf-8?B?WGlSM3dtdFRXSHpGdndUL3RNcjRrTnRQbUxhYnlqOXdSRW14aWxIZFdlK1NR?=
 =?utf-8?B?UEdSc1BoQnUxZHdaOGJSTmVTbDh6c25LQkxzd2pNY2RUMGRKRWhiYnIyTHht?=
 =?utf-8?B?cmVTTHFsb2JVYlRDN01RQUlpRit1aEs2ajdSaU0vWFZWdWM3T1NBc1lISTRl?=
 =?utf-8?B?U1pOOTZuS2h5V0ZlTHgxbHZYYjBkTERUSFBjK0lqSXpRWGRWT2xPWUxxSHFu?=
 =?utf-8?B?Nm0yV1dka005NythOHpBK3FCVjJVaGppeWY2STJLWFFrT0VINlV6OG9oOUw3?=
 =?utf-8?B?enUvV09aRzcyb2QvV2N3UFlqRjJWVlU3cUVNajE2Q2p3aHZnTjdFbm1wSnk0?=
 =?utf-8?B?MXdldURkU3BXcWJ5dE9zZnZidnFwZFZoalBZOGdxRlBKRVEyNkZjMkhGa1hD?=
 =?utf-8?B?a0NXalZHaS9HMzZwVVZCUzhlamxiTFFxUUJaVy8zRUFWTVl1SkFOZGNaWUF3?=
 =?utf-8?B?QXYzSGJqaWRnaHY2bTZrL01HTVNLWTdJZFFIUk1BeFRwYkFaZHEwZkFvaVZl?=
 =?utf-8?B?d0NZbjgxSzVpQWJZTU9WaHB5V3RkL1BnOHJXM3pxWGQwZGhWNHBwNDBsYklR?=
 =?utf-8?B?d0R3Sk1EclFIbXU5L3lSN0M5SWFWcTlEKzhXemJhcWJTMzQwOWQ0V20ybjFR?=
 =?utf-8?B?QTlNT3FOdkZIOWxReVJ0UWZPQmdjNDZPbnF0ay9IWGdKdEJIM3JqU3daK1A3?=
 =?utf-8?B?ckZtQ3Z6bmpDT0czMCtmbVluQmlLeUpwWERMZ1A0K0I5aWhHMCtJZVJYU2w5?=
 =?utf-8?B?dWZndUVFdk42OUpMb1RPYlArK1hNWVhPUVNQWHFTaUtYNERFRGc1clk5RWQ5?=
 =?utf-8?B?bjdVWWVzcE9TN2Y4YlgzUkR1MDNGTFpybmp6QnM3NmczVU4xN2gwckZyS1l2?=
 =?utf-8?B?Zm5BTFFwZ0Q0elRmYnI3MllqL0orRWd2ZkJpb3FwTFlkcHlmNDNuOWwwRmNM?=
 =?utf-8?B?cU1lTmRPZElmTUdGRENYQ1drR2hQb05vNzdVVjc3V3ppTXF3NHhLQzRrWm1Y?=
 =?utf-8?Q?i08BYQIiA8+GkXRGw1evjjO6HF6Nu8pRlj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77e7800-ec15-4dbc-c29a-08d89799afcb
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 14:42:41.0849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1HFZx4Goe2hl5C1gw+Mj8r2YoymuarBACYqfAarmmbv8Pq5Yc1oOqhiNPakt8OX8ojSTiGmIMuhssubEdW6wbWQHXSa9tb/Z50PKbCPMZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4379
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tested this on a system that had the script in patch#0 fail 100% of the time.
With this patch, I haven't seen any failure in a few hours.
Haven't seen any unexpected side effect either.

Tested-By: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>

On 12/3/20 2:51 PM, Jessica Yu wrote:
> Apparently there has been a longstanding race between udev/systemd and
> the module loader. Currently, the module loader sends a uevent right
> after sysfs initialization, but before the module calls its init
> function. However, some udev rules expect that the module has
> initialized already upon receiving the uevent.
> 
> This race has been triggered recently (see link in references) in some
> systemd mount unit files. For instance, the configfs module creates the
> /sys/kernel/config mount point in its init function, however the module
> loader issues the uevent before this happens. sys-kernel-config.mount
> expects to be able to mount /sys/kernel/config upon receipt of the
> module loading uevent, but if the configfs module has not called its
> init function yet, then this directory will not exist and the mount unit
> fails. A similar situation exists for sys-fs-fuse-connections.mount, as
> the fuse sysfs mount point is created during the fuse module's init
> function. If udev is faster than module initialization then the mount
> unit would fail in a similar fashion.
> 
> To fix this race, delay the module KOBJ_ADD uevent until after the
> module has finished calling its init routine.
> 
> References: https://github.com/systemd/systemd/issues/17586
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
>  kernel/module.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index a40ec708f8f2..e1dd0df57244 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1897,7 +1897,6 @@ static int mod_sysfs_init(struct module *mod)
>  	if (err)
>  		mod_kobject_put(mod);
>  
> -	/* delay uevent until full sysfs population */
>  out:
>  	return err;
>  }
> @@ -1934,7 +1933,6 @@ static int mod_sysfs_setup(struct module *mod,
>  	add_sect_attrs(mod, info);
>  	add_notes_attrs(mod, info);
>  
> -	kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
>  	return 0;
>  
>  out_unreg_modinfo_attrs:
> @@ -3656,6 +3654,9 @@ static noinline int do_init_module(struct module *mod)
>  	blocking_notifier_call_chain(&module_notify_list,
>  				     MODULE_STATE_LIVE, mod);
>  
> +	/* Delay uevent until module has finished its init routine */
> +	kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
> +
>  	/*
>  	 * We need to finish all async code before the module init sequence
>  	 * is done.  This has potential to deadlock.  For example, a newly
> 

