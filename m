Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9772BFBD8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 22:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgKVVzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgKVVzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:55:37 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708D4C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 13:55:37 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id k27so20574174ejs.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 13:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqpYjQ+PGcW1Zliu3zVha2yXOh9qnCs6d+1tFYlWvLU=;
        b=uE21F2TZwzmZhDf0EemaAvk72giHQLQxLBtQ2A/hZnlQqR5DMpduIfsviX6XWQVIA5
         U5LSC3z1gM8HZG7xhsix6+fNlUI0bqxysI6jCSI1hpKqwnsTBfl7A3ZGuPCNRgh7EWZe
         6Of91QefiL69x275vggcx92vCTwZRpOlVp3BElKBHbufVQ9/wAkpg0SNYgZO7pHqhlCT
         ywHm/hw7ep5sXEV6SIDtre/iOQIOJoLjw9YFnFDEn89R4x9QOxj5GFMtmI3MvanN61+h
         aQP9wlVxelNJpCuZi3VyRNIjZbB77I7hN7fX+dHNJOiUFGu7VH9ztYddDsMTFu4uadpM
         9ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqpYjQ+PGcW1Zliu3zVha2yXOh9qnCs6d+1tFYlWvLU=;
        b=bEZhwggK0jQKKnMZizplcs8Z30hlX04uJAkukhoszFSrqQmyUNDvNCEYlTMIykdAQs
         IK9egTjGgc6/fswq6pXNq6S6RNgzErOx0Xlrg5UTmhGkPquexDXSXIdC1juBJ4ekTpsM
         Yf0NS0LbwDZAhFJzVrE9zuaKfQlxYrhnNR/NneoHxa+gXlryPZ1h61WG2+H9sva72S8j
         tl12Kaaan6s4gWqDSai/E/RblBQNqpFfAZnXqdsFdVgOmevw0P3OGe1oxLGKsQoJWNON
         Kk8vKhagQGBkwXYzgkiUt2CMGoRsrSYhiNUtcGOGlRiun/B3hbYgnJNRKAZzUBtZxKOL
         +LkA==
X-Gm-Message-State: AOAM531OiaFVjAFFzTR0j7dJsnODqr2joMjTmFnVAcRv2RtG0BZtX0Fa
        nFgril3XMYLp9dZy3LajaVJ+IEAXShpU3XK4SnI=
X-Google-Smtp-Source: ABdhPJy07kQh16653VIqzljjoXbLIp850Rh1tftCY9BRp2/rmpFyyXpHdiUQt6F0suidLiAtWc23f3ZkqdKyNV2NFoQ=
X-Received: by 2002:a17:906:ca93:: with SMTP id js19mr43561460ejb.537.1606082136168;
 Sun, 22 Nov 2020 13:55:36 -0800 (PST)
MIME-Version: 1.0
References: <1605666995-16462-1-git-send-email-yejune.deng@gmail.com>
In-Reply-To: <1605666995-16462-1-git-send-email-yejune.deng@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 22 Nov 2020 22:55:25 +0100
Message-ID: <CAFBinCAoFHknq8guq2JmweBvpeXgFh5dzSOeHBaaCJAD=OODHw@mail.gmail.com>
Subject: Re: [PATCH] phy: amlogic: replace devm_reset_control_array_get()
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     kishon@ti.com, vkoul@kernel.org, khilman@baylibre.com,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        p.zabel@pengutronix.de, lorenzo.pieralisi@arm.com,
        repk@triplefau.lt, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 3:36 AM Yejune Deng <yejune.deng@gmail.com> wrote:
>
> devm_reset_control_array_get_exclusive() looks more readable
>
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
