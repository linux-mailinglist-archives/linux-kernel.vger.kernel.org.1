Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D1C2DDD21
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 03:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbgLRCzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 21:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732637AbgLRCzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 21:55:14 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A469EC0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 18:54:34 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id iq13so515565pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 18:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=GwED+zkYeoip+RZibjgPn/mm0NWtqDJz8jS6yQF5rtQ=;
        b=Fjz026Fj+U+yopuLKa45dVwvE/dvan9ptbFl1JEDmh73VydkBs3d9049RmEvb5SjFm
         lHP98SA3NwDtndnopUn4/776YqRPA1ZWq6W6c9HA0M22XPPT8KPuko4N9GZfGUtSBr5J
         +LY36YGJDF7XpjjHObtWawr2j+5Vv5xuaegfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=GwED+zkYeoip+RZibjgPn/mm0NWtqDJz8jS6yQF5rtQ=;
        b=N6/fA4Gyt/f4Vg2mdIgm6rkGyQ60KLo4mz5gP4727KNRhklPYT5TeCnVVSPZtBbE1/
         6I6BxwkVWix9jyHJqWOwTwrS0oWHouoYydql5fIn0NRyWPfNBoeWigL4j6rcTnwFdMSr
         FDPP9n8xqVwReL2MdR4Qe53rnosJma6u95TWqIDiKac82hVA0SoECYmIgvXYvTOQ3mHp
         nDrrfcFbDtWnMJJgWBHPfwsg+0SsGEiMbrSRv/ag63xRmtqMMXdVgLo3CcAptngv+C4s
         pZ8p8qjN32qWLbY5odbPHq0YgPXLb34TxM8Tdqds7MrR5xGbxpXKMNt+1EaZ6I7ePWj5
         E6pA==
X-Gm-Message-State: AOAM531oi3cCm5u7F28FI9TLr1O/YmzVNGoWlFdIaf26dsaAAQgpXIoz
        aJLORm3KbQlGxI4406qmLzZTpA==
X-Google-Smtp-Source: ABdhPJy/B+rPaUdHI8pBnouZyK0jvxnhdNkswCz1agyWTg/Di2JurWpyCScgEsiAmXNZh0Hyv1Ex2w==
X-Received: by 2002:a17:90a:f194:: with SMTP id bv20mr2195451pjb.11.1608260074306;
        Thu, 17 Dec 2020 18:54:34 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id l197sm7099056pfd.97.2020.12.17.18.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 18:54:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201217142842.v3.4.I666b37646de9652cef438ac7c2c6c2053367fc6b@changeid>
References: <20201217142842.v3.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid> <20201217142842.v3.4.I666b37646de9652cef438ac7c2c6c2053367fc6b@changeid>
Subject: Re: [PATCH v3 4/4] spi: spi-geni-qcom: Print an error when we timeout setting the CS
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     msavaliy@qti.qualcomm.com, akashast@codeaurora.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Thu, 17 Dec 2020 18:54:32 -0800
Message-ID: <160826007235.1580929.15942404538098977025@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-12-17 14:29:14)
> If we're using geni to manage the chip select line (don't do it--use a
> GPIO!) and we happen to get a timeout waiting for the chip select
> command to be completed, no errors are printed even though things
> might not be in the best shape.  Let's add a print.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
