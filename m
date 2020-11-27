Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A822C66BE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbgK0NWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbgK0NWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:22:33 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F31CC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 05:22:32 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so5123674wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 05:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oX0bOkw7GMihlFDHpc3hUl4NHpH/S5J1UA5FeTz+LA8=;
        b=qIbq5vaBUR8UzcGOv6ZHj/GueHfwo63BjNzFQYSNNQufIWW7NVMqZf2QpJh89Jh3AV
         MFWr8ToZx6SF3YXYRM9AdcoLleBGPlqux/pmGoz7lhXjuyjqmULnhLQKilnxXvbIG4Sr
         H5kgQkLPVdVPKruTG6xRAbqZ20IuoLidlVJWxV0tNt6br/1mNxTvzTbat0uiLUA8TSjX
         LeU5p6zFTPqNrey4ctH9Le+2dCxy1JkEAeHEHkCV9Gh3omzOp9fe7fG5gE64YKBuYHw7
         0q/YvltmcuNtdgtN8XGDUmcmitCSLUJATUWXsHCX/8E2KFdNv8KjM6s/F1CVIgdmHlSM
         yPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oX0bOkw7GMihlFDHpc3hUl4NHpH/S5J1UA5FeTz+LA8=;
        b=Nhp5mUrlhHxxBLqtwUbwGuRZa0WidJ42JkNkyNidh67Kc0wNk/6MyQJZoi75e0C1He
         Q5TDnWO+HUQ3ldUrLiMQt+g/OyL9KUr5BQTKBjbVWJn0KpGErFcfyvoMjFD7zAf+izMR
         oyie2NRS6nqc9SHoIQHO2Ocf2U0GlBAOF8F3XQsx9gPjfM78nVnkBMuUyDG7L+3Qq4YC
         b9sDSp/WUWTXC8237/JjSCXsz3iBaxbO6QHWSQUQ1WpWOCvsSBRgC5VsunRphy0Wsku9
         g5KlF9SGYbL7KDpDK5IqdC+C8Sh1r8wVr6uro66TTscwGylFL7iBwOzfdEUanwsJpwTR
         OwWg==
X-Gm-Message-State: AOAM5314aX7zJkSuoJuo6poszmlKbOmRvRLSjImwYlcGtKKYcKq6b2C9
        5Jh88SvME3XMNxTYjsAwHoazCw==
X-Google-Smtp-Source: ABdhPJwbrXmgAUkkKu5kwC3hwFFP4pSk0YVly8kwcQFJUUxfEEFcnhGLIZd7qEZzqDzy6MZpVwjENA==
X-Received: by 2002:a1c:b107:: with SMTP id a7mr8789408wmf.121.1606483351047;
        Fri, 27 Nov 2020 05:22:31 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id j13sm7837713wrp.70.2020.11.27.05.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 05:22:30 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:22:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] rtc: rework rtc_register_device() resource management
Message-ID: <20201127132228.GV2455276@dell>
References: <20201109163409.24301-1-brgl@bgdev.pl>
 <20201109163409.24301-8-brgl@bgdev.pl>
 <CAF2Aj3inp8=dn9xuc8f3uJbL+m5LH7W3BDoOeZyiiOupmbfgOw@mail.gmail.com>
 <CAMpxmJXa8L0TaeENeYsypmgfkabdP8pH6H6iniwmy0KJs8w4Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJXa8L0TaeENeYsypmgfkabdP8pH6H6iniwmy0KJs8w4Pg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020, Bartosz Golaszewski wrote:

> On Fri, Nov 27, 2020 at 10:16 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> >
> >
> > On Mon, 9 Nov 2020 at 16:34, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >>
> >> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> rtc_register_device() is a managed interface but it doesn't use devres
> >> by itself - instead it marks an rtc_device as "registered" and the devres
> >> callback for devm_rtc_allocate_device() takes care of resource release.
> >>
> >> This doesn't correspond with the design behind devres where managed
> >> structures should not be aware of being managed. The correct solution
> >> here is to register a separate devres callback for unregistering the
> >> device.
> >>
> >> While at it: rename rtc_register_device() to devm_rtc_register_device()
> >> and add it to the list of managed interfaces in devres.rst. This way we
> >> can avoid any potential confusion of driver developers who may expect
> >> there to exist a corresponding unregister function.
> >>
> >> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >> ---
> >>  .../driver-api/driver-model/devres.rst        |  1 +
> >>  arch/alpha/kernel/rtc.c                       |  2 +-
> >>  drivers/mfd/menelaus.c                        |  2 +-
> >
> >
> > This patch should have been sent to and Acked by MFD too.
> >
> 
> Sorry Lee, I missed the fact that there were changes outside of
> drivers/rtc/. Other than skipping the MFD maintainer - do you see
> anything wrong in that bit?

No real harm done.

The patch looks fine from an MFD standpoint.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
