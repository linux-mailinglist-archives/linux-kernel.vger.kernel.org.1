Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F01527CD38
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbgI2Mml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbgI2Mmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:42:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CFCC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:42:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y4so3881025ljk.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wL+1l72oaUbbwBYyOUJaeBQMR0dV1wzd/aL/FIdgzb4=;
        b=xhI9/PHfv+fX23vW8dLBjw1liKAYXb+ehygLbCkVVwhzB6JiSXu+4BSaVZ4K8tBuz8
         5betdA0Zo0dabPQTPyfZgfGTDRQYI5C1gWh0BRD9fKcCBngerR2lOWM6xr3sfq6S2s/Y
         /Mo+9SC2I8EVmdNve7qAhBpn5F9tLTzY/IAKPCo6m5bShm0nxord7LzVA1x87AZPLb12
         UJEziVcQ+xJKvZDAiTNt9Sn9HxG/gC5Yy8gtPpaw5V3T2wyIqipuXwsWfWmCgYiA8zHU
         B6Hzix9baMwWdkCc2y+ggKX7H1oALbOfGl6Dq9X7RQQR7J7/Urh7pkj3jF5MeGQU7tMM
         G/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wL+1l72oaUbbwBYyOUJaeBQMR0dV1wzd/aL/FIdgzb4=;
        b=ekycTg0tM4M9W5tpzpGzbjEGnGjXx6N14569CAuGJdECo5tmBDmnz2g3zXF72ir6Ra
         jXLJOR2m5XozpGC/xOc70Yokw6weyOctQJpc06rBm8OB0xQ5RWtHZvA7Dj3bqsd6rPyc
         fXMWEZR7crVaInC1+WlUhI39f/GZrtMj3kOeNx2so/4NxgNS2T+CAQx2d5S0+3CJNyUv
         lzT9aaKFJxbsSbK56n8tiSLBMtNLctcOUzD+dgPq+pfnozmiweBqbfE702BMHctr96Th
         4q8bDZ559bgI/HQ30AH3dR3fA1ofcGTHrkWnFjk969b+ugtnfQovVYNKKlL73tp3eeq8
         FjYg==
X-Gm-Message-State: AOAM532rFV+flMiyXTKytHq3n8UsNjb5dqA1RGeDg1u8c7OQzZsXqKrq
        cLm7LVewAZe88/v8qtqjiOB6utrWa6G1F9mqCCMRDyrOJTHZ+Q==
X-Google-Smtp-Source: ABdhPJz/TfA+SJy/EqXpDNJpRqIZcEOun8CwZs40GRQvdlhJ77EBdzNBtnUcoYLOOyqUveIA96w7ow/IynDH7+Culcc=
X-Received: by 2002:a2e:a306:: with SMTP id l6mr1227143lje.286.1601383353717;
 Tue, 29 Sep 2020 05:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200911034631.8473-1-chiawei_wang@aspeedtech.com> <20200911034631.8473-5-chiawei_wang@aspeedtech.com>
In-Reply-To: <20200911034631.8473-5-chiawei_wang@aspeedtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 29 Sep 2020 14:42:22 +0200
Message-ID: <CACRpkdbn9294JnddMsmGooCe7KCxMiGbuAZ+OAuLwPkZUYD10A@mail.gmail.com>
Subject: Re: [PATCH 4/4] pinctrl: aspeed-g5: Fix LPC register offsets
To:     "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Corey Minyard <minyard@acm.org>, haiyue.wang@linux.intel.com,
        cyrilbur@gmail.com, rlippert@google.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 5:47 AM Chia-Wei, Wang
<chiawei_wang@aspeedtech.com> wrote:

> The LPC register offsets are fixed to adapt to the LPC DTS change,
> where the LPC partitioning is removed.
>
> Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>

I can apply this one patch if I get a review from one of the
Aspeed pinctrl maintainer.

Andrew?

Yours,
Linus Walleij
