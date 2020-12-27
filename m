Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578F22E31AE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 16:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgL0P1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 10:27:03 -0500
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:64352
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbgL0P1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 10:27:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMDOBWmx8nT3E4ZS6G3bP48WZasjlv5wF6eaQ29/Ur8dWDoBfw+AjLHFCbKrMrTgoPwfPiCHps4rHhbr0mWCGlQv8Re1EilomAMH2isSnKPBbJMXHU6pc3IDSIYKx6YpiQup28iT+vd32ngqP7d5niWcRI3jyf8Ly4RMC2fBCd6m2fEBJfnhxLLKjTUhY4nKGBQ7y1NTvK6pRPCJ3gW9F050rxfdPUwsVbIDyKi2DyawhCAP2Z8csoqXsiAI78VTMD9+thgTSRaxCQEVHGg3o3bGRQgmAXfO/P3ESRgTNry/JSFZi94M5vYyMstAFbKn05AVu0eBltnw+p5Fv7Wviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7FLWmGwVDI0Y/BiQhZqgMfWGK1zUsyaMC+NdP+i7iA=;
 b=hTbfNTyoWyHPgNXWky2BGxqVVxBZGClmBrAZfQS9o/NadZX/+4JVTMDbdvhCIOfywuAuXVdKN71V/WdE3uGaejfZNwoVvgowGSkm2paADoBeGS/xnuGTaW6eJ21FH8xxtnyFjOqSvTs62T2Lg1mG3Jd5peSBgulF6F1o2mgGUCb4/uYTlYIwlNVAlbgrj+1x7S2qtVe3qU5qQrQ/AoMsBSXRD+MTYpkvtKJMTJhqps5Vu+0M5JnWklutnXDLjNIa66HPGv6Gm7UBPQetKwktW7UQlcfNFvrZpKRV9geZUqtVmtD1Hj04+99INRtdoZPFq4ZtdQu8P+hyIM5hFKltIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7FLWmGwVDI0Y/BiQhZqgMfWGK1zUsyaMC+NdP+i7iA=;
 b=SjDPWNt2zJDClitAxBdz97n/aMLa5qRYoWiHkxhP9zhlH3k3doIkQmjmj2Jn+Cf4bAa9nnV/Pum3Ee1mw1uaAyI8maXqCDVqEQOkPADoqGdLdp95NNoGgBkTvkb/uml1I+JksCEyMuTEyK6bHq58ICEKjU2UZE70q5Z1xAbUmqc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.30; Sun, 27 Dec 2020 15:26:07 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845%12]) with mapi id 15.20.3700.031; Sun, 27 Dec 2020
 15:26:06 +0000
