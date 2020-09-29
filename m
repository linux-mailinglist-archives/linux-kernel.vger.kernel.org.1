Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B615727CECC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgI2NPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgI2NPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:15:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44BEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:15:17 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 77so5488667lfj.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6aot3ORIQWKklkoQf+YaVDp4V9gsCzqvPIkopUs4mX0=;
        b=dUmsJ0i7XR3z9EytyoaRkBCnYTTZbQbn8UUL/mjbFCipsoKs5VLk8XwRwEJqDieOFZ
         2br9h21lt13EzHT2uov8YVPfwLuuuxx7gqpJm0YW87YyL/ui7yt0/4D7ptgB/CsR9yMF
         shPgFfZJVWeaj5Y/Z/m9XKA2VPb5dCHIvsEOrCgD3WFxToHDdARq0StzAawOARdWrLig
         rmLdvFUxwblNPZBkHvB/IbW2noxBL5RAeCZohzJDv46bWLM0lXYoWYNfhzyRYbjnTKaN
         thkQ3rIYCeX9ruobWXasBbv9BBU58Irx5ShuFF778rFrCVATtMHHcZSKFh2lkNCuQaGT
         wfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aot3ORIQWKklkoQf+YaVDp4V9gsCzqvPIkopUs4mX0=;
        b=QENQwlcKn5M9FJBXJ63fqBM68tdrfQg4u6AonYS91V+aZoge7Dg+AtBKHgJOeZVQBY
         ff1desGtdQNkGEoJxGHfAqUes1eUukGtsFhBlj5aF4axjEu62yQy96vfG0TxmZbpUW69
         l5ilBdTjnSvqeGf2AZ6lc2ZTXPjO8NlpU67kvYjL2Ts88gUz3RXy3MGdhJ7hECz8UuHO
         vS9a6R7iYkEde7rur1ipra4HCDq6bNpBB/FrCYKZI/3njNx3Ee3LuVW7Zwaq2X2r7cYl
         xg0qq6VPcsLUunQS9pVnqWJi/+S1lmzwlKEyaQ38w6U5zmu+AZO07t2mWHCYpkUFalyi
         +dOQ==
X-Gm-Message-State: AOAM530bu1gm1x6YyJVQE+iuPlRG34ycLfOluoS9V3JN0T7vyCHCalPp
        PWWFP/TdPAmTRDBWG/3uCWKMyMH8qropfPNXKH8iYg==
X-Google-Smtp-Source: ABdhPJwc4/l/kg2LjGeD3Jd6MrQBZoVZ0JSIzvE4o2yVcYJFeRaz7+ouc9dM4cVpuLUXXCyFxzmEMnkMbT/8IQImEe0=
X-Received: by 2002:a05:6512:370b:: with SMTP id z11mr1115395lfr.571.1601385316111;
 Tue, 29 Sep 2020 06:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200919021832.191137-1-miaoqinglang@huawei.com>
In-Reply-To: <20200919021832.191137-1-miaoqinglang@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 15:15:04 +0200
Message-ID: <CACRpkdaTRmQat9jejsqgA1PmtOKvndzmAb3qOk5ZknZKoWbidQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] mfd: ab3100-otp: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 4:18 AM Qinglang Miao <miaoqinglang@huawei.com> wrote:

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
