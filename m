Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B080D302C84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbhAYU3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732170AbhAYU04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:26:56 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C70C061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:26:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l18so341852pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Kq5gT7mxggPfi7e9b5vgYqHvxswxUEITmOo503bNPRM=;
        b=l8fldT7NjqGsjK8e94mViVElU78aFxacWv4iHmvj1C3Ick6Lhj1+EsgWrpghrCeHWi
         JsIV2m2zChqQE0GBl535HOJULKdZKUINIZR0VX/EwakawxvZAgXmZDmDwnJqiAGWvfRS
         xohl0yNNwGWrr0UvyECHMsm2FZkHmr9fDb4N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Kq5gT7mxggPfi7e9b5vgYqHvxswxUEITmOo503bNPRM=;
        b=PzE80ybOkUCFl4F0Msa3UhYNVLLNNwgrV38j1gwYVbKkecmNwpRZ1LmqGKSD81lozy
         G8yyUva4mqyYiCcHz4MBZXyk0cR0pwdflbHV6KNn5QTHJ7QgbNFWdhvkLFgVGHhLLo4g
         tn7T0D3ONFHfOmqiMxZZHRY2b1DwVOHIkFXKMW9i20tLgdCxuVHU404uSoB/pzi79MNI
         JlKwQZw2tkzX/rGCgnc8oCo7ed3gbbPQ5wYZomM7FRjWR+1ksndKMStholQw1YkXKlGR
         7MzzAdwyVV/r3QFgjxTM6p5O0rHjAR4SJpGp50Kmbm8eFDPiUN1mNGdBtGOx9kRfu4/U
         3LLg==
X-Gm-Message-State: AOAM5334eG2IG+lEyCG1boa9e/MCA+2d2gM1RYTb+L2Bc97pZq8JRQ2c
        PdY5biFFYcKEBCDDPj93BcOeIg==
X-Google-Smtp-Source: ABdhPJzqwYZ812WkWyypqLpJnXmYbS5oyt36jko1D4jMQ5RuHYxVmUdhXcCRuhSBCyLyeK/rHupRGw==
X-Received: by 2002:a17:902:9883:b029:df:fc41:38e1 with SMTP id s3-20020a1709029883b02900dffc4138e1mr2160391plp.68.1611606364411;
        Mon, 25 Jan 2021 12:26:04 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:1066:b437:97cd:2278])
        by smtp.gmail.com with ESMTPSA id t8sm183396pjm.45.2021.01.25.12.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 12:26:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210115144345.v2.2.I183b1817610d7a82fdd3bc852e96d2985df9623f@changeid>
References: <20210115224420.1635017-1-dianders@chromium.org> <20210115144345.v2.2.I183b1817610d7a82fdd3bc852e96d2985df9623f@changeid>
Subject: Re: [PATCH v2 2/5] drm/panel-simple: Don't wait longer for HPD than hpd_absent_delay
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Mon, 25 Jan 2021 12:26:02 -0800
Message-ID: <161160636226.76967.16862386814744159828@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-01-15 14:44:17)
> If a panel has an hpd_absent_delay specified then we know exactly how
> long the maximum time is before HPD must be asserted.  That means we
> can use it as a timeout for polling the HPD pin instead of using an
> arbitrary timeout.  This is especially useful for dealing with panels
> that periodically fail to power on and need to be retried.  We can
> detect the problem sooner.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
