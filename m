Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356D62FE528
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbhAUIi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbhAUIiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:38:19 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55D7C061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:37:33 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id j3so1524735ljb.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 00:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sHXOH+Jx/x8nDpSBss54UYUl1G9f4HNF08JDUMRanCY=;
        b=zHxK1SAQeKJpWbfpFnMXnDQ4nKrMqqOPI1cEA0rtjLJkiGYl/05YCGfbMn8j7WtCM5
         scAFhFfAouIYEdHQ7yzZti5vYnrUTWkyntbphqL7dX66vMT/MUnB7SiX0gWnWUIHkr58
         U7ipLyhZnjuNA0jDXInE1rzBIeuyNbHD0z3A1m/5AszewBaA2Oom+pSnmQmGh/l/miu5
         4q3bkyYfa6uQUvwb0oQx58ydNzGD3rLlEp4P/LUWERmXRcSXIpgB60/h9aflqS+dSWEc
         Kvv8KFMcWvGU+AZIW7EBuEih7WHmXqm61iizZeaTfsTDIKhHNaeemeFHcxSG6wCa43Cg
         WZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sHXOH+Jx/x8nDpSBss54UYUl1G9f4HNF08JDUMRanCY=;
        b=O2qSkFqr2dLFrvHcxA3o6bDNIb7vmFrKDzgQqEh3GfJdlBHMrxKxu298tfLTSG9jt5
         09RqoDCZrY1LfqxSoXb/COxNv7rRtXMZla9en3/PZifUJJJadGv2xanT0smJ6qefS3mN
         eC8BPlmeoxTBuk22w6AJfVBpIQlU0XtK+/mjtb9+fzYGt0MgAlSUCCJbjv4jRCWLw+8Q
         C4CzXzpQv/gLyMwwaw297SdAQRA5zOgc6aML1u3vdiHKGF4lB3LYOadLS5aD66TSmlI7
         pD/LLcxG6y1RCmlgyzJH+EhSrHvUkCH4uztbBmW0qmLLturVnKARkvr6xmDG53zrlCdV
         YOfA==
X-Gm-Message-State: AOAM532nleQIKdcRkAyhN/NK/8xE+7HRayi3MLFVHI9DdYBzcdTgr/DS
        MmjjXuos68QaUuGnkSxMofj4dNEK2fpojga4ao5vNw==
X-Google-Smtp-Source: ABdhPJzCZiUOZ+9u57kz65rrepIAROZj6z27qrpddY9YJCx8wBMJ0nU7/a4RKMq8qHRywoSnQgM/z/84OJOUKsId6OE=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr6090722ljl.467.1611218252444;
 Thu, 21 Jan 2021 00:37:32 -0800 (PST)
MIME-Version: 1.0
References: <20210120131559.1971359-1-arnd@kernel.org> <20210120131559.1971359-2-arnd@kernel.org>
In-Reply-To: <20210120131559.1971359-2-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 09:37:21 +0100
Message-ID: <CACRpkdZoZCYZXcubCHwGQfTiHUOE9TOTjH-8chm0oQ_wdQoGLQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] timer: remove u300 driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 2:16 PM Arnd Bergmann <arnd@kernel.org> wrote:

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
