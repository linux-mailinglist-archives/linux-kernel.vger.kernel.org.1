Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F31129F2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgJ2RKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgJ2RKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:10:03 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC55C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:10:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j24so4799692ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ej4yS8ap+XBOqnlNcXdzMhK0bt1ESoPkZ/WRIP+D8yc=;
        b=DDd66bqBN1ECj9L7lWlj37myfrINHdMBpv63J+bS8aWXeAfBK/P5nE0rviy8tYpH7Y
         uVHqrH6p0rtBtg9QCftuWvpY3UkBuOMyEF+VD4hCRNKHgVJNX5vtueK5opREhi9CDX0m
         1nczMRf9AmGRIK9t7c9zotkAN36F7rdAVN9pVADXrRgd8BzTxf/uaZp3zr4F3FSgmcBF
         2vsrqt5o0Px9ppDKjJEi8ROmlwAxNv/yWhljknZY5oxDUXQeaJAXv7ZVts0z0QPuVLmC
         uSJpMlW+3rLCyuKMdm+vaMF5KEljmxtZijiZH+aqYSA5XHtLyqn+bhlAOTaIg66h8Xq4
         q61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ej4yS8ap+XBOqnlNcXdzMhK0bt1ESoPkZ/WRIP+D8yc=;
        b=p91x+ackc7So0y9e7RkZIvx/DNZsxJ2CE4kAG8/vxfTHOZvgvKNeJdXJjoLVK41PNe
         kWQ68rt0k0o7gpUeARUV7RCs6zwrfCB5qK0XWtr2rayxTzew6vvkGGHestW9CDvIv1Z3
         qBA3P1ZEIOXKiWcuUd68HMFPoDnlC7haTfwb5iryW+ibLdztEWAMvBdMfEgYxUidQp9v
         EN0RQlqVENixouQL5ryHkn6JFZH/4/dPqPsJhTo5DjQIC2JIM20xLxpiDU4pZS7g4a25
         KnDSf3d5v46AB0FEWY7m+UzYum3Glky6LEHlqYjNs6u0vDbuTUyqCB+Th03BhXQkRk3z
         NBaA==
X-Gm-Message-State: AOAM5307NSZL/JsXBF2EjqYHUdEleHxpdz4ZW0W1w3cHDTw06210dfbw
        k8S+A8BR48VEN0vsEgWaGlY/bhTBQKjUsxqGENSa9QT25HzcdA==
X-Google-Smtp-Source: ABdhPJwcHY+CitZath3dnhj/ZcwIgEU6KICkCLfFowci9FCg06L2RDtO5nVLQfnlWOHXhYrnIH6OZE8ciH9/BukpzUA=
X-Received: by 2002:a17:906:b110:: with SMTP id u16mr4977640ejy.55.1603991402119;
 Thu, 29 Oct 2020 10:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201016204019.2606-1-linux@fw-web.de> <20201016204019.2606-4-linux@fw-web.de>
In-Reply-To: <20201016204019.2606-4-linux@fw-web.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Oct 2020 18:09:50 +0100
Message-ID: <CACRpkdZrUbq6h4uDoxfN70mzfbeWAeqo5KAdTWhiHbsb7VTbJg@mail.gmail.com>
Subject: Re: [RFC 3/3] pinctl: mt7622: drop pwm ch7 as mt7622 only has 6 channels
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 10:40 PM Frank Wunderlich <linux@fw-web.de> wrote:

> From: Frank Wunderlich <frank-w@public-files.de>
>
> mt7622 is reported by mediatek to have only 6 pwm channels
> so drop pindefines for 7th channel
>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

I can merge this patch to the pinctrl tree if I get some kind of
review response from one of the Mediatek maintainers.

The rest should probably go through ARM SoC.

Yours,
Linus Walleij
