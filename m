Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5B32FEB5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbhAUNQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbhAUNPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:15:22 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70235C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:14:42 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id q12so2407804lfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WhDYHGatB/2fJ84TYkwR2bHfKk3YQA5kHvYxOP9pUI=;
        b=PDM86Pvc5BIx/CgmfIVb2zj8qduUY4jS2Dad+MflKrcjLv53lxZs4WdImpHLeiIatI
         123CIxftakEQ6n0K4EN5k8x1UM9Whywwny9e7OQEc8K3dqJwhRcOd06mFwMp0Sy5V+0H
         DrER7L4nIG0Tsh2YDwilmzS1gwIlnWq8KIwhCKohUDick3XEz4TTXJ9WNmdzYZF+zOvh
         PTQT0UK72ULSRu1q7B9fJxKa740uIQoYhE2MI4mIR3iTOU2KorpTMoX6YBycv8enE0gc
         rUXFqxJBS6LHW/4DtkoSfswEJvLw6XI3rAnIVvwE2xseoD8vwU1oF/vYiqL8eP1BSCOY
         v2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WhDYHGatB/2fJ84TYkwR2bHfKk3YQA5kHvYxOP9pUI=;
        b=IHjYhSXRXng3PdsGy5/D5vIrfBYRPAz4NdQPZfYQI/N4WuoAz9//BxiX/c9lXqt18m
         H47bGeoEG4NHk5R0Hx51Mjym9KldxSFTnRSOTf6fVilg6Qzn9ziMs+7nVlO+tW2+gDHI
         5U5/2riKhre3qioVRSuIcAKgp/9iF0HyMa4AGMOujGllsK9GlDHavu/UY6LRXKHwfcEX
         S4lqrZ8frxW3bBiPWA16wLrtP11Etun59CDUVSC3b4WYg4kF7y9HGaAeqVqWz8BUG+H3
         cfdzTGpzP9jn/+Slg02+Y0iZx9Y+IEIm/5c6DRL5k468U4nluH9maCNzgcdtcYpGkcWz
         ufHQ==
X-Gm-Message-State: AOAM532PNYhJqiSQwXLmvi+ye3QQJDgmZIeMPtCaGavmxY1wySe1ZEoE
        Ls8oJmsl/+g17AvLBCmFx2L1InR8TjkjWmKWITKG7g==
X-Google-Smtp-Source: ABdhPJzX5OEuHG39nSXa8fVE3LqQ+FqhQx9j0neb3l27AjHf91ct5iDaXgV0ncFcF0R5akfj/VeW1VZsL8qtEKXr2Vs=
X-Received: by 2002:a19:8bc6:: with SMTP id n189mr6431666lfd.291.1611234879540;
 Thu, 21 Jan 2021 05:14:39 -0800 (PST)
MIME-Version: 1.0
References: <20210120162745.61268-1-arnd@kernel.org> <20210120162745.61268-6-arnd@kernel.org>
In-Reply-To: <20210120162745.61268-6-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 14:14:28 +0100
Message-ID: <CACRpkdaBLij-NoTXU8HJkeQWwN9QwTDV_1u4U4vVwqXPt-A0HA@mail.gmail.com>
Subject: Re: [PATCH 5/5] watchdog: remove coh901 driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 5:28 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The ST-Ericsson U300 platform is getting removed, so this driver is no
> longer needed.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
