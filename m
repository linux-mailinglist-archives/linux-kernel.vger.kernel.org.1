Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE58F2DB1DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgLOQuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbgLOQtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:49:35 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3178C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 08:48:54 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id 17so6566866uaq.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 08:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpW7F2subR+onTiC3pv9jysqDXaZokb9fXlk0wC3Kt4=;
        b=KeaM2gSSATPK/nSQ/NIlog5AhbFB86RIZ2XDIeCzVqXL3ISYPrIQnZ18VZZvNsLWVi
         il3MyeyQqZ6bzYsYRujhbbFAkOT0KS01039QZIqVMQSdWRw/lL86EjRXHRmLvhe0fXC1
         ITU27NRarj8bf4oQ3P2Jy5PssVv52K4I2SYiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpW7F2subR+onTiC3pv9jysqDXaZokb9fXlk0wC3Kt4=;
        b=QFO+Nj6ZHUfsEQtuYZ2IKE7Z4tptUszUy679ztG9KAvv2FwxHVteY+wJzanNeqXZ0N
         7hf3a+3Kyr5qnsuapvjeyYFr1JXK9eMs1stNKaZKGf74OR+LnxlmzsCU81T6dteQLGxA
         AIz5bUFf7C40z9HmvMV8Bte4TKfB7raehQwOx68pAVSa9tBoY7GxF/2pMTVfJGSOU4TN
         u1VMpCa3pifShdIin5I6oJ7U0jyZFWfVXPUmnyx02lcFAX2yHMF/7LvlhY3iS2SZn/0v
         5qH9D3foR975EDuFJxEGZHGadTeMGBcq1PbQpLMBmlbJOYiwvF2uV3GeYxOrTo40nGXT
         OE5A==
X-Gm-Message-State: AOAM532BapBHuLT5RA8cKKLjD7jqECK1NZxfxKwF7nw/hDtvDituS/F/
        QbYKeOU1uPCJ+lARGO3GSJYrCNe/Hs+4Lg==
X-Google-Smtp-Source: ABdhPJzKhJ6pwhrJxYC0+jQ5EpnRd+eJCj4J/rl7VA7kbevhjRFlmjGEtmAiBDJjXnvb96ccMufsCw==
X-Received: by 2002:ab0:6f0f:: with SMTP id r15mr27342928uah.52.1608050933752;
        Tue, 15 Dec 2020 08:48:53 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id i9sm2591606vsq.24.2020.12.15.08.48.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 08:48:52 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id p7so11332903vsf.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 08:48:52 -0800 (PST)
X-Received: by 2002:a67:bd01:: with SMTP id y1mr22286877vsq.49.1608050932297;
 Tue, 15 Dec 2020 08:48:52 -0800 (PST)
MIME-Version: 1.0
References: <20201215020004.731239-1-swboyd@chromium.org>
In-Reply-To: <20201215020004.731239-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 15 Dec 2020 08:48:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UcpztEGVLoR5ivmP8wHX_V+nWReuL7Bb_rjbiz_F4S7Q@mail.gmail.com>
Message-ID: <CAD=FV=UcpztEGVLoR5ivmP8wHX_V+nWReuL7Bb_rjbiz_F4S7Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Drop pinconf on dp_hot_plug_det
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Tanmay Shah <tanmay@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 14, 2020 at 6:00 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We shouldn't put any pinconf here in case someone decides to invert this
> HPD signal or remove an external pull-down. It's better to leave that to
> the board pinconf nodes, so drop it here.
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Cc: Tanmay Shah <tanmay@codeaurora.org>
> Fixes: 681a607ad21a ("arm64: dts: qcom: sc7180: Add DisplayPort HPD pin dt node")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
