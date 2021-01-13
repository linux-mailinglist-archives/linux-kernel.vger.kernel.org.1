Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D1D2F5409
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbhAMUWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbhAMUWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:22:53 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801DCC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:22:13 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id x12so1706480plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=uYdhB/IsYvawJycPiJl/5+j+upKU06AcD0VCLNhUlaw=;
        b=Rnw8wZNgL/NU7d2j/IIT/v+xRriznTX2qmL+omKVWccZWTvuTw7vDiomDS6UqXCVtu
         RDi9A8BkpwgPlvTPdfZPVe2go7pOrs5TIR1bdHo9kHujsG0rM7sKTOUJ+lm0Y8jnkZBb
         VFVtI49gAXxI3why8VhPZj/v+9SFTgJJD2Q6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=uYdhB/IsYvawJycPiJl/5+j+upKU06AcD0VCLNhUlaw=;
        b=IutSo9qsxtZQAe0Z8m47ZVVz4t2meTmm4dVvwDimkpruvSExJvyhxF2kJBnPCr84DD
         oCQPGkpW6wwQG7PQVVL5jUquWyy2Qdi94DBnx2kbP5txYvq2kEIec97GVyDHjk/QFHCF
         ZCRUxewHAPVDIIbzT9Z12+XUcUrjA13MWq2dPjteNABjMQOEyHFzaOsDRW4YbRN7RGkh
         cP6Y4JBKquS8kpm5lMq1ccIlS1swm3KQ1LazxnAiPmShGqnQgqOHGPldw/9oCR2ffxUI
         rIk+yPNlFSyPE8r2pkufBGnQrVf0P2Wl+RH4aLo7QJUtSGltQHQG8UNy19nkE5KNMwqW
         Wo/g==
X-Gm-Message-State: AOAM533GRnzXLEavGGrzMOL7Z+HSQyYRVWnDd25uf74mM/ZZtcLPdgCr
        3EHp8tLHg0vW9AkVK0Hp+Ulyug==
X-Google-Smtp-Source: ABdhPJyBYSOo7yqM0F3+0FagAGnq8EmkmQDZ6U/aCeqO+pjCFDUxsNUGyXyAWMpF2WReDekTNDdTcQ==
X-Received: by 2002:a17:90a:8985:: with SMTP id v5mr1011035pjn.27.1610569332989;
        Wed, 13 Jan 2021 12:22:12 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id l197sm3488968pfd.97.2021.01.13.12.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 12:22:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <17a116011ae60194834210a4a0c877b3@codeaurora.org>
References: <y> <1610051425-20632-1-git-send-email-khsieh@codeaurora.org> <1610051425-20632-2-git-send-email-khsieh@codeaurora.org> <161039491877.3661239.1387205899512360969@swboyd.mtv.corp.google.com> <17a116011ae60194834210a4a0c877b3@codeaurora.org>
Subject: Re: [PATCH 1/2] drm/msm/dp: postpone irq_hpd event during connection pending state
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     khsieh@codeaurora.org
Date:   Wed, 13 Jan 2021 12:22:10 -0800
Message-ID: <161056933099.3661239.9450322359293035316@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2021-01-13 09:44:24)
> On 2021-01-11 11:55, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2021-01-07 12:30:24)
> >> irq_hpd event can only be executed at connected state. Therefore
> >> irq_hpd event should be postponed if it happened at connection
> >> pending state. This patch also make sure both link rate and lane
> >=20
> > Why does it happen at connection pending state?
> plug in need two state to complete it.
> advance to connection pending state once link training completed and=20
> sent uevent notification to frame work.
> transition to connected state after frame work provided resolution=20
> timing and start transmit video panel.
> Therefore irq_hpd should not be handled if it occurred before connected=20
> state.

Sure that's what's going on in the patch but you didn't answer my
question. Why does irq_hpd happen before connected state?
