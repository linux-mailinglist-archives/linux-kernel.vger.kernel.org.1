Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E919A2FE9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbhAUMZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731075AbhAUMX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:23:27 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95411C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:22:46 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id u11so2186669ljo.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qQa9XA+PE7vNx4+uRL3BJLOZsQ/P0C86Vh586DLM5EY=;
        b=r7yTYoIlGWvcQcAIuAjWzhjr8nCKUUCZ7+aGlfgBelGv+m5tbkSJwq7ODc0upmtlbR
         EFp7fEc6SQLAcCSbFydY/QqKX6/HKp6KmAPwZuFgfRzFUq21UFMQkTrgxulEVhTHPihi
         owzTqd5UCWqz/0HK6SZeIQdQs3w35YJCKPhwIz3240JhgPDS9Ubk9ob6am+TQkWdGMEC
         MBzx5hr0VypU1Fd2BeJ+kGuKP7vTEJEyI49Mem70XVJEXplU8Mi7CJBv2CTWFtVeBxX3
         45rmyUyZig8f7KcNgsYA91FFDY09E8dZQMiFyWQ3gV2jzjKhn3zjTYbFrODvz2/IXf/x
         yU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qQa9XA+PE7vNx4+uRL3BJLOZsQ/P0C86Vh586DLM5EY=;
        b=sx2EG59Y2TWwqvpF98cWJufWz7uIW/W7yhkpnfIE6vldt+22P/B8dlKDvfoE1YGk2l
         PgreEYBX+VcQJIVQMC2uaiBS0ea6/qrEL0le5j5+tc8zJd6kjnwNCVkiplOOw5YM99zP
         G0HWa5qvu9D1/cTT4L/F6yYwOphGN9L+5Vau3y+yi7UZJ55hTHDZRooNCgPt+Y9xgk8M
         wzM5/Iht8V/9qC7aF2VNI2eocy/byHzLkhODZJuqLSWuEXoABVIpc9bjHZHMsJYFOLSz
         M5sl5rn9WukQW7qCuQ1wZs8SQjkukU7hY3DyecJ09XDDg/rpaROt2xM16q0cUpdrnCii
         Sg+Q==
X-Gm-Message-State: AOAM533xKF3621ub1/zN3RjGdNNAfqybLGj5skzJW0Swld97+hOUXRX1
        brvfNe3k9YefZhHq3uQcI+z6aAN8fQh6QVvqeWTKlg==
X-Google-Smtp-Source: ABdhPJwWqUC0cSwxunla4cSDHnmgCbCrgyjSZqoducdIUr2CsZuUQ9KVRjWdDuOHGnEWHnqK64BT4YRNHPWdxaqlroQ=
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr1106820ljk.74.1611231765057;
 Thu, 21 Jan 2021 04:22:45 -0800 (PST)
MIME-Version: 1.0
References: <20210120151307.1726876-1-arnd@kernel.org>
In-Reply-To: <20210120151307.1726876-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 13:22:34 +0100
Message-ID: <CACRpkdb4o=VsCBc6VoyCut0WniP7fOitJMJHoTwhUkzJkzVYdQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: remove ab3100 driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 4:13 PM Arnd Bergmann <arnd@kernel.org> wrote:

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
