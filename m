Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730F32EB083
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbhAEQuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:50:19 -0500
Received: from mail-eopbgr750042.outbound.protection.outlook.com ([40.107.75.42]:52245
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728740AbhAEQuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:50:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/sLulGsfr8yNhJUfQTUp5T8TPxpaub/TiBz8JFK2dpVgO3gzziLzGpqhN7ZwiTx56UyZq0n8Hdkfrfvd4atFH44Jwg/6AiN+eLZ17yIKgDPIEZ1blMw/VUZri4yUYTcLoM/Ag2SVPFuqpA4J+hlx16ta+74fvY6KQG3EU0ol+ovhP1RM/zZ5gpBS3NRAtMYZ/BfmOEY7yPzp8tSJ14/Vaz/yB8N47w8vaTbsqtZ/iYveYcCqHVeFVy8pQJymBFLQEfQ60SOIb2mceLcj6wmJRJe5Ar1ObCQStuPOvbj0gx8vo/bNuiNexjl8dZmKE/ZE42fGK7OEFKAqUTIgjAB6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFPIYbMFbhKcGHTq5X+xtdJZ2It8kdeCpiVct9Fpvqk=;
 b=AvM3HRoTmTMAbrKtoeHhWz7ztPiAdC1Hmpgxtru2LMSfRtxybZ4AodSLBT4bk/9JdUvLOM20oUngVz7Vgu5yeUsnJvAeYOH5M6tnKi04H/EeVX3GgcZhGs1639X1vGjrjCovaWLoDQVogDDY5oHIvJ19L9swRd5XpNkwbhSvKFTj3kOZQHg4ok+tNDpbDw+tnqyBsb8dfbJ9wWL7LWU7SwE8ZLxMUc7P+1gH0F+ch4RyuquwOveyRXFyIszNsN3jetZmUyuOIcmgEctdirSiXOFcPwWJiv/X3v7MBxxFkTQmO6QkNKw3PZH+ZDh4VtknV1tU3kRf4R9Cki5oojJ8uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFPIYbMFbhKcGHTq5X+xtdJZ2It8kdeCpiVct9Fpvqk=;
 b=Nd90DyBoCrJBjZ9aqzXw7dOmre+74tbj8eWI7kKGe5x7t9QBsel5DjnPo83WBSxl39h/Re5AF4VgcKW13RbxBbpKK6X0fZV2Y8TCsoci0PpO28jbB73whnc1gTasF+sSBWoc0qBYWZ47KBl5eP7wBK8siN9WktiWE8k2IoVVg58=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 16:49:29 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.006; Tue, 5 Jan 2021
 16:49:29 +0000
Subject: Re: [PATCH v2] drm/amdgpu: Add check to prevenet IH overflow
To:     Defang Bo <bodefang@126.com>, alexander.deucher@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1609862799-2549739-1-git-send-email-bodefang@126.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <adf3a79f-9e17-da80-3c45-9aa72fb0b85d@amd.com>
Date:   Tue, 5 Jan 2021 17:49:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1609862799-2549739-1-git-send-email-bodefang@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR02CA0211.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::18) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR02CA0211.eurprd02.prod.outlook.com (2603:10a6:20b:28f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.22 via Frontend Transport; Tue, 5 Jan 2021 16:49:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffe1e1d5-5825-4940-373a-08d8b199de6c
X-MS-TrafficTypeDiagnostic: BL0PR12MB4947:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49472FC850C5CE3FACE8DF9383D10@BL0PR12MB4947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTjbjD1lsxXP/4XaGKF/R+2NEH2Lk0nwWTpeQRGqF5hODVEhx9YhpsdLo37dp0gVYZaS9yE9T+u0TO8Jt3xeYLFYzSvascCkVjyJXoT3KNrxexcgTVaIzJaiyVKD5Wj4Xea5qK+PCnO32tNLcOv0rq2WeKrxHB6ws6jGvGNOJ2cxbxug0Af69I79scsYrR8pl/JEnq/SussdMp1flUkMjNtTMLuftKLACvLWT3rWmjCwZNqt3Ai6mMlfbyPY9z+Jyyb4vDaGLS0EbJMZVgDFFiV7Zp5GMZBeo9Zk4Abw+31QjL6h3ayt7bf+FfeDorUWtRaEbDENHoHoPHQWW86FmY9dm+72+L6jbquN4opUNu1mRYU0WyiLU7G0TUcAXfc8ItTVZF7oHG23Z2Zx422HBQkQ0yfbCc3YjMnIhC4kmiXf2U/w4vQ3/VMPtxLjspcbtLd8MtmAruEVjf851VtVrZaF3LErpZ9Y6STnm0TdM7Bhxw50mXny41glI5emeezE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(8676002)(16526019)(5660300002)(186003)(66556008)(66946007)(478600001)(6666004)(4326008)(66476007)(31696002)(86362001)(36756003)(2616005)(83380400001)(8936002)(316002)(2906002)(6486002)(52116002)(31686004)(525324002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eEJRcStueDZsMFV2a2VIeU1ic1ZtRjBicnBvWUUxM0dxcmtqS2NFUm9USXU2?=
 =?utf-8?B?cE9laDFFd0RONmRoejlPQnBHaWVpUWNNWkhOSUxuZi96cWd4VnpCRkpCYjhC?=
 =?utf-8?B?aVJtNWtIWDZoMTNLZ1dwTUtwVm4yNDRhNmI1YUlicXpmQzlTNk0xc1lDN09J?=
 =?utf-8?B?S3lxN09penVlN1ZtOFoyWERZTTkwUmVyc20yaExQQ00zYTVkWmZMZ3dWMkNQ?=
 =?utf-8?B?RmFpZmF3bkJIM3lEM0xvWmpDSk9yL2MraG5veStySGJldnRiVFNtaUVPeS9J?=
 =?utf-8?B?eVRsL0x3MEZlSWJUZXVBcjRXcnlkWGVjZ2Zta0lFQVdhVURNRmdGcVhEVXJa?=
 =?utf-8?B?UXMzUjErNmlGRE5naGpTNzlDN2hoZi9CVHNpOUxsN3UvcEdTUy9tcDNKS0Y4?=
 =?utf-8?B?SFM4UmZrRE1YdlViaU5TUFZkSEpVUGZqL2E2cFpjN3YyeHdXOVl5b0NucVVM?=
 =?utf-8?B?djlBTjc0bUxPeTNXemhjSnBWOW4yei9FWUZhS01KWTRXcGs3V1NBOHV0b3Fk?=
 =?utf-8?B?VXhoWEpoQXhoRlRnMFliL2NadHk0YUR1bHpheldENTZFYVA4SlVkWTNuOTRY?=
 =?utf-8?B?VDVNVmJMVU84VFZoeEVyRmM1dS9UT013Tk9nR0NTbENXSG9tbDgxMlR1OTl3?=
 =?utf-8?B?NnlhZ2JIOGkvY0dYdVhsbGVjVHNjRWhPQzRZMEo0cHdBMmhxVTlQSlI2TDlz?=
 =?utf-8?B?TkRzUWxsR3JncFZEdEhucnZRVTVVQndVck1RZ1V5U2JxaWRlaG00azZCaDlz?=
 =?utf-8?B?MDNYeFMzSUNISE54ZFZzRXorRUpYM1JWWlpqSURiaGFkaGNTNHdjcEJrNHVj?=
 =?utf-8?B?UnVLNkFoNUhUT2NjNk9xeGZ3RndwUGFuU0xFWXpqSWZFSG1sNUhiZVhIVDhZ?=
 =?utf-8?B?a3lTejQ5eVZ6dWZIVFM5YzNNQTdJQXl4M0RUMFRBeDhXenNFdFNmOC9QU2ov?=
 =?utf-8?B?WlA3R2IyTmpaM20rVHdNMzlFdnV1VmNSSDM1OUYwUkVINk1EN0VkYkJ3dDFL?=
 =?utf-8?B?MXlMSXZ1UURLYUFmb3N0SkUvU0N0ZEE1cmE0VzNtVFhISEU0SUJ2dTN3aUdu?=
 =?utf-8?B?MG45ZDdMbDJwSzd1UWcwWG16VzMwNHJaM09hSlFmRFdFakNTb2ZMZDh0bmxj?=
 =?utf-8?B?aUlieDRqUklldDhFSHdvM0xzQm1peHg1ZkljTUtQbjFyekxkb1lDc3ltYzQy?=
 =?utf-8?B?L3c2L3NBNU9CM2Rtd3ZvWmxGVUF0YnBWaWFYM0NWeDZRamd0Mk5BZDhIaDFL?=
 =?utf-8?B?MVArRklUcGowbFBaZWZEckxjT0YzSVVQTkNxWDJNS1VZSG55N1V4OXAydGdQ?=
 =?utf-8?B?ajQ0ZVlLdjQyL0lQeHRhd0IwWGd6dUp1Nlp0VExJdXJqL0RhU0tRTzd3ZzFW?=
 =?utf-8?B?Q2plSWlYYVFKUnB5V2t4anczcUUxL21zTnhuOHk5VGpLOXJVaTRkUGUvMm96?=
 =?utf-8?Q?8vsyJeEW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 16:49:29.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe1e1d5-5825-4940-373a-08d8b199de6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkSCrFlFJBdXN/XUKHZILU2k0t65zjr1vFwOdrhga2Ew3WktfDqplEZSK9sc9EBy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.01.21 um 17:06 schrieb Defang Bo:
> Similar to commit <b82175750131>("drm/amdgpu: fix IH overflow on Vega10 v2").
> When an ring buffer overflow happens the appropriate bit is set in the WPTR
> register which is also written back to memory. But clearing the bit in the
> WPTR doesn't trigger another memory writeback.
>
> So what can happen is that we end up processing the buffer overflow over and
> over again because the bit is never cleared. Resulting in a random system
> lockup because of an infinite loop in an interrupt handler.
>
> Signed-off-by: Defang Bo <bodefang@126.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks for the help,
Christian.

> ---
> Changes since v1:
> - Modify the subject and replace the wrong register.
> ---
> ---
>   drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 39 +++++++++++++++++++++------------
>   drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 36 +++++++++++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 37 ++++++++++++++++++++-----------
>   3 files changed, 72 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> index 1dca0cabc326..65361afb21ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> @@ -190,22 +190,33 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
>   			  struct amdgpu_ih_ring *ih)
>   {
>   	u32 wptr, tmp;
> -
> +
>   	wptr = le32_to_cpu(*ih->wptr_cpu);
>   
> -	if (REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW)) {
> -		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> -		/* When a ring buffer overflow happen start parsing interrupt
> -		 * from the last not overwritten vector (wptr + 16). Hopefully
> -		 * this should allow us to catchup.
> -		 */
> -		dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
> -			wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
> -		ih->rptr = (wptr + 16) & ih->ptr_mask;
> -		tmp = RREG32(mmIH_RB_CNTL);
> -		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> -		WREG32(mmIH_RB_CNTL, tmp);
> -	}
> +	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> +		goto out;
> +
> +	/* Double check that the overflow wasn't already cleared. */
> +	wptr = RREG32(mmIH_RB_WPTR);
> +
> +	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> +		goto out;
> +
> +	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> +
> +	/* When a ring buffer overflow happen start parsing interrupt
> +	 * from the last not overwritten vector (wptr + 16). Hopefully
> +	 * this should allow us to catchup.
> +	 */
> +	dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
> +		wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
> +	ih->rptr = (wptr + 16) & ih->ptr_mask;
> +	tmp = RREG32(mmIH_RB_CNTL);
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> +	WREG32(mmIH_RB_CNTL, tmp);
> +
> +
> +out:
>   	return (wptr & ih->ptr_mask);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> index a13dd9a51149..8e4dae8addb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> @@ -193,19 +193,29 @@ static u32 iceland_ih_get_wptr(struct amdgpu_device *adev,
>   
>   	wptr = le32_to_cpu(*ih->wptr_cpu);
>   
> -	if (REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW)) {
> -		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> -		/* When a ring buffer overflow happen start parsing interrupt
> -		 * from the last not overwritten vector (wptr + 16). Hopefully
> -		 * this should allow us to catchup.
> -		 */
> -		dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
> -			 wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
> -		ih->rptr = (wptr + 16) & ih->ptr_mask;
> -		tmp = RREG32(mmIH_RB_CNTL);
> -		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> -		WREG32(mmIH_RB_CNTL, tmp);
> -	}
> +	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> +		goto out;
> +
> +	/* Double check that the overflow wasn't already cleared. */
> +	wptr = RREG32(mmIH_RB_WPTR);
> +
> +	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> +		goto out;
> +
> +	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> +	/* When a ring buffer overflow happen start parsing interrupt
> +	 * from the last not overwritten vector (wptr + 16). Hopefully
> +	 * this should allow us to catchup.
> +	 */
> +	dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
> +		wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
> +	ih->rptr = (wptr + 16) & ih->ptr_mask;
> +	tmp = RREG32(mmIH_RB_CNTL);
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> +	WREG32(mmIH_RB_CNTL, tmp);
> +
> +
> +out:
>   	return (wptr & ih->ptr_mask);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> index e40140bf6699..2ba1ce323b6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> @@ -195,19 +195,30 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *adev,
>   
>   	wptr = le32_to_cpu(*ih->wptr_cpu);
>   
> -	if (REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW)) {
> -		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> -		/* When a ring buffer overflow happen start parsing interrupt
> -		 * from the last not overwritten vector (wptr + 16). Hopefully
> -		 * this should allow us to catchup.
> -		 */
> -		dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
> -			 wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
> -		ih->rptr = (wptr + 16) & ih->ptr_mask;
> -		tmp = RREG32(mmIH_RB_CNTL);
> -		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> -		WREG32(mmIH_RB_CNTL, tmp);
> -	}
> +	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> +		goto out;
> +
> +	/* Double check that the overflow wasn't already cleared. */
> +	wptr = RREG32(mmIH_RB_WPTR);
> +
> +	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> +		goto out;
> +
> +	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> +
> +	/* When a ring buffer overflow happen start parsing interrupt
> +	 * from the last not overwritten vector (wptr + 16). Hopefully
> +	 * this should allow us to catchup.
> +	 */
> +
> +	dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
> +		wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
> +	ih->rptr = (wptr + 16) & ih->ptr_mask;
> +	tmp = RREG32(mmIH_RB_CNTL);
> +	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> +	WREG32(mmIH_RB_CNTL, tmp);
> +
> +out:
>   	return (wptr & ih->ptr_mask);
>   }
>   

