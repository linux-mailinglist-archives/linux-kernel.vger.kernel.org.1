Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF42929AB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750364AbgJ0L4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:56:50 -0400
Received: from mail-edgeka27.fraunhofer.de ([153.96.1.27]:40281 "EHLO
        mail-edgeKA27.fraunhofer.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750357AbgJ0L4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:56:49 -0400
IronPort-PHdr: =?us-ascii?q?9a23=3AJhWF0hdVW92x86nM/19Wyn/wlGMj4e+mNxMJ6p?=
 =?us-ascii?q?chl7NFe7ii+JKnJkHE+PFxlwaTDdfd5u5Nk/KQuKflCiQM4peE5XYFdpEEFx?=
 =?us-ascii?q?oIkt4fkAFoBsmZQVb6I/jnY21ffoxCWVZp8mv9PR1TH8DzNFvfvnSq9XgZHR?=
 =?us-ascii?q?CsfQZwL/7+T4jVicn/3uuu+prVNgNPgjfYA/tyIRy6oB+XuNMRhN5rK708wV?=
 =?us-ascii?q?3HuHJVfeRRy25yY16ezBs=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FBBwDYCZhf/xmnZsBgHQEBAQEJARI?=
 =?us-ascii?q?BBQUBQIFPAoFQUYIrCoQyg0oBhTqHXy6YeoFCgREDVQsBAQEBAQEBAQEHAQE?=
 =?us-ascii?q?tAgQBAQKESAI1gU8BJTkFDQIQAQEGAQEBAQEGBAIChkoMg1SBBwEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCgQw+AQEBAxIRDwENAQE?=
 =?us-ascii?q?3AQ8LDgoCAhEVAgIyJQYBDAEHAQEegwSCTAMtAQEDmzgBEi0CgTuJXoEygwQ?=
 =?us-ascii?q?BAQWCTIJIGIETfQkJAYEEKoJyhjSEE4IbgTgPglo+g3aBBoJYgl+TGAGkcQe?=
 =?us-ascii?q?BYoEMmnAFBwMfkj4GjxorkxSgOQIEAgQFAg4BAQWBbIF6Mz6DOFAXAg2OH4N?=
 =?us-ascii?q?xildzOAIGAQkBAQMJfIw7AYEQAQE?=
X-IPAS-Result: =?us-ascii?q?A2FBBwDYCZhf/xmnZsBgHQEBAQEJARIBBQUBQIFPAoFQU?=
 =?us-ascii?q?YIrCoQyg0oBhTqHXy6YeoFCgREDVQsBAQEBAQEBAQEHAQEtAgQBAQKESAI1g?=
 =?us-ascii?q?U8BJTkFDQIQAQEGAQEBAQEGBAIChkoMg1SBBwEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQUCgQw+AQEBAxIRDwENAQE3AQ8LDgoCAhEVA?=
 =?us-ascii?q?gIyJQYBDAEHAQEegwSCTAMtAQEDmzgBEi0CgTuJXoEygwQBAQWCTIJIGIETf?=
 =?us-ascii?q?QkJAYEEKoJyhjSEE4IbgTgPglo+g3aBBoJYgl+TGAGkcQeBYoEMmnAFBwMfk?=
 =?us-ascii?q?j4GjxorkxSgOQIEAgQFAg4BAQWBbIF6Mz6DOFAXAg2OH4NxildzOAIGAQkBA?=
 =?us-ascii?q?QMJfIw7AYEQAQE?=
X-IronPort-AV: E=Sophos;i="5.77,423,1596492000"; 
   d="scan'208";a="25270737"
Received: from mail-mtadd25.fraunhofer.de ([192.102.167.25])
  by mail-edgeKA27.fraunhofer.de with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 12:56:46 +0100
IronPort-PHdr: =?us-ascii?q?9a23=3AsCGWtxIJhN+F3zeJ+NmcpTVXNCE6p7X5OBIU4Z?=
 =?us-ascii?q?M7irVIN76u5InmIFeGv6U/ilLVVJ3DrflDjrmev6PhXDkG5pCM+DAHfYdXXh?=
 =?us-ascii?q?AIwcMRg0Q7AcGDBEG6SZyibyEzEMlYElMw+Xa9PBtTFdr3f0WUqXq3vnYeHx?=
 =?us-ascii?q?zlPl9zIeL4UofZk8Ww0bW0/JveBmcAhDe0bb5oahusqgCEv8gNjIAkJLw41x?=
 =?us-ascii?q?3JpXVFYaJayDBl?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BxHAAMCphf/2q0YZlgHgEBCxIMQAe?=
 =?us-ascii?q?BSoFQUQeBSR0+CoQyg0oBhTqFeYFmLph6gUKBEQNVCwEDAQEBAQEHAQEtAgQ?=
 =?us-ascii?q?BAYRKAjWBTAImOQUNAhABAQUBAQECAQYEbYVhDIVzAQEBAxIRDwENAQEUIwE?=
 =?us-ascii?q?PCw4KAgIRFQICMgceBgEMAQcBAR6DBIJMAy0CA5s1ARItAoE7iV6BMoMEAQE?=
 =?us-ascii?q?FgkyCSBiBE30JCQGBBCqCcoY0hi6BOA+CWj6DdoEGgliCX5MYAaRxB4FigQy?=
 =?us-ascii?q?acAUHAx+SPgaPGiuTFKA5AgQCBAUCDgEBBYFsIoFXMz6DOFAXAg2OH4Nxild?=
 =?us-ascii?q?zOAIGAQkBAQMJfIw7AYEQAQE?=
X-IronPort-AV: E=Sophos;i="5.77,423,1596492000"; 
   d="scan'208";a="93801480"
Received: from 153-97-180-106.vm.c.fraunhofer.de (HELO xch-onprem-07.ads.fraunhofer.de) ([153.97.180.106])
  by mail-mtaDD25.fraunhofer.de with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2020 12:56:44 +0100
Received: from XCH-HYBRID-01.ads.fraunhofer.de (10.225.8.57) by
 xch-onprem-07.ads.fraunhofer.de (10.225.16.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Tue, 27 Oct 2020 12:56:43 +0100
Received: from XCH-HYBRID-02.ads.fraunhofer.de (10.225.8.59) by
 XCH-HYBRID-01.ads.fraunhofer.de (10.225.8.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.659.4;
 Tue, 27 Oct 2020 12:56:43 +0100
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (10.225.8.41) by
 XCH-HYBRID-02.ads.fraunhofer.de (10.225.8.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.659.4
 via Frontend Transport; Tue, 27 Oct 2020 12:56:42 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwLDQzkv4mcpYfy8WNCJLu9XIlj+UXxtNVH+cJawH/SM8FM/xmjSEPaLM32MsuFFM867bJgfF6OnYTm7ELEJ7/tKUDYox8XFTapCOxSLQA/QHsSjRKuv6MbbbcKFikOSpT4rSJsiABfS6gO70jjIhtDTMB9lFuzk/lJPxJ3G53A3dbRt9BNi8EJVrfIR0PP5wRobE549+e8j4cv3TSbPHs3J9QsGLQHr7S6VA9/Gf4MrudMxxuosAKFf9VDeihffXmOSnLQdP1YFo1hTysR9ql9cfpFxy2LrgWM6dtXwnaqQryTuEcwzZGWjgx8Nc/jOioX6KmymTAixjraKGAshYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI0a3OHrTAjFrqJ6YMAST5skNL9yQt/Whey/JHtPwwY=;
 b=HkoQdSNJ6TcoLF2hOBqd8LmFz8r2Zzk8DH/UhQKQpFDuloErUFFMh6fYS6bRaeBt6fXzSmEFYuf/S+D7PI5B1sJ6KvjzzP3rWwi/+8ccndLOAnvl+71zGKPQRNOHErUng5Hu4QhNAzfmD7nASoO1XHO0ItFKxecyNX0RyUxNbnX1/PRh5eWntXMsbUYft4UJz98NhSXQkKd6KNRMXVMWwBzryn93fSGEuFltGznhpbL6uoZ1gh4yrhlMX+TkV5ymeagpHEO9yU1hERQ+//fFZY8nE36JkOCbimSe0SeW8UK03Ufy6mDrJ4o9mbLtiI8q50EBEoGY856gpe9z/6koiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aisec.fraunhofer.de; dmarc=pass action=none
 header.from=aisec.fraunhofer.de; dkim=pass header.d=aisec.fraunhofer.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fraunhofer.onmicrosoft.com; s=selector2-fraunhofer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UI0a3OHrTAjFrqJ6YMAST5skNL9yQt/Whey/JHtPwwY=;
 b=l5+AucJhB3UXQEvJEZrR9V33W2JJ2EloKjIXP7dJJ/FD/1WKpGQ16dAt3YeSa3UJm+PzX5fIH6ZDBO07qXpNoskfQoZPENTsobigvbXRBI88Eo4dxGMA7un+5wogYBUdTCMfJW4LeNeY5b/w5vAIuaula1h7NPIAZOkJFhjXQAI=
Authentication-Results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none
 header.from=aisec.fraunhofer.de;
Received: from VE1P194MB0814.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:16e::20)
 by VI1P194MB0606.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:146::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 27 Oct
 2020 11:56:40 +0000
Received: from VE1P194MB0814.EURP194.PROD.OUTLOOK.COM
 ([fe80::a444:c1dd:6805:6e3b]) by VE1P194MB0814.EURP194.PROD.OUTLOOK.COM
 ([fe80::a444:c1dd:6805:6e3b%8]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 11:56:40 +0000
Subject: Re: [PATCH v4 2/3] fs/proc: apply the time namespace offset to
 /proc/stat btime
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
CC:     Dmitry Safonov <0x7f454c46@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
References: <20201019195257.10728-1-michael.weiss@aisec.fraunhofer.de>
 <20201019195257.10728-3-michael.weiss@aisec.fraunhofer.de>
 <87eell46y2.fsf@nanos.tec.linutronix.de>
From:   =?UTF-8?Q?Michael_Wei=c3=9f?= <michael.weiss@aisec.fraunhofer.de>
Message-ID: <c83b8551-ebb9-12df-3e3b-fcd4047671bd@aisec.fraunhofer.de>
Date:   Tue, 27 Oct 2020 12:56:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <87eell46y2.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [178.27.102.19]
X-ClientProxiedBy: AM0PR01CA0178.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::47) To VE1P194MB0814.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:16e::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.3.194] (178.27.102.19) by AM0PR01CA0178.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 11:56:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afa915ae-6972-4e56-05ca-08d87a6f5da0
X-MS-TrafficTypeDiagnostic: VI1P194MB0606:
X-Microsoft-Antispam-PRVS: <VI1P194MB0606187FA26265E31563EC44AC160@VI1P194MB0606.EURP194.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umVeV0cAMUFeAxTsMdC0fkYZXitWop91g6GrIuqupYM7X/QphFtkrEdSKZJnFyg7c/IPIOcoZEzRy2q1fI/sufXxnuQGdx9VPfCKD0Ijw8D52lHAaYDAlY620j1rmr5sS6Px/Ziei6SZNhPGkkGfeorAWu637N7mda/Eln+8UDLG4og/sZYn8YS7tzir1nEa3CDGNWApSL2gXmI/mjcHCN3aJhNujdt0aQLtd2jZwyurdO+eu9RLLMrnQ7HONX1Uu2JNulVvQwQhET/nh/2OLGNkO+NHjP18RCIvIs7VA+IGOBGR4z0djeMZpqUf4bHOW5yEcW5iuVo9iVKm4ZvVzMHUB/y9jy2UL3wijzU9+o5guwvkPL/vLgtQAwOxIAAO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1P194MB0814.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(6666004)(66556008)(66476007)(53546011)(2906002)(83380400001)(186003)(6486002)(8676002)(66946007)(16526019)(110136005)(316002)(956004)(2616005)(31686004)(478600001)(26005)(4326008)(86362001)(5660300002)(16576012)(31696002)(8936002)(54906003)(52116002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: yQXd54LuplIDaVEKjQURuFbYp8e2BUgxmEUMU1outLgU1bFhrVgetEiVAQ6JIlf0L0O9jC7vEZxuj/LXw3Ww2uI6QMFcycvoL+UXJsGxsXEArVLWik4Uts0DapPZdHdiRvElfNRoqo28ws+CCWyCNVnyXFay/Tkszzzz73YvNwuSEPcJ9ecdK1Z6j18cAMJxhuxiA1LXT792gKqXA9jXh5IgLlxMAw7wc5+htznslH9jvdlkZ/ssVYwSvEG74WcpupNe9RETdBYNMQTvB3mZeP2FlCl5FRfHk5BAvuXFvJ6iPvXi0kVEN71uU5V1ZO/Iq/jv29pxKTVKpCpAoPgywRBGBgWRBR40+r8fXLQ3UaVP4IFmQKAQW8pwave4vUFBVDPfLze1nAdW2fkkjKx8kWLQ4zgsWsinAT37DxM/XFCdANvr6l37d6euUME1FZMS0Iq6qKbPCTZMMmKjj7vgHPvLBCEdjCSCo+VT0f9skVWoAS/gU1+a+3ZnW7DUJIOZTUhOj6amgVxUiKJevkKaQ9qbl3uTJEpBZSJZstpVv/OUXCBlbdbR9sZ6isDa2vnGjyywBk+KWAwSgGwC/JleJJWBgQ2q3/WyMQlAjG7Ic8wSH2Rby4dAH9aH6bMwxxMVdV4867RIMksJD3pxDo/fKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: afa915ae-6972-4e56-05ca-08d87a6f5da0
X-MS-Exchange-CrossTenant-AuthSource: VE1P194MB0814.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 11:56:40.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f930300c-c97d-4019-be03-add650a171c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8QFwCg012Iy/TACu29vG/PX9tPW12k8AylDn29jvKiKAK6VQIEoM/Bgxv8s8GML7fTFZ0hs3B8Silv4VukMOSdNN/BNdDz8JimIIS40XZvrAkNYx9xGGJ8PFEksAVqS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P194MB0606
X-OriginatorOrg: aisec.fraunhofer.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

On 26.10.20 11:28, Thomas Gleixner wrote:
> On Mon, Oct 19 2020 at 21:52, Michael Weiß wrote:
> 
>> '/proc/stat' provides the field 'btime' which states the time stamp of
>> system boot in seconds. In case of time namespaces, the offset to the
>> boot time stamp was not applied earlier. However, in container
>> runtimes which utilize time namespaces to virtualize boottime of a
>> container, this leaks information about the host system boot time.
> 
> Not sure if that qualifies as a leak. The point is that it confuses the
> tasks which are in a different time universe.
> 
From a container isolation perspective this could be interpreted as an
information leak, if you want to hide the host systems boot time form
users inside of the container.
However, since proc is not totally isolated concerning host system
information inside of namespaces, I agree to your point.

I will take this into account when preparing v5.
When amending the tags I will also updated this passage and remove the
leak statement.

Thanks,
Michael
