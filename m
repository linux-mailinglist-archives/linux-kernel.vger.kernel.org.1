Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809451F7BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 18:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFLQqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 12:46:47 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:6105
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbgFLQqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:46:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoJsLirdd9mmdkSrz9MP9nDy9AgmcRzUAVRrr07FBZNVH4buIGwEhNM449kydwCPbcEVQjZekvzNI4ltziQoIuuYy71QYdYSeePBx1kAH5/pujI+TI8b8eUe9mNxPV8SJEHG/jMoDKVv9xYv82HWl3qIRWxpfCjhWU9m7tSoQ/0t+Xm2SB90WqVwflv3tj9TtpxiJJQiJeh+KvDC7m/yj4I2EOTPoJkebn5YEoYhMT9r+s4XLVcD1uDfTEyQzllmkIMuScO8esk+l/k8WPFYgTt/uulcahTkqtS20Ma+iyfJTOE+4DSwrB9PUcuKtO/8fMF6okFG6AksdjJvNbmSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWj69g3/xPai1svYKwg6G00x/dLVxCs93cpD5cvggbg=;
 b=V9awApw0fHFhW87RqWdlrl+/Zb37yovlZxQFGvxaVkSsQsIvBn3c+supYr69c82OFxQImawCy9BRNc67Z64mkUDzd21HhOPmG4VNFSM49EGs6HYDIgZSBw95v031GMFQuHjiSLys937dXyecJibmxwBKoz9Ay2bNO5FVdC/wmm67VGv+j+2UYmjgkY8OEs+KDcLfflFL3CO06cFfZJOGbQST1AZGIX0XjAhmDnrygLu9KC5oF9WJ2Y2TJt7j7hTuOpUVNqc6P3UdNQlI5Z9xpmnW5pAcAldGVE1WAHAMQ1GooLLgKhDeb1CCcfBuc9ACpAe0K2wgJMgW1ulYpXnpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWj69g3/xPai1svYKwg6G00x/dLVxCs93cpD5cvggbg=;
 b=kWj5uUKJyPw9ZgejoThUGeAkHOFwd6SsHSkIJ9DHq1/lxzAsCUQpoomUo4c0hHgT+gJQqsQof4JDhAEBwtOhY2fbnOzFtpcuNeg8qObUUbE7acNbEGSCTzPqYRm9ian6Rh5qIHazX8vVrYQN84WISbAr3AMb2yi9VGQdIatXxUQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) by
 DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21; Fri, 12 Jun 2020 16:46:43 +0000
Received: from DM5PR12MB1337.namprd12.prod.outlook.com
 ([fe80::f51a:1689:5079:c01b]) by DM5PR12MB1337.namprd12.prod.outlook.com
 ([fe80::f51a:1689:5079:c01b%11]) with mapi id 15.20.3088.025; Fri, 12 Jun
 2020 16:46:43 +0000
Subject: Re: [PATCH] ASoC: rt5682: Register clocks even when mclk is NULL
To:     Mark Brown <broonie@kernel.org>,
        Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     yuhsuan@chromium.org, albertchen@realtek.com,
        derek.fang@realtek.com, Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200612163111.11730-1-akshu.agrawal@amd.com>
 <20200612163421.GO5396@sirena.org.uk>
From:   "Agrawal, Akshu" <aagrawal2@amd.com>
Message-ID: <d91c552f-aadb-605c-3950-a5372d74a491@amd.com>
Date:   Fri, 12 Jun 2020 22:16:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200612163421.GO5396@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MA1PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::23) To DM5PR12MB1337.namprd12.prod.outlook.com
 (2603:10b6:3:6e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.105] (122.171.36.38) by MA1PR01CA0129.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Fri, 12 Jun 2020 16:46:39 +0000
X-Originating-IP: [122.171.36.38]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6520b35c-8866-46d0-f621-08d80ef02fe6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37400A959E73BFFCB82E4C4AF8810@DM6PR12MB3740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0432A04947
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GHIvTy0MSPOL0oJuAgyNUqCIANHpZv7cOb+SHT5N7wx+kKSJe7+VdlaKlsanX5nvid5n1b71PNm9pqkXSpEUN5WqlgA7ZJWgX4zY+g4Hh2PFMFEttrwbYoIRCqRnXiICFrpj61OdcwZioluKTFKBxSWFS4WZ/Jh7Jra7igQntIqJN/UtWM6C56KDCSGYkIbjgrvSjjyRClcOPPRVLKd7l4H/smrBZzrKXXIgU04rjG9Ib54kZ8cuyb66LpjpWYqBZn32MP0xqJ/IOX24uaxByXQmK4nzRreL9LZR/S+G8LoF63aLwFPzczvrYtQbEmbH63ERGGZb44TUv1MGYLutbiW4YZNgwTjCgnHdhD2fbtrvOlIjiIP1Q1wrPoIcC4TilLygC+ZF5wbq/n8V2f9fjg3GOcutxwXjF617WRz1CJDt6KlaTYS0yabO1PIL4NPM7R58BZAqZHEAbVkkd9keyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1337.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(186003)(26005)(7416002)(16526019)(6486002)(966005)(8676002)(4326008)(31696002)(6636002)(478600001)(4744005)(2906002)(2616005)(8936002)(16576012)(36756003)(316002)(5660300002)(956004)(53546011)(31686004)(110136005)(52116002)(66476007)(54906003)(6666004)(83380400001)(66556008)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lbrrK4IvD/f+wzLATo0NA/q8j+WnXV65GMYgunzv1OmTKQdXU0UQEi46p/jpMkgCs+g/d+YHM1XZy3K0/+zdM4MbOlN7zKwv/cygrVfJKQxvg9vmCh4DAdhswwPWRhSK/GKD4Nrxv4idUFREQp60wdVIt2U5QIvlr6XmaLItTS8tVf9IV8mp3HOipvVLW2yvkK6HczfumDS635sbl8HddA1/03X1HD6n1qjQxUPoRzt3QjksReVhBly0/UF/5HsvN4v7ZzKSQHb9Rz1pa50SwG7A2/yrKTy/TuaRt/T5grhvqYzCXm2157QldYK+ucWUv9rVkvc3i50hRae6bhXPd8rIVPQw2rB8Qe+Ohbj2NuaNGCZRtNIBNmF6xRLzUBX6gJ1xn7fcgaRJXxl2NiaekCziRzUOQhzjMp3PHSgMXRWTVPtgxU3vDCdo4l4QQ0WOfrpD0Vp4BI+o/OXjf8scmIIx1ygD9zR5NQofYNPKrEM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6520b35c-8866-46d0-f621-08d80ef02fe6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2020 16:46:43.4359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbWB2tVEVDvtLtW9NqCfAuWSjNE6zzH6S0qsFxf4+9zswpVDQdSSqPFQxBVAf4gX+fMnRkWPs9JRhueCBa1xGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/12/2020 10:04 PM, Mark Brown wrote:
> On Fri, Jun 12, 2020 at 10:01:11PM +0530, Akshu Agrawal wrote:
>> Fixes kernel crash on platforms which do not have mclk exposed
>> in CCF framework. For these platforms have mclk as NULL and
>> continue to register clocks.
> Derek already submitted this:
>
>      https://lore.kernel.org/alsa-devel/1591938925-1070-5-git-send-email-derek.fang@realtek.com/T/#u

Ok great. Thanks.

