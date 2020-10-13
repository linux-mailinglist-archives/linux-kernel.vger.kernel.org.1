Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C3828D02A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbgJMOZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:25:26 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:57538 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387516AbgJMOZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:25:26 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09DEIck8004208;
        Tue, 13 Oct 2020 14:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=bPyz1vZdlihX1U0EwZXgFSbE2Y1m0/lIv5TP9zbxw8Y=;
 b=ZjTcDLIW0oW4kVHsYKSOfZ26hrFixKMAI2UxuljdfNRjhRqlD/eEFEk+qsSPay+yfN4j
 cxrc4HIemiGhmFANvg44k7WF2QMtwZiAMALrxCa818A3CwMrR3NKfnQo+UZJTqH2j+ED
 TMY5fHbAwsDUohMhNJmfYAAM53uW2VYK23KM50puwnSmjSTjfkgM1zERIPRGihubnDDZ
 Fh1meq9YgrgmWqfudZpZ9aZD4hxHlpZNfI6GkmICmUwzzC6Cubq1ahtV2iPsCS+7LVOd
 3vWs9TqJtI+ePZHVB80FnWXyU6wP3tavn9QD0izk0WCa/vhu9+qdcWrGJd1QJdo+OF3G TA== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 343pfkmawt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Oct 2020 14:25:20 +0000
Received: from G9W8453.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.160.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id ECD7081;
        Tue, 13 Oct 2020 14:25:19 +0000 (UTC)
Received: from G4W9121.americas.hpqcorp.net (2002:10d2:1510::10d2:1510) by
 G9W8453.americas.hpqcorp.net (2002:10d8:a0d3::10d8:a0d3) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 13 Oct 2020 14:25:19 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W9121.americas.hpqcorp.net (16.210.21.16) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 13 Oct 2020 14:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYtS2kAAUmfGsyctUz9NFESvnBAT/CuZpxC4TzBQ65Ml4uvPnjwRZY5AS2EG5h1vZOBu20FoGM6J0zct+Hd64DMf2eK3KYR/oZfd89S/KyyHn8k3ywwxGGfhp8s4Qa3CRZHTx30X2SfrvoJFx6xaVJ2p2xABn/6xNUHo6Qoom9Gg19cI2Ye9jniSMKYOvRDFqtqkNf7FsQBtr61wOrapUW+AdlQ6YTdnMm6l3ufDHyGWrI9TFY8qPvmQksu73vCOuJjA7bRo03stlz2f/ue4FPSxVLo7z4ku/cAupDj03eKTtwIOOOzGQrWwEl59BlMNU/F9Zn3gz1lOmwogYb3FQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFui8/zXHkaHoc5cFhO16x8XzmCVV9/MVDkp4MNCxvk=;
 b=BY7i1tz1eEH+aljBftIDU5ShwlF1hNlvMyunglzKESffAMQ/bBLDxNGB4B+YcHxH6obrShxgDbPeC+4Y9woIc7zvFQKW197ZpnRAR/7zgC0Di0fAVUljLyP6cCmg4Xe/marblGk6onGBT+2w1XH03wSVP+DuHMKzEsP9oSRHItJ8qe+H1xfc+6u+RPxf7Qg3btYtLsiTzkxkOePCvnC3UobCDC0keIOG/4K9wzWbJqIGTl0twzhMrDTzxFwHflZiydg4A9A+lTfmv384V4EdTI+dr+k4hMaPZqNCk5I3LMl3IoBjCMVvNHCA/tSPk//xNHS7NK9sEKShDtH9fMf3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Authentication-Results: hpe.com; dkim=none (message not signed)
 header.d=none;hpe.com; dmarc=none action=none header.from=hpe.com;
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM (10.169.48.136) by
 TU4PR8401MB0350.NAMPRD84.PROD.OUTLOOK.COM (10.169.47.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23; Tue, 13 Oct 2020 14:25:18 +0000
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::de2:a57f:7b22:5ef0]) by TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::de2:a57f:7b22:5ef0%4]) with mapi id 15.20.3477.020; Tue, 13 Oct 2020
 14:25:18 +0000
Subject: Re: [GIT PULL] x86/platform updates for v5.10
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Wahl, Steve" <steve.wahl@hpe.com>, Russ Anderson <rja@hpe.com>
References: <20201012101012.GD25311@zn.tnic>
 <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
 <c8cfb3d2-d3c4-6d8d-1dfd-aeb349e26303@hpe.com>
 <20201012212709.GM25311@zn.tnic>
 <f778b25e-68e7-98ec-9032-b35696948405@hpe.com>
 <d865e9cd-38c9-2210-116b-935336a3738f@hpe.com>
 <20201013111158.GD32151@zn.tnic>
 <25632026-b498-022c-f37e-444672d57ecb@hpe.com>
 <20201013132940.GE28215@zn.tnic>
 <93b52b3e-8eda-eb46-0feb-1c02c92d3819@hpe.com>
