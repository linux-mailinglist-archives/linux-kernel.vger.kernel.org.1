Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA338292A06
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgJSPIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:08:54 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:47461
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729223AbgJSPIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:08:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftPIVW8tVsXssOFiy8RRGNXYTDyJZL4BGgFJN1xS7ATNVEGXe2OA2znKp3Fj1AbT0QEFWk1K6ybiRtL2cdd0KNgBhAs+yUEZ1t5+dLNRtLaobCI36wOPQe2wRDjEIQFxx4FuQ7j9yxK0E71jcGOurEGs4KZSmgJhnfaK8kr2Ot8ZKbpBc3t72+TaiMEvAty7RZ8t3VzFaU1KKxKhYApPggDXIZ2OGRQrEqwYj1f7PZjdTsIFNjP3AN4LFhcTKNwskoEj7XdAj9vAljYzhK7gqv2awNSr/hWF7K8cc3cyZBOIcZT0imY/jOfNK0qS7/rBzmuMlAbZPoZ3w9wDbX9qIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKwNL9cWgoJcdpDobhKuOmoaJMMmOYEyy9fb0G6CXPY=;
 b=aMIIKkeJhduLxyIUDOy/s7B4VyuqdgREatEaPARXQA5ea9fV3hKPkO7KznxGPMv6/dO9DPVn1VYpoRg5kkYxaM6Z9dEOMYmpCQH4BLQ2sGHbwA3jB5ezlGthWURQwvQk8Y1NsWXP7EzZd505bz7TtJdt1ihPeMr1x1V1fKNE8lsaBghghpCmrLguv19+RvaZeWj+ZzBalnZlP8qQX7g7CHU7k6jMUM0cAi5ZmSDWueTdcUIJYQ0My8dxTjT+jCSIAw4qkHljG6kx/RhnWcUgOtXKW+vXJUIHNT5W4tpF91JnXWK/mzrfZ7lFcq2he7y0KkzU7s5kXBkFn2CXP7HW6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKwNL9cWgoJcdpDobhKuOmoaJMMmOYEyy9fb0G6CXPY=;
 b=Hpfo5KGOt++HjZ/XnHlEmSXtMvqa3EpDkmm04+XafdJ8z/9qOLyrF3UKMMPjr25bQjxu/wcqg3f5bcxRwK5fXUXcqtoe1ejdb4ap8HsTFDFy+4R/wWWIz07THSfBbV8ktFwcdaqP9WzwzVQC6Mp+d/uAZA6GwJ0ks8XbTseYZTw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR1201MB0063.namprd12.prod.outlook.com (2603:10b6:301:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 19 Oct
 2020 15:08:49 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::5dc0:bafc:6040:a8fe]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::5dc0:bafc:6040:a8fe%2]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 15:08:49 +0000
Subject: Re: [PATCH] drm/amdgpu: remove unneeded break
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        trix@redhat.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, issor.oruam@gmail.com,
        Anthony.Koo@amd.com, Rodrigo.Siqueira@amd.com, Tony.Cheng@amd.com,
        Charlene.Liu@amd.com, yogesh.mohanmarimuthu@amd.com,
        Aric.Cyr@amd.com, Igor.Kravchenko@amd.com,
        colin.king@canonical.com, tao.zhou1@amd.com, Dennis.Li@amd.com,
        mario.kleiner.de@gmail.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20201019144311.18260-1-trix@redhat.com>
 <2f951197-b93e-d0c9-153f-2ddd1b195b3f@amd.com>
