Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EBC2A3ED3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgKCIYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:24:00 -0500
Received: from mail-dm6nam11on2058.outbound.protection.outlook.com ([40.107.223.58]:48225
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725993AbgKCIX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:23:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCcYoHbcwhiKx1UuOABb14CFKahSuAV79jZVBDCweP9EVh/qnzn4AJjXgBYuUfltuggnp1H2ES4YkWGm24pwchCBqIzRBn/dWuxICICjlCMeJbM4hLF82hSG/qMRJevExZHXBrZttYtfOIc3Da6nInuBnjgUSbqfHXVOxpUtzhHvAPbLaGib/Ib+Ru13b/vZgmgCW23JEog8YGj3rhRGnLQL0btnYOvMhBWBmdgSP2/+BtbcT9JvFqjSqPRKRQolKzdV+5mGCq0zLBx9IUXcbCwja9Cgqw2msNiVNcaJunqCOEIZCw5U7b1ArYnifCnbPEXNiO/85oVhGPptliwDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38jpEJ3MQ9Etp+55oqRI+57YukolE7yGG9nzyaTSN1k=;
 b=Z1TKCsjstqNzb3tXkELnO3nAJEdlg6fEbPeEx/7tx8qlVLxBTvOtgt+Ps87GNR3SUwEt6Xn0fY/DPxSYOLe6jaBRO2jSlcEGiujmDcYhwKXSIzL/6uU4m10WYz2NQxcelOx75w+1USGJuNYXiw7VxFD2T0ap+9dyk9zJG7DKtRV0IEXvDH91JZXIekXwau8W19Ts6MleuXpLMGZtuQgTcw81s27OZfYDugkpuV2cBMEWs5tOhXLdCbhljA6w0pV0raDXcu7XageUrMT7yeUCxeYXNkRsw24VdsH+4WY6kaMJwETX18wAsrHuahGlS/dMA5U/r5ZiNnGT6KVyUJ2O+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38jpEJ3MQ9Etp+55oqRI+57YukolE7yGG9nzyaTSN1k=;
 b=iprfHkIkG2fjBrs47+9faETKTgSLtI/qE/mf21fxOO4aMRZ86xduwYePgZdeiOzIPYYB4TvOVi3TQEn2whDMlzudb95eWTiklVXOHejjgnxmtJSzjxV+xdQLpGj1P5Ep62lfTYUyF5lxB11Dx7/bM0+tN7xITa5hJlqIDICU3WA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 08:23:56 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 08:23:56 +0000
Subject: Re: [PATCH] drm/amdgpu: do not initialise global variables to 0 or
 NULL
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20201102184147.GA42288@localhost>
 <CADnq5_OnA3T_p4pTEOpoqQ=NZyso2VFoDiOHu=+h7dKOeKHq-A@mail.gmail.com>
 <c916ae88-5933-ab06-ad32-d87f00cac21f@gmail.com>
 <20201103065324.GD75930@kroah.com>
 <c6292ea5-4559-f8e5-d10a-9acb884b2ce8@amd.com>
 <20201103075355.GA2505796@kroah.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bc1fcda4-d229-c5a1-bea4-eda646a12bd0@amd.com>
Date:   Tue, 3 Nov 2020 09:23:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201103075355.GA2505796@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR04CA0059.eurprd04.prod.outlook.com
 (2603:10a6:208:1::36) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR04CA0059.eurprd04.prod.outlook.com (2603:10a6:208:1::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.22 via Frontend Transport; Tue, 3 Nov 2020 08:23:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90716e5a-a4e6-4036-a27d-08d87fd1ce76
X-MS-TrafficTypeDiagnostic: MN2PR12MB4320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4320EEC4B7072B0E08F9B20783110@MN2PR12MB4320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6kzwXde7EUrUwG2izgH1NQIaEA1VgFkLGGO+WZ1D/O8yBWl4nuCUo/zzRRcBaCpU3nl3Y5cK/3mRd94xn3Oite/kaLnwqUdg6Zl3DOCcaNQuPH0wYru3ek9QxECh6C7VLCZ3NcCUt2LKr31DDT0OVD9h5jIFLkAlZGphstXAPrhOUd6kjlWaxByVeLbabWWC21oY+ZtO3E+iaX0nwj1odt2YxkPdqzY0k1S96lJyQTMfcl/NDKrm5MIE5hFzAKieMuQZZ3FUrCyzePdAMOXlWn21iwFaH3qALfman35VPptNKvJqpepx+8tIfPGGBtklUyEnpuwuOlt3B0nlMyzCpqI/WAPTAjqi3SwcboajNmb78PvQoQNJdsCugARTam5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(31696002)(7416002)(31686004)(66574015)(36756003)(52116002)(6666004)(53546011)(5660300002)(66946007)(66476007)(8936002)(66556008)(6486002)(86362001)(4326008)(54906003)(6916009)(2906002)(83380400001)(16526019)(186003)(8676002)(2616005)(478600001)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: srDa97hoIFAvwW8aATCritMCgNOzVsCNy9Kjq8+uHOm9OynQbS7XEmJXDSoMxrEl29sKzyuZUYrE2uiXaYXTuEztHV28GmHZhBral5FS5PDD18tFfrpFYl2UYQPHJgIy+CFzwJU4U8VU9IpDFgKPdmbi4hH1LVX2nRQG2KTPaaDaNFtJocx7gsD+uLFG2cYkRzUcP3TPTkrHUHqzcZW2nKUPSuBxFeeXVZyLmsx4gOg1QJqI4d5r1iuelp9FN8S3OJBDK7LAcD4nftgAkbn7HQanGIYf/fhoUCImjyaWr730qbVKQqY24IV+U6SQOrk0M8sRtP+VhM54abZjpWbpOe0UiHzihvl3+hVd443MpN62GJeYwFlFkGwzRHItBjoiSPvqAGAQzxs9XmruH5Bc1G8x5QwDtpqfbGqJFJynOk159RTQTVlJaczjnUfzwPmQlAPYBNjjT1uYDLBE01j4oJXweNiyz8T/nE3HjfEhy+AAuMZbWkN6WMm6Shim/mZ5ZtBIkKbTfJ1Ry4ddJWESw4uJoSF0146kbIjdsMqUh0H5Pqxw1HDA9ywmWyCCHrVx1274cPfj8Cl7bX2G8BFIAI6qT/GpXDAb70TrCwtO3Jkl1o0ZuP4GQUWXJ043xLVEEoAxWMq8ZQXOmt5nZCUdva1y6+9TIMifxJ77b8VptYh6avUm3ZYZj3F+FXUZEIY0sVRU/2ftA3yL6T4cTgla5Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90716e5a-a4e6-4036-a27d-08d87fd1ce76
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 08:23:56.3168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyqFk3mRTlN2Av0kqU2l3/YiVxRwzVKG/cVF+bLK4wRSYZi/dsCSrL3yi8NnIX09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.11.20 um 08:53 schrieb Greg KH:
> On Mon, Nov 02, 2020 at 09:48:25PM +0100, Christian König wrote:
>> Am 03.11.20 um 07:53 schrieb Greg KH:
>>> On Mon, Nov 02, 2020 at 09:06:21PM +0100, Christian König wrote:
>>>> Am 02.11.20 um 20:43 schrieb Alex Deucher:
>>>>> On Mon, Nov 2, 2020 at 1:42 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
>>>>>> Initializing global variable to 0 or NULL is not necessary and should
>>>>>> be avoided. Issue reported by checkpatch script as:
>>>>>> ERROR: do not initialise globals to 0 (or NULL).
>>>>> I agree that this is technically correct, but a lot of people don't
>>>>> seem to know that so we get a lot of comments about this code for the
>>>>> variables that are not explicitly set.  Seems less confusing to
>>>>> initialize them even if it not necessary.  I don't have a particularly
>>>>> strong opinion on it however.
>>>> Agree with Alex.
>>>>
>>>> Especially for the module parameters we should have a explicit init value
>>>> for documentation purposes, even when it is 0.
>>> Why is this one tiny driver somehow special compared to the entire rest
>>> of the kernel?  (hint, it isn't...)
>> And it certainly shouldn't :)
>>
>>> Please follow the normal coding style rules, there's no reason to ignore
>>> them unless you like to constantly reject patches like this that get
>>> sent to you.
>> Yeah, that's a rather good point.
>>
>> Not a particular strong opinion on this either, but when something global is
>> set to 0 people usually do this to emphases that it is important that it is
>> zero.
> Again, no, that's not what we have been doing in the kernel for the past
> 20+ years.  If you do not set it to anything, we all know it is
> important for it to be set to 0.  Otherwise we would explicitly set it
> to something else.  And if we don't care, then that too doesn't matter
> so we let it be 0 by not initializing it, it doesn't matter.
>
> I think this very change is what started the whole "kernel janitor"
> movement all those years ago, because it was easily proven that this
> simple change saved both time and memory.

Ok, well that is even better because it is a technical argument.

You have convinced me, the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Regards,
Christian.

>
> This shouldn't even be an argument we are having anymore...
>
> thanks,
>
> greg k-h

