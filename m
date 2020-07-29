Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28948231BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 11:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgG2JUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 05:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgG2JUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:20:20 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AAAC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 02:20:20 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m22so13930752pgv.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 02:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=laWlLvysNkw+EqkUXXWh3qRKnJp9myxjPBYwvjpsBKI=;
        b=RevM9dPyszfsbo00TAsrrA5RNf/6znzZWEF3bluYJrFli5YQ2K1kR0L/MK5QK7Msxp
         uX5o143Tp13ao35F2TpjObPOmZnSWvwtGvs3NimBOhGM4ZytcQLt3yyRdCR5AhhBcEgg
         eMzDvf7XfOL3CqNQY8Vm7t9pqaZoeyDFT+CrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=laWlLvysNkw+EqkUXXWh3qRKnJp9myxjPBYwvjpsBKI=;
        b=YZFmo7Q+K+GJ4c9c1dsjXQRLN0AvHj/D1nF5CyRszz9sRtZNfhqeQOtwGILIHJBaiY
         fLnLksKOqsILCFJgzd2gon+Y5FCuPx0xLYM4kpnWiuLw0ge9v7kSmJ8tHU0K1OmR/skS
         VD8ZPl/TmyvrRu2jtTSMH3+ycFxZ2NoaUdvsFgK/xLknNPOr0ONI02xsPGfCbOEQVrex
         TrYo3gt98WwUojyOTZ6xiDweQScLSYrPm7foT/h8VwhbqQ71BSCXgheuroi+Z8q4whhT
         eP0bhhyiWS2OPgWm+4RAiYDuR/0y0crMwxbD+tEEzvxii7lgkRbZGlwCCqapLrcUo42y
         cUCA==
X-Gm-Message-State: AOAM532lXPmiWDbIzWa1iyWY6nl4un8WtHDNEjDdxQCX+7obnNJvXip1
        Go5u3anPCGR/wxyCxb7sc735Bw==
X-Google-Smtp-Source: ABdhPJx9/lhEja1H2gezD9OyVNkzKTD4MosXtyG0cjUNZuaSWJgrv5Sj6Z9PzF0YYChW1FJeoNBA5Q==
X-Received: by 2002:aa7:93c3:: with SMTP id y3mr28318781pff.206.1596014419908;
        Wed, 29 Jul 2020 02:20:19 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id p1sm1568332pjp.10.2020.07.29.02.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 02:20:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728230520.2011240-1-campello@chromium.org>
References: <20200728151258.1222876-1-campello@chromium.org> <20200728230520.2011240-1-campello@chromium.org>
Subject: Re: [PATCH v2 00/14] sx9310 iio driver updates
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 29 Jul 2020 02:20:17 -0700
Message-ID: <159601441795.1360974.13003926832878715423@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Campello (2020-07-28 16:05:06)
> The first patch resends the DT binding for the driver that was merged in
> v5.8-rc1 with a small change to update for proper regulators. The second
> through the eleventh patch fixes several issues dropped from v8 to v9
> when the initial patch was merged. The twelveth patch fixes a few
> printks that are missing newlines and should be totally non-trivial to
> apply. The thirteenth patch drops channel_users because it's unused. The
> final patch adds support to enable the svdd and vdd supplies so that
> this driver can work on a board where the svdd supply isn't enabled at
> boot and needs to be turned on before this driver starts to communicate
> with the chip.
>=20

Can you add this patch onto the end?

----8<----
From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH] iio: sx9310: Use irq trigger flags from firmware

We shouldn't need to set default irq trigger flags here as the firmware
should have properly indicated the trigger type, i.e. level low, in the
DT or ACPI tables.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index 24a2360b6314..2106b9141928 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -945,7 +945,7 @@ static int sx9310_probe(struct i2c_client *client)
 		ret =3D devm_request_threaded_irq(dev, client->irq,
 						sx9310_irq_handler,
 						sx9310_irq_thread_handler,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						IRQF_ONESHOT,
 						"sx9310_event", indio_dev);
 		if (ret)
 			return ret;
--=20
Sent by a computer, using git, on the internet
