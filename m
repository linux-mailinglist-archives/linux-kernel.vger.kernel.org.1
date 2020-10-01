Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74E2280526
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbgJAR2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbgJAR2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:28:08 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B373C0613E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:28:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so3710615wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=1M4RAfm7Ka56hTVARaFbgr0VJN7Hux9S4garFliWQrQ=;
        b=of5jzw3PMgufI53qBrC2IN+3pkDwsZMmS8MapDtIqs/jRJVAtRNIK5NaDLJTzFRu6O
         EYphTukdKvGCSmMzQwdDNTvjyg55U1+uhs4sZ7UDsqRMrfW+bdIRVAeso5kctUQ3PPmO
         fTtG7v30wu0HPu+/UspUI3agEHuhSkt+y6qOQYSr+8OqjcVQUHBPsPKO3GDsih2xLp+r
         VXbby1N/7G0XvD+/BVHbNUwjJVhsoHD5W33pcDGbhV709XEYe5Bn4+eqeuSsh6lRVOlm
         ntz4ZoUrHhH02HsIwi2Gu/8kiNiJqlqJvyX8lRrJG5U4Ab2lfTUwML+OwasgOQzqTn3E
         f6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1M4RAfm7Ka56hTVARaFbgr0VJN7Hux9S4garFliWQrQ=;
        b=mQp2R16vJ/8t7QqYmFqJGA67NYbiAi+Pl9HBo46piN6Or3evvZfkH/3y9CALDT6M36
         ILmmu+rJhziP6OE3qrOESXm2UUFZA8UkgNOlad9tsHlH10OuyoYWWb3bQAP/M6jEw0IU
         MhHX2C3/7plCoEzvZK2QqxCqLDiAK6Knnt97NwoxrBNRWr5G97m62HLpb/x5V9opdhFs
         W2USfi9mXf0aV4e4v/KqaryvbORNhA/p6dTuizXrEbaLp19dHmgKFEJbvHvFCSiWv0P5
         MIGE+duLSYg6qaB+QedP7YjsWIuD+dXK8IgXuQWsJOB3iLxkEp4UcgY2XXxsyCaPAfOZ
         1jYA==
X-Gm-Message-State: AOAM533H2z+DHlITKzqLjrNO0TPUg05WhzQvdRUoNmgAJ38eF3tQjsTF
        sYNaB8lZ4G+8+0MY48bPUNkKJQ==
X-Google-Smtp-Source: ABdhPJwyVDVxYje8TjchORDThAw8Nf2lyrEVVWCNGUtzSKY/wsPFwtKzJsKQK/RU/wWZQIwlAkVZlA==
X-Received: by 2002:a7b:ce89:: with SMTP id q9mr1060628wmj.65.1601573286992;
        Thu, 01 Oct 2020 10:28:06 -0700 (PDT)
Received: from ?IPv6:2001:861:3a81:3690:b885:8dcf:f8c6:7841? ([2001:861:3a81:3690:b885:8dcf:f8c6:7841])
        by smtp.gmail.com with ESMTPSA id k6sm827843wmf.30.2020.10.01.10.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 10:28:06 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] Add a RPMsg driver to support AI Processing Unit
 (APU)
To:     linux-remoteproc@vger.kernel.org, ohad@wizery.com,
        gpain@baylibre.com, stephane.leprovost@mediatek.com,
        jstephan@baylibre.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        mturquette@baylibre.com, bjorn.andersson@linaro.org,
        christian.koenig@amd.com, linux-media@vger.kernel.org
References: <20200930115350.5272-1-abailon@baylibre.com>
 <20201001084856.GC438822@phenom.ffwll.local>
From:   Alexandre Bailon <abailon@baylibre.com>
Message-ID: <8e4bb739-c3b3-d790-e8e3-dd5df2d6f869@baylibre.com>
Date:   Thu, 1 Oct 2020 19:28:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001084856.GC438822@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 10/1/20 10:48 AM, Daniel Vetter wrote:
> On Wed, Sep 30, 2020 at 01:53:46PM +0200, Alexandre Bailon wrote:
>> This adds a RPMsg driver that implements communication between the CPU and an
>> APU.
>> This uses VirtIO buffer to exchange messages but for sharing data, this uses
>> a dmabuf, mapped to be shared between CPU (userspace) and APU.
>> The driver is relatively generic, and should work with any SoC implementing
>> hardware accelerator for AI if they use support remoteproc and VirtIO.
>>
>> For the people interested by the firmware or userspace library,
>> the sources are available here:
>> https://github.com/BayLibre/open-amp/tree/v2020.01-mtk/apps/examples/apu
> Since this has open userspace (from a very cursory look), and smells very
> much like an acceleration driver, and seems to use dma-buf for memory
> management: Why is this not just a drm driver?

I have never though to DRM since for me it was only a RPMsg driver.
I don't know well DRM. Could you tell me how you would do it so I could 
have a look ?

Thanks,
Alexandre

> -Daniel
>
>> Alexandre Bailon (3):
>>    Add a RPMSG driver for the APU in the mt8183
>>    rpmsg: apu_rpmsg: update the way to store IOMMU mapping
>>    rpmsg: apu_rpmsg: Add an IOCTL to request IOMMU mapping
>>
>> Julien STEPHAN (1):
>>    rpmsg: apu_rpmsg: Add support for async apu request
>>
>>   drivers/rpmsg/Kconfig          |   9 +
>>   drivers/rpmsg/Makefile         |   1 +
>>   drivers/rpmsg/apu_rpmsg.c      | 752 +++++++++++++++++++++++++++++++++
>>   drivers/rpmsg/apu_rpmsg.h      |  52 +++
>>   include/uapi/linux/apu_rpmsg.h |  47 +++
>>   5 files changed, 861 insertions(+)
>>   create mode 100644 drivers/rpmsg/apu_rpmsg.c
>>   create mode 100644 drivers/rpmsg/apu_rpmsg.h
>>   create mode 100644 include/uapi/linux/apu_rpmsg.h
>>
>> -- 
>> 2.26.2
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
