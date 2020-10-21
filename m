Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994F9295055
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444359AbgJUQCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:02:42 -0400
Received: from mail-eopbgr750135.outbound.protection.outlook.com ([40.107.75.135]:33622
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2444352AbgJUQCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:02:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMoKqgN8Rb5s0hliZPucI3MNI09q/g4JM5je2jfUQ9FfXc4BUhJKlSIiu/h18Cn3JCCfAMdmmDt8QGk+zIC++n3I6gq0bkHuf5DrDtEl+mdwL/U8v7sEfjb9x7744DsdHpjBMGKg45udkrCD0QnXRwFZkm2+HoSWpFjhSXznkWvFAoKUebXrMsS6UcUGyLvtXss96UBPviaKWPAGCoermZx2ab5drVfCAhtaXu1xum0Nc/F14Pqv1vjG4+rkO8KywR3iXsDk6iP+N0fE735XS9/rpiWcOGWWqEYTJtPNuRtgEPn/LHjFBPRnSoT+G9kUqvlczD5S6yb5dU9+d99vJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUok09JGqvqXrfFzEm8bYUp+JwHnYW4ByubzcN2pDJc=;
 b=I0mHyrfA64lnNYju47LQrIfIcvhoR2E5YBuaQ/3PpfRQXpRY/j6kbTQRBsdBYM3zEzUWP1gzpLfonP8GH8gj8wSe7ki/2cztnu8sq0Mukg/BRW7E/v0BmQDkxkZFRG1gXw24QhtveLszhZVPyVpT0v8noPB9GxZwr4inEOEeOrRs1S7FqrXE14CEJTfC2XgQjbzSLR1v7lbXeegD3Ht9MyYOBB16mteK1ss/PKcGfVWcwSG4h6+vF0HZGfHYf+S0T6Fm6eAOtdcQe4WeFJoV0sREEVmuLQhg6t5yJDTUu/uaLG8OSIcT9oeJNDpYezWN9H2VRYR0zhOEEsuwv/Pa1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUok09JGqvqXrfFzEm8bYUp+JwHnYW4ByubzcN2pDJc=;
 b=PSJ+vTk6PGXiURMZ91q0KQL70SYhOxXs6qi4qRAdLw8GojT2TwPDRswiqhLphYc/bLLWwK3q63GeeZ3L+W/LstAEaGV8vdteEBdsjMZ2CyW/+EBV035NN2nbcLoqLjSOJgljxf0tWlSSuPnPFDjEEW83mKyOV7KjuNv+Jc92Xs0=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BN6PR01MB2468.prod.exchangelabs.com (2603:10b6:404:53::8) by
 BN8PR01MB5587.prod.exchangelabs.com (2603:10b6:408:b5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.27; Wed, 21 Oct 2020 16:02:37 +0000
Received: from BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3]) by BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3%9]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 16:02:37 +0000
Date:   Wed, 21 Oct 2020 09:02:34 -0700
From:   Vanshi Konda <vanshikonda@os.amperecomputing.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, patches@amperecomputing.com,
        linux-kernel@vger.kernel.org, Anshuman.Khandual@arm.com
