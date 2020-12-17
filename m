Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FBD2DDB23
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 23:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbgLQWBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 17:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732049AbgLQWBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 17:01:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF44C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:01:07 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m25so215406lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTzuY0vYsl+M9p737cbiYnLCLw63QNnFUnI65JZ2FAQ=;
        b=GCGGBlKNKgdCbIPzCYDCSIUiiKyL+6rZawyb/TB9LJCX5qO9tVM5No9LBxQo0FaJDJ
         ZPtI38QwUAWrXybrEoCp51WIa3sMflCb4L2yYNpPlX9yfP2JbD1ecaJq7X0Djp1pFKeo
         LmC+Fhj6mnaRhYmkbyMdeIxNYhh2y4b0yaYauRn/t1l2ehUNHLRRZC9azkicUqp6/CCB
         z2YGqi3E53gRDizf+Ql1yAz0ZV5OdDp1SU3UeAQaGJycOBez3MalWC++J5EaV2OyXa+3
         wCy3Yp+pZMmf7bWTUt6iTJHiPafDbTJ0lQIYIy6TA/naiWaznrAUTr7s2JHm8F6MjPcY
         hRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTzuY0vYsl+M9p737cbiYnLCLw63QNnFUnI65JZ2FAQ=;
        b=NJCHZ6+UyCaR9bGqDaJl12BU4VsvCw7kI20oWPwxMUDZs6V9TWou7YWM2+/3qlL5fl
         fQ6maIT2SSsrSWptZng0XqunEp3A7Ada2ivG89OT3XqK2TbbnL7ISxpkuiPB9bgfTFGm
         dc538gNJwgH4TdrHmFnNJxDSxjE+7MTX5jYHwGDxzmtBwALEIo6b3viBbyEGixffF1DW
         XseTsd74Xxny12RX4PlA5EML1fMu7GoflLFq0TcNBKqOugDLjUvfpg2Q/UTGrxAHaW0a
         U+m5x21QW4r0GngKG77IMMjqAqPYzb33dQbx3Hc6CXEQrDM0UT4uznd7MqiLC5TcbxAC
         Dpqg==
X-Gm-Message-State: AOAM533IJxe+xlHniQ+OHmEWA/w//OftL3zIS1/9E/J5ddcCSuf0Jmh7
        6v8gbRAhMcSfELkSM+NfTUZ7t6eegTSlAzmalC+1bA==
X-Google-Smtp-Source: ABdhPJxX/B3jrVdbWp3O9ARi/kZEt1Z+Y1Vm3/EXQQ175+OpBCQHyEJ0gbWUHINNKnoxv03NcRgwDS4xO7lCUIRzrhI=
X-Received: by 2002:a19:8bc6:: with SMTP id n189mr299901lfd.291.1608242466353;
 Thu, 17 Dec 2020 14:01:06 -0800 (PST)
MIME-Version: 1.0
References: <20201217171705.57586-1-colin.king@canonical.com>
In-Reply-To: <20201217171705.57586-1-colin.king@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Dec 2020 23:00:55 +0100
Message-ID: <CACRpkdZeQyPyvHqrQy_W3pbn-9-rn8YNYiDmR72xqxVhdpeTBg@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: Fix spelling mistake in Kconfig "fullfill"
 -> "fulfill"
To:     Colin King <colin.king@canonical.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 6:17 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in the Kconfig help text. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
