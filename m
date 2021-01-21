Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97C02FE9E6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbhAUMWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730532AbhAUMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:22:07 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01727C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:21:27 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b26so2205632lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yimdx4ZEIYCrRVLF+2NU0OizS0WCMrr/pbZs3FbSvjM=;
        b=EPnXHr6yZpdy1V1kIy3ctOUkkRMRXgJTomkYX2dAHRkNMS3UYGt1znP8t297cMQQmm
         OY3EIWxjL+xbNp453Csnx7qFabFAldU7devy9J28VbqbS4xS2KkHegc3974CLjGDSFE1
         aW8bykzakwL2wk1PLa0tGg6yV1hPKUpJwwur7Embl1m6EXTSR8Xhtqhhj4gPksUGD9ex
         alBF9q+TnkN6YQtrHgl3jBBxUER0mlve+6jr80D92D/X9eEpkmNew8yqKtKYjZOCcj+d
         IVhA8unhx+dT9sGGmezYWST4I6NmBI8j865N/Kn2jHtAa4nPnqGsdFmQUWNETa96ylYt
         bBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yimdx4ZEIYCrRVLF+2NU0OizS0WCMrr/pbZs3FbSvjM=;
        b=MmgOczarXprQMcWsrt+RGlF93+ysEGQuJPgcZsAFNH6YtUdxwP3rhPuXGRbIiNYqzY
         TxlV74OHEOWsbV/dcz6xkgPOK8juUOKf0kC2lVVw5GS40zNCBbavQaxPRWyFboUcx0Fx
         31+SEJtGRLVMJtpF4t0VJO0ZBdmjz+f+M6PPoMZ4x0Oxe4caKPGt8FEXXGULWMQja2Jk
         L4UnqcqXwL8GZ62ysJOSmYPeaYmSy1Afi00X04ky/eyMt1soKQ93o46hkf0fp6X8eMjt
         GntbRyigV++KOnMKVl9y8mWGEE50hh/2wfwJKSGdvwEXf5tv+kPXtQMFL6SRvF8/spJu
         IkAw==
X-Gm-Message-State: AOAM533shHOTkaH8By1G5IQrvIx4gpCtyzdW0pIejTjzvD2J5KNEmpVU
        kewx+TO6c6v2JR8nhjcX74n83/dZ04rhMsY26F9epQ==
X-Google-Smtp-Source: ABdhPJyLoUO3vEOj/0GCCxA14/vsoSsvNgo7yEAm7/If4CXqAzS/7+UNrJ+Rlq/37pc5T2F42NDbBhHJ/Sa5azjikAE=
X-Received: by 2002:a19:6557:: with SMTP id c23mr6061478lfj.157.1611231685556;
 Thu, 21 Jan 2021 04:21:25 -0800 (PST)
MIME-Version: 1.0
References: <20210120142642.256235-1-arnd@kernel.org>
In-Reply-To: <20210120142642.256235-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 13:21:14 +0100
Message-ID: <CACRpkdajBcW6VX1=R5fRS4WrrvsbBUF3geHSTs9rLG5Wc4ztWQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: remove ab3100 driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 3:26 PM Arnd Bergmann <arnd@kernel.org> wrote:

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
