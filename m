Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7410F24A773
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 22:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHSUHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:07:32 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE78C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 13:07:32 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id q13so12599106vsn.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 13:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qeG68/iGaDfUT5GNDRtXeBjtRxO2lzb4494Br3HhoQ8=;
        b=nth9Ndu3BBX7zAieFztilD8MMhjA3cdKplDrlZ5W49D+qhHUXF16NTrUFVUtNZIS5h
         nrjyXqD0UKvz/RmioArJ9MppfKV1DecA3144QIXSTdy70+pM6+C0j1wW1xWuwQI0vTGk
         xwDrfNSyE9v1KWX6aTq33r618HHrmZ26rfI20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeG68/iGaDfUT5GNDRtXeBjtRxO2lzb4494Br3HhoQ8=;
        b=CJG9hVUtUQCntZnwEYhTC9OQ7xiScjh9gHZtlXrfmaxT2J8XuTlhyX2heTqh8p/BTP
         d1aT57ZzDx5j58fXOwTOuJyRxMDkYaD3qywnGXxUowpEqKpZtWssqfua9EYCl4CZlcjX
         C6Z1z2buHhKkz68cp0BWN4YP22UfN1w6Df7DX20W13JvS+HDBZkfyxCwQ/4emo8g+jR2
         DEKb2IF8uB3KlYu+PU2zDEg8HgSlz/WoohKUif2hU4JKsBlTtBW4V4YpA716+Tay9Evm
         OdnpsIr50MnBZlggBmQG+wrOb35MAi4o3HhpX08M7KLEBhFwuBJ1sEOONSOg/YDalD+Z
         1ucw==
X-Gm-Message-State: AOAM532YPgWdIRKQtquFD/ogah7RvcAbloJkNOUqKkJdAvIj57lXYDnm
        Atr1kWdRGG2aMggMqQ730gtIiizED4jCfQ==
X-Google-Smtp-Source: ABdhPJyGsr3u+oFr2ePkN7DFvOpfeyqzSJLaCjQLmTB2zUgFKbS9L9qTcwXo7NLW3vo5bQYBocmX9Q==
X-Received: by 2002:a67:f709:: with SMTP id m9mr35301vso.82.1597867651050;
        Wed, 19 Aug 2020 13:07:31 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id t191sm4983660vkt.46.2020.08.19.13.07.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 13:07:30 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id j188so12625839vsd.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 13:07:30 -0700 (PDT)
X-Received: by 2002:a67:fd67:: with SMTP id h7mr14388451vsa.121.1597867649964;
 Wed, 19 Aug 2020 13:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200806163126.22667-1-georgi.djakov@linaro.org> <20200806163126.22667-6-georgi.djakov@linaro.org>
In-Reply-To: <20200806163126.22667-6-georgi.djakov@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 Aug 2020 13:07:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UBhxxd2zc6uu7z7LDc7q5sfVRONuJZXQrwKjZYuyMy=w@mail.gmail.com>
Message-ID: <CAD=FV=UBhxxd2zc6uu7z7LDc7q5sfVRONuJZXQrwKjZYuyMy=w@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: sdm845: Increase the number of
 interconnect cells
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 6, 2020 at 9:31 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Increase the number of interconnect-cells, as now we can include
> the tag information. The consumers can specify the path tag as an
> additional argument to the endpoints.
>
> Tested-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 44 ++++++++++++++--------------
>  1 file changed, 22 insertions(+), 22 deletions(-)

I believe you missed updating a few places...  Fixup can be found at
<https://crrev.com/c/2364731> or look carefully under "ipa@1e40000"
and "gpu@5000000".

-Doug
