Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827DA215940
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 16:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgGFOTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 10:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgGFOTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:19:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7159C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 07:19:15 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f12so16499281eja.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e09p5QITQkKL6gC86n4XecdWjeqGC63TNv+Y/1UsPo4=;
        b=I6SLqTjXc4TQKrcGYmdV9Jmtx2kHGjwW497n5UNy/hv1EagzZebGWzYd46JJWdCFgD
         g52mPlvHRBmUmbX57essLeG+q8ABb+0VY0Q/DmWEd+8n7leK/IGhNoAQcqLYNPQb/pOa
         4VatUMsmV6qrLQa49yKnVnDiksl0fJNk7DQVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e09p5QITQkKL6gC86n4XecdWjeqGC63TNv+Y/1UsPo4=;
        b=c4JWEtZrSYLBfCxqBC4vguSjBvVMQ/lyinSfZOJZJYm54WuBpvV4xt4oRDeEia18Hv
         eHJn7fd9zprFhYxn7l2VR/w8HNgfZ8OQUo1DkQQ4NZEq4iKSaMDrx5UL/akf37XzJwq4
         qnAkO6l1h0KDaCUyMrVbH5R2lUses4zp/kmaBoMVDxYkXzznH71O1JlUqZ5cFF59S8wf
         U056qvidoNs5X2wIzTPC43Tr4hwj3uOabbFjdeA+YDN7xJ0Vxgdwzw+U3MdyUQoRbkPc
         euz/qtip+SgDUFjKgJULzsnAfxvJOOBtTEZfG+pOvM/ZToIMLROKlFm4HIhzonNNxEJm
         1xWA==
X-Gm-Message-State: AOAM531mIwf7u7AOofV9Cnvpn3KYyoGpJYKXudfN2m9HyrxDcHvpBE0j
        ExYlRpriIDo9JZ3t+JIA1hYnlx/EQ1bpSvv/8qhZX1mF
X-Google-Smtp-Source: ABdhPJxcTXKlQm4m3y7T4v8MiTKSUQSagIgY63Mdu9snxAokerZ2rXxpAeKxvXtNLkBSw61jkXJpiM50zda3BR0pylk=
X-Received: by 2002:a17:906:9244:: with SMTP id c4mr42725139ejx.60.1594045154437;
 Mon, 06 Jul 2020 07:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200403140616.19505-1-jagan@amarulasolutions.com>
In-Reply-To: <20200403140616.19505-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 6 Jul 2020 19:49:03 +0530
Message-ID: <CAMty3ZDBdry965H1VvC8E+cZC07qY-9ZM53BmZSstGhtpxWnEw@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable GPIO_SYSCON
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Levin Du <djw@t-chip.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Fri, Apr 3, 2020 at 7:36 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> roc-rk3328-cc board has vcc_sdio regulator controlled
> by a special output only gpio pin. This special pin can
> now be reference as <&grf_gpio 0> via gpio-syscon driver,
> as mentioned in below commit.
>
> commit <99165b93dafe4f2a821b5dae106f2ef6b4ceff7e> "arm64: dts: rockchip:
> add sdmmc UHS support for roc-rk3328-cc"
>
> So, enable bydefault on the defconfig.
>
> Cc: Levin Du <djw@t-chip.com.cn>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---

Any update on this?

Jagan.
