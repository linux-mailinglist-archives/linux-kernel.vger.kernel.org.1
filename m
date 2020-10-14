Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA3128E522
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbgJNRNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgJNRNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:13:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A63C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:13:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id j8so83762pjy.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zscSsuRjA2i+Yv1HzDPjwJXpkYzEKYfL+D9exT2/oXQ=;
        b=HoLebvqC4t9n4514qYB1P5ZZiDF3lK8ucrHRqLLieu0WdMWzNpKkZAf+PodEpPnnn0
         x8ZWFAueJ2APz1n1+rBU3+LCSbTZX1Jblg6HvwCVuSKHxmJfypWdGqB8l/r1ElbG6754
         uhKXfTVLsRnBqAxCmhEdel3Hcna2Sv3BHzSIQdieUpgkphLOo2RpoYZ0earZPuUhKh+5
         dS1mscP8QWzzdVhL3mhhkScMxajdAHK7Jz+OSo56riQHXQJlRdtx+yUdLlV/LQc3CtL2
         +5cFLS6IMP5iA3ZZRzILglBtCrGGDUn9bs9n8zcxb69Dk3LP2Fjpt09cXTppzX4o3plW
         Q08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zscSsuRjA2i+Yv1HzDPjwJXpkYzEKYfL+D9exT2/oXQ=;
        b=J3fyfhSoA3dCEAM8R3l2DlZqJsrTuqiSDYehNzxKP/otO7fv6mNKuszIKT2E1WKbw1
         4sk5wjQPMEflLQHc9YPFOSBfJVkTyNwlU+fqkcoMjPghvkilAcnVXKqd8zp6yMr10vUX
         AAmTwNc/wXNoBSycjCC1ehTq32mv9pt/c/Nnwm9ewPGv/0fhgPv/+UEwGx4ivZwOkwym
         NSgULOP+G34wBFUmmufF/YpqPyGufzRC3GexjmJuZE0ikZ7K8/m1ED/laCx9JSsHvE9g
         jANqn4Cvf2/fbXV3ctrutqEZDAjVKAL0zzUcXwWlSoQ1Vo/lA3taoHqX3nMM5VeJUX4Z
         MPYw==
X-Gm-Message-State: AOAM530KEg79HrGFbs3PgVzOn0lTEo1ZEOIkhbXwR0PtEXegJP8MwtBv
        O6IcDHTTTaICioyyPj0+H6f9BmT31LA=
X-Google-Smtp-Source: ABdhPJySge9IPccylO+lyQa3pMjam7t/R1NBtMg0v/3RehMDj5uV+eitLiy84OjA9C7WmglHWKnXdQ==
X-Received: by 2002:a17:902:8608:b029:d4:c459:f1e8 with SMTP id f8-20020a1709028608b02900d4c459f1e8mr412124plo.36.1602695586465;
        Wed, 14 Oct 2020 10:13:06 -0700 (PDT)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s8sm61200pjl.41.2020.10.14.10.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 10:13:05 -0700 (PDT)
Subject: Re: [PATCH] firmware: arm_scmi: Fix duplicate workqueue name
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20201014021737.287340-1-f.fainelli@gmail.com>
 <20201014091806.GB20315@bogus> <20201014130524.cj42wknvzdpgsbsr@bogus>
 <20201014134819.GA24061@e120937-lin> <20201014160120.4x2l7hozf376gk3l@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <fdb270ef-bec0-9592-1d33-3339872bbffe@gmail.com>
Date:   Wed, 14 Oct 2020 10:13:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014160120.4x2l7hozf376gk3l@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/20 9:18 AM, Sudeep Holla wrote:
> On Wed, Oct 14, 2020 at 02:48:19PM +0100, Cristian Marussi wrote:
> 
> [...]
> 
>>>
>>> I have pushed a version with above change [1], please check if you are
>>> happy with that ?
>>>
>>> [1] https://git.kernel.org/sudeep.holla/linux/c/b2cd15549b
>>
>> I agree with the need to retain _notify name, but I'm not so sure about
>> the above patch...which is:
>>
> 
> I agree, I thought about it and just cooked up this as a quick solution.
> I will move to that, even I wasn't happy with this TBH.

The reason why I went with just dev_name() was such that the workqueue
name and the device nodes under /sys would strictly match, which helps
as an user, and also it avoided the temporary buffer and its size
limitations. However I don't have a strong feeling about this. Sudeep, I
can confirm that:

https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/patch/?id=b2cd15549b1fad6b0725c7a5a89ec3d41723fe8f

works as well for me:

# ls -l /sys/bus/workqueue/devices/
total 0
lrwxrwxrwx    1 root     root             0 Jan  1 00:01
brcm_scmi@0_notify -> ../../../devices/virtual/workqueue/brcm_scmi@0_notify
lrwxrwxrwx    1 root     root             0 Jan  1 00:01
brcm_scmi@1_notify -> ../../../devices/virtual/workqueue/brcm_scmi@1_notify
lrwxrwxrwx    1 root     root             0 Jan  1 00:01 scsi_tmf_0 ->
../../../devices/virtual/workqueue/scsi_tmf_0
lrwxrwxrwx    1 root     root             0 Jan  1 00:01 scsi_tmf_1 ->
../../../devices/virtual/workqueue/scsi_tmf_1
lrwxrwxrwx    1 root     root             0 Jan  1 00:01 writeback ->
../../../devices/virtual/workqueue/writeback
-- 
Florian
