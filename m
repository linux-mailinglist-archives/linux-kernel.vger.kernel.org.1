Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4566A26AE34
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgIOTzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgIOTxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:53:48 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA73FC06174A;
        Tue, 15 Sep 2020 12:53:47 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g4so4291564edk.0;
        Tue, 15 Sep 2020 12:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+Glag7Zdcx+JA5O5eROeVL4B8Ql3yXhj7TU2E4Q+gU=;
        b=mfMz05Wy0Rzi3mc9FRF90iBbA+HVDHL4eISMtdCcvtfUvBQM8Wh5qiWEAI/6L8k0oh
         AhFsZPp4OUXp1F8ZdKXdwcQJsuHQ1Zy8naiBndsPu70ZwZQoQpvXgSd54Eyhu79W36Ho
         Pc/au1ytVTbm4f2LpU9Td2cdox15NHuXZSR/vJwUD2y/hrA1VD5Hppc4XvPlS5chwMqD
         lznko/lVoIDy4XNuCtmT1zWCCktBAUIBTQsjy+IgPmfQBFjEksf+EX2rVk5+KvSAQyb/
         GGfRamqsqpooy6xQRI1jsubexprAnEoblMG0wLEzt/5+kbEQ+rUYebyqCA4rEZhMhpaF
         BgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+Glag7Zdcx+JA5O5eROeVL4B8Ql3yXhj7TU2E4Q+gU=;
        b=tRivKBzRGs1PMJv9mtwSdub4uIWm213gwgxg7TMAq+fOgMaRTmrbPWQYLZ66WoU/Oo
         r/2VzF4BQgAJGfzm8Y/hi6k3Nfw/k4mlNmg1TYQ69Ns+uUqSQBU3oVNG8qkz/c3pOhz/
         IFsrOwyfma+rmjyJdonV8e66vqtICPlkI3vg4zBV9o0KuV80N541P9kCf2wksDU/Y42h
         OglYIigeZiSGRtApZUY4LT59XqcicJpyOYj3dYbI0q/0WOqlg/4jWwjTuhWqd7z0H7o5
         sstwcm5fPQvYMIHU77hLiFOdwfza8XvqxBzAsUBxGIYpeps40V/fvg0KFYgqeb6RLUAz
         D7RA==
X-Gm-Message-State: AOAM531D/q+ZdWFu+WheRR/xRICI8f2uRZLtY2gYL0/ifNUBTPiGHWpa
        UjU7zmpdOZ2VuS3g6h8+0b+o3MPW0UWsTtFF40k=
X-Google-Smtp-Source: ABdhPJxVXkzjJNtB0Y3kNGVBHxg1BFzbFcjYn0XJtJNYLcueZkJd0W0gKFbpcuyRnBJHwu4kAof7yiVtgnwo+VrdTVc=
X-Received: by 2002:a05:6402:489:: with SMTP id k9mr23671549edv.287.1600199626131;
 Tue, 15 Sep 2020 12:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200909160409.8678-1-narmstrong@baylibre.com> <20200909160409.8678-2-narmstrong@baylibre.com>
In-Reply-To: <20200909160409.8678-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 15 Sep 2020 21:53:35 +0200
Message-ID: <CAFBinCAAv1fUxO+u7NRuXw8rUqa=z5GYEaPMr7CRq+dasQ6oXw@mail.gmail.com>
Subject: Re: [PATCH 1/5] phy: amlogic: phy-meson-gxl-usb2: keep ID pull-up
 even in Host mode
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, kishon@ti.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 6:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> In order to keep OTG ID detection even when in Host mode, the ID line of
> the PHY (if the current phy is an OTG one) pull-up should be kept
> enable in both modes.
>
> This fixes OTG switch on GXL, GXM & AXG platforms, otherwise once switched
> to Host, the ID detection doesn't work anymore to switch back to Device.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
