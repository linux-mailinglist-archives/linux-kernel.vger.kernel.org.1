Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797F323E389
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 23:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHFVeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 17:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHFVeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 17:34:16 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AF7C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 14:34:15 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t6so18289440qvw.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+76LXO14aNsx8i1gnsECIsp+iH10M2aik6HmT5GQNM=;
        b=mWogffXazu8aVcQxrtz2BpdyrkCKOBfTzr9EAQaCeetZCb3M0J/y901nI1OnHvRvzS
         Ban/20sVtB3RPaygay2NwTeW7yzd2JJwp4ETi01vtqE5Z7ZS5pxr/9pe8h+n0g2hqiSQ
         6FVcv1v5O9PkmJizhozW8gSa0sSBZH1cuPWzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+76LXO14aNsx8i1gnsECIsp+iH10M2aik6HmT5GQNM=;
        b=m+0QIV5ERp1bKWZRAoz+hgDVPheppNZkIOpQHpTwZWD+A+0jcARhC2SNFpXcjV3TWG
         F0DfG/YlYEK6s6j35DWOXKL0PyxNGuauQTofgbSXzRHmR+UZAM5OYWsxEPeFSC+tks2S
         nanEv+Xg3gUg+iPSku4x6JZQi6ynW7zcWvVVM5IP8gTFpc38VOTOIFe8mfNE2xRGTE8n
         vLrTnJN8Vx1A2GFWjZJOB3Wp14AKsDS5fsLcRM7NW7CVbGGXzzf2ffeZrloBKCx4LmDT
         HtYPxLrJx67pzKBNk7IZDWaq3qPtjJwJqNZJi3YzsY6abmIVpi1JcMC1/hOt7rmc94A5
         GzfA==
X-Gm-Message-State: AOAM5338MGg77KAOcEQydVMTCccVJU2BPn70IiU3gVFJSGos7VACxdCi
        h/ybgpSiuHcif7SIFRhqTDJlWlVOz60=
X-Google-Smtp-Source: ABdhPJyAj3yZZUngUqcckymF9EF4VL9J8V/74vh5uUmX5EAPCi31t88cd751HB1BBChplMee2Xb1KA==
X-Received: by 2002:a05:6214:1910:: with SMTP id er16mr10833717qvb.228.1596749654328;
        Thu, 06 Aug 2020 14:34:14 -0700 (PDT)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id 8sm4944429qkh.77.2020.08.06.14.34.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 14:34:12 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id x69so46434231qkb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 14:34:11 -0700 (PDT)
X-Received: by 2002:a05:620a:1424:: with SMTP id k4mr10651380qkj.2.1596749651000;
 Thu, 06 Aug 2020 14:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200806153308.204605-1-linux@roeck-us.net> <20200806153308.204605-8-linux@roeck-us.net>
In-Reply-To: <20200806153308.204605-8-linux@roeck-us.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 6 Aug 2020 14:33:58 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPkQKfXGzP3kr150VKDE0eGc+2CALEvbU+LGv3zwGyWLQ@mail.gmail.com>
Message-ID: <CA+ASDXPkQKfXGzP3kr150VKDE0eGc+2CALEvbU+LGv3zwGyWLQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] pwm: cros-ec: Simplify EC error handling
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm <linux-pwm@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 8:33 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With enhanced error reporting from cros_ec_cmd_xfer_status() in place,
> we can fully use it and no longer rely on EC error codes.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Brian Norris <briannorris@chromium.org>
