Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D36A2F56B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbhANBvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbhANAKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:10:01 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B66C0617A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:00:37 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v1so2103230pjr.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 16:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=k57ZhRrdloPs/GcEcxbbSOcP9IUvd/QqVLj/vQtWOGA=;
        b=PgROP4CZyTegHbcBGSGPfzlbQ9iKI2HXds7Jv7ExYN4ghND4hn600Tl7055MY/5Mkt
         iL7JRhMLvwikZgba5xx01mAYvFRY7sQnvsHfF9b0mB1BBbifjrCiUrKdfd+Wn/FbMlBA
         NsJwax1laWdmIqQDmj6+/QXl+VcfSjQbhVUMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=k57ZhRrdloPs/GcEcxbbSOcP9IUvd/QqVLj/vQtWOGA=;
        b=Vbeq1+v4QTYjEMT5Kp4pvkpKiS3kL9Tc7/p83bjiWDBE2uv3iD4BJkqYndILMS3i2c
         BtC/aJ/n9Zey+Ij7CFtIrhFJ09sd+t8SBeVsrFWRVecUrg7gEGgLZD34prnh8zjKEkqq
         uvGl+AAuAelg3G0nfvLRIv09TMerrkB72UQAiM1m71qwNKNb8J+7Oyqwdw2GVnOjamoR
         ELOy6BvWwia8E72N4trrSv8b1Yx/i5LgQZvw51xTs5I/BAr19Dex4fpu8IkqgaNn3nk4
         yoNfcJcucW+MUJ7TRAaWRtJK9pk+DWzrhfFHlBbInsOs9xG3eoO15JxIVGWELROqyox6
         5sow==
X-Gm-Message-State: AOAM533SERjIUtqWl3hqTN9XWhyZELFJLswP0iS0c+BH2LxZxbck9Lvi
        LH1o1PPUwwROmoYaR2A9YHMN3w==
X-Google-Smtp-Source: ABdhPJwMhTtYcwAsWs3Qi+OwSYJ2CR9NoQDmaOCjU+lahm8EBylFHvEC6lIxGvYRKNkWIFX4SvYUig==
X-Received: by 2002:a17:90a:9304:: with SMTP id p4mr1854399pjo.220.1610582437210;
        Wed, 13 Jan 2021 16:00:37 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b19sm3591694pfo.24.2021.01.13.16.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 16:00:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b4a6e7695d12c3191bff75668f386da9@codeaurora.org>
References: <y> <1610051425-20632-1-git-send-email-khsieh@codeaurora.org> <1610051425-20632-2-git-send-email-khsieh@codeaurora.org> <161039491877.3661239.1387205899512360969@swboyd.mtv.corp.google.com> <17a116011ae60194834210a4a0c877b3@codeaurora.org> <161056933099.3661239.9450322359293035316@swboyd.mtv.corp.google.com> <b4a6e7695d12c3191bff75668f386da9@codeaurora.org>
Subject: Re: [PATCH 1/2] drm/msm/dp: postpone irq_hpd event during connection pending state
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     khsieh@codeaurora.org
Date:   Wed, 13 Jan 2021 16:00:35 -0800
Message-ID: <161058243505.3661239.4173340912311093207@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2021-01-13 15:44:32)
> On 2021-01-13 12:22, Stephen Boyd wrote:
> > Quoting khsieh@codeaurora.org (2021-01-13 09:44:24)
> >> On 2021-01-11 11:55, Stephen Boyd wrote:
> >> > Quoting Kuogee Hsieh (2021-01-07 12:30:24)
> >> >> irq_hpd event can only be executed at connected state. Therefore
> >> >> irq_hpd event should be postponed if it happened at connection
> >> >> pending state. This patch also make sure both link rate and lane
> >> >
> >> > Why does it happen at connection pending state?
> >> plug in need two state to complete it.
> >> advance to connection pending state once link training completed and
> >> sent uevent notification to frame work.
> >> transition to connected state after frame work provided resolution
> >> timing and start transmit video panel.
> >> Therefore irq_hpd should not be handled if it occurred before=20
> >> connected
> >> state.
> >=20
> > Sure that's what's going on in the patch but you didn't answer my
> > question. Why does irq_hpd happen before connected state?
>=20
> I have no idea why it happen this way.
> during debug=20
> https://partnerissuetracker.corp.google.com/issues/170598152
> I saw two different scenario
> 1) irq_hpd followed by unplug with less than 20 ms in between. this one=20
> fixed by this patch set.
> 2) plug followed by irq_hpd around 300ms in between. it does not cause=20
> problem. but it should be handled in order (after connected state).

Ok. So nobody understands why the hardware is acting this way and we're
papering over the problem by forcing the HPD state to be what we think
it should be? That's not great.
