Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB00280832
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbgJAUCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:02:10 -0400
Received: from services.gouders.net ([141.101.32.176]:53158 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbgJAUCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:02:09 -0400
Received: from lena.gouders.net (ltea-047-066-024-155.pools.arcor-ip.net [47.66.24.155])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id 091JtVtT012416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 1 Oct 2020 21:55:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1601582133; bh=+c1Qskew6XfuK4sFE9wvL98lkeAWXt2+Jq5q/gW488k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JmC1J8dwKII1dewZfDGkgW0nbtA2ZSDvkYbR953c4qSu11FVo6IX7DKUQL4nr74t2
         ZUjifx35Emh1kZsfadniVSE4sS8DI/Tq9sjmfqP96Cm8ks4DcShIoXVV2WakjURJDw
         y5AEp5mkLVZke4CFCX56lmWMaYWSsZgOhae/AxsE=
From:   Dirk Gouders <dirk@gouders.net>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Dirk Gouders <dirk@gouders.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Evan Quan <evan.quan@amd.com>
Subject: [PATCH 0/1] drm/amdgpu: fix NULL pointer dereference for Renoir
Date:   Thu,  1 Oct 2020 21:55:24 +0200
Message-Id: <20201001195525.3477-1-dirk@gouders.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CADnq5_OOL3UZXKXEKU8VzkZAkOnk9HM8m=nEwywoQPm4GXs0rw@mail.gmail.com>
References: <CADnq5_OOL3UZXKXEKU8VzkZAkOnk9HM8m=nEwywoQPm4GXs0rw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Deucher <alexdeucher@gmail.com> writes:

> On Wed, Sep 30, 2020 at 4:46 PM Dirk Gouders <dirk@gouders.net> wrote:
>>
>> Commit c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
>> introduced a NULL pointer dereference when booting with
>> amdgpu.discovery=0.
>>
>> For amdgpu.discovery=0 that commit effectively removed the call of
>> vega10_reg_base_init(adev), so I tested the correctness of the bisect
>> session by restoring that function call for amdgpu_discovery == 0 and with
>> that change, the NULL pointer dereference does not occur:
>>
>
> Can I add your Signed-off-by?

I did not expect the diff to be seen as a proposed patch, not even that it
shows the correct fix.

Anyway, I did my best to create a hopefully acceptable patch with
some modification of the code that avoids "else" and an identical function call
at two places in the code.

I testet that patch with amdgpu.discovery={0,1} and together with the patch for the
first issue you helped me with.  The result is no more call traces.

Thank you for your patient assistance with the two issues.

Dirk


> Thanks,
>
> Alex
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index 84d811b6e48b..2e93c5e1e7e6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -699,7 +699,8 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
>>                                          "fallback to legacy init method\n");
>>                                 vega10_reg_base_init(adev);
>>                         }
>> -               }
>> +               } else
>> +                       vega10_reg_base_init(adev);
>>                 break;
>>         case CHIP_VEGA20:
>>                 vega20_reg_base_init(adev);
>>
>> Dirk
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Dirk Gouders (1):
  drm/amdgpu: fix NULL pointer dereference for Renoir

 drivers/gpu/drm/amd/amdgpu/soc15.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.26.2

