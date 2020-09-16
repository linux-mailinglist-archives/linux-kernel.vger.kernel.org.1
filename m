Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7E026CC6D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgIPUoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgIPRD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:03:27 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D131C0073F1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:03:26 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x69so7147851lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIYfIcMaZmbBbQs9ovnLOhCvQId5vYpt64H/LvrbT/M=;
        b=Opoih8xxoRbLvz4aM5ODrp8s4apAGwfTEgqMJf2ALg1RYzKZHad+wNwSG+jxZXZ6tV
         66JyJqv6GkZBMUmS5iiMQk+DQIZsCQutrmFYdt4L/S10G2RfSQR9tGZ+U0hMq0mow3LV
         V0V5iUviyNawXQpszIUTt5QJRqEucuvYAcf0M5jxyUZ7mYZQtAXUflAJ8EK0HaGE6AZs
         7lg0yjl5WX7QfT5ZNMrPXAwNEsAOP09sAk1fNI3QSQ1//ww2D49fbsbpR9YEWcvgaNWT
         Ajx3Y0A9cy92honbEKRZHt4vYV/2TiPt6RyAoEhb5UVO9MpX6lXbWGrAKCadsJUCC1uh
         6QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIYfIcMaZmbBbQs9ovnLOhCvQId5vYpt64H/LvrbT/M=;
        b=QUxmx6n0Maa6TYMEec1gB5lVpm8NVCR+5Sx3xK+2JLAuJaAfm7yStyydqndd4ChKX1
         SRrRC2ImKpZIEWx5wisCzhFbbPhEN1A7lKnfisSQ7iMJumnM0D4QJToV7KyhPHFVwyb5
         6N1YK9Ln2bBxu5H6m12g6wtsACaDE0YiiaR5KfSxyactv4kBjP0BwTImyqQcGAPoJgzK
         eMqkVmyZI+CCfb5+erKDhFBHPlM3zcABzjNMmmTN/TIqLA9LCahOcGBvpnjcubn7seHj
         IzR3PgZN28sXRux2HG5E/az6AVaphuuDrBg+XfeQGS92WLYWXEoU3gcXpouXwCYQ0tJT
         9nnA==
X-Gm-Message-State: AOAM530eHX2BtnQlenbnRgQhJyANx+6JE0U5WljRpXKTBU6BXZIM2Yzj
        YaHiSVUlgNfNm4+CHYHPhw0i4y1UYHfKap9dEcN7cA==
X-Google-Smtp-Source: ABdhPJxoHcECLyQAiv0oBmSHZ633SwZ3+ZLe98C6SWsoHoHm1BwWqZogJJi/ZPHgeK9smZgI5/DDB9l7BN3quwvMyWA=
X-Received: by 2002:a19:6c2:: with SMTP id 185mr7257961lfg.441.1600265004617;
 Wed, 16 Sep 2020 07:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200901144324.1071694-1-maz@kernel.org> <20200901144324.1071694-9-maz@kernel.org>
In-Reply-To: <20200901144324.1071694-9-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Sep 2020 16:03:13 +0200
Message-ID: <CACRpkdbqiUye3fcLSdtNB2WffsKp-tmpV64RtWm_kwkqiz2+7w@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] irqchip/gic: Configure SGIs as standard interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 4:44 PM Marc Zyngier <maz@kernel.org> wrote:

> Change the way we deal with GIC SGIs by turning them into proper
> IRQs, and calling into the arch code to register the interrupt range
> instead of a callback.
>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Hmmm apart from Exynos this crashes the Ux500 too... I don't
even get the crash dumpon a LL UART, it hard hangs.

Yours,
Linus Walleij
