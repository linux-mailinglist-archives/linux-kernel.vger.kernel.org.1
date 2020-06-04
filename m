Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB2D1EED8C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 23:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFDVyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 17:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgFDVyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:54:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A566BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 14:54:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y11so7573803ljm.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 14:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22Wtqy8gIHx/OWMtNzE9YiY36SfGsi23Baca0TrE4fM=;
        b=jkIWzy5dTcu3OCzuFGGAKdTxSEkZa/GbVmnv3CtVS4Vw7b+eo8ckPTZ/AZqP4GF5of
         m9AeZS80XkNU81VVJ7X5P2un/xTMK6zv24F5RXgLsxGfZNlYysZf3CSI5Ao7+rtvCDWH
         dcfKZd7ibPHok//s5g08AkmFZ8k8g3DS7EwnkdVFrVMFw4O3WYScpmJU/pRzhdLHSAIt
         DReEoT4dUFqWEs5YIb/9yJnprGn5o5rDiahW4KLYsjdwVWX0OccYZO4ZYu5s80taR3eY
         BX1ZUV/zt1Og5vNdZSy0lOL9PADD4vtEp3oGGQ9f/sOf67vhA3UvC4Qtu4ejkMLXvUed
         /vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22Wtqy8gIHx/OWMtNzE9YiY36SfGsi23Baca0TrE4fM=;
        b=WX3JS65t6f8EwhOdoeSZ7nM6i8RzZW10TTaOz7mK8EMuiDJ3KiYGDbNM7rFukN5/AL
         V68bjsFbue678VjfsKt+zYeQMfp5036D8JUK5fvQl3Ab6dNAHZDpIV4JwDS3pSimkMC4
         STihL1VwooHlZ2NbmG7F97YOYKV4oYaB/5JKo2f6i+rYChp4e92EyCLLIM/sZCLGk7o7
         GqO537IIvIMlJXYCSFiqndvQN4ix4tapUR+Z+b9yFclitKSOv4sK786ZFcLloQKYfHhf
         SrqVUfLmCpyuOK4vSCVefd7TMlA/Pbuz7l3nSofnAemGHBIJBDWjqa7n16RaUw+R29CK
         q89A==
X-Gm-Message-State: AOAM533hIFHJQJusii1g897rS8tDaW0QPQBMubfVveUfMq655ThATcRe
        /x3usczeYUlMwV3dYog8JBU/8mXTQ/egmesLx++rgw==
X-Google-Smtp-Source: ABdhPJwH+pdp50kNI1ISWPREOQTUt+EZsEsLMSnvwrphzAG2humptfIT+oJO3B9lD5O02nSuFcgzyxj/uotd8TVWVwg=
X-Received: by 2002:a2e:984b:: with SMTP id e11mr2897161ljj.358.1591307639810;
 Thu, 04 Jun 2020 14:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200604202520.66459-1-maco@android.com>
In-Reply-To: <20200604202520.66459-1-maco@android.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 5 Jun 2020 03:23:48 +0530
Message-ID: <CA+G9fYvtY2KwxVOmVfQ+Zp4LMS6pf518-H3COb7K-=RqsGwznw@mail.gmail.com>
Subject: Re: [PATCH] loop: Fix wrong masking of status flags
To:     Martijn Coenen <maco@android.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020 at 01:55, Martijn Coenen <maco@android.com> wrote:
>
> In faf1d25440d6, loop_set_status() now assigns lo_status directly from
> the passed in lo_flags, but then fixes it up by masking out flags that
> can't be set by LOOP_SET_STATUS; unfortunately the mask was negated.
>
> Re-ran all ltp ioctl_loop tests, and they all passed.
>
> Pass run of the previously failing one:
>
> tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> tst_device.c:88: INFO: Found free device 0 '/dev/loop0'
> ioctl_loop01.c:49: PASS: /sys/block/loop0/loop/partscan = 0
> ioctl_loop01.c:50: PASS: /sys/block/loop0/loop/autoclear = 0
> ioctl_loop01.c:51: PASS: /sys/block/loop0/loop/backing_file =
> '/tmp/ZRJ6H4/test.img'
> ioctl_loop01.c:65: PASS: get expected lo_flag 12
> ioctl_loop01.c:67: PASS: /sys/block/loop0/loop/partscan = 1
> ioctl_loop01.c:68: PASS: /sys/block/loop0/loop/autoclear = 1
> ioctl_loop01.c:77: PASS: access /dev/loop0p1 succeeds
> ioctl_loop01.c:83: PASS: access /sys/block/loop0/loop0p1 succeeds
>
> Summary:
> passed   8
> failed   0
> skipped  0
> warnings 0
>
> Fixes: faf1d25440d6 ("loop: Clean up LOOP_SET_STATUS lo_flags handling")
> Signed-off-by: Martijn Coenen <maco@android.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Thanks for the quick fix patch.
I have tested with the patch applied on x86 and arm64
and confirm it fixes the reported problem [1].

Test log link,
https://lkft.validation.linaro.org/scheduler/job/1471435#L1299
https://lkft.validation.linaro.org/scheduler/job/1471574#L714

ref:
https://lore.kernel.org/linux-block/CAB0TPYEx4Z8do3qL1KVpnGGnorTLGqKtrwi1uQgxQ6Xw3JqiYw@mail.gmail.com/T/#t

- Naresh
