Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16529226FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 22:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgGTUYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 16:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgGTUYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:24:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC6BC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:24:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a24so9614903pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4Ot9BSN65uwqjuzPt11oHFwPT284z0A1s3vHTUzwUuc=;
        b=P7kNkP1J0vskqpeYwWoRwgS0pIRkpEhb9+IyXfYYWTqympKRjTVxOzshkA4wbQFkw1
         xv9aA77wGusH5dc9v0Il+7wnwsbnpxhLK1PWdwacHM6/F2emh32Sb7s/jQvJX/xs9KlF
         16yDXjDs1sHY/0t+BRFW3GFojUuvY8/lS8QWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4Ot9BSN65uwqjuzPt11oHFwPT284z0A1s3vHTUzwUuc=;
        b=EydOQOIjanqsOZjcuen4KVcv6wb/PWQQmwkH10ueETRxyF1JDGMDkZXYqAHAxxaY3U
         fO7yZfaIBkx9o5PcpzFBTVaD9a5Er3AlTqKOisbZR91rjZuEt3HiXG8AYfaf6+jfkjGC
         hAv96fAQL4ldlbLsCXGwdvwySlPwsBezlsBwAoF/AxjOLbgiI0r2r8vcNYH5o+g95iD4
         c8Vu9Jk6KGZdyzCZxRqdKrKnr5xRjoVf5yqSQocVfl48EaRsPfdEoI5ulrs3+V87FRDW
         stmE3Q8iQR+n5/zU1v+vZK3KsfKb0/uJMJDcV0VXFpVWPvLZblLy6xAAy2c1qRLaO4iZ
         xoMw==
X-Gm-Message-State: AOAM531pHg+pwyCuh8HwqJQk2t9TyxuYCVb+/yyrMd3ln1MGkHW6bfks
        TPe+yDosxjQKcCmBnfU0iezZ2A==
X-Google-Smtp-Source: ABdhPJx0ht90Y69rD5rQnfk78renCW+m6JoyhG8U2VU/215s6FVTp+kZISZ6zfOaaE+wVaD2kwNDvQ==
X-Received: by 2002:a63:5220:: with SMTP id g32mr19401467pgb.78.1595276690630;
        Mon, 20 Jul 2020 13:24:50 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id hg13sm433919pjb.21.2020.07.20.13.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 13:24:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5c2265e82af8f755d649c0c36a462f19@codeaurora.org>
References: <20200217085842.28333-1-harigovi@codeaurora.org> <159304723830.62212.5069780400830519255@swboyd.mtv.corp.google.com> <5c2265e82af8f755d649c0c36a462f19@codeaurora.org>
Subject: Re: [v3] arm64: dts: sc7180: add nodes for idp display
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        kalyan_t@codeaurora.org, nganji@codeaurora.org
To:     harigovi@codeaurora.org
Date:   Mon, 20 Jul 2020 13:24:49 -0700
Message-ID: <159527668913.1987609.9777678660905277260@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting harigovi@codeaurora.org (2020-06-29 06:50:09)
> On 2020-06-25 06:37, Stephen Boyd wrote:
> > Quoting Harigovindan P (2020-02-17 00:58:42)
> >> diff --git a/arch/arm64/boot/dts/qcom/sc7180-idp.dts=20
> >> b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> >> index 388f50ad4fde..349db8fe78a5 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> >> +++ b/arch/arm64/boot/dts/qcom/sc7180-idp.dts
> >> @@ -232,6 +233,57 @@ vreg_bob: bob {
[...]
> >> +       ports {
> >> +               port@1 {
> >> +                       endpoint {
> >> +                               remote-endpoint =3D <&panel0_in>;
> >> +                               data-lanes =3D <0 1 2 3>;
> >=20
> > Is this property needed? If it's the default assumption it would be=20
> > nice
> > to omit it so that we don't have to think about it.
> > This property is needed during panel probe. If this is not mentioned=20
> > here,
> mipi_dsi_attach() will fail during panel probe. In dsi_host.c,=20
> dsi_host_attach()
> fails since dsi lanes are greater than msm_host lanes. msm_host lanes=20
> are updated
> as part of dsi_host_parse_dt. If we dont provide data-lanes in dt, it'll =

> have default
> value and fail in dsi_host_attach().

What is the default value? It looks like dsi_host_parse_dt() says it's
using a default but I guess the default is 0 lanes? Why not make it the
normal 4 lanes?
