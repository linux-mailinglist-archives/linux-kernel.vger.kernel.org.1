Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E91F652C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 12:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgFKJ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 05:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgFKJ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:59:56 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853D3C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 02:59:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u8so2039346pje.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=oB4mtb0xksSziQYWuiZhgrSJVGcBjygHK5uCltGAA6I=;
        b=cCqBVJogoMW54JT8hCGAAwmvRhaNP2+tdxBdl9ysnVAUWRoWcq6dO+Xv4oLyAu6Shu
         fWqLlu+2FrhtBN2ypp9U1dVi76fmzo7Z+vSuo3q6hq6qk6a5QRp6Q7k+S4byXUVI8SDz
         kgFkpRgObJ021BKn+r+PvZ/mBUXPy//f77/AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=oB4mtb0xksSziQYWuiZhgrSJVGcBjygHK5uCltGAA6I=;
        b=ZSOF1liIo2rWMouiTdxxy3Cr4lLEr2fqXtPkTcA5SIl8oodeOip05sSc5Nv7Ar8hoh
         xCmSISwTYnnFHVfjbxjA5Rl2SdIeYbKaR3n2Q4ZugQfQNIpaaxm1Qpb/0uTAL+f76AYw
         VMT9SljzLjDGtbwZVjLAQd6splPLz1B3rDsIkmWhQohovvwkgObqcgFiPN0g1iCz3jsy
         STD06Q0YO2L7VL9JZ6vs6iTlHCVYjSX9H3WBvnW8C8ojVPX3zXVIbBDg+6QCJsBsXYlG
         GUbGf1hcUPfohPnWLjfRE/+ytc5JVF+PvWSKB2k7lqTuY3R2yH1BF3ITXm5/tu6B1VhT
         OSGg==
X-Gm-Message-State: AOAM531acPNhgNUsoz1zXVbc2bqQDOOAkCLmqqOsdrWjpkf77MUw2bbU
        P7TXopORoTtfKpy4SsR1HLEg6g==
X-Google-Smtp-Source: ABdhPJxEX6EPj5ivY6YNa2MMUScYAvFF56H/mo5xEMT0vW/YhejhIW0EkdgS65SMEAveqlDt5qSx8g==
X-Received: by 2002:a17:90b:714:: with SMTP id s20mr6577390pjz.99.1591869596069;
        Thu, 11 Jun 2020 02:59:56 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k19sm2792046pfg.153.2020.06.11.02.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 02:59:55 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200608104832.3.Ib616e311c48cc64b2cef11bd54d4a9cedc874bb1@changeid>
References: <20200608104832.1.Ibe95d8f3daef01e5c57d4c8c398f04d6a839492c@changeid> <20200608104832.3.Ib616e311c48cc64b2cef11bd54d4a9cedc874bb1@changeid>
Subject: Re: [PATCH 3/4] drm/bridge: ti-sn65dsi86: Fix kernel-doc typo ln_polr => ln_polrs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     robdclark@chromium.org, bjorn.andersson@linaro.org,
        spanda@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>, a.hajda@samsung.com,
        narmstrong@baylibre.com, sam@ravnborg.org
Date:   Thu, 11 Jun 2020 02:59:54 -0700
Message-ID: <159186959470.242598.5120667136602798347@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-06-08 10:48:34)
> This fixes a kernel doc warning due to a typo:
>   warning: Function parameter or member 'ln_polrs' not described in 'ti_s=
n_bridge'
>=20
> Fixes: 5bebaeadb30e ("drm/bridge: ti-sn65dsi86: Implement lane reordering=
 + polarity")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
