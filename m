Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036D22C2F65
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404047AbgKXRzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404001AbgKXRzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:55:50 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD55C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:55:48 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id b190so4961931vka.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASb49GMgEQk5JUxUZFVOUivC69eYey0JM4nqNA/W1FQ=;
        b=SJ82uvGUhVyRpvlEm0DW8ZjBfkucQNAdh1ODVXCMTEVB/n47PNRWRkHissZ34gBQLZ
         IVFdQU4/UbVOnKnxxklVwVwyewiOXGlngAWBsqPCyo/lpxZf+ANvLWHkXwG06EzXKj4M
         7XTCjcAIaUtH/njdxeUlzGEAUqHkm3CSUVrxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASb49GMgEQk5JUxUZFVOUivC69eYey0JM4nqNA/W1FQ=;
        b=j1IqAtDyX5ebHcLGGJ2rWefWIRbBxo3PcBs7UAMvXvZD2twkePwtjc73ORf5WRf8nj
         vSSfFJK3u7iNg7i1gq1iv2oYNaDPwQMPyeTo3JFu93csMcJg8tGmkRwDx0cBHZ7117kY
         d8sbHKnYEtKWbTzMQwPFjPPs2nTXdHiag28nrb1NE4OO/C2Xm91nUaSzzoQ2cl1QrrD5
         PW371DrW3OdG1ZSbR2sf1PC0z2Pv8Ch0pWrn69MNvBP1iksR40wfF0sv6pwZowj7vuV3
         uqjNqVLIEvKuxIh3c4M49TzkIkMbW6skTwyHhM3TzvXTljLfinaHBXYfQ/C2Cv+DFKj2
         +yFA==
X-Gm-Message-State: AOAM532Ni0l8jz0/Gjst8swcn478fA9dMoHMvD5v9owhNeTIaNJKp+hv
        9ImOc+wIbO+dKodLHlqBG11aKcM6tkBLGQ==
X-Google-Smtp-Source: ABdhPJwWikEtxhG2+G5GxSAbtfzVB2PJYV3vn3OYDSbDMprhyZT+G4fEKIddzYICfj796AtNm+wveg==
X-Received: by 2002:a1f:9889:: with SMTP id a131mr5042371vke.15.1606240547394;
        Tue, 24 Nov 2020 09:55:47 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id d132sm1457275vka.1.2020.11.24.09.55.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 09:55:46 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id t15so7103871ual.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 09:55:46 -0800 (PST)
X-Received: by 2002:a9f:36a1:: with SMTP id p30mr4817290uap.64.1606240546042;
 Tue, 24 Nov 2020 09:55:46 -0800 (PST)
MIME-Version: 1.0
References: <1606198876-3515-1-git-send-email-sibis@codeaurora.org>
In-Reply-To: <1606198876-3515-1-git-send-email-sibis@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 Nov 2020 09:55:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XpX3zq-rzMNE8f7mZEWBqD1aOrCekzwzugdG7ANW9j-A@mail.gmail.com>
Message-ID: <CAD=FV=XpX3zq-rzMNE8f7mZEWBqD1aOrCekzwzugdG7ANW9j-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sc7180-lite: Tweak DDR/L3
 scaling on SC7180-lite
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 23, 2020 at 10:21 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Tweak the DDR/L3 bandwidth votes on the lite variant of the SC7180 SoC
> since the gold cores only support frequencies upto 2.1 GHz.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>
> V2:
>  * Updated the lite ddr/l3 cpufreq map to have better power numbers with
>    similar perf.
>
>  arch/arm64/boot/dts/qcom/sc7180-lite.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

I certainly don't love the way that this works but it does match the
way folks have agreed that DDR bandwidth votes should work.  Long term
it feels like we should re-think how this is working, but it seems
fine for now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
