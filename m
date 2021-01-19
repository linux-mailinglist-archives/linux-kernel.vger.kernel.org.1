Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA912FB70F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389377AbhASKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388461AbhASJrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:47:39 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75955C061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 01:46:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b2so20712243edm.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 01:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=knYHysr88c4/TWe82gygyIRvNinfSQv9W9jGZvmbheg=;
        b=F0aVGzGUQigXZWR5zVdpACnob/1MitNbwwVbuM/5Zvg6oHnmx7FLWtSqEB0eyRWBbc
         WsiWp5FYsHfA8HS3I6GcpkpLsPEBjGlnPLEDOPi95TAJduWZbcoAbUDPNHWmVwmgkx5S
         1LGw3Pabt6Z1Vg+K3q7X4hvVoqTazaWezyL9Hrrub/SVnsZXeB6iAPI8v9Q9MOVNaPiN
         HMA5AzSYMXnI9RqvEFMqn1TQWlN0r8wMhDbuxWRjkrbpWX+BJqIEYmH8DdT9LDHcqyhA
         eSYkPFWvnx70WK20WKixyCK3BpXa0TIPXT/YWBMEkudIbAlE6w3uae4dQbwXDQ5UBxud
         s3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=knYHysr88c4/TWe82gygyIRvNinfSQv9W9jGZvmbheg=;
        b=T/YhGNOypAWL4Q/ETqEp/axerPw9mFtGVS1A2uA1rKQwJDaG3tmsx+D/bevJocgC9y
         Ug+ACL+P5r2VP6BLdpEwnc6aFEz6kvKCXRiIvz8XNG/2pJN2cGiFrxPV+BD+sOiHizlm
         W603Axfv/dxf8z2+dL98RiLVH7lpJLs76DrfZ67/cPGPRCiICjxg3IcYZo3fa0XE/ON+
         nX9kHpvpDAjAVNlGQuzQ4VnylTRuXd3WxEr+O54U/5D4JJ3eoH5tvfGdUlL83Ouzgifm
         cvg3zGqIJP2cDSmFxBaHxgWB7jAs8bxkNG4Mmyim/jbwx1f69VhW/FcDVCmOCZ90Gs6K
         Y5Fg==
X-Gm-Message-State: AOAM533s6CQjCzvM2gMv5WHkcxb9zLbQddPDK4U07giA00rl52TRHL0w
        /hjM1Un6iohrzZh1oAb7jyQJUYdAMeY=
X-Google-Smtp-Source: ABdhPJysagZzJn3NDuTWpGm9ePU1dBi+ffgcRmCMaz7tEzNScBUc49fSIrYI/svjRZncmLv+Jd78pw==
X-Received: by 2002:a05:6402:30a7:: with SMTP id df7mr2590354edb.108.1611049616996;
        Tue, 19 Jan 2021 01:46:56 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id m26sm5472279ejr.54.2021.01.19.01.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 01:46:56 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] drm/syncobj: make lockdep complain on WAIT_FOR_SUBMIT v2
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     daniel@ffwll.ch, mingo@redhat.com, will@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210118180334.43714-1-christian.koenig@amd.com>
 <20210118180334.43714-2-christian.koenig@amd.com>
 <YAan6haGjnIlNIoJ@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <019f2342-9d64-f6c6-d03d-0ab8ddce101d@gmail.com>
Date:   Tue, 19 Jan 2021 10:46:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YAan6haGjnIlNIoJ@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.01.21 um 10:35 schrieb Peter Zijlstra:
> On Mon, Jan 18, 2021 at 07:03:34PM +0100, Christian König wrote:
>
>> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
>> index 6e74e6745eca..f51458615158 100644
>> --- a/drivers/gpu/drm/drm_syncobj.c
>> +++ b/drivers/gpu/drm/drm_syncobj.c
>> @@ -387,6 +387,13 @@ int drm_syncobj_find_fence(struct drm_file *file_private,
>>   	if (!syncobj)
>>   		return -ENOENT;
>>   
>> +	/* Waiting for userspace with locks help is illegal cause that can
>> +	 * trivial deadlock with page faults for example. Make lockdep complain
>> +	 * about it early on.
>> +	 */
> Egads, the cursed comment style is spreading :/
>
>> +	if (flags & DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT)
>> +		lockdep_assert_none_held_once();
>> +
> Should this not be part of drm_syncobj_fence_add_wait() instead?

drm_syncobj_fence_add_wait() is only called when the previous try of 
finding the fence wasn't successfully.

If we want to check drivers for stupid behavior for the uncommon wait 
before signal case we need this much earlier.

But I'm going to double check if drm_syncobj_fence_add_wait() isn't used 
elsewhere as well.

> Also, do you want to sprinkle might_sleep() around ?

Good point. Going to add that as well.

Thanks,
Christian.

>
>>   	*fence = drm_syncobj_fence_get(syncobj);
>>   	drm_syncobj_put(syncobj);
>>   
>> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h

