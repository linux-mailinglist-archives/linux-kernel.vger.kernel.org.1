Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393AE2FB3FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbhASIYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730917AbhASIYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:24:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42898C061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 00:23:43 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a12so18767361wrv.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 00:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0o446r/7sfNrNMbiwlFxGJePev96CeNNzqsH+vREsX8=;
        b=I+pBsb0vAWfUoTHY7RYJ6yNwT7cwg2JIs/IprcYa7Jzjnxdqdpn2CwBtUjTwRo4XM8
         uyIxI/Ggh9GSR8awn0b5sPWRSJ6KeHwcuc4V3KOQtFbLoo91T/73rswe0bX4MOgtFIIq
         ZGSHMQaKXk0g37CDxvDds7AOnm+lJVqQiA8kil11Bj3iT+HcRtNi3LkzM+W0rIu2yY5l
         wYQ2dW8NeBCzjwnly/8/Evir6hbxKdfoTmtw8ACc/5C0nweEREnUNSjhfoxL146bZiLg
         Aw0Xg9rkmpOGYX/qwx16LkK3/KSXweJF8f1Ja+42rbAaqhrWjHyujQ/j/QaJohd5V6CQ
         +kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0o446r/7sfNrNMbiwlFxGJePev96CeNNzqsH+vREsX8=;
        b=HVOEBK1EO0fSEsa2AqNjnP2PCrO1NaURFg2hl6oADd5zQwnr/aEnsURp+0MdkB9zQP
         zUF9i53ukE1ltPFVTvWJ9vunN4EytHd7/61K6fjhVxunyhaUVV+1mUtgYbwUJQvY/Dx8
         +l4izoTdAgm9KYnAoPNo0Jy1kY1S5pE5SCoeJOzDPEH+mWOnzNZOmujiN/JmXwRC6VkP
         8ACsdR2jEezjKwSvHe1aJKlm9wFtjODNI+jdddcwChYPwJXLH0f+1QMJx5S0dikqUVSS
         LrkwInowUHybsaiBYlULgVgNEs37U5szdnt6YHo4oX2aCqi3LD9ZHsa9f1b5E4szhMPx
         /QBw==
X-Gm-Message-State: AOAM533zxYejlr4oaeHfjkfhE0HxWI9zh6x/M8BWx34cqpsS4dj2evko
        oTOHvLuchqkI28M2bpCdeCY6wg==
X-Google-Smtp-Source: ABdhPJy40W+PZAbNiUmSORK+HY3by6NS2OcSzoL5kUbSYa1SMUjm7J9uhh20bQCKaiilyG3zYfMTCA==
X-Received: by 2002:a5d:6289:: with SMTP id k9mr3282521wru.200.1611044621936;
        Tue, 19 Jan 2021 00:23:41 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id y14sm29847493wru.96.2021.01.19.00.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 00:23:41 -0800 (PST)
Date:   Tue, 19 Jan 2021 08:23:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     AceLan Kao <chia-lin.kao@canonical.com>
Cc:     Campion Kang <campion.kang@advantech.com.tw>,
        Rob Herring <robh+dt@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v6 4/6] mfd: ahc1ec0: Add support for Advantech embedded
 controller
Message-ID: <20210119082339.GI4903@dell>
References: <20210118123749.4769-1-campion.kang@advantech.com.tw>
 <20210118123749.4769-4-campion.kang@advantech.com.tw>
 <CAFv23QngmvuKZb0_pK7RBa=VX=2ypabg5p1+vSqrT36CNdJhgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFv23QngmvuKZb0_pK7RBa=VX=2ypabg5p1+vSqrT36CNdJhgw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021, AceLan Kao wrote:

> Campion Kang <campion.kang@advantech.com.tw> 於 2021年1月18日 週一 下午8:37寫道：
> >
> > AHC1EC0 is the embedded controller driver for Advantech industrial
> > products. This provides sub-devices such as hwmon and watchdog, and also
> > expose functions for sub-devices to read/write the value to embedded
> > controller.
> >
> > Changed since V5:
> >         - Kconfig: add "AHC1EC0" string to clearly define the EC name
> >         - fix the code according to reviewer's suggestion
> >         - remove unnecessary header files
> >         - change the structure name to lower case, align with others
> > naming
> >
> > Signed-off-by: Campion Kang <campion.kang@advantech.com.tw>
> > ---
> >  drivers/mfd/Kconfig         |  10 +
> >  drivers/mfd/Makefile        |   2 +
> >  drivers/mfd/ahc1ec0.c       | 808 ++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/ahc1ec0.h | 276 ++++++++++++
> >  4 files changed, 1096 insertions(+)
> >  create mode 100644 drivers/mfd/ahc1ec0.c
> >  create mode 100644 include/linux/mfd/ahc1ec0.h

[...]

NB: Snipped 1000 lines.

> Tested-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

Would you be kind enough to snip your replies please AceLan?

It would have the benefit of saving a lot of people a little time.

TIA.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
