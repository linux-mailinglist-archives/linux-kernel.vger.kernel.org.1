Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828032745B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgIVPuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIVPuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:50:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA57AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:50:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s12so17636019wrw.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k1qiM4bUagO9PvzG1mYjhQ2oeaOlyE+NHa+RI/UKMuI=;
        b=OffjgK1VvQU3R4J2PDeHOOirKPulZND04R2KV4wX2yXgAdKlN82m3+qgP/YLrgHdoP
         XRGEQpgSy/EvjUge6T9J532EjQGUOMSKUUm2YjrwEEnfFJYXoItcvuYoojcMCiFOLfCl
         +a9sSbot03midkDhZaSzd4yF71ySdX6mfEYJ8UiYu3QOnw1082QuhAksGSZ6TEBI4DqE
         YXpTPsDBx4UiAtoiXHGouZPixegjYM59VecZEk+F8kHX62SO35UKc/naF7K0IgW1DkdP
         s9pm7Hru94v9+btXnyu2IXDVeNLGSWoDFO8I+lUf5O0ulzIoYYO61eFmy6f9gCBnvy+b
         +miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k1qiM4bUagO9PvzG1mYjhQ2oeaOlyE+NHa+RI/UKMuI=;
        b=pbdwsNyDGZKJfqm2INJY0ii3Nt5BNqMw73lCpjvYnU/5p3UTomMLFX2LVHX/lRyfXa
         gdXMJF/AVJlYoa+7Bb/JvosK70IzVNdJQTjGsvPD/d2et9WjD1XnGHOPmKwWav3YFGqL
         oMIheL/eE7xWPEzjBskDwJv7ps90BJ1oQv/Iu0LFqepGCho/W4VHEsguL9e2vTH/NmQj
         5Z/+UwObHvYUSln/IKb2kr8dOL5Qo/Vw9CnXPUZoA16b1DlLqhQpKvef8USqLPujUXvt
         Gv7AHgW8EsuPCYuxa8xCW6xE2yXpPB4N3YtryRFV0kWRjLMRRqXL0yTYo7TOwv3BemJp
         QVQQ==
X-Gm-Message-State: AOAM5336zQk8pY6NZRmV6XkMKHvbiXcm8jyDW2aodJ4ZyeIhUVhAqRuR
        qgf0cNO4UUV1fQ3RSbm8VCVju1Y8zMkMCZzANtc=
X-Google-Smtp-Source: ABdhPJzNUoLcCUJtNlHpGP5CHl4ouHNhSErzbaqeG9ZEfR+X8xgDw8Vu/pgn8/BMiFFtwMkSUKK2DOChEI2ZoswOEhw=
X-Received: by 2002:adf:dd82:: with SMTP id x2mr6452043wrl.419.1600789804606;
 Tue, 22 Sep 2020 08:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <1600773099-32693-1-git-send-email-wangqing@vivo.com> <CAD=4a=URYhNswOBfBj39b00HWR3vWeHF9ntP-n_SPa94YJZbTg@mail.gmail.com>
In-Reply-To: <CAD=4a=URYhNswOBfBj39b00HWR3vWeHF9ntP-n_SPa94YJZbTg@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Sep 2020 11:49:53 -0400
Message-ID: <CADnq5_ObAjsxfKsJgk6mE7OKK6Jw=-bacva6_rxySKSD8nqAjg@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/radeon: fix spellint typo in comments
To:     =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Cc:     Wang Qing <wangqing@vivo.com>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied with subject typo fixed.  Thanks!

Alex

On Tue, Sep 22, 2020 at 10:07 AM Ernst Sj=C3=B6strand <ernstp@gmail.com> wr=
ote:
>
> There is a typo in your patch subject. ;-)
>
> Regards
> //Ernst
>
> Den tis 22 sep. 2020 kl 15:11 skrev Wang Qing <wangqing@vivo.com>:
>>
>> Modify the comment typo: "definately" -> "definitely".
>>
>> Signed-off-by: Wang Qing <wangqing@vivo.com>
>> ---
>>  drivers/gpu/drm/radeon/radeon_vm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon=
/radeon_vm.c
>> index f60fae0..3d6e2cd
>> --- a/drivers/gpu/drm/radeon/radeon_vm.c
>> +++ b/drivers/gpu/drm/radeon/radeon_vm.c
>> @@ -188,7 +188,7 @@ struct radeon_fence *radeon_vm_grab_id(struct radeon=
_device *rdev,
>>             vm_id->last_id_use =3D=3D rdev->vm_manager.active[vm_id->id]=
)
>>                 return NULL;
>>
>> -       /* we definately need to flush */
>> +       /* we definitely need to flush */
>>         vm_id->pd_gpu_addr =3D ~0ll;
>>
>>         /* skip over VMID 0, since it is the system VM */
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
