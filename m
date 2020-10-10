Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3787628A239
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389380AbgJJWzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:38 -0400
Received: from mail-edgeka27.fraunhofer.de ([153.96.1.27]:25698 "EHLO
        mail-edgeKA27.fraunhofer.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731421AbgJJTXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:23:04 -0400
IronPort-PHdr: =?us-ascii?q?9a23=3AXdpdSBU8fhjNnofQC1L8VYU1FqDV8LGuZFwc94?=
 =?us-ascii?q?YnhrRSc6+q45XlOgnF6O5wiEPSBN+LufRJl+POq+brXmlTqZqCsXVXdptKWl?=
 =?us-ascii?q?dFjMgNhAUvDYaDDlGzN//laSE2XaEgHF9o9n22Kw5ZTcD5YVCBpHCu5CYKXB?=
 =?us-ascii?q?74MFk9KuH8AIWHicOx2qi78IHSZAMdgj27bNYQZBW7pAncrI8Ym4xnf68w0R?=
 =?us-ascii?q?bC5HVScvlQxWRmKEjVkxuv6w=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FgAgDFn4Ff/xoHYZlgGwEBAQEBAQE?=
 =?us-ascii?q?BBQEBARIBAQEDAwEBAUCBT4FSUYIrCoQzg0cBAYU5h2kIJoECl3mCUwNVCwE?=
 =?us-ascii?q?BAQEBAQEBAQcBAS0CBAEBAoRIAjWBYAElOBMCEAEBBgEBAQEBBgQCAoZFDIN?=
 =?us-ascii?q?UgQMBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAoEMPgE?=
 =?us-ascii?q?BAQMSEQQLAQ0BATcBDwsOCgICJgICMiUGAQwBBQIBAR6DBIJMAy0CA50cAoE?=
 =?us-ascii?q?5iVd/M4MBAQEFgkyCNhiBE30JCQGBBCqCcoYxhBKCG4ERJwwDgiU1PodUgmC?=
 =?us-ascii?q?TCwGHZ5xuB4FggQuaXAUHAx+DFI8aBo8DK5JzgXueKQIEAgQFAg4BAQWBa4F?=
 =?us-ascii?q?7Mz6DOFAXAg2OHwwXg06KWHICNQIGAQkBAQMJfIw7AYEQAQE?=
X-IPAS-Result: =?us-ascii?q?A2FgAgDFn4Ff/xoHYZlgGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4FSUYIrCoQzg0cBAYU5h2kIJoECl3mCUwNVCwEBAQEBAQEBAQcBA?=
 =?us-ascii?q?S0CBAEBAoRIAjWBYAElOBMCEAEBBgEBAQEBBgQCAoZFDINUgQMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAoEMPgEBAQMSEQQLAQ0BA?=
 =?us-ascii?q?TcBDwsOCgICJgICMiUGAQwBBQIBAR6DBIJMAy0CA50cAoE5iVd/M4MBAQEFg?=
 =?us-ascii?q?kyCNhiBE30JCQGBBCqCcoYxhBKCG4ERJwwDgiU1PodUgmCTCwGHZ5xuB4Fgg?=
 =?us-ascii?q?QuaXAUHAx+DFI8aBo8DK5JzgXueKQIEAgQFAg4BAQWBa4F7Mz6DOFAXAg2OH?=
 =?us-ascii?q?wwXg06KWHICNQIGAQkBAQMJfIw7AYEQAQE?=
X-IronPort-AV: E=Sophos;i="5.77,358,1596492000"; 
   d="scan'208";a="24884050"
Received: from mail-mtas26.fraunhofer.de ([153.97.7.26])
  by mail-edgeKA27.fraunhofer.de with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2020 13:51:22 +0200
IronPort-PHdr: =?us-ascii?q?9a23=3Au5edIRVxjGE0yuB9HEau2z2xIc3V8LGuZFwc94?=
 =?us-ascii?q?YnhrRSc6+q45XlOgnF6O5wiEPSBN+LufRJl+POq+brXmlTqZqCsXVXdptKWl?=
 =?us-ascii?q?dFjMgNhAUvDYaDDlGzN//laSE2XaEgHF9o9n22Kw5ZTcD5YVCBpHCu5CYKXB?=
 =?us-ascii?q?74MFk9KuH8AIWHicOx2qi78IHSZAMdgj27bNYQZBW7pAncrI8Ym4xnf68w0R?=
 =?us-ascii?q?bC5HVScvlQxWRmKEjVkxuv6w=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DQBADZnoFf/2q0YZlgGwEBAQEBAQE?=
 =?us-ascii?q?BBQEBARIBAQEDAwEBAUAHgUiBUlEHgUlbCoQzg0cBAYU5hgOBZggmgQKXeYJ?=
 =?us-ascii?q?TA1ULAQMBAQEBAQcBAS0CBAEBhEoCNYFdAiY4EwIQAQEFAQEBAgEGBG2FXAy?=
 =?us-ascii?q?FcwEBBBIRBAsBDQEBFCMBDwsOCgICJgICMgceBgEMAQUCAQEegwSCTAMtAgO?=
 =?us-ascii?q?dDgKBOYlXfzODAQEBBYJMgjYYgRN9CQkBgQQqgnKGMYYtgREnDAOCJTU+h1S?=
 =?us-ascii?q?CYJMLAYdnnG4HgWCBC5pcBQcDH4MUjxoGjwMrknOBe54pAgQCBAUCDgEBBYF?=
 =?us-ascii?q?rI4FXMz6DOFAXAg2OHwwXg06KWHICNQIGAQkBAQMJfIw7AYEQAQE?=
X-IronPort-AV: E=Sophos;i="5.77,358,1596492000"; 
   d="scan'208";a="124013636"
Received: from 153-97-180-106.vm.c.fraunhofer.de (HELO xch-onprem-05.ads.fraunhofer.de) ([153.97.180.106])
  by mail-mtaS26.fraunhofer.de with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2020 13:51:19 +0200
Received: from XCH-HYBRID-01.ads.fraunhofer.de (10.225.8.57) by
 xch-onprem-05.ads.fraunhofer.de (10.225.16.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Sat, 10 Oct 2020 13:51:19 +0200
Received: from XCH-HYBRID-01.ads.fraunhofer.de (10.225.8.57) by
 XCH-HYBRID-01.ads.fraunhofer.de (10.225.8.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.659.4;
 Sat, 10 Oct 2020 13:51:19 +0200
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (10.225.8.41) by
 XCH-HYBRID-01.ads.fraunhofer.de (10.225.8.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.659.4
 via Frontend Transport; Sat, 10 Oct 2020 13:51:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUhIRrdyKVtqwu4MNN2tTeOWDmdedpumYLjXUVo4vDS2WkJLsJ5BeVeciAHa05tWbrjGEcCMfodg60DqjH7WC4xDiX7EI+qsprTL3QSqO/8OXTnhaRiEqx+jugFSuOW4wioIJ3oXsARqg5fSOv3cfNUqGzLJbWM+m/77LHIRa5NSxwARMTwmf/WnUtQrxzaTjJSfwaICUEAIKefY/4I7FmOvZUDCJqPHTHEkPQTDZGCcBZcwB5bwnZLHgGynf7Zvd1aO/dG7WANeQ2qeEPuRsqUu/Cgm0hRNAPPPxWFy1W0FYqEmW3u2xGBAjP+fgUZFMffB6g4wZqCytJaTGBABDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj++1eDosy6pBbruF4HxJQGjMoEItbnhKr3/ReNwLjs=;
 b=aK/QeVBZWGnGQWM6cF8PhZwK0LdSkTRFZo/Ak88Z+anaoZGIXJF/WXcRyFpZYZBksYdHlb2CprTsnuQrqyKml7raAOLXDkvIas5fICgHRHAAIfya8mjEcwDOS3uZpKExvEI3FVvIPbiDkjTCw+pQv4qCjq/3TvjiVKVzzrz+Yzus04vCWWwGZRWrGU/iiUCVZn/re3ecqYl7Pjbz+RfuOtNO6izl4/VKq9kOEKeIie3NI8giJpc/yqMNTRYtdA2cQro5tPSpIpiMS37poEVFwvx4NWRI/6NeDEKyYW5ajLd37WFOJHcnunsSb9P21Ow6w9ic752oIjGa5OnL57FhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj++1eDosy6pBbruF4HxJQGjMoEItbnhKr3/ReNwLjs=;
 b=mwS38JTUx5waGzJYXCpGjZKFawUAS8wMy3QtpNv5NVL6v9wqci6QRifK9UZgVVFu7KlETAa07ttdYgAtZOwq0Bk3+1ywDzHbBLBftew4lvRe/CcZgN4iUj2Nkyumwk6S+5lBkCD5k/TWARqiUlj8Nfv/Zty6/QtbjqNBvsMZRjI=
Authentication-Results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none
 header.from=aisec.fraunhofer.de;
Received: from VI1P194MB0526.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:15b::12)
 by VI1P194MB0461.EURP194.PROD.OUTLOOK.COM (2603:10a6:803:48::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Sat, 10 Oct
 2020 11:51:17 +0000
Received: from VI1P194MB0526.EURP194.PROD.OUTLOOK.COM
 ([fe80::34fe:1b82:3115:c1fa]) by VI1P194MB0526.EURP194.PROD.OUTLOOK.COM
 ([fe80::34fe:1b82:3115:c1fa%9]) with mapi id 15.20.3455.028; Sat, 10 Oct 2020
 11:51:16 +0000
Subject: Re: [PATCH v2 2/4] time: make getboottime64 aware of time namespace
To:     Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Dmitry Safonov <0x7f454c46@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
 <20201008053944.32718-3-michael.weiss@aisec.fraunhofer.de>
 <20201009132815.5afulu5poh5ti57m@wittgenstein>
 <20201010071914.GA135401@gmail.com>
From:   =?UTF-8?Q?Michael_Wei=c3=9f?= <michael.weiss@aisec.fraunhofer.de>
Message-ID: <3bb1af44-4245-365d-8ef4-ce17debc476f@aisec.fraunhofer.de>
Date:   Sat, 10 Oct 2020 13:50:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201010071914.GA135401@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [178.27.102.19]
X-ClientProxiedBy: AM3PR03CA0068.eurprd03.prod.outlook.com
 (2603:10a6:207:5::26) To VI1P194MB0526.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:15b::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.3.194] (178.27.102.19) by AM3PR03CA0068.eurprd03.prod.outlook.com (2603:10a6:207:5::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Sat, 10 Oct 2020 11:51:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 620d9ecd-8d84-409f-4bd2-08d86d12cb5b
X-MS-TrafficTypeDiagnostic: VI1P194MB0461:
X-Microsoft-Antispam-PRVS: <VI1P194MB046136B5B53433AB49494225AC090@VI1P194MB0461.EURP194.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9k5ATGJxxyRqM3C86qZllt2CP2AHY/Eudcgin8HAiTbdUFEU9Z9khtwa/W4z0IIwkiu9qzBLTIK4DdsBOhf0HXYp5JDJLyHMZ538NbIR88jDdsL7/i9JwOjo2JfrrzV1W1d/0OsdTeH5P4iDVw9IhirOLZQIs/Bx3PW/+RLqthkq74f325KowlH1O+QzhFIXav2OiGxxnUlhPMmR06ADj7/EOztDCvP17TISv2kSbTSOgy7lbm9jG7Rg81IFsPZYt1THn0aIOSF1wnUimMrJ6kdXXIsI7S9tS2HRhJZhItZp0cmYQlLEm67EEqUVTbyftA4Ca4+2irAmpjPKCCNmhleLQiMFFcAoKoK1p3mHvQuXDHr2EbbhhgZyi2f67Q7F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P194MB0526.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39840400004)(396003)(8936002)(8676002)(2906002)(83380400001)(4326008)(66946007)(66476007)(66556008)(6666004)(6486002)(16526019)(186003)(956004)(2616005)(26005)(16576012)(86362001)(478600001)(316002)(110136005)(54906003)(31686004)(5660300002)(53546011)(31696002)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: EScQqHiqtFZPtfdTCIL7Zsa282Jsabp1ELc6yuNOcurgyBY48HzM+0tavxW3RUCLO+BAK9Icgv5fKHbqjj9UaTtEuHR58r6akBeruFIbbqoITO76mfkqeHG9C3P/ssrinnPthEDau81At/zBappOFLWLAtT2ZD/B7OQ+MeiO+r1jcEWs03jBU7+vnfz8TgLhnooSFnCcOdq3y6s06mzk/YFV+KTzBJkFf98iETsecF8E2HQ1mueStFKpEzmPiPuWh6F7dKv1gvRzCUva23aqMV2Rp2lei6PTROViYtWioskZLEP0PAKbQNSpjYFDPLYCh3K+LKJvUZy30+zIbf13CR4QRJT4S0zwUkebpa70fHoErYxc+t1nb8jtB3zs/+c03Y9M5XAsaSQH+N+hJz1GchtiGOiF+JuriKVu8wn+St7/xxNLQkhACBsvt0mtOq07AsS6/eJUoG7yVGBKONeRv5OcGWEEWTxiNfpHmhUIqk23EjXlY/0lKTme5hmXZhdB8QPHCcXnlAFJ9jL0T0oeDmbDnGZCKgPA0HNDsswmMjqd1ni+3dONCg1MwW6h7EWf4IxhakMSPBiK1N2J50S2cDHIFrs9BP43jPNXyAyIL2VdNwN5ED6w0lhJF6brvekY/dCMHWDdmrUzwllFVU3pcA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 620d9ecd-8d84-409f-4bd2-08d86d12cb5b
X-MS-Exchange-CrossTenant-AuthSource: VI1P194MB0526.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2020 11:51:16.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //AY5djfOfDuV7M6zr6A33RzJxVb6i0xYIJvltzb36ahdyhY3vmqWF218xJ7FfO+YGbIS5D2jBfeFkj5zKMBnFbbmmbAoo0WAsFtFUEPfZDQ0ht1QvM2wLOeU01AmVey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P194MB0461
X-OriginatorOrg: aisec.fraunhofer.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.10.20 09:19, Andrei Vagin wrote:
> On Fri, Oct 09, 2020 at 03:28:15PM +0200, Christian Brauner wrote:
>> On Thu, Oct 08, 2020 at 07:39:42AM +0200, Michael Weiß wrote:
>>> getboottime64() provides the time stamp of system boot. In case of
>>> time namespaces, the offset to the boot time stamp was not applied
>>> earlier. However, getboottime64 is used e.g., in /proc/stat to print
>>> the system boot time to userspace. In container runtimes which utilize
>>> time namespaces to virtualize boottime of a container, this leaks
>>> information about the host system boot time.
>>>
>>> Therefore, we make getboottime64() to respect the time namespace offset
>>> for boottime by subtracting the boottime offset.
>>>
>>> Signed-off-by: Michael Weiß <michael.weiss@aisec.fraunhofer.de>
>>> ---
>>>  kernel/time/timekeeping.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
>>> index 4c47f388a83f..67530cdb389e 100644
>>> --- a/kernel/time/timekeeping.c
>>> +++ b/kernel/time/timekeeping.c
>>> @@ -17,6 +17,7 @@
>>>  #include <linux/clocksource.h>
>>>  #include <linux/jiffies.h>
>>>  #include <linux/time.h>
>>> +#include <linux/time_namespace.h>
>>>  #include <linux/tick.h>
>>>  #include <linux/stop_machine.h>
>>>  #include <linux/pvclock_gtod.h>
>>> @@ -2154,6 +2155,8 @@ void getboottime64(struct timespec64 *ts)
>>>  {
>>>  	struct timekeeper *tk = &tk_core.timekeeper;
>>>  	ktime_t t = ktime_sub(tk->offs_real, tk->offs_boot);
>>> +	/* shift boot time stamp according to the timens offset */
>>> +	t = timens_ktime_to_host(CLOCK_BOOTTIME, t);
>> Note that getbootime64() is mostly used in net/sunrpc and I don't know
>> if this change has any security implications for them.
> I would prefer to not patch kernel internal functions if they are used
> not only to expose time to the userspace.
>
> I think when kernel developers sees the getboottime64 function, they
> will expect that it returns the real time of kernel boot. They will
> not expect that it is aware of time namespaces and a returned time will
> depend on a task in which context it will be called.
>
> IMHO, as a minimum, we need to update the documentation for this function or
> even adjust a function name.
>
> And I think we need to consider an option to not change getbootime64 and
> apply a timens offset right in the show_stat(fs/proc/stat.c) function.
>
> Thanks,
> Andrei

Since the problems in softirq context mentioned from Thomas,
I would agree to Andrei's option to just patch proc/stat.c and leave
getboottime64 unchanged.

Digging around in the kernel tree, I just found /proc/stat as the only
place where boottime is exposed to userspace, thus it seems a valid
option.

What do you think? If you agree I'll come up with an updated patch-set.

Cheers,
Michael



