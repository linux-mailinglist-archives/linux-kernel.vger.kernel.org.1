Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4557F2C9839
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgLAHet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgLAHes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:34:48 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67573C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:34:08 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 142so1231306ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3sAfYzfnHpBDQQEiR5AB4kL1wrJ/tmzzqABS0iM18lo=;
        b=GHXUq2YpLuIQ36kaJyi6gm+57jEHYfI6XasZB7E8uDctHdzu7RWhpv4EGD1pUV/Lea
         UP63nqdng6ZhpZg7NP/OTVWmHJslZ3spK7pjGIxQZopEsEIbHuDtkiHmy+u0uCYnw2g0
         Q8QgCGLR1UUBHiRPmDdQ0vecTsMRD6KLthMZh291cZxqPcR+VuBSfUcvOFjWGkZPhHCR
         aUL7Nsv4eECy7to6BV2N/MdGNpvpXZvSxNRV8gWapBmFggYOHvWFkYzaXAOKpB9IYayy
         W3lXzunc5ErjdF5fCTPCwSciYu8c0xP+gFsvM+PRdjBTOF8JxdxmjtZNhsXjiurggb1v
         w2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3sAfYzfnHpBDQQEiR5AB4kL1wrJ/tmzzqABS0iM18lo=;
        b=OkXZ1N8x/71KIiia0nc7S4ymBmEbhfQhFqvbPvlHlA4TughrADGR6/Uh+7WZYUjROv
         1e3q28Llhkd3cu0zaNk5d4mN3GF+3nXnBjF+nsx+O1Agtn0pnS7aegZLuiGU/W35E9EC
         kCkkIAnLklLhlhc37lMQp36gRKSoABt838Zrr0rtze51/VGewDFhpWzGs5QU22ii3aV9
         OChmbj1eNcZrDwARmxon4NPW0k7sHqABsj/jUeccDH7IfEUogqZ2GCWlHplJLyBUQzIU
         Av4AsLpiOH7/iBEih3BIenw66gudqPlQb0VrajkFd/C4ob8kvZtolpu8j/MaUkLt3sK6
         fA5Q==
X-Gm-Message-State: AOAM530S6nNsXiPOSl/Fd9Q2hnAHQ7y+SZK+ZRa2vg56PascmcNLLcgZ
        I/9FEh6aDmOJPXVJG7m36t2ECh38NoIkauJs7SOTTg==
X-Google-Smtp-Source: ABdhPJxsHo7jWyLvtclHc5phZMJ2NRcTEMgll8C8jkpEWdcV6iozaUa6EbEg14cZVBhgXvtZiTb3kqSxHi6+e2yLbEA=
X-Received: by 2002:a2e:8504:: with SMTP id j4mr673944lji.169.1606808046741;
 Mon, 30 Nov 2020 23:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20201130233242.78413-1-dlatypov@google.com> <20201130233242.78413-5-dlatypov@google.com>
In-Reply-To: <20201130233242.78413-5-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 1 Dec 2020 15:33:55 +0800
Message-ID: <CABVgOSkTEudDdbJ3b8mRBvKFtnC=hV9qT8h8EZhJqyEcpFxd5g@mail.gmail.com>
Subject: Re: [PATCH 5/5] minor: kunit: tool: s/get_absolute_path/test_data_path
 in unit test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 7:33 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> 1. the name is a lie. It gives relative paths, e.g. if I run from the
> same dir as the test file, it gives './test_data/<file>'
>
> 2. it's only used for generating paths to tools/testing/kunit/test_data/
> So we can tersen things by making it less general.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
This is an excellent and overdue rename/replacement.

My only note is re: the concerns I have in patch 2, where I think we
probably ought to make this function actually return an absolute path.
It seems from the code (and the function name) that that was the
intent, so if we can fix it, that'd be ideal.

Personally, though, I'd still prefer the new test_data_path(), just
have it be an actually absolute path.


-- David