From:   Harry Wentland <harry.wentland@amd.com>
Message-ID: <7179e50d-f29b-811d-030b-f2cfe3a1a502@amd.com>
Date:   Mon, 19 Oct 2020 11:08:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <2f951197-b93e-d0c9-153f-2ddd1b195b3f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTXPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::41) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by YTXPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Mon, 19 Oct 2020 15:08:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6505db3-851f-413c-2216-08d87440e17f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0063617B3A833A65EE5A06E08C1E0@MWHPR1201MB0063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZ2a1l8l+Fckdj/2zPYERAvNlmyLHsoMkdJxw0ik8AajSPfgo3sw2OULXd3AobZErGSOzqNpdSmN5OxA03W7sYDTWeOfMYj8+9nlB9p/PdZqHquF7b6dqCDIui9hFMvYj8cxe1zI8ECGm7d7U4lzTlluKJNYvXDTU8QAW3kjUv3Knpfnyn9AbfxFBnuQFjDyxUWte2hjz73JNzupFrrogyuLfrsn7nsODxKUi5VQ/4ZYLSqJ2dN+6oEEljYiDqjPS86WUZogO5yoXeDzI5nbmvUUdBwCtNM9jhRkiqEUHPnqOcKDLKq/QyU+7pYzuwm7K8sQYvpy7jGY1M9cvzupFa/kEK7nQ7vgmaPwMOwHN+mB91IBTtty+orZcC/xecM8sZfuzOVBicqIzvUgtC+ChQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(16526019)(83380400001)(186003)(8676002)(8936002)(2616005)(956004)(4326008)(44832011)(53546011)(66556008)(66946007)(26005)(6486002)(66476007)(52116002)(31686004)(31696002)(86362001)(4001150100001)(478600001)(316002)(5660300002)(36756003)(16576012)(2906002)(921003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kYDwBKlzDqrEv3I1jg4HaSb0LHi/VYvLAqz+X3WiN/OOd2dHy1bLoGrYLWqzJp7gvqfAG5Uv8hwfH6+tjGiK8sHXF46xTYh2sMFRBU5Tc7u0D8XYWo90LrXsPGkSJnJxLFdq61ITl5iRJqimSa6Uca3hlurJZUqxivkwP1eTygNscJyV/e/Cl07IMpPz7rEmIJzS2wjJS/WZ1q7bTRdBN/fKCoGzxvhOUacnhf7wbKp9GG/Ulqey5IEEN9p++TuPm2mClQI/CAINKEPFzJG+UsztF5jQmrdpmW6OpGI2GLTtRdn6METzsZgsVdDOtZmlFKmvLxb9ulHbLS1BUfi+J2GlIjGzUUmg/3es85O0F9GGGhWqkrh1TN/3bWh7SXy0uk0wA6MKOWlDL2KDj+ANExQAaBGW+tbbQeRODH3V1jPa7SKs6qagQZOn2LgWMpAwJr/LxnRbyZWYDuWIiHNd4BuJdSxeDzhfMnQbbHFfUix7XhgfM4m8jTwbWg0o/RV0SLd0y4mI3WwR+OOcSuRuwgPt8Kbny3I+Cnm0R2d0nTex6qq/mj1BX6+WhBGYbzVOLveFEgwMp84gfJYsWj1PfmuQKN51iJD2O/qVmVLsk3pL78JizNxmthrwL+YpGalphY4yU3qL3ARPFueQK6Enlg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6505db3-851f-413c-2216-08d87440e17f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 15:08:48.7439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLm4NUtqyn5SfIHNOUxNRjBORzKQbEy+DRvaWFZzX2wzHTqZy9ehUNBbq1YE4AkVxyz3HC0kIstXoDumI4Dfww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-19 10:55 a.m., Christian König wrote:
> Am 19.10.20 um 16:43 schrieb trix@redhat.com:
>> From: Tom Rix <trix@redhat.com>
>>
>> A break is not needed if it is preceded by a return or break
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> 
> Acked-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> 
>> ---
>>   drivers/gpu/drm/amd/display/dc/dce/dce_transform.c      | 1 -
>>   drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 7 -------
>>   drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 7 -------
>>   drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 7 -------
>>   drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 7 -------
>>   drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c   | 7 -------
>>   drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 7 -------
>>   7 files changed, 43 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c 
>> b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
>> index 2a32b66959ba..130a0a0c8332 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
>> @@ -1330,7 +1330,6 @@ static bool configure_graphics_mode(
>>               REG_SET(OUTPUT_CSC_CONTROL, 0,
>>                   OUTPUT_CSC_GRPH_MODE, 0);
>>               break;
>> -            break;
>>           case COLOR_SPACE_SRGB_LIMITED:
>>               /* TV RGB */
>>               REG_SET(OUTPUT_CSC_CONTROL, 0,
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c 
>> b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
>> index d741787f75dc..42c7d157da32 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
>> @@ -418,25 +418,18 @@ static int map_transmitter_id_to_phy_instance(
>>       switch (transmitter) {
>>       case TRANSMITTER_UNIPHY_A:
>>           return 0;
>> -    break;
>>       case TRANSMITTER_UNIPHY_B:
>>           return 1;
>> -    break;
>>       case TRANSMITTER_UNIPHY_C:
>>           return 2;
>> -    break;
>>       case TRANSMITTER_UNIPHY_D:
>>           return 3;
>> -    break;
>>       case TRANSMITTER_UNIPHY_E:
>>           return 4;
>> -    break;
>>       case TRANSMITTER_UNIPHY_F:
>>           return 5;
>> -    break;
>>       case TRANSMITTER_UNIPHY_G:
>>           return 6;
>> -    break;
>>       default:
>>           ASSERT(0);
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c 
>> b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
>> index 2bbfa2e176a9..382581c4a674 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
>> @@ -471,25 +471,18 @@ static int map_transmitter_id_to_phy_instance(
>>       switch (transmitter) {
>>       case TRANSMITTER_UNIPHY_A:
>>           return 0;
>> -    break;
>>       case TRANSMITTER_UNIPHY_B:
>>           return 1;
>> -    break;
>>       case TRANSMITTER_UNIPHY_C:
>>           return 2;
>> -    break;
>>       case TRANSMITTER_UNIPHY_D:
>>           return 3;
>> -    break;
>>       case TRANSMITTER_UNIPHY_E:
>>           return 4;
>> -    break;
>>       case TRANSMITTER_UNIPHY_F:
>>           return 5;
>> -    break;
>>       case TRANSMITTER_UNIPHY_G:
>>           return 6;
>> -    break;
>>       default:
>>           ASSERT(0);
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c 
>> b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
>> index b622b4b1dac3..7b4b2304bbff 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
>> @@ -446,25 +446,18 @@ static int map_transmitter_id_to_phy_instance(
>>       switch (transmitter) {
>>       case TRANSMITTER_UNIPHY_A:
>>           return 0;
>> -    break;
>>       case TRANSMITTER_UNIPHY_B:
>>           return 1;
>> -    break;
>>       case TRANSMITTER_UNIPHY_C:
>>           return 2;
>> -    break;
>>       case TRANSMITTER_UNIPHY_D:
>>           return 3;
>> -    break;
>>       case TRANSMITTER_UNIPHY_E:
>>           return 4;
>> -    break;
>>       case TRANSMITTER_UNIPHY_F:
>>           return 5;
>> -    break;
>>       case TRANSMITTER_UNIPHY_G:
>>           return 6;
>> -    break;
>>       default:
>>           ASSERT(0);
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c 
>> b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
>> index 16fe7344702f..3d782b7c86cb 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
>> @@ -383,25 +383,18 @@ static int map_transmitter_id_to_phy_instance(
>>       switch (transmitter) {
>>       case TRANSMITTER_UNIPHY_A:
>>           return 0;
>> -    break;
>>       case TRANSMITTER_UNIPHY_B:
>>           return 1;
>> -    break;
>>       case TRANSMITTER_UNIPHY_C:
>>           return 2;
>> -    break;
>>       case TRANSMITTER_UNIPHY_D:
>>           return 3;
>> -    break;
>>       case TRANSMITTER_UNIPHY_E:
>>           return 4;
>> -    break;
>>       case TRANSMITTER_UNIPHY_F:
>>           return 5;
>> -    break;
>>       case TRANSMITTER_UNIPHY_G:
>>           return 6;
>> -    break;
>>       default:
>>           ASSERT(0);
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c 
>> b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
>> index 5a5a9cb77acb..e9dd78c484d6 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
>> @@ -453,25 +453,18 @@ static int map_transmitter_id_to_phy_instance(
>>       switch (transmitter) {
>>       case TRANSMITTER_UNIPHY_A:
>>           return 0;
>> -    break;
>>       case TRANSMITTER_UNIPHY_B:
>>           return 1;
>> -    break;
>>       case TRANSMITTER_UNIPHY_C:
>>           return 2;
>> -    break;
>>       case TRANSMITTER_UNIPHY_D:
>>           return 3;
>> -    break;
>>       case TRANSMITTER_UNIPHY_E:
>>           return 4;
>> -    break;
>>       case TRANSMITTER_UNIPHY_F:
>>           return 5;
>> -    break;
>>       case TRANSMITTER_UNIPHY_G:
>>           return 6;
>> -    break;
>>       default:
>>           ASSERT(0);
>>           return 0;
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c 
>> b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
>> index 0eae8cd35f9a..9dbf658162cd 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
>> @@ -458,25 +458,18 @@ static int map_transmitter_id_to_phy_instance(
>>       switch (transmitter) {
>>       case TRANSMITTER_UNIPHY_A:
>>           return 0;
>> -    break;
>>       case TRANSMITTER_UNIPHY_B:
>>           return 1;
>> -    break;
>>       case TRANSMITTER_UNIPHY_C:
>>           return 2;
>> -    break;
>>       case TRANSMITTER_UNIPHY_D:
>>           return 3;
>> -    break;
>>       case TRANSMITTER_UNIPHY_E:
>>           return 4;
>> -    break;
>>       case TRANSMITTER_UNIPHY_F:
>>           return 5;
>> -    break;
>>       case TRANSMITTER_UNIPHY_G:
>>           return 6;
>> -    break;
>>       default:
>>           ASSERT(0);
>>           return 0;
> 