Subject: Re: [PATCH] arm64: NUMA: Kconfig: Increase max number of nodes
Message-ID: <20201021160206.hfnfvfgyaby4nzbk@con01sys-r111.scc-lab.amperecomputing.com>
References: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com>
 <jhj7drkrcpr.mognet@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <jhj7drkrcpr.mognet@arm.com>
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: CY4PR19CA0031.namprd19.prod.outlook.com
 (2603:10b6:903:103::17) To BN6PR01MB2468.prod.exchangelabs.com
 (2603:10b6:404:53::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from amperecomputing.com (4.28.12.214) by CY4PR19CA0031.namprd19.prod.outlook.com (2603:10b6:903:103::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Wed, 21 Oct 2020 16:02:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f30678a8-4640-4cda-5719-08d875daba6b
X-MS-TrafficTypeDiagnostic: BN8PR01MB5587:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR01MB5587DF0E11A7069F1BB1F6079D1C0@BN8PR01MB5587.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9WsFCWMfCrkab8OCzZXti1kRjCeJVGpQQdxhoMcpbBMvSOyrzoxcC1wQDADXbYn/SamTooGOs4PeZuLdY1sq4TK4gadilyt+r+WaALlnerQYvvafl8/3xWegBwF11ZWehoLjQ9JpmLt9991tRfTHar5m+8zxZUm9qQKnNhpv/moAVUxjTKd+Ez/ZfnHiumYHkn+bsLbkRLAyoCJIRX3K0AzlrMZXyCeqZGNXFYggYc/Bc3Kqhb36Ptpq+I9TnOaYiEM4FS3i0hwclgGwVg+SGwxfV1/3gyhJNx59im2stzdsUqIP/Q6jycYipkmL6cIYAnN8+kFQP+//faEvVLJ/kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2468.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39840400004)(136003)(376002)(396003)(366004)(8886007)(6486002)(6916009)(8936002)(66556008)(52116002)(8676002)(5660300002)(66476007)(66946007)(316002)(26005)(478600001)(186003)(4326008)(86362001)(83380400001)(16526019)(1076003)(9686003)(2906002)(956004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: jyYIAUQZDd7QVSTU0I47+AqJohIcNyBU0Av22tGFPaDNgs5IOI1dfrZQgZeK4nCwP5vwFzxoF2Xh03egrr+DUr2GM0p4/hoSXY4i0qABeDpFLZloGRza6Jvu0uhy1yvBX8TW26zngI9OvLZk/jwUUTNnYAJn5wjg5axS4m8vcznWDQ6Ld8fklvejkctaUJnTCzQ934kByAr6x1uo1aSIo27JOW1hG5j0DGl2eiOBjWS9zcTaeBqhmDrcYDEHfJAngw9K9KVoIdVBlptMSiubxh3bWraBchZylHpUli6Xv0i/pC1gsj5du2ywmAUwkA/q8SBOJXeI5dsF48l75PMbBEirgc2eWUBLG0rQ6ZnnqLdDee7yXbAH4vcv9Xrgsllk6D4WvOWP5AGrPnQcQ03OqzU4wwirN84SIzir5fOyp0Egsdu5sCJ1kVolbpBeMPl3xT11NNe4TP0a7v4wwdbb4MbS8xPeaNVkg/ZmF6ryVbWy3jXUtKww3QmoU3BycqWG8YjDMMtyr+tEUcGHUafd0bzA+Dnbok6ETBn5TkIf4iJsoWM1ShfrHPcVQyXDl9U1MLth9alLij+C8aqN2cyL9f3NZ3KpffnwUClfDk46ty6pxSiJYjNSUUKB2xDeyNT36CsIASjBTbCT2qCu8pnymw==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30678a8-4640-4cda-5719-08d875daba6b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2468.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 16:02:36.8810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Krj/oQImGHG5cD6a9mBwluXkuff8+R9zGarytI5XCgRZIHLjuiTJVpahikuihh3Z8WHuB+7s/YySKYeOik4GSoh0srArY4M25h5jW5gBy6e6BpbYcjCOCErKXmv3ToRw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR01MB5587
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 07:09:36PM +0100, Valentin Schneider wrote:
>
>Hi,
>
>Nit on the subject: this only increases the default, the max is still 2?????.
>
>On 20/10/20 18:34, Vanshidhar Konda wrote:
>> The current arm64 max NUMA nodes default to 4. Today's arm64 systems can
>> reach or exceed 16. Increase the number to 64 (matching x86_64).
>>
>> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>> ---
>>  arch/arm64/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 893130ce1626..3e69d3c981be 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -980,7 +980,7 @@ config NUMA
>>  config NODES_SHIFT
>>       int "Maximum NUMA Nodes (as a power of 2)"
>>       range 1 10
>> -	default "2"
>> +	default "6"
>
>This leads to more statically allocated memory for things like node to CPU
>maps (see uses of MAX_NUMNODES), but that shouldn't be too much of an
>issue.
>
>AIUI this also directly correlates to how many more page->flags bits are
>required: are we sure the max 10 works on any aarch64 platform? I'm

I created an experimental setup in which I enabled 1024 NUMA nodes in 
SRAT, SLIT and configured NODES_SHIFT=10 for the kernel. 1022 of these 
nodes were memory-only NUMA nodes. This configuration booted and 
recognized the NUMA nodes correctly.

>genuinely asking here, given that I'm mostly a stranger to the mm
>world. The default should be something we're somewhat confident works
>everywhere.
>
>>       depends on NEED_MULTIPLE_NODES
>>       help
>>         Specify the maximum number of NUMA Nodes available on the target
