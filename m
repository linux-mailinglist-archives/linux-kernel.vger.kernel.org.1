Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279AA2F8A1D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbhAPA60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbhAPA60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:58:26 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89FCC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:57:45 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id 186so3577145vsz.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuO5xo5F20WS2U3YFOHP5hzwzCcypzAVBEVyMj1tuRs=;
        b=OB+wZUB9YCSSH8DkArXCN8GMeoKn9Ss4CIXEwJEz/SZ1dyA/ZpeQox+8u1nKtY+EKN
         IjzOkD69Egtm6f+ow9+DVBsJXUwIe6AFicqRZY41ChVfu06/rWn8lNBrsCSpSPB9dOMz
         RBbIGXAhO3E6WzR6Eat8ofB3SBNrJfJ2d20Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuO5xo5F20WS2U3YFOHP5hzwzCcypzAVBEVyMj1tuRs=;
        b=YD/OrgaEG+SAaWeGJRZlCkEJKaNzSJp3JKugObXKQEIXrTzUDZF6FTiQIYcEigZADH
         GyzyL95LqqXBCxxbVAVcalaRJ7EIs34n3hYJMD7OK0nAk8wZbgJOEXarrLMYwGCMf0sV
         Jv2hNCg2cMX+Dqs9SsAvQFY8PZ8Tpbr492bnnhlRu06YIvcXmO0xAAxIe4CzfNrGKcTn
         iEQCieEc4d3g1RCKgAAOenUYybitbfTSNfENaAVj2ss0vKIzppOw2+stS8S8tqWUPtDt
         UzXYsZjro62z5ZtBxHGDZVPCQ5mSpIrN9NkU8IDEOva8F7VuSFILZleXszvZyNeCPF+B
         eT2Q==
X-Gm-Message-State: AOAM533kdA+Zc7DjStHASCTojIzu2yXwCk3v2y4J7XdtprD86HKQTead
        SuOhmDlMxzP3Ic9g10Ax2ExbE1nRkK5X/w==
X-Google-Smtp-Source: ABdhPJz1NDvrUa7cL9tKwgib8FWdF5kQ5IhnQ4nglKqPYS56r3Dfs9hfsvABfL126Tzsu2D9ZDjYdQ==
X-Received: by 2002:a67:18c6:: with SMTP id 189mr12552052vsy.54.1610758664779;
        Fri, 15 Jan 2021 16:57:44 -0800 (PST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id y2sm1494109vkg.47.2021.01.15.16.57.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 16:57:44 -0800 (PST)
Received: by mail-ua1-f49.google.com with SMTP id i25so3521883uat.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:57:44 -0800 (PST)
X-Received: by 2002:ab0:2e99:: with SMTP id f25mr12091635uaa.104.1610758663654;
 Fri, 15 Jan 2021 16:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20210115203951.850873-1-swboyd@chromium.org>
In-Reply-To: <20210115203951.850873-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Jan 2021 16:57:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XGajtxTo1wNk1iDj_17F0Ris1A5fdwtJkYRUSjMkXb7A@mail.gmail.com>
Message-ID: <CAD=FV=XGajtxTo1wNk1iDj_17F0Ris1A5fdwtJkYRUSjMkXb7A@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: socinfo: Don't print anything if nothing found
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

On Fri, Jan 15, 2021 at 12:39 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Let's skip printing anything if there's nothing to see. This makes it so
> the file length is 0 instead of 1, for the newline, and helps scripts
> figure out if there's anything to see in these files.
>
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/soc/qcom/socinfo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
