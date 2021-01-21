Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482EB2FE9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbhAUM0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbhAUMYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:24:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB930C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:23:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id u25so2250705lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fcGiD7OwR1/jKyiV2ZSUx3opsk7q8xBXMeaqlhO/Z0=;
        b=VCfb+xDMRVyqrMJlzKVRriQ7XncA/ZJvY01+z0RJ0M/9cEUbd+GV10httUkReMk81o
         6i1fR2lVm7rCPBgPPDYwV2QSxTTpsFCUi8X/mgmT5HMUQ74mh0x3GbTuj/tEGW8altsW
         E9vSZ4frIMrRDopfC0eGQDXuXq5QquXGkvjUmqrM+f/1eF23OWBVEjg14T+fzSzDT9yL
         WVjUBAxHOt8Q3AMoM4tghFwbLywfivk584kyQ3Ntn+4BdOD8u1+xeRMa/VCN33N9Ypok
         aMwY10h6RiJr4pGhXqJjECtsx/cVZvQSYqMnBkqFDRs+LaQdM4pC9id5XbGi+/EoLDSF
         1ovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fcGiD7OwR1/jKyiV2ZSUx3opsk7q8xBXMeaqlhO/Z0=;
        b=lcUZSZeZgEFDGLkPuSHsYZGyIqcMMzKNrNzR41Fvke4rglvmO2nMhWosBlt+8c/rRS
         k1rM7nOiLKFuqzc3AWw3ZOvCvS8jSlWuzXAn5gxp8fyKMrnQ76LWpFqAzSN8MxO8vabe
         mP4R4hstN4rfNzD8fSltxj0IPJJ3EcoRgyF/Y2c53emcti5rL9dytWgtHhq3jarCJQiK
         zJ6ESARGfGyD7qzYkbaEnixJ3z8kUPOMJMvrejr31BoZ46fOjf2vdyt0vBek5uF58et+
         bku0UWxPKEpy5bX4FwDnimMeAXmxf8PJnWsCqMOxcvjtA2wV34wDfcif+OnZeJsx5oEH
         L0rw==
X-Gm-Message-State: AOAM531PaWwiMZPKdr9vP/grWc6x54ewtex3cdAOrgtQv3rw4QvKrhdw
        wKe02lXSPmqPbTcVO3D/LhdOqsDg0DYWy2rGfxqpfw==
X-Google-Smtp-Source: ABdhPJyVkr58ajloKJ5wJplZwsXm0JgXkDYNE2LbP4m5olsHGtdSAnryYXTR/OLfKzwabv0Y5/p0tjh07D+mo5oE6V4=
X-Received: by 2002:a05:6512:74e:: with SMTP id c14mr6668456lfs.529.1611231803244;
 Thu, 21 Jan 2021 04:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20210120154158.1860736-1-arnd@kernel.org> <20210120154158.1860736-3-arnd@kernel.org>
In-Reply-To: <20210120154158.1860736-3-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 13:23:12 +0100
Message-ID: <CACRpkdYqijxwE8=441+i4t7A7WuCiQocCy5Q4sOrJKrg-S6fbg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rtc: remove ste coh901 driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 4:42 PM Arnd Bergmann <arnd@kernel.org> wrote:

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
