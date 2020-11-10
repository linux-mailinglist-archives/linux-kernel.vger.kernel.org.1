Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2372ADB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbgKJQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:03:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730681AbgKJQD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:03:27 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C79320809;
        Tue, 10 Nov 2020 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605024206;
        bh=Q4tizdLmjkzMbfpePr+avvWWNz2g0MJUKN8eJ2xoJc8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A6KVxoRVUh7MGpM78oa3naUGFo1EcjhPmNuJoaAofEbM4A1BSeiqKQPmq7g7OEDvo
         /7P91TM9kqQ1O2kq4xIYur9mfdDywNu6VkjsrLrpX12sVUWDACrjbTm3U+JGiGfz29
         h/Y6nTdFSFQhx/+ikQUBprsBbdi1sI/l/h6O1vRo=
Received: by mail-oi1-f181.google.com with SMTP id t143so14862315oif.10;
        Tue, 10 Nov 2020 08:03:26 -0800 (PST)
X-Gm-Message-State: AOAM5328HCNvpQ7YqYYbFCoYVSSJNKJPKVynhQAqrCqNc5/NsyBHdbAS
        6ktSNQozU0JkPoRaKrScUwb5sziTa2w566uUQA==
X-Google-Smtp-Source: ABdhPJxffCMld8zxb9GQXqc30p3WWWPLcHwsDvjVqY4ZjnX3Xq/4kK3Jyc+SH7Uma8dDisNt6kO4m/SmAfDDh4PMeBw=
X-Received: by 2002:aca:fdd4:: with SMTP id b203mr3276663oii.152.1605024205264;
 Tue, 10 Nov 2020 08:03:25 -0800 (PST)
MIME-Version: 1.0
References: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com> <1604887429-29445-7-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1604887429-29445-7-git-send-email-weiyi.lu@mediatek.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 10 Nov 2020 10:03:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKj3Mr6fT_R8JLCK4Ciyt-NyEbUbXXrxnbCBzo2TsLFZg@mail.gmail.com>
Message-ID: <CAL_JsqKj3Mr6fT_R8JLCK4Ciyt-NyEbUbXXrxnbCBzo2TsLFZg@mail.gmail.com>
Subject: Re: [PATCH v5 06/24] clk: mediatek: Add dt-bindings of MT8192 clocks
To:     Weiyi Lu <weiyi.lu@mediatek.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 8, 2020 at 8:03 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> Add MT8192 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, pericfg and subsystem clocks.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  include/dt-bindings/clock/mt8192-clk.h | 592 +++++++++++++++++++++++++++++++++
>  1 file changed, 592 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt8192-clk.h

linux-next binding checks are broken until this is applied.

Rob
