Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2002F5414
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbhAMU0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbhAMU0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:26:37 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D389AC06179F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:25:56 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id j1so1727512pld.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 12:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=gcin89rV0I7IqOVbv9QUmTeBAufbW/EP7UVT7uECDZc=;
        b=W3/hfnVx1RKsL4BcMpubo4sIVkeHPQNvBiKClmnTGfqiZIKSQNo4mDZfx0kJQnXQm7
         D6jatbyMCWCHJMfpg2HfYmnwgMGkzs5HYGM0kgMjpRA0wpvjZq/pIqVf6PJsRt+Kx6XW
         r/YcVR2l5+N25gm2DaDM+Ap+SK+7GQuvK7rx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=gcin89rV0I7IqOVbv9QUmTeBAufbW/EP7UVT7uECDZc=;
        b=OqNVPGSfiAwnq/jzYn8dDLy+cYujw3UXD7aF6nNcFE3r1KrWLkSOGeAUAnuccuZqLS
         2d+U4Wx/FdJ4FH4+UQjnd6WzGzS3w5S4BkUtV0aVhjY3h4xccB240YBSK8PB6PnfgwMt
         2RVzgno3smE0Xo+RPxC7D/N0zv6I6YDlrir1ybyv/u65eJxJY5QKvqR0Y31wb7JTEMf5
         4tkZn2Hyk+ULsrOPTc522/wdJfTiEiicy624a0dutrIasYFqopzAYDHS2oYr5qhR+CaV
         Y5BSUNfd6qIz25495zYMNu3slJsm2hs66QMoaerlT6uZuMtuHeIbYvdlB3VW2cQWRfWh
         im9A==
X-Gm-Message-State: AOAM531iyI/Y89Q6SdRXojh3aZ/ziYEDfgI8ZbOhqRCiw5FkwYWdT2+J
        67Dx3qpWkffK5g1ZD5glWfq49A==
X-Google-Smtp-Source: ABdhPJycCWJ3lRjFwltpCDQVyM6m4HdsDCiUKkLSp4ACw4lxoBY0IFDGY9PSQ9YLIGnXpVCrdx04ug==
X-Received: by 2002:a17:902:9009:b029:dc:52a6:575 with SMTP id a9-20020a1709029009b02900dc52a60575mr3869284plp.57.1610569556468;
        Wed, 13 Jan 2021 12:25:56 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 36sm3511232pgr.56.2021.01.13.12.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 12:25:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1610564400-29788-1-git-send-email-khsieh@codeaurora.org>
References: <1610564400-29788-1-git-send-email-khsieh@codeaurora.org>
Subject: Re: [PATCH v2 0/2]  fix missing unplug interrupt problem
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>, tanmay@codeaurora.org,
        abhinavk@codeaurora.org, aravindh@codeaurora.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Kuogee Hsieh <khsieh@codeaurora.org>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run
Date:   Wed, 13 Jan 2021 12:25:54 -0800
Message-ID: <161056955435.3661239.1548841852585636847@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-01-13 10:59:58)
> Both AUX_SW_RESET and DP_SW_RESET clear pending HPD interrupts.
> Therefore irq_hpd handler should not issues either aux or sw reset
> to avoid following unplug interrupt be cleared accidentally.
>=20
> Kuogee Hsieh (2):
>   drm/msm/dp: return fail when both link lane and rate are 0 at dpcd
>     read
>   drm/msm/dp: unplug interrupt missed after irq_hpd handler

It won't apply to the drm msm tree. Please rebase and resend.
