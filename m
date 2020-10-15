Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7B128F12E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgJOL1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:27:37 -0400
Received: from mail-edgeDD24.fraunhofer.de ([192.102.167.24]:21807 "EHLO
        mail-edgeDD24.fraunhofer.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728968AbgJOL1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:27:09 -0400
IronPort-PHdr: =?us-ascii?q?9a23=3AwDXHoBR/f7m9W0mEYWyMCXMwSdpsv++ubAcI9p?=
 =?us-ascii?q?oqja5Pea2//pPkeVbS/uhpkESQB9WJ7f9YgvLO9avnXD9I7ZWAtSUEd5pBH1?=
 =?us-ascii?q?8AhN4NlgMtSMiCFQXgLfHsYiB7eaYKVFJs83yhd0QAHsH4ag7Ur2G79SZUER?=
 =?us-ascii?q?L6ZkJ5I+3vEdvUiMK6n+m555zUZVBOgzywBNE6LBi/oQjL8McMho43I6cqxx?=
 =?us-ascii?q?CPrGFBZuJWwm1lPxSfkkXx?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FbFgBkpYde/xoBYJlmHgELHIFwC4F?=
 =?us-ascii?q?UUAVvVR08CoQRg0YBAYU5hXiBZC2YHoJSA1QKAQEBAQEBAQEBBgEBLQIEAQG?=
 =?us-ascii?q?ERAI1ghIkNwYOAhABAQYBAQEBAQUEAgJphSoBBiUMhkYBAQEDEhEECwENAQE?=
 =?us-ascii?q?3AQ8LDgoCAiYCAjIlBg0BBwEBHoMEgkwDLQIDpDECgTmJV38zgn8BAQWCRYJ?=
 =?us-ascii?q?4GIERewkJAYEEKowxghqBOA+CWj6HYIJejgiCQKBOB4FJd5cfBh2PNQWMRqt?=
 =?us-ascii?q?PAgQCBAUCDgEBBYFoJIFXMz6DOFAYDYgKgzWCXgwXg1CKV3KBKY0ZAYEPAQE?=
X-IPAS-Result: =?us-ascii?q?A2FbFgBkpYde/xoBYJlmHgELHIFwC4FUUAVvVR08CoQRg?=
 =?us-ascii?q?0YBAYU5hXiBZC2YHoJSA1QKAQEBAQEBAQEBBgEBLQIEAQGERAI1ghIkNwYOA?=
 =?us-ascii?q?hABAQYBAQEBAQUEAgJphSoBBiUMhkYBAQEDEhEECwENAQE3AQ8LDgoCAiYCA?=
 =?us-ascii?q?jIlBg0BBwEBHoMEgkwDLQIDpDECgTmJV38zgn8BAQWCRYJ4GIERewkJAYEEK?=
 =?us-ascii?q?owxghqBOA+CWj6HYIJejgiCQKBOB4FJd5cfBh2PNQWMRqtPAgQCBAUCDgEBB?=
 =?us-ascii?q?YFoJIFXMz6DOFAYDYgKgzWCXgwXg1CKV3KBKY0ZAYEPAQE?=
X-IronPort-AV: E=Sophos;i="5.72,341,1580770800"; 
   d="scan'208";a="34944101"
Received: from mail-mtaka26.fraunhofer.de ([153.96.1.26])
  by mail-edgeDD24.fraunhofer.de with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 13:27:06 +0200
IronPort-PHdr: =?us-ascii?q?9a23=3AMjaq4RA16opQTuPfFBDHUyQJPHJ1sqjoPgMT9p?=
 =?us-ascii?q?ssgq5PdaLm5Zn5IUjD/qw33A3PUJnS8+oCgO3T4OjsWm0FtJCGtn1KMJlBTA?=
 =?us-ascii?q?QMhshemQs8SNWEBkv2IL+PDWQ6Ec1OWUUj8yS9Nk5YS8Dze1TKuju56jtBUh?=
 =?us-ascii?q?n6PBB+c+LyHIOahs+r1ue0rpvUZQgt5nK9bLp+IQ/wox/Ws5wfgJBvIeA/0B?=
 =?us-ascii?q?LUpHtPdelMg29ldl8=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AuDADHMIhf/2q0YZlgHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAB4FIAoFQUQeBSR0+CoQzg0cBAYU5hgOBZi6Ye4JTA1ULAQM?=
 =?us-ascii?q?BAQEBAQcBAS0CBAEBhEoCNYFSAiY5BQ0CEAEBBQEBAQIBBgRthS8GJwyFcwE?=
 =?us-ascii?q?BBBIRBAsBDQEBFCMBDwsOCgICJgICMgceBg0BBwEBHoMEgkwDLQIDoQICgTm?=
 =?us-ascii?q?JV38zgwEBAQWCTIJHGIETfQkJAYEEKoJyjF+BOA+CWj6HVIJgkCmCaQGkaQe?=
 =?us-ascii?q?BYYEMmmIFBwMfkjUGjw8rsy4CBAIEBQIOAQEFgWwigVczPoM4UBcCDYdDhlw?=
 =?us-ascii?q?MF4NOilhyOAIGAQkBAQMJfIw7AYEQAQE?=
X-IronPort-AV: E=Sophos;i="5.77,378,1596492000"; 
   d="scan'208";a="93431577"
Received: from 153-97-180-106.vm.c.fraunhofer.de (HELO xch-onprem-06.ads.fraunhofer.de) ([153.97.180.106])
  by mail-mtaKA26.fraunhofer.de with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2020 13:27:04 +0200
Received: from XCH-HYBRID-01.ads.fraunhofer.de (10.225.8.57) by
 xch-onprem-06.ads.fraunhofer.de (10.225.16.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 15 Oct 2020 13:27:03 +0200
Received: from XCH-HYBRID-01.ads.fraunhofer.de (10.225.8.57) by
 XCH-HYBRID-01.ads.fraunhofer.de (10.225.8.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.659.4;
 Thu, 15 Oct 2020 13:27:03 +0200
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (10.225.8.41) by
 XCH-HYBRID-01.ads.fraunhofer.de (10.225.8.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.659.4
 via Frontend Transport; Thu, 15 Oct 2020 13:27:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dh1j7uwPLoPP1UiJ+S4zOkKph01DSa2zRJID1ToLhXfaWCpegg5v3Ed0dAO0Hd8PI+RqE/R9YIqzutFAoML+H5WoB7vGcIrWZlPI/40xQRyhC4Ni/cgWcSRLCktsyiCMVAW5tExJs6OsnsgRT6QNh13LQPtQEGYWwG4cRlwp04S+i+K7JedBHTDlkl0fXGHARyjiSCV/9zxmGUGdv6JnN6Yu7spJ8wZp+H51GYv6isqdq1AQtwtzLwIiyJVFNnNkbDkfdXQ0OkitDq/CrIuBncvETGygXIy0x3iINJkflR1fGNNoBihDvGeRBlto5feZJLkwsyfW2Axksh38oVoppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sknu/9YzjHyv8l3Ol9VWPtE/Be0WAOcVX2zTXwnT9o=;
 b=XRJHAkLzz1SnhFoBhF/vhBseyRnA2/ignR+u184x06UBssuDwHO5Ua8t6CLhFZJwpm/VPVXDgcPeARGX3HovfwfFS4YOtHGV+z1mSVWFSbKOVA4Ehyc8elKiW5ni818xsWWifgShWT6Pt+2EM2urRDLL9AfIK5/Be7yA9awW99raeyxty9WuZn4X/cy/OJlLexcu4tS4flmJKgAUdJOpAcJbU2bFUKU5LFFR0hSHeN5GN7CuB8OQQFxLV/Q8nBaO+lAlbUv82beFQsKhzYeFoY7zs6k82l87qV1accahuTTcXxQfRxwxScVDeTIoPfkpSg+SiOVl5i8K2Q9SbSHa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sknu/9YzjHyv8l3Ol9VWPtE/Be0WAOcVX2zTXwnT9o=;
 b=lm7PkAaEz+0RMVZ0F7+k0Ynh4OQKJzk2b4LNS/a/RFXV0xzvykyP5DXz4SVKBMLGo3StUI8DPdMuWnZWRg2xOEkP7XfPmsYemSSbW/uvpf/2zjyotaRLThue3p/qFJCBLu0HRjZAQ50scFPUNkcdN481i+ninND2497lL3xSeYs=
Authentication-Results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none
 header.from=aisec.fraunhofer.de;
Received: from PR3P194MB0524.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:35::17)
 by PA4P194MB1086.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 15 Oct
 2020 11:27:02 +0000
Received: from PR3P194MB0524.EURP194.PROD.OUTLOOK.COM
 ([fe80::21ac:1329:3a33:7b95]) by PR3P194MB0524.EURP194.PROD.OUTLOOK.COM
 ([fe80::21ac:1329:3a33:7b95%6]) with mapi id 15.20.3477.020; Thu, 15 Oct 2020
 11:27:02 +0000
Subject: Re: [PATCH v3 2/3] fs/proc: apply the time namespace offset to
 /proc/stat btime
To:     Andrei Vagin <avagin@gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
References: <20201011145924.6554-1-michael.weiss@aisec.fraunhofer.de>
 <20201011145924.6554-3-michael.weiss@aisec.fraunhofer.de>
 <20201015075319.GA271498@gmail.com>
From:   =?UTF-8?Q?Michael_Wei=c3=9f?= <michael.weiss@aisec.fraunhofer.de>
Message-ID: <33937e1e-e660-8a17-eb54-4ddb64b1b54a@aisec.fraunhofer.de>
Date:   Thu, 15 Oct 2020 13:26:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <20201015075319.GA271498@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [178.27.102.19]
X-ClientProxiedBy: AM0PR02CA0089.eurprd02.prod.outlook.com
 (2603:10a6:208:154::30) To PR3P194MB0524.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:102:35::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.3.194] (178.27.102.19) by AM0PR02CA0089.eurprd02.prod.outlook.com (2603:10a6:208:154::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 11:27:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84f3095d-0e17-481b-edff-08d870fd3cbd
X-MS-TrafficTypeDiagnostic: PA4P194MB1086:
X-Microsoft-Antispam-PRVS: <PA4P194MB1086AB80349AC2BCE0A62885AC020@PA4P194MB1086.EURP194.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEN2Rcivc01A6dfKjb+LytxnhGOlTSS+YBgm/UaVXLs0Bjk2MlsZ+YmPVxefyAjcPiAV6PhtAQZDXpRQapjKN4cIWeVZ9CrR+VDle4smBB8g2U8PITK7s5K+Zu4+8ZmFiGwZcE48lCp6u7S7KKH2LQ9q4LRbUXHjDCzzRYGLntmbtdUeaocWovxePHUAoxZItcc4ed5k51SGpMrKJsqPaX++XUjaAm+KZMGKKiqibeAOvMe9DDoL3Dx/toIHn58NypNz5XY7gI+lfhhWZuqwcmuLU7cn6f/8MGxzavC5VYefdIl27LXg0/wHWCTj0/mhd2crc7kN1/aYpEuRmet/urCkhJ4pFoH1AUPKw3U8pcr23LMVjgRC9ih5T08AW9mazREZZYxWhA2IAbWyWnQ59J3TXiiVNNlybCWX4BqR9vE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P194MB0524.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39850400004)(6486002)(66946007)(66476007)(31686004)(478600001)(83380400001)(66556008)(316002)(16576012)(54906003)(31696002)(4326008)(2906002)(86362001)(34490700002)(8676002)(16526019)(26005)(186003)(6666004)(53546011)(8936002)(5660300002)(2616005)(52116002)(6916009)(956004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lDwKN45/7XEhbrhrMciTi62Z0vaIRQKgHd/PnGwcuUxMO0Mz08tgKugoxxoWZknk6/A5MbbQ6QMlNgHxJSJn4JzBFjmZingoCQOj4izgaSW0nfMv8foufvTpY7khZkFbzLqWoOHw9zemDwLZCFIvUlZGBdILTsKqsvuCHimf735dtZiZcxrzw3+JQDV6OzWjz1r7Ay1xm8yIR1zfKAqpKJYSiPnpvaPpPbKNWqpHi0OTbDFTgTuinpMnKMa/3dcrnCiwaRsjprHPpQG+8A03TZnZ9rwDXayWTwkyP37xDXISWMIdk62U3mlHsF0wbHvs/R6DptYLWbXmg5p7qaZIJ6ZCl2/VFeFV3OLveaXb9RWb0nB9qHbRapSQrnO9Bh/+q4hYS/f+T0QKFEF4x8TCWOJkgyxsdurrYXWTvw6vdCZGspIR+CYbdD1uWkVEAqHClgICODvV8RGP0NZYpCXDs7TMgmUP0ytkCTH154rNER/uWBhiVgATGRGBKfT9PPoSuBdSi4SRpPokIdY8iLlCBMs+Hm0SGzSKewnZc/C50tmjoECMYdw/TanQulmjA6rQ7dskoRY/Y8+RvWhA3eTwZKP1nqAuWnfqW2//ee5Tz2iRhis809VD+zE/qcFr446q2y5GFmEjRHqTS92jZ/FVsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f3095d-0e17-481b-edff-08d870fd3cbd
X-MS-Exchange-CrossTenant-AuthSource: PR3P194MB0524.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 11:27:02.2426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/zDUOqR6d17cGX3wTOtHHNs8QeTNCNKSdcjiEnxAOFz04ZUla71cSlv3K+xqIA1EZClYINfcaabaBMQTI5vGtbuDtS1P6YWlAxD5shbPho3nhZ+v/QUD3Kk82midoJH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P194MB1086
X-OriginatorOrg: aisec.fraunhofer.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.10.20 09:53, Andrei Vagin wrote:
> On Sun, Oct 11, 2020 at 04:59:23PM +0200, Michael Weiß wrote:
>> @@ -79,6 +80,20 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
>>  
>>  #endif
>>  
>> +static void get_boottime(struct timespec64 *ts)
>> +{
> 
>> +	ktime_t boottime;
>> +
>> +	/* get kernel internal system boot timestamp */
>> +	getboottime64(ts);
>> +
>> +	/* shift boot timestamp according to the timens offset */
>> +	boottime = timespec64_to_ktime(*ts);
>> +	boottime = timens_ktime_to_host(CLOCK_BOOTTIME, boottime);
> 
> timens_ktime_to_host is used to convert timens' time to host's time.
> Here it looks like we are using it in the opposite direction. I spent
> some time to figure out what is going on here. I think it worth to add a
> comment here.
> 
>> +
>> +	*ts = ktime_to_timespec64(boottime);
> 
> I don't like all these conversions back and forth. Maybe something like
> this will look better:
> 
> #ifdef CONFIG_TIME_NS
> 	if (current->nsproxy->time_ns != init_time_ns) {
> 		struct timens_offsets *ns_offsets;
> 		ns_offsets = &current->nsproxy->time_ns->offsets;
> 		ts = timespec64_sub(ts, timens_offsets->boottime);
> 	}
> #endif
> 

I agree to that, but maybe we then introduce another helper in
time_namespace.h analogues to timens_add_boottime() and handle
also the ifdef there:

static inline void timens_sub_boottime(struct timespec64 *ts)
{
	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;

	*ts = timespec64_sub(*ts, ns_offsets->boottime);
}

using this in proc/stat, it is obvious what is going on and we only need
to add one line of code there. Further, future use-cases which depend on
timens aware boottime would be more strait forward to be implement.

Cheers,
Michael