Message-ID: <20e7f2da-793d-18f9-3345-45095383bdc6@hpe.com>
Date:   Tue, 13 Oct 2020 07:25:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <93b52b3e-8eda-eb46-0feb-1c02c92d3819@hpe.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [73.222.225.80]
X-ClientProxiedBy: SN4PR0501CA0072.namprd05.prod.outlook.com
 (2603:10b6:803:41::49) To TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7715::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.157] (73.222.225.80) by SN4PR0501CA0072.namprd05.prod.outlook.com (2603:10b6:803:41::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.13 via Frontend Transport; Tue, 13 Oct 2020 14:25:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd64a296-1515-4b9b-6ae1-08d86f83cf40
X-MS-TrafficTypeDiagnostic: TU4PR8401MB0350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <TU4PR8401MB03501D507AD98D776689E342E7040@TU4PR8401MB0350.NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xWRhj7+LHXHcR4dchf+Pml1+JGK1Fsel1637f82TOojl8Oe6Uw7OFVtEImYpYuHwwVpG7+1X1JTws8c7M7TxvCbyGx4fBJ+YK+1uqdcJePDlVvKRgxCQhAdVGHNIaqOctguYmos38UkidzkwIaWRWJVfxDePpfQUzPMxDTCsNQLj4qUWpGWBeG95DJ/ER0iQQg5eFLw4sceYSoWQvgWavcA4fXtA5Ih7z7XPJLscKu7dACitKSVjuT1ZADNcr+P46UIrwD9l4oiDEL+O8cEAoW6E+XiVRJKOnQwy+59LWT7UUTYVaBq3l3cE+TZTq15IZvf9ldFMXZcxq6r4Gde816AiaOIe25Ybh3By7XgbAbmZ5Syl7j6RKldmSc6C18Ow
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(376002)(39860400002)(4744005)(16526019)(6486002)(316002)(31696002)(2906002)(478600001)(31686004)(16576012)(8676002)(36756003)(186003)(26005)(54906003)(4326008)(6666004)(66946007)(5660300002)(2616005)(8936002)(53546011)(956004)(86362001)(66556008)(52116002)(66476007)(6916009)(44832011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: jyCakKN5Fu0q56QhqxqlzuRg2skF6JUMzy+0qhnCak4d9fGeJeECfFMgqTk3dtYH7m/nJzeuMpP9lswtt3OcjHubbCZ2RWjxIc7h21f+AUrI99E+OqFzuiRUS2qexbTACuTVYTmO89CpklrGCDG4inpgn2o8jeOlVs55tfAUoBVq4hG4nvBxAiRU4j8fOhx9GhWvEIW46XQDoCDLbgIq585iouETqGT0c6t6cbrcgO4dFTdBfuxIDO4XivetsdDZRsPWi7s/EcD46cxzbD+B1o/tyJTxmyN61ky3jbt2E5Ex//jQK3+dpySqkAdqkMEww4RpZqrD6q0UexQeJ8h+7My9rIum817+DSCMP3rKV98P0BegPm/b3GfFqrKEtc2u01LXDD0hlXyGoH/IDDtGrdsP4iZ8OXCOhOGCmcmEtjSi2CVuqJ9A+IBgvyMSYacYlMPDnYx6fjAnopyj8X9ywjU77h5jovSHx3SMrbTSzJVRm+c6BgwGUlXzRn73ya3mL5QtKduVkq3/euJ8skitB/R3TP6uO4fQh1/3bnYyndZmBYLDgQN3fM5oteHSa5UfYh+JAJxnNLAr+4+axlkfsYHfnO54E634SeFHcjr86Qk/Wa3bhMMm7DUI3i/YrqiR5SMRx5skbqpKqBnvZfFQNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: bd64a296-1515-4b9b-6ae1-08d86f83cf40
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 14:25:18.4078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5itZx11IGiad+fQUgbMx2tsDiERLzFXuxzA5TebTiAfK54qEVYc69yCIPV6Ob0kgBVR9VPnbiv4bU0uCBsXFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0350
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-13_06:2020-10-13,2020-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=2
 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2020 6:37 AM, Mike Travis wrote:
> 
> 
> On 10/13/2020 6:29 AM, Borislav Petkov wrote:
>> On Tue, Oct 13, 2020 at 05:33:37AM -0700, Mike Travis wrote:
>>> I'm working on the correct code now, and I have UV4 & UV4A machine time
>>> starting at 7am (PDT) to test it.  The UV5 simulator does not yet 
>>> emulate
>>> console initiated NMI from the BMC.
>>
>> Ok, let me put it another way: is this simple fix good enough for now so
>> that it doesn't trigger the build error on Linus' tree or not? You can
>> take your time and do all kinds of fixing later but we need a minimal
>> fix *now*!
>>
>> Pretty please?
>>
> 
> Yes, it does fix the compile error.

Turns out I was combining 3 different sources to determine if the NMI 
INT occurred and I used the 1ULL << SHIFT to check each one.  So the 
MASK is indeed extraneous and can be removed.  Tested and patch follows.
