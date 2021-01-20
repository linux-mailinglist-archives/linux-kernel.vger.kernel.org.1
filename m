Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF12FD5A3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403897AbhATQ2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403994AbhATQ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:26:50 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E62C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:26:10 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id g13so576651uaw.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VA3sevNOG9LLzIdGtexh/+cDQStXz1NVLJUbTaa/OpI=;
        b=XqHtcC1Cu+MW2ZiMfGVlGOQfR0LPyWWzi5zKLqS01utd6G69mhKg9C0CV4ZI0McEbv
         CSg7aZXht+OcOyeAmNPQMaBsN2VzhaPNVYuP5qT4pckI9GKBN60qMdtolLmElgTe5Xol
         633w5+Z4SJCMYCOPmES8Zy3+SQdgwmdr/qrXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VA3sevNOG9LLzIdGtexh/+cDQStXz1NVLJUbTaa/OpI=;
        b=UxHX39EFlMkGsBNSCtgmL7Q8AS/37S46Yl8g4aXB4qToBmhAB8ITqR0EoXxp0w7AUh
         kEETFRc8kZRfS19flVn9tGe2l4d2lcqxXhdVWCHxyq+x6a5XGuS1HQdB+Nz1NQlgVXom
         foPEL3gwXg5b+8k2dYCpDqLXWC6Ct/yTaswb73thQ8vgqE6z/YkcoylVYJ1XNKRpZFFU
         1VduAD6HDlgMuWX1XwbxeAssuim5zzAZWawIAuGk7XF7S2CdFUeq4iuJPbmJ9c3DNEp5
         ERO0nXeXodlkcRcL83ge2uNar5HVXGRjhGWigAwzCCQZ06B/H3XakwO/S5evKy2NfNNN
         9s3w==
X-Gm-Message-State: AOAM533nn/hFHpBXmKaSFP6gzbUlkPRa9/bi3aj4W4WuqFDfXfaqfvq0
        suTRh7hwhyhFOq85Ys4tU//QA+6Y/WyCNg==
X-Google-Smtp-Source: ABdhPJyMCGkFgkukNC+zpLZrfRAN5HA/USIhYcjZHtQPJosF+31ke1uU8ZlET0iB3YUctHrvB+bqKg==
X-Received: by 2002:ab0:2549:: with SMTP id l9mr6670123uan.128.1611159969067;
        Wed, 20 Jan 2021 08:26:09 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id i17sm352801vkn.38.2021.01.20.08.26.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 08:26:08 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id p2so8044021uac.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:26:07 -0800 (PST)
X-Received: by 2002:ab0:6454:: with SMTP id j20mr6909033uap.0.1611159967277;
 Wed, 20 Jan 2021 08:26:07 -0800 (PST)
MIME-Version: 1.0
References: <20210118113651.71955-1-colin.king@canonical.com> <YAf+o85Z9lgkq3Nw@mwanda>
In-Reply-To: <YAf+o85Z9lgkq3Nw@mwanda>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 20 Jan 2021 08:25:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XMxHCs5bvjPGjENL2Sty=AD6CS3jYnESDG+qKJdiMU+Q@mail.gmail.com>
Message-ID: <CAD=FV=XMxHCs5bvjPGjENL2Sty=AD6CS3jYnESDG+qKJdiMU+Q@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: socinfo: Fix an off by one in qcom_show_pmic_model()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 20, 2021 at 1:58 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> These need to be < ARRAY_SIZE() instead of <= ARRAY_SIZE() to prevent
> accessing one element beyond the end of the array.
>
> Fixes: e9247e2ce577 ("soc: qcom: socinfo: fix printing of pmic_model")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/soc/qcom/socinfo.c | 2 +-
>  1 file changed, 1 insertions(+), 1 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
