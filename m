Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049B128DCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgJNJUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbgJNJUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA42C02524B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 17:36:55 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id j8so539502pjy.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 17:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=9imkWvMot1MzH+ehLJwgyaxPJxuOFrOphid59RBNFTo=;
        b=HmED74OGfPJeiSnehPVeZnQq0lW4FvMWAIKlf6FYb2rHCFz01nDI709PwTOJWBOj/0
         MqXvSM8QPTAfDM0pB4JgvphWDxwGWuejZM0o8302Eeidj20nyPmXqdAJwiviFChpfl/v
         s9g+sRDQ98tTWvQF3cB4/9eQhNX2CD4UTJsuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=9imkWvMot1MzH+ehLJwgyaxPJxuOFrOphid59RBNFTo=;
        b=UnwLjtk4Z5VnJBH9Us95g77O8ujvx9Yg68QaoTRkkDtylbYWmIiDWmrNWS8EH/9H9n
         y/SAhgNQY67yplwJ6wO6vsnZ6b64HLZM9c40ayKvK8RTs83h4tX20b3LyyU+HXTlnVUk
         TSkUTQB14eAPcUM3J/KEj9YnS2wcYAArQbNjfR1Tp2rVeACv3VKdXQt1dLSiE9j2tbnF
         RAvJPfhUkpph2rygzmHz8QhasRbpFDMcXg+f+Df+wWJpe/f+2cxqleSOVo+3M5yEjIaW
         OZa+O3x53lMG2uYrvsI3rw0REgsyaYJPdH+QgfwZi2ZYu7pQJ/szPJjL81rkUOgFR+2M
         NJyA==
X-Gm-Message-State: AOAM531waKwKXhCkYyAds9MuTB/QQKyhSJxELrnu7DJi6pPBMuGTh7nW
        43i5cKvLjzIApNCqQKwNbboqyw==
X-Google-Smtp-Source: ABdhPJz//cpuLR3q6+8Xtvz7MFQA92okbEa8Sfnd9VzfzsJ3RYQ0rokXMZ0mF0DjfGRDqJuhhbjOPA==
X-Received: by 2002:a17:902:708a:b029:d4:cf7c:6c59 with SMTP id z10-20020a170902708ab02900d4cf7c6c59mr2262370plk.52.1602635814708;
        Tue, 13 Oct 2020 17:36:54 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id w10sm455476pjy.13.2020.10.13.17.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 17:36:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201013233522.5222-1-khsieh@codeaurora.org>
References: <20201013233522.5222-1-khsieh@codeaurora.org>
Subject: Re: [PATCH v4] drm/msm/dp: return correct connection status after suspend
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>, robdclark@gmail.com,
        sean@poorly.run
Date:   Tue, 13 Oct 2020 17:36:52 -0700
Message-ID: <160263581242.310579.522359444728182805@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2020-10-13 16:35:22)
> During suspend, dp host controller and hpd block are disabled due to
> both ahb and aux clock are disabled. Therefore hpd plug/unplug interrupts
> will not be generated. At dp_pm_resume(), reinitialize both dp host
> controller and hpd block so that hpd plug/unplug interrupts will be
> generated and handled by driver so that hpd connection state is updated
> correctly. This patch will fix link training flaky issues.
>=20
> Changes in v2:
> -- use container_of to cast correct dp_display_private pointer
>    at both dp_pm_suspend() and dp_pm_resume().
>=20
> Changes in v3:
> -- replace hpd_state atomic_t  with u32
>=20
> Changes in v4
> -- call dp_display_host_deinit() at dp_pm_suspend()
> -- call dp_display_host_init() at msm_dp_display_enable()
> -- fix phy->init_count unbalance which causes link training failed
>=20
> Signed-off-by: Kuogee Hsieh <khsieh@codeaurora.org>
> ---

Can we add some sort of Fixes tag? Maybe the beginning of this DP driver
support?

Tested-by: Stephen Boyd <swboyd@chromium.org>
