Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375AF2CFBDE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 17:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgLEPvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 10:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgLEO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 09:58:23 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD06C02B8F3
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 06:47:30 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id b5so981339pjl.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 06:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXyfW/MOF1GC7gFH6eMrnSd2RczMd1PKQk2yaRcPi1g=;
        b=NUP7VUBboQYlYfKlvt1q5hm/95Dp0qy9yROg5ye2pE7IOT5Qu8E0iSdta+kqip+dZ8
         qnrrhhI03C+5Zldh0suZAf381vsBWP5gL7K126mdLr9hwhol7Gdw2YOeP+Yghu5N3TuK
         kK5qdJ23UyUixbIRYQuoXUJ3tMfZVxXbHrHJJVrgVqWEWPOUzaiQZN3pj/kvsNskFDyr
         XttB9Qhq0DM/bKb8xXYNhA1ua8KuaXP3ufzCiLLS+iiXUbL7fiKOHYFGK58TMPrPD9xh
         bueWEhfasB34+9CMZcL2zaY0/AywEoqF0tq1dBCNTbs/7dO+3yNcEOooswCThBrr+Vrc
         tW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXyfW/MOF1GC7gFH6eMrnSd2RczMd1PKQk2yaRcPi1g=;
        b=JNqitoGhSdcUSXbm0gJa3C6S12nahIgjcc1HXjO3YlFetC6uvPHwjHGV6Ks7vH5R9F
         tm/C91DAAHR51sMdTJwEGNes5GCR4t+pN4wY15dXlpwtTwPuy1ocDls/ciVWvFiwDLvi
         tybPYq08ojIQ5o1fTqmXmKkakyMnP4ZZ5ce9nXbSDyevMZWh4LNMdoWMLTPLEm9TVYPN
         dJSeuFF/44c4H2bKQxS76rzxgwMwz7gWxh29dVaUkDeJXWW4Fp8/cX7Hv26qNivokF0R
         4ivT6uFGFOSJhS6bkGk3dZY+YzCXI9rq9jfbJJD3ZzQjMzUjOW9IusLceoP4LtHk5a/6
         6JRg==
X-Gm-Message-State: AOAM531FL16o118h0hCSz8RqjJe8zwr4XT4FbJfLtv69rIuQGLSTSnfU
        3OT+O594PFYxCfLfaJxTMnmND5Og/S5oWjYbtrs=
X-Google-Smtp-Source: ABdhPJyQ8+KzBh38nM1VVwl++fObl9pwdTRvDAQgKZhdgmR8gwVtB0RBPVqu+vMfPrkTLAwbcR/rrhj8hdKY8OG/5uk=
X-Received: by 2002:a17:902:324:b029:d8:fdf3:af34 with SMTP id
 33-20020a1709020324b02900d8fdf3af34mr8179239pld.70.1607179650020; Sat, 05 Dec
 2020 06:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20201205103827.31244-1-wanghai38@huawei.com>
In-Reply-To: <20201205103827.31244-1-wanghai38@huawei.com>
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date:   Sat, 5 Dec 2020 20:16:53 +0530
Message-ID: <CAAs3648wsmiJw43BAfigLHC_Sr=9Coubk9b=na0dVNTtNwFqXA@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: audio: Fix possible leak free widgets
 in gbaudio_dapm_free_controls
To:     Wang Hai <wanghai38@huawei.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, aibhav.sr@gmail.com,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        devel@driverdev.osuosl.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 5, 2020 at 4:02 PM Wang Hai <wanghai38@huawei.com> wrote:
>
> In gbaudio_dapm_free_controls(), if one of the widgets is not found, an error
> will be returned directly, which will cause the rest to be unable to be freed,
> resulting in leak.
>
> This patch fixes the bug. If if one of them is not found, just skip and free the others.
>

nit, typo error "If if one".

> Fixes: 510e340efe0c ("staging: greybus: audio: Add helper APIs for dynamic audio module")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---

Reviewed-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>

--
thanks,
vaibhav
