Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4E32CE072
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgLCVQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgLCVQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:16:52 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5AEC061A53
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 13:16:12 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id q68so1166339uaq.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 13:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KpAV3MXS1o8rezasMM1Hu2p6gpTsqQSOsJaHWo/0vNc=;
        b=CEW9JBOOzh0F3Klkaa8Ir1OYxinBKR2N0KYC7/LeFAu6hJ/PfFv6zSzHzkbvPM0Rsp
         FYJJxYgsOz5ccvJBw81HJx1G+wgvIWsg7Kj2utMJeuJbg31XpQMoS6VxpTcuizayosBD
         MI5SmDm7kho6G7ns5Z1UIBR0lhFUyI3ewAmNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KpAV3MXS1o8rezasMM1Hu2p6gpTsqQSOsJaHWo/0vNc=;
        b=PlQhhtlUS5q08NXqT7lt14O71bZh315KiK2wQYoTXV/dJJ5c0/X1edaApnew84BeA/
         k48q2fwr0452awMY2Wtiyud3eUdfDQIjPG3xJSBjrf9C4YSecw07OrR1+8O0uxQOhmsa
         IWI+KbgJCOP8CWGHtMWMsMugZ5bmNzI3ACg50IpVOt2DsZ5SNVw7ri/ytAUCWx8XkNNx
         C/Hu4HJVYuUN6HZf/62S2yA31xzActNRqklmYpYLPVcpkfailsBuxwPKSX6nTA6YIOLe
         9iIAuGVthFIIXw7WmmdrgOPWAFklNgtQ6/tOqtktO0Nve2ZcEUfj4uA/yY63cGYDkbJo
         LUwg==
X-Gm-Message-State: AOAM531LDkeogUk1WA22eUCtXj4iTkAuVwhcF5s22w3TP8RWkej1WUtz
        0EvySxjf2bZfxdZJRDch4FV1fCRVhrb2yQ==
X-Google-Smtp-Source: ABdhPJwvRLTD773mJSvP5UiKMkCqhSE0nGyDLVzNxZ7FU5ztU0xfvCpS2LUslcO0GzmpeT67H1kYJw==
X-Received: by 2002:ab0:2898:: with SMTP id s24mr939427uap.124.1607030171403;
        Thu, 03 Dec 2020 13:16:11 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id f1sm105751vkh.12.2020.12.03.13.16.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 13:16:10 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id z16so2090016vsp.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 13:16:10 -0800 (PST)
X-Received: by 2002:a67:8c41:: with SMTP id o62mr1300593vsd.49.1607030169919;
 Thu, 03 Dec 2020 13:16:09 -0800 (PST)
MIME-Version: 1.0
References: <1606211610-15168-1-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1606211610-15168-1-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Dec 2020 13:15:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xk_1=eCvqLPPnYLrQWf1zVy+iEHs=DWEubb6n5ub3Wxw@mail.gmail.com>
Message-ID: <CAD=FV=Xk_1=eCvqLPPnYLrQWf1zVy+iEHs=DWEubb6n5ub3Wxw@mail.gmail.com>
Subject: Re: [PATCH] drivers: qcom: rpmh-rsc: Do not read back the register
 write on trigger
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 24, 2020 at 1:53 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> From: Lina Iyer <ilina@codeaurora.org>
>
> When triggering a TCS to send its contents, reading back the trigger
> value may return an incorrect value. That is because, writing the
> trigger may raise an interrupt which could be handled immediately and
> the trigger value could be reset in the interrupt handler.
>
> A write_tcs_reg_sync() would read back the value that is written and try
> to match it to the value written to ensure that the value is written,
> but if that value is different, we may see false error for same.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 658628e7ef78 ("drivers: qcom: rpmh-rsc: add RPMH controller for
QCOM SoCs")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
