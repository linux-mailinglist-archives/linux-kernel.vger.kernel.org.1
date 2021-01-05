Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F53D2EB5E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 00:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbhAEXHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 18:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbhAEXHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:07:30 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B61C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 15:06:50 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id n18so476418ual.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 15:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TBITFTqV6PffwXxlyzM4ancQolf5iif5eFpCVo3z2EQ=;
        b=kOZclM5WFOaKzW+8A3iRvt0N9DiusMsfk4m3ba9rJtPyG3wjbg29HXpHaYs5+1iGUB
         zftwAhc4QqiZNMASTo0yA+ExTzZ7eFf/lOq4EIi0VRJDmtmwPWfJrxv5VeDTH9cXAp3T
         i4b6ss1fNuCVXmAtXTKORygfcZUOz1Iu9QO2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TBITFTqV6PffwXxlyzM4ancQolf5iif5eFpCVo3z2EQ=;
        b=UqEiH8MJmWLlo+lYtaCH7FmdohXKsf6Z1hQwsJAcgxpplIMkooRsp5rwG4dfK2pIZJ
         Hlu9eeRbJiGTUHhdOJiKk/SL4Ta2HfB5JHhd6Jf43lHSGTldLWbjrNal9ZwbPVFVeFZE
         eJHQDjvGL0B+BdGCRYR87w+fhtOfO4uqNDh866d2nbySUSNDv6C9scyg4KSsSS0FYfWq
         ScHRoae7zB4BUHWunyn1Cyg4T9TjwDD09NSPGHDJ2hfctEYtqPSKEV1vfwHw5EYXZi09
         hcHY906o6yiZtD6+rg94GvBJAQftZLQbC5434pBhHvUIydVwfaxAKPDNduA6z9uycdg2
         057w==
X-Gm-Message-State: AOAM530sqbbQXGvPiIeEg2MT/DvW5G1dZfmHSJE8r/F7hYXnB4MUfBDT
        l8COou4kUm7ohGUoqePhZ6/1p7TNcoDpxg==
X-Google-Smtp-Source: ABdhPJydp96/Tyb3jHsp3WY0DcAHp3vXQXPy2930IiH7zjcmtbq1SevnQRWjX3gQeMFAkrBYRfDhUg==
X-Received: by 2002:ab0:43a1:: with SMTP id l30mr1537604ual.126.1609888008938;
        Tue, 05 Jan 2021 15:06:48 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 13sm136775vky.37.2021.01.05.15.06.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 15:06:48 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id u67so380999vkb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 15:06:48 -0800 (PST)
X-Received: by 2002:a1f:4582:: with SMTP id s124mr1533105vka.7.1609888007477;
 Tue, 05 Jan 2021 15:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20201216071926.3147108-1-swboyd@chromium.org>
In-Reply-To: <20201216071926.3147108-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 Jan 2021 15:06:35 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VZ7BPw0=_3mfLYmO+kUDLbOfxy=wzH5Vnff=MiGP5oVQ@mail.gmail.com>
Message-ID: <CAD=FV=VZ7BPw0=_3mfLYmO+kUDLbOfxy=wzH5Vnff=MiGP5oVQ@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: socinfo: Open read access to all for debugfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 15, 2020 at 11:19 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> There doesn't seem to be any reason to limit this to only root user
> readable. Let's make it readable by all so that random programs can
> read the debugfs files in here instead of just root. The information is
> just that, informational, so this is fine.
>
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/soc/qcom/socinfo.c | 40 +++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)

One worry I'd have is whether there would ever be any PII (personally
identifiable information) here, like maybe a chip serial number.  If
so, is that something that is OK to provide to any random process?
...maybe I'm just being paranoid though, since presumably there are
enough random HW characteristics that could be strung together and
hashed to make roughly a unique ID anyway and hiding every HW
characteristic would be a bit extreme...

-Doug
