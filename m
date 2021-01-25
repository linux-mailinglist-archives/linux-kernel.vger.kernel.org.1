Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC2C302C97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbhAYUct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732311AbhAYU3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:29:49 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33EBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:29:08 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id t6so8394369plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=L7hcJowvgJK8XV5T2kSWijbbIn+FH0xsHHJJGhXiQE0=;
        b=O0ld6mWRMFPALAbHEFHcpFb3ogYdK765/sIFvWxcavPzvG3UvEenEJG/4gDiZpQxp3
         dKdkzZEU1UiaGk3ow1+GBrlKcORtjunc2W2f+ouEhzj0sVyZp+sHgSv5dzqdgwEmk1Fr
         TXufxTyI0yW8X5HVP7fhfvH7h0DHQKCtx8zZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=L7hcJowvgJK8XV5T2kSWijbbIn+FH0xsHHJJGhXiQE0=;
        b=kJW6opHcuZPJuzBez5aD6YlY6FZGqxq6Jo8Wz/J0pxeRIUzujurAGyAatz2h2ibf2X
         E2vCwHWOUglz/nTw1WfE88TWJLoyW/DIGDz1AKZOFPn+Z5H1io3i6ERRo4DUZOOgdSU5
         BS509EbzwfIJXhjlKho5ltJqI26lWjkMNnVZx6gZdSN9XUzGu+UxODm92FdQ0m3lynpk
         LrWFrIJt4fwnTb64H2ORnxAkBq+G/SSbv6/PaO3R7Ke+38XI2H88p9Vi2JFNk45TyziO
         9QMT/uNMFEpQ8Mt4JuZMRIZFlOS029s4nlq5dOHipPiVDKLA36JtJRm61uP1+kfSp8fz
         /+kA==
X-Gm-Message-State: AOAM533x1KC29JmthNBPNQYN0MJ4XqMOgkoPp2a0Gl3LlomWjIzTEMv2
        ge2CyPXRwL+xWWFkX2iYhGwFig==
X-Google-Smtp-Source: ABdhPJxsTjN0zorpk0zOXXWw8UDdJVB06DcpY582k8+LI0wqcMj42Yy6RVlk3j+kBGaTZOz/Ysc8AA==
X-Received: by 2002:a17:90a:4dc1:: with SMTP id r1mr2045991pjl.12.1611606548517;
        Mon, 25 Jan 2021 12:29:08 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:1066:b437:97cd:2278])
        by smtp.gmail.com with ESMTPSA id i62sm14073923pfe.84.2021.01.25.12.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 12:29:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210115144345.v2.4.I6889e21811df6adaff5c5b8a8c80fda0669ab3a5@changeid>
References: <20210115224420.1635017-1-dianders@chromium.org> <20210115144345.v2.4.I6889e21811df6adaff5c5b8a8c80fda0669ab3a5@changeid>
Subject: Re: [PATCH v2 4/5] dt-bindings: dt-bindings: display: simple: Add N116BCA-EA1
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Mon, 25 Jan 2021 12:29:06 -0800
Message-ID: <161160654656.76967.8777176702304883328@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-01-15 14:44:19)
> Another simple eDP panel.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

With subject fixed

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
