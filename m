Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D782DFB25
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 11:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgLUKln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 05:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgLUKlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 05:41:42 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3185DC061793
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 02:41:02 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 81so8367538ioc.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 02:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzabDuWmM3g5ZkaOr2QySkn/9M6a1A2MD8omeBNCWbM=;
        b=OoK9GePTmRNbd6WWPi0aUbjvK9fwYRW49mNoUmvsgE0GRxMQ9EjdYWTRQFXzKM6VV3
         TUPCQFzVNsdor9TmGl6s25zqjVR0tRyoOFGzepRpANjqRNGPpNZkR5dhZyH6qXwDgqnV
         hsrh7rL2/eHAijyYeXEEKiy0QDQNjCobg23N39P44MS2AxATpCtb2lejXlhWpHRDQPNL
         8n4qGA7Yll74ppfXUE3eQAQ6KsiLOzCt/Wa3rudRjbJ66veA4Dv7U1d0f0WhPnQxNznf
         jJI3M91U1n8Sk8BIpIMytPZussgTfiEpwjgpDps3qAhEbEFkFtWGE1GnsR5KEuAShxGj
         2ZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzabDuWmM3g5ZkaOr2QySkn/9M6a1A2MD8omeBNCWbM=;
        b=fdzOqc57yqVX3rDms7ziWwq+FjxFCjLsiTKD0Nbkqt5WJI10Jlv3SKcsDETOODHYas
         ZBSd8GcKGV9/r2dPQc4dC6cujmJVQpo2cK9Jr/AUXWPzv9oPjrJ3rvfRCkd8aa+NvXcc
         XzaxC8PrQaLxjUF4rp3EQjwZ17Ti5KFt2G/hgQkhDyiwPeg4s/ZzDq5uiphwBc3lv0Ow
         wEacaQWdNmFChuB028b3w6No/DLImZR4bg5l9gHmIcw5yB4Tf07npa9oPJRz1Bs9uQxY
         6rzW/MP7oCbIjN7w2O88BcQRwUduToNpr1SV9NYyJtthkB3Rjd14i1JkjS8myb2wBLGK
         eZVg==
X-Gm-Message-State: AOAM530qEiqBd8W+Isekt7Kek7sPX0SNwiyVZKbwjr7PM9RahF7S57UQ
        boTUTM+Mn11A7aeqQbuHVAM5LF6qJnGXg1KcP2FfZw==
X-Google-Smtp-Source: ABdhPJyFQyl1t0H4p6tZG/o1SwqRmGMAx0ZxPSCwOV7m56OEBD7j9iKK9VmxZJ3e+OwcF6LCmRCkuR8LP/mn38i3NyQ=
X-Received: by 2002:a05:6602:2b01:: with SMTP id p1mr13586508iov.156.1608547261441;
 Mon, 21 Dec 2020 02:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20201221095820.27192-1-stanimir.varbanov@linaro.org>
In-Reply-To: <20201221095820.27192-1-stanimir.varbanov@linaro.org>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Mon, 21 Dec 2020 18:40:50 +0800
Message-ID: <CAAQ0ZWRU71ayBKQG3956XqEBkOmwjKi4LE8_OH=YYZ9LFbZB5g@mail.gmail.com>
Subject: Re: [PATCH] venus: core: Fix platform driver shutdown
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        vgarodia@codeaurora.org,
        Mansur Alisha Shaik <mansur@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 5:58 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> With TZ system reboot cannot finish successfully. To fix that
> enable core clocks by runtime pm before TZ calls and disable
> clocks after that.
>
> Fixes: 7399139be6b2 ("media: venus: core: add shutdown callback for venus")
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

It fixes reboot on Lenovo Yoga C630 laptop for me, so:

Tested-by: Shawn Guo <shawn.guo@linaro.org>
