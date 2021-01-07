Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0607C2ECDB0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbhAGKVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbhAGKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:21:17 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290AC0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:20:36 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o13so13424769lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2Z57oRMgV8H88lmGxyt0IypANIWalVTfC1aYe8+U1E=;
        b=f7qxYMqodMyFWwyVKPQ+maYWvU8LpydxglZmjVFt3/Kquj/mHL+kueWogIW6L2gcah
         ye3O3WW8tcxVf3oUi0fYW7TR8p/uE34HSCZMhMAkGOBpq3hln5Y0CNdu49RvrcAb9JqN
         9ppkQZ1LmCJ8zTxQNFwJOtSlIVevjk4J6XoZPunGxYW515QV6Me08tWGH39HrPDA0Ni/
         xjjCKVtqgpr6j7aquek0eeM7nMZbGKIRZ3aZmuXqtkVArX3tlWACRSdXrx5pij769YTh
         KdCCfV7uZRdOHu7AHpXhuQ7EuB4XcLH1mMxOPbpcZUIvqoZsPLWkZNL0my0SLnP4H8Tr
         GEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2Z57oRMgV8H88lmGxyt0IypANIWalVTfC1aYe8+U1E=;
        b=lNxo5ahRUKpkpugNthjPf/RNiAb4XvLB03zumQle9mWVEFzWZBEBoEdKiNO4rFGbmn
         h+FLUSKCfSQ7qrffTliVYDNp1NYgYEcwI5Do77djI0qvGxQEJABs9cGyooIfVvkLAGrr
         13CdwdKWgHoKaaaPYpAppT1FupJabobm8M/lVjWjNgPUIv/NN7+kb3/twac0wOq5ILpS
         i0ucsA6JqO6hzzEWmAJHwfHiA93q4LYOt8nJQ3NaeQhacntLimmK6WLSTyuIXkSb2drv
         hC128iYfT2YYx0L5U5LwvQ+RHuHo9UvZooYbNqprb9O30+zGuowLK7FNoWlv+x2ato1u
         bjgQ==
X-Gm-Message-State: AOAM531pXsAGE8dwXOHaVPoQys9HGZmgLWuYv/+Snwv2H1OVQ1pkjsEL
        L9ypuh8HBrwKN272hmQ1nuDUAwPwOxO5HZvDocbQAQ==
X-Google-Smtp-Source: ABdhPJwnnQx19Mo90ktD1Q8381IfaNNjXYuZsfi7Y3OQQgvakpwZvbD9A7VAn4LYqVC9tDW7g/HZ9ehaM3xPA2do1NE=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr4045386ljj.326.1610014835410;
 Thu, 07 Jan 2021 02:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20210106131908.584-1-zhengyongjun3@huawei.com>
In-Reply-To: <20210106131908.584-1-zhengyongjun3@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Jan 2021 11:20:24 +0100
Message-ID: <CACRpkdZHuNSaox+GWpk5A_+y-uqAN88eomCNfYerjOA_RiaF+g@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: vx855: use resource_size
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 2:18 PM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:

> Use resource_size rather than a verbose computation on
> the end and start fields.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

The commit message of these patches is obviously wrong.
Resend all with the right commit message.

Yours,
Linus Walleij
