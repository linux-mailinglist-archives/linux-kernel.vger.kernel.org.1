Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24322955EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 03:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894580AbgJVBH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 21:07:27 -0400
Received: from mail-eopbgr770118.outbound.protection.outlook.com ([40.107.77.118]:18542
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2894545AbgJVBH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 21:07:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZvAPHO1YgAfXfFPLgRJXEGhWz4ToNN7Jp202PwIV/kZ2TxOIfrhS7SYPqjofZHnAOoC8UqOLHUSPFmyotj+ddiiIA9COSmq/ezfEMws/cdxFNNGb6TaK6aKXcgCDE6mUvNSd399L/v/aswaJwNO3ul10/Kh9QInVYpM+N0DR3nCVuuD3Qh9Ejvw7VFfyk+Gia/yhtiL4WsWit/pERNV/tY8kijmBtRwemlV7vz9ZdGwoNKdN4fO4L449tzoaDg19oNOX8Q0E50sxFhb6TdXyaU4fTq9Xs6Uja3mQTcTUaQUpWHKRkAcw3e3wmnHcqMPllMrYghQjjsmqnsw2HoDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn7GjrRqJs1dwfKRSy5GE2BQ1YFoD74wAV/z73XELlc=;
 b=fBTYAT0VlNeHvQa9mZCHVsi9GZLKk30xXNFV/+XXSAUZrM9T7fhDC1hMUEBadtmkuoeC08PWE9SH0Qq21SNmUrsuV+jIBWgy8ghHEEvZZYWi0KhD7Kyk9x2pkQZjNDwC0Rei3DV/oQwcLrZfHHO1QkJ9XUsr80Uhi3y9rKYPnjOebK4oXh/cV8CyvRi7PWLJR69tQzsfHgEiY7B1nu7aYhbt3v06NHpf3ZL+xFURJgAsNkBn7MeQQstVj2aAp7usX2R4q+upj2o/D0rjlDwkekBFQclOkzYKAL2JPlY0Gq7YDTJEcMvKOobLdEq33g7vBnMB2Sftx+UNeaIQps9now==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jn7GjrRqJs1dwfKRSy5GE2BQ1YFoD74wAV/z73XELlc=;
 b=laB7H+E6XA2FF9Ws7xq8mvQD1NOcoMk7wJsvutoAkjk9wNY0twAe/GV6euPKVj2+LvZ6ONcu3LYYt1QVfgFzIcXKSRRpHC/MbHYwbeFk1zIWpLEfE+43noKHaXCIkmmmyZygXpFqzpuqOSyBEsuvTsIZU6WcBYVNSTFTolGKULo=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BN6PR01MB2468.prod.exchangelabs.com (2603:10b6:404:53::8) by
 BN7PR01MB3762.prod.exchangelabs.com (2603:10b6:406:85::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.24; Thu, 22 Oct 2020 01:07:21 +0000
Received: from BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3]) by BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3%9]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 01:07:20 +0000
Date:   Wed, 21 Oct 2020 18:07:18 -0700
From:   Vanshi Konda <vanshikonda@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: NUMA: Kconfig: Increase max number of nodes
Message-ID: <20201022010718.5jkrcyvoae56vdd5@con01sys-r111.scc-lab.amperecomputing.com>
References: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com>
 <jhj7drkrcpr.mognet@arm.com>
 <9e14c0d3-9204-fb32-31db-5b3f98639cba@arm.com>
 <20201021110201.00002092@Huawei.com>
 <da1b140c-fdd9-5970-fe83-02f33c3d8251@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <da1b140c-fdd9-5970-fe83-02f33c3d8251@arm.com>
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: CY4PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:903:dd::19) To BN6PR01MB2468.prod.exchangelabs.com
 (2603:10b6:404:53::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from amperecomputing.com (4.28.12.214) by CY4PR21CA0009.namprd21.prod.outlook.com (2603:10b6:903:dd::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.3 via Frontend Transport; Thu, 22 Oct 2020 01:07:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54d9d6be-1c5b-45de-85f1-08d87626d386
X-MS-TrafficTypeDiagnostic: BN7PR01MB3762:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR01MB3762E3D97C0B7EB29D7CE2339D1D0@BN7PR01MB3762.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k75D1LfchbhqChjagrGEcXV5VATpP5yhvLSGiyWizAFb+RfXQIg9pg0FfBZFzi3yPGvexCt9/FD3dEFQpyWZD0xSkIdkFwY97bcIzCcclTg3KmZTIbhxoblU+KvSGgvicjd7LBGOzt96tolA/8JmiiUn9P4UWOuZLhaR4Dd+nheVMQ5lVr82jo5+L4zJoH3qNOlmLH+6wSBIKFpuwv9pgbquNkvKEyPK0FHFPtzlh3RxbSOGjarb3FBs87m4Vqrm1jAypHmzomernhLfDL0TW3a/pYlcOcKizdKoWMtDk/65x+l8/zFBlawnVK6F2r9ivUN3GmYEhVekzYSSwesGCN6ekJcgnMAwbZfaUBokEYZ9p2dmaH1G7xeC0924MQIoDTHaZiZ2d9V/30bkrLMyCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2468.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(366004)(376002)(346002)(136003)(5660300002)(956004)(66946007)(9686003)(83380400001)(66476007)(26005)(478600001)(186003)(8886007)(16526019)(6486002)(8936002)(66556008)(4326008)(52116002)(316002)(2906002)(6916009)(8676002)(86362001)(4001150100001)(54906003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: PYoCbg/+KRBgOFVwf4/vQgbbPWCGiI5T1SEV6d0Y+QD/v4R94z7NIPsDpKcY9YP/YKmBfeT9xw5T8XgPVWOunpiKUMBQ8sRuKuW9t4rIcRCFH9378Eic742jTNRauOw6prhzcrtyxlLDEQKBDDsyukWmA1jTyFPIrxkCqAcg035KmiEzPfRsbIEik6cu4G9BPnq/KhjpZKI2Upmj5Icba1BBSImUmbMmV9kraXN6v4n90QKyLhFayA3ZERUU0TZQYb+gtZ3voc49ymCY4cXTPtctXNSCyiPbL5KvqaHfd0Hjw0HOM1jQQwba9CPsT/yzcc00mO9aYFvTyJNHOpoPNerDTAbUzWAmVlq/eRcLeWlcwNsT/A0yjnVG9ZQavOCLAOJIV2eUTIa1gwXT+enEnR5sJlV9Sq5CyGUPMxJcmyDiiPKSZI4d3yq/onA0nHCSChSmTfmA2uqGtHY1YCp/ey/7XAoc1EdqdARc/T8QAe0NHUYmvUrCRIUjr6M9eDYgDwlzuiaz1WNIe6UJ2RSiiTT329NYIPSXQ4BHkiyTpgO/ZIX7LM2aCWlNx5i/hjx4UYpOoAzhn20o7n44o4WajilFzoh4lE4v6TO5ECBPAmxUTzJobaOz5IWJ0kfUQ5unllu5Ho2WSkDS68NCyWUnmQ==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d9d6be-1c5b-45de-85f1-08d87626d386
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2468.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 01:07:20.5987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsykfW6V0jWcJ2CeNhdxJ83YnrfRyk+dxB791G319wMyemfUz6Jt89CwWKhIggKFDWiEQac62W1eSHp8JSK800peQQ2tgMixOWpqNqUy4G1C/d6qIbndviGQA1JH+Bjm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:44:15AM +0100, Robin Murphy wrote:
>On 2020-10-21 12:02, Jonathan Cameron wrote:
>>On Wed, 21 Oct 2020 09:43:21 +0530
>>Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>
>>>On 10/20/2020 11:39 PM, Valentin Schneider wrote:
>>>>
>>>>Hi,
>>>>
>>>>Nit on the subject: this only increases the default, the max is still 2?????.
>>>
>>>Agreed.
>>>
>>>>
>>>>On 20/10/20 18:34, Vanshidhar Konda wrote:
>>>>>The current arm64 max NUMA nodes default to 4. Today's arm64 systems can
>>>>>reach or exceed 16. Increase the number to 64 (matching x86_64).
>>>>>
>>>>>Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>>>>>---
>>>>>  arch/arm64/Kconfig | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>>diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>>>index 893130ce1626..3e69d3c981be 100644
>>>>>--- a/arch/arm64/Kconfig
>>>>>+++ b/arch/arm64/Kconfig
>>>>>@@ -980,7 +980,7 @@ config NUMA
>>>>>  config NODES_SHIFT
>>>>>       int "Maximum NUMA Nodes (as a power of 2)"
>>>>>       range 1 10
>>>>>-	default "2"
>>>>>+	default "6"
>>>>
>>>>This leads to more statically allocated memory for things like node to CPU
>>>>maps (see uses of MAX_NUMNODES), but that shouldn't be too much of an
>>>>issue.
>>>
>>>The smaller systems should not be required to waste those memory in
>>>a default case, unless there is a real and available larger system
>>>with those increased nodes.
>>>
>>>>
>>>>AIUI this also directly correlates to how many more page->flags bits are
>>>>required: are we sure the max 10 works on any aarch64 platform? I'm
>>>
>>>We will have to test that. Besides 256 (2 ^ 8) is the first threshold
>>>to be crossed here.
>>>
>>>>genuinely asking here, given that I'm mostly a stranger to the mm
>>>>world. The default should be something we're somewhat confident works
>>>>everywhere.
>>>
>>>Agreed. Do we really need to match X86 right now ? Do we really have
>>>systems that has 64 nodes ? We should not increase the default node
>>>value and then try to solve some new problems, when there might not
>>>be any system which could even use that. I would suggest increase
>>>NODES_SHIFT value upto as required by a real and available system.
>>
>>I'm not going to give precise numbers on near future systems but it is public
>>that we ship 8 NUMA node ARM64 systems today.  Things will get more
>>interesting as CXL and CCIX enter the market on ARM systems,
>>given chances are every CXL device will look like another NUMA
>>node (CXL spec says they should be presented as such) and you
>>may be able to rack up lots of them.
>>
>>So I'd argue minimum that makes sense today is 16 nodes, but looking forward
>>even a little and 64 is not a great stretch.
>>I'd make the jump to 64 so we can forget about this again for a year or two.
>>People will want to run today's distros on these new machines and we'd
>>rather not have to go around all the distros asking them to carry a patch
>>increasing this count (I assume they are already carrying such a patch
>>due to those 8 node systems)

To echo Jonathan's statement above we are looking at systems that will
need approximately 64 NUMA nodes over the next 5-6 years - the time for
which an LTS kernel would be maintained. Some of the reason's for
increasing NUMA nodes during this time period include CXL, CCIX and
NVDIMM (like Jonathan pointed out).

The main argument against increasing the NODES_SHIFT seems to be a
concern that it negatively impacts other ARM64 systems. Could anyone
share what kind of systems we are talking about? For a system that has
NEED_MULTIPLE_NODES set, would the impact be noticeable?

Vanshi

>
>Nit: I doubt any sane distro is going to carry a patch to adjust the 
>*default* value of a Kconfig option. They might tune the actual value 
>in their config, but, well, isn't that the whole point of configs? ;)
>
>Robin.
>
>>
>>Jonathan
>>
>>>
>>>>>       depends on NEED_MULTIPLE_NODES
>>>>>       help
>>>>>         Specify the maximum number of NUMA Nodes available on the target
>>>
>>>_______________________________________________
>>>linux-arm-kernel mailing list
>>>linux-arm-kernel@lists.infradead.org
>>>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>>
>>
>>_______________________________________________
>>linux-arm-kernel mailing list
>>linux-arm-kernel@lists.infradead.org
>>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
