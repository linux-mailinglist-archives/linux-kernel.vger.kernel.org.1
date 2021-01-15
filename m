Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDBD2F86C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbhAOUfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731380AbhAOUfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:35:01 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3908C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:34:20 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n25so6770583pgb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=g+YP0bVv1YfQ4vqCqWwoBJPB0DUFQOEmaYfwxcveiIA=;
        b=BF5sTMwQLqTbsyDlqquGDw/KXf1h3FUyEXcOPNi/o1CHl7yHh50bZEqxyLD5QVR4yW
         yWVLAZZkEDY5Gb4yuZfV/qjcTTfWWmExpwev/jTOJm3IKk+6mxWzYp6pt5pZkooUIVCr
         E24D0xxUOsZ3Ile+o4KLzim2rj5RxTUKFslLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=g+YP0bVv1YfQ4vqCqWwoBJPB0DUFQOEmaYfwxcveiIA=;
        b=TeHs/8jYDNu/Tr/lET0Prv8Fs+6TOhKvwna56EDhP2UeatRtplacSzSeMJNavhrb1M
         7iT9TPfwAlOiTg+c21bmwlN7eq+4kG6Tqo7eggTGQGffusLwpbNCC6cBcTa+Zcm+jbvA
         e2x/iH0ocLS4qwLJoq5cg8NPBuTHz0V+LPqKXQ8HySXZGxD2JOUSgbvSgRzJdjtLO9b1
         L8FiZcbTRzvLyWIIQ0j4VEc4LFI0BWQsVb+zPYn0yg3cWkmyv2IWbvGGtmMK/EYCKzX9
         udLt678r1ZxhPnPCq5XZp2DOjaG0gp/Za5xkoUr3vRCOGZ3997pu1N2uQWWupDEyZj8j
         hhRg==
X-Gm-Message-State: AOAM533JrNNwEM2wMTYNEuldJvB6fAmTWJeT/NPqcr3D4H+Nu4cn02wl
        n8vUk5QWNzL9G952nb6ZTJ/fww==
X-Google-Smtp-Source: ABdhPJwFxrCy6unJ9wd4f769/57cihhVD8RvoOwOtvmtOsKd2+BhZR6IT569L9AX8EMqVI2bYQyQeg==
X-Received: by 2002:a65:534c:: with SMTP id w12mr14398508pgr.179.1610742860241;
        Fri, 15 Jan 2021 12:34:20 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e65sm9118505pfh.175.2021.01.15.12.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:34:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210115122412.v7.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid>
References: <20210115122412.v7.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid>
Subject: Re: [PATCH v7 1/2] dt-bindings: input: cros-ec-keyb: Add a new property
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dianders@chromium.org, Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>,
        dmitry.torokhov@gmail.com
Date:   Fri, 15 Jan 2021 12:34:18 -0800
Message-ID: <161074285814.3661239.12462722802289701745@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-01-15 12:24:29)
> Add a new property `function-row-physmap` to the
> device tree for the custom keyboard top row design.
>=20
> The property describes the rows/columns of the top row keys
> from left to right.
>=20
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
