Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8492C26C1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbgKXNE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:04:56 -0500
Received: from mail-eopbgr680062.outbound.protection.outlook.com ([40.107.68.62]:64487
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732763AbgKXNEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:04:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4LodbxA8dqiiU13ar9uWYOhMQfAc/a15HShoLF7C61pG8aovEmlS4KGfVFX5lNyo1WNpknuoKVcKlATL7Yf99ItPHbKAVEfqxNImorAmM2dVoXlQ+8YAPm4AwYBtPiu/drYGOvTuecRWMswgQbD1O+yji0V5A0U0WkbyGz+H+cOqygdrYpn//leBULsoftyG0MAnT6M3w/yBKHPvoBtlJTwLmC/GQI/Wf1aUBC9/5NtYfZCnmSDgBgLr77yOtfRfxkm6Nkl273GOH07N4/r9fM6QAKzbIR9/tKOoo6Yq6nbbSaR9JI5xJfXlAG31D2EPz1lQ/gYX+ow3eHEXcRUzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fboZ5BTHLdWnzkEjTcjaJYI4eIrDtibOvxm8UXpAeBM=;
 b=hNOXqwSz1SPybwTM1975lqRz1xFAoF65SUwLXa19u/PMsNf82Kxgj61lPXB4lY8SsJmoE8iffA2ZrHbLFn8mg8rg+3mCrm13c7MX+tJ5yuHqIe2JgTxx8Im22JpNm/SToc2inBh53BIeNg3w7Bb6DxRaZYvbdy/8scNCZY6DdEcLXFUYJDzjvtn/BExVrBb8UuBF3QtYk3XWQ4jtIpoQXN8OuhpXRDjlqhrVBs7O9MnKzJM5ZmrTt+ukkwlSAn8MYM6CCXVl/IaJUl7rC3fWwCJKeSOkoHvFBxoV/EISnFaB8zoyFKYjeH0mFDFVdggjgaqJ9Vf2kPjWWGkGEADXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fboZ5BTHLdWnzkEjTcjaJYI4eIrDtibOvxm8UXpAeBM=;
 b=jtfhK7k4MfuF4O3MrydyIAAN/RgFeCDFJp6xHgbJOBlAX0J8Kf3U3A/zvF7lQH5KOp2Vm04g8DxXwwD559PPyk1hwubMA/H4CnzhXN++XhPnjwlgl0CXcOV1iaV+aLZUSukw0rNMn0qiwITAprvo+TtJBMNykSb+y54DkrKV/f0=
Received: from DM3PR12CA0104.namprd12.prod.outlook.com (2603:10b6:0:55::24) by
 MN2PR02MB5840.namprd02.prod.outlook.com (2603:10b6:208:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 24 Nov
 2020 13:04:51 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::22) by DM3PR12CA0104.outlook.office365.com
 (2603:10b6:0:55::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22 via Frontend
 Transport; Tue, 24 Nov 2020 13:04:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 13:04:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 24 Nov 2020 05:04:49 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 24 Nov 2020 05:04:49 -0800
Envelope-to: ravi.patel@xilinx.com,
 amit.sunil.dhamne@xilinx.com,
 rajan.vaja@xilinx.com,
 michal.simek@xilinx.com,
 TEJASP@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de,
 arnd@kernel.org
Received: from [172.30.17.109] (port=52568)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1khY01-0001HI-Jd; Tue, 24 Nov 2020 05:04:49 -0800
Subject: Re: [PATCH] firmware: xilinx: Use hash-table for api feature check
To:     Arnd Bergmann <arnd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Rajan Vaja <rajan.vaja@xilinx.com>, Arnd Bergmann <arnd@arndb.de>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <TEJASP@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        Ravi Patel <ravi.patel@xilinx.com>
References: <1606197161-25976-1-git-send-email-rajan.vaja@xilinx.com>
 <d63804a2-1880-70c3-841d-e824ec7942f7@xilinx.com>
 <CAK8P3a37YhCPmzJMi2iw=XQwx2_7r1ueCF6AA_j7qkCJV05Uuw@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <40c98156-36d4-6b2c-a7ed-ef736fda9544@xilinx.com>
Date:   Tue, 24 Nov 2020 14:04:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a37YhCPmzJMi2iw=XQwx2_7r1ueCF6AA_j7qkCJV05Uuw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07b17496-4f99-4c3c-829a-08d89079870a
X-MS-TrafficTypeDiagnostic: MN2PR02MB5840:
X-Microsoft-Antispam-PRVS: <MN2PR02MB584015EC9563938198B22725C6FB0@MN2PR02MB5840.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAuyn3jgTdyeTzAFa+NhBpzF8oMfBW9N+zKh5UKOKjwJ0Ims10I/LIXf2dBtZLdIvMKZoqB+7BDL6bhffdr9/BTZTfU3u7Ntvpsqbz8dtYjW037sV9vPMFtWka55bXZztYTv4yzfQFFdAg0+OCcWmmiTfkGDGh08T4GSiB/FcK61CYLgkv6LShnqp+IEQEi90T1SZPZYKOkyglyy97g56Sx45cG026A7n78/Fi+xdHdqMk/opJwlZZ4MOgGMQDPeQwqFDQEEhmDOOuaW69smNANwGjzQ6VCS7OxvTMvif40pxMnkRgjwOXQpxMxCpxhEQIaWIFdLqIlYe0CeDifO3o2fg9NnK7G7CwP+irMd0E4RtwughcjkoWvMivEllW8BpAH7DYwlQY3LNB1EDeHV5qOYHHJCM4N8mAQf0G0T3cdNNPUSFw8QwTCld2A0Ff3zlHeoo678MLViSnhOQnnMdQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(346002)(136003)(46966005)(4326008)(31686004)(478600001)(31696002)(426003)(4744005)(336012)(7636003)(356005)(107886003)(316002)(2616005)(8676002)(8936002)(83380400001)(44832011)(47076004)(9786002)(6666004)(5660300002)(53546011)(70206006)(70586007)(82310400003)(186003)(26005)(110136005)(36906005)(82740400003)(2906002)(54906003)(36756003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 13:04:50.3350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b17496-4f99-4c3c-829a-08d89079870a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5840
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24. 11. 20 14:02, Arnd Bergmann wrote:
> On Tue, Nov 24, 2020 at 1:54 PM Michal Simek <michal.simek@xilinx.com> wrote:
>> On 24. 11. 20 6:52, Rajan Vaja wrote:
>>
>> Some lines should be added.
>>
>> Cc: stable <stable@vger.kernel.org>
>> Fixes: f3217d6f2f7a ("firmware: xilinx: fix out-of-bounds access")
>>
>> Tested-by: Michal Simek <michal.simek@xilinx.com>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
>> Arnd: do you see any issue with this?
>> I found that your origin patch was taken by Greg and pushed to any
>> 5.10-rc version which caused panic on Xilinx Versal. That's why I would
>> like to get this patch to v5.10 if possible.
> 
> Looks ok to me. If you'd like me to pick it up through the soc fixes
> branch, please forward with the above tags to soc@kernel.org

I have one more fix in my queue. Will send pull request with it soon.

Thanks,
Michal
