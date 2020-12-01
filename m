Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA42C93A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgLAAGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgLAAGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:06:18 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05269C0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:05:32 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 3so607095wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=PxcXUulEgKyT5OqGMviihTXF0lRaKbBQv3juecUtJO8=;
        b=O7tahjFvfV270xsIxQrZzlM6k0pOwQyJC3RZ5+23q7vBo/Af+t8KarNIHs67XtYjR3
         MG5fxSV+idLE+yD9ZEqVpNV4QqRuAIoJyiLNmF2q//gSDnIGLe1705lVNg646dyLIbOY
         l3N7G+Q3Lagwg2lM66LXayYUUQaXmBKIHlxctdOjfTjLLr8tigAnTkRXXLMEoNG+Z02M
         3e+6cb7+kFzE9fvDrgIskCefZrYNXco1DzWq4KNx9hRGsjlPhURp77jFj8P+evOOawzO
         pizJJmd8NdBIIrUF0nptK18nImb9dM8agDGLY5ZiyVbyKqfsJOM4jQ/IyKp+Pk2N/aL6
         r3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PxcXUulEgKyT5OqGMviihTXF0lRaKbBQv3juecUtJO8=;
        b=UWkz+EIDincci7DcZG28NcSlhInCCa+BzgqyNkmpFlZnrh5vATZ/zP/QsIphr/Xa83
         X8ixzEk0IU/SvRA2d/2xxulIfSZ9tXiaTHN7wwQLQxN5M2ae0UPWiFzOl4Z6j/dUGoXq
         dglD0cCLNuBdYjq6lewc9Aep8Krc4Sca2Cc6h5T7tRwv1qq2he4yEQCwUIwtlgmZO9mP
         GKq4jjF6MXuKNnf438FC7ds3+wOPMA4Vc1JpZI5p/HSXxdJ8sHwxBpP+vJjLEHXjuOFB
         bpaR49xOWqTJhXALtpuPzN4LjrUmf30GvnHWvbD9FzuQoKsOGr0M2kquxG6FD+WSDvXv
         FZNQ==
X-Gm-Message-State: AOAM530hIsal1R+tmYbwN8YF8xistlO1MLadPpdUEZSMfkHzQbmSLaPx
        SUnn0lQBL4RMB4CaG2Vsiqs6ZA==
X-Google-Smtp-Source: ABdhPJxDo2whkAA2R00WX2/QVf+Qt3ioNPbxjqDxzSFpgUK0pyo10hiDr+JBjoGg0Wl+Gi6pgaZ9mw==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr319472wmj.25.1606781130659;
        Mon, 30 Nov 2020 16:05:30 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id t7sm27223749wrp.26.2020.11.30.16.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:05:29 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] usb: meson: fix shared reset control use
In-Reply-To: <093933fc-eac5-de56-d314-a1348de348af@baylibre.com>
References: <20201113000508.14702-1-aouledameur@baylibre.com> <093933fc-eac5-de56-d314-a1348de348af@baylibre.com>
Date:   Mon, 30 Nov 2020 16:05:24 -0800
Message-ID: <7hzh2ytmpn.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amjad Ouled-Ameur <aouledameur@baylibre.com> writes:

> Hello Felipe and Kevin,
>
>
> Could you please review this patchset ?

The changes are OK with me.  Please update based on Martin's
suggestions and this can be queued up by the USB maintainers.

Kevin

> Thank you in advance.
>
> On 13/11/2020 01:05, Amjad Ouled-Ameur wrote:
>
>> This patchset fixes a usb suspend warning seen on the libretech-cc by
>> using reset_control_rearm() call of the reset framework API.
>> This call allows a reset consummer to release the reset line even when
>> just triggered so that it may be triggered again by other reset
>> consummers.
>>
>> reset_control_(de)assert() calls are called, in some meson usb drivers,
>> on a shared reset line when reset_control_reset has been used. This is not
>> allowed by the reset framework.
>>
>> Finally the meson usb drivers are updated to use this new call, which
>> solves the suspend issue addressed by the previous reverted
>> commit 7a410953d1fb ("usb: dwc3: meson-g12a: fix shared reset control
>> use").
>>
>> Important:
>> Please DO NOT merge before this patch [0] is merged, it adds
>> reset_control_rearm() call to the reset framework API.
>>
>> [0] https://lore.kernel.org/lkml/20201112230043.28987-1-aouledameur@baylib
>> re.com/
>>
>> Amjad Ouled-Ameur (3):
>>    phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
>>    usb: dwc3: meson-g12a: fix shared reset control use
>>    phy: amlogic: meson8b-usb2: fix shared reset control use
>>
>>   drivers/phy/amlogic/phy-meson-gxl-usb2.c |  5 ++++-
>>   drivers/phy/amlogic/phy-meson8b-usb2.c   |  4 ++++
>>   drivers/usb/dwc3/dwc3-meson-g12a.c       | 19 +++++++++++++------
>>   3 files changed, 21 insertions(+), 7 deletions(-)
>>
>>
> Sincerely,
> Amjad