Subject: Re: [PATCH v1 00/19] x86/insn: Add an insn_decode() API
To:     Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20201223174233.28638-1-bp@alien8.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <9e5d1122-d5ad-93f2-143d-d0386d054e4a@amd.com>
Date:   Sun, 27 Dec 2020 09:26:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201223174233.28638-1-bp@alien8.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA9PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:806:27::7) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SA9PR13CA0122.namprd13.prod.outlook.com (2603:10b6:806:27::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.13 via Frontend Transport; Sun, 27 Dec 2020 15:26:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93d23ab0-01b3-48dc-c0e6-08d8aa7bbaf3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4058:
X-Microsoft-Antispam-PRVS: <DM6PR12MB405853FBB9B18600819D06D0ECDA0@DM6PR12MB4058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVJtBVzT/GaUHKyB0DfWI/m95QF1Y+iUactPz0YkF7XsTZjqFubsBv6skvCMsQSPod0yaLcqTKPvxfctUDhhjQXgddVhN4GhGesllX5hV96E3Oo6+Zukixo55xuiRSyxAURXofC0sXnNnJK34Pw+zW30Fbh50qoC+RWiAxGuV7NpiGUwowlIEHFNIK7KOlAklgCsRrIfTLH9Dp9lhvSDbHBhZnKgLhwV4tRhn4Rdqqg9I06cGHta/KH9abKCyl+I88+bDZl7rZ+q7aCaOe3OZIawzWKxi9ScYO8BLAw4Jwon5mmyMm8O1z11X074D+W3JX6LSnUCUHjbnc0MgbmmYTQkJ1iY/Pz8s0xvKRJTHSAC/IPHHZ6w97MqzoRxrhUeERfVN4V1zqtOzrITsChfMbsXZHMa9C+F5m63Ml4/Y0y2d5b8cLTg2J7l/JPfyjfqWoWsHg+JVfK9lbD0b6ng2NB0S0jN710nOeXtURYyKtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(6512007)(86362001)(31696002)(52116002)(53546011)(4326008)(66946007)(6506007)(5660300002)(31686004)(186003)(2906002)(16526019)(8936002)(110136005)(2616005)(8676002)(478600001)(54906003)(6486002)(316002)(26005)(956004)(36756003)(66476007)(83380400001)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bTMvWFVmZWQrWjBwUGNKV0xvZEFxdU91QnJWbE5hYTdEbWFYYW1jYy9Cd29U?=
 =?utf-8?B?cVZRc2p5VnFuWXB2NWg3RU5lWlNZQzFUa0V5V0VXMHQrZlJPeGZtZjUwdmtl?=
 =?utf-8?B?blBHUXlFY0pJNTFRVHp4dGwwaHVybHM2TVBiR2hieGxLQlJIbFlDRGQzQ016?=
 =?utf-8?B?bWJzZEhRT3E4TDA0ano0NmNKU2tveUxndGloVisyNThsamFrSmtJa3Q4MlV5?=
 =?utf-8?B?MDA4ckdrdFhzL3pFaTZkTG1RRDI1a1Q2eXJSMGxWajVHYVRJVlJiYWc0MC9j?=
 =?utf-8?B?S3dFc0pGQnVVM1VqWHFONHNlUE1BWkJzNStIZXNKRE5YdWZkVGVGcGZoZzk4?=
 =?utf-8?B?VnFUZW9OS2cycU5yUFJLVWdVRXdORjJvNmVBcVFvbHIyMVh1Yk9hWHF0aUNk?=
 =?utf-8?B?UVFMT1FXeDJUbVBVTGpqTlNnWkxTSGYzWTFDWHNRVkxWeVFPSEcrK1Jrc1E0?=
 =?utf-8?B?ajRiWTlNZmdwTlAyUGJFclo3dHRpWHZXc3NmNVNmaDVrNW5QU1ZtUzlFZFIz?=
 =?utf-8?B?UWk1emNlSXhHbUhZT1g4RXl5K3FNS0NlU0grZ3FtbkhEZmxDclJYb0c3T0No?=
 =?utf-8?B?L0lSdVhuZHhMMU5oaUkyQXdQMS9INEkrWVM1ZURoS1V6eDFtTjB6OXp5aG5J?=
 =?utf-8?B?ek1aOUJEcDUreVpLMUxYSkxaS2pOR2RrdXZveEpVVG42OU5acjFuMmNWaXI5?=
 =?utf-8?B?UTJ4OE1kRU9hWEZGa2k4eUcrQVZQUjNFV04wQmtvS0VzaWx3WTluNnFuajlS?=
 =?utf-8?B?V1NtMnZQTmpXOGpRN3Q3bTF5RzAxblg5aXJlM1JhR3R4V1Rmam92SXVMV3Ux?=
 =?utf-8?B?bkJDRjZnMmVTZlJYcFUySnlEOVpHQVNUK2dpNVFYYy9TekZ2em9VdnlhNnhr?=
 =?utf-8?B?dnMxblVLRG92QlduK0F3dG1CdWtnMVhkVytzb3IyUzhmL1VnWXRtcllzT1py?=
 =?utf-8?B?bTVycEpsQ3JwaUlUYlA4d2dVWmZIWkorQkdGK2laRFRxSnFac1NpS3pVTmxQ?=
 =?utf-8?B?UjUzbFRtSDdhZHpjU0ZDS0FHaGUydmJRekNXYmxJYTN5RjJ1UmNuQU01emxs?=
 =?utf-8?B?cnhNSWlsMmJHeU9JNEtveXdQenNQeGxuYmFhYUs1TlpCRXIvZ0JMa09rNEZy?=
 =?utf-8?B?VXJteXZIMlRFM0plQ1o5V3RDWmNFWUU2RmhTdEFXNTJDSnBvSWhLQU83blVX?=
 =?utf-8?B?T21kMUYzeVpYTUx6bzdHM3FrelNjbmNjeDZwMGhEc0RBYU5kNGNGeTN2dERt?=
 =?utf-8?B?V0dUcitIRHdWSGtaQi9aZTJsVk1vSitkaHovaXJRUGh3aHZTL2ZxaGYvc1lp?=
 =?utf-8?Q?qbri/SwQNxL6oAWuGhEorHfmHEJc6RIpoj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2020 15:26:06.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d23ab0-01b3-48dc-c0e6-08d8aa7bbaf3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJpWy+a/Rwear6xcfyI6ez6RnyeVwIpTs1kONd13VMb/Kg3hE1ilQvVXdeN9qaUxeadIZuRjix6bu9vF+Gfatw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/20 11:42 AM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Hi,
> 
> here's v1 with the requested change to return -ENODATA on short input to
> the decoder. The rest is as in the previous submission.
> 
> Only lightly tested.
> 
> Thx.
> 
> changelog:
> ==========
> 
> That is, provided this is how we want to control what the instruction
> decoder decodes - by supplying the length of the buffer it should look
> at.
> 
> We could also say that probably there should be a way to say "decode
> only the first insn in the buffer and ignore the rest". That is all up
> to the use cases so I'm looking for suggestions here.

That's the way it works today, right?  One instruction, no matter the 
length of the buffer (assuming the length is long enough to include a full 
instruction)?

Because the callers of the decode may rely on parsing only the current 
instruction (like SEV-ES), it should probably default to that (although 
most of the call points are being updated so you could supply a boolean to 
indicate one vs many instructions). The caller doesn't necessarily know 
the length of the instruction, so it may provide a buffer of max 
instruction length.

Also, if you want to parse more than one instruction at a time, wouldn't 
you need to maintain register context within the parsing, I don't think 
that is done today. Or you could chain together some instruction contexts 
to identify each instruction that was parsed?

Thanks,
Tom

> 
