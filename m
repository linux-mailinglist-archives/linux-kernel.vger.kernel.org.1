Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B8A2F5405
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbhAMUWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbhAMUWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:22:00 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811C7C061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:21:20 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id g3so1724891plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=u6R4AQJwna1Zvnrc86J9azzfneuprQEtwwFsQuVc3og=;
        b=iGXcSZ3vf/7+lrMXeBvMLEppSiK1QOGxXONM1Ag/hWB8KQDBSrKEAAFvMTVAdX8mo2
         904o7LBICMF1rvrHUaBQjuc6HXgMDjU58eUM9Bo7IEbtvn1CjU0CPmJprq1EE7mt5lrJ
         kMGx+WtjLTWHCgokFZwc9UoaNZ94W7yzydDh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=u6R4AQJwna1Zvnrc86J9azzfneuprQEtwwFsQuVc3og=;
        b=siLlUBD5+d1u34Mjvt+S1YLZvNeZE3IXegN5SBPATd1YizPAhn+4cwBXoldcD1m7VL
         +Lykkpwyx2Pr43NpIVO4E5lXCHDY+okFB4OArQMFWsBsGuJzIqDrZ+P59CTPLhXv1eP/
         Bgl23zwDBdq0E3ZBVdzGADYSFIwQmgM03GMMKMbe/LWP+6UBccSwnLMOo+4Xv6aaCWyU
         Eh9o/Um1Rc12llif0gS1LrbGUAdoAQWD4OTUommmopWXjboj5Q3KxVEKvJBygf1nLSKD
         4XgPk856AocO156Uv+exXmeRetnn80sf2qH2fKXoEL8r9D8xHiDGA3/GlaO2iA2JoZJt
         /l1g==
X-Gm-Message-State: AOAM532yhPAGkLqMAKwxkDajWMAsRFRNQhILDlRaidaw+E9eGUW7yyeC
        GyGGy6Z0O2X9Wk0MPrH5VuJpXw==
X-Google-Smtp-Source: ABdhPJxcze093Ox1ieIVbzxnheFHDjdf8Jr9Y7KtYj1RjSs7J3v7DkFm1CU87BqHfMy/L0UhxaPWgA==
X-Received: by 2002:a17:90a:3e4f:: with SMTP id t15mr1038628pjm.57.1610569279973;
        Wed, 13 Jan 2021 12:21:19 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id g26sm3323866pfo.35.2021.01.13.12.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 12:21:19 -0800 (PST)
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
Date:   Wed, 13 Jan 2021 12:21:17 -0800
Message-ID: <161056927774.3661239.6186577459996584479@swboyd.mtv.corp.google.com>
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
> >=20
> >> are valid before start link training.
> >=20
> > Can this part about link rate and lane being valid be split off into
> > another patch?
> >=20
> ok, i will spilt this patch into two.
> I will merge irq_hpd event part into 2nd patch (drm/msm/dp: unplug=20
> interrupt missed after irq_hpd handler).

It looks like Rob already picked this patch up

https://gitlab.freedesktop.org/drm/msm/-/commit/2b5f09cadfc576817c0450e01d4=
54f750909b103
