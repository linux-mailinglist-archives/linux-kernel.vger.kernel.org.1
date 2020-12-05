Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995EE2CFF54
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 22:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgLEVnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 16:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLEVnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 16:43:23 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC91C0613D1;
        Sat,  5 Dec 2020 13:42:42 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id m19so13879826ejj.11;
        Sat, 05 Dec 2020 13:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BcFwvccBZsNRXg6tthMMYxCZiveruOlpyGXOybgngvQ=;
        b=jiOiKlaZJLpwxmeKjTWxcVGZCEkUHCWFjES5nFUbk1CJYTGVEBHGjg29kLi2I3rTP4
         m9uZo8fJZqILlx2qptuTXKjm8L3+xYj0ur8Il1W4lB787lPdbAJBSoBcbQDDNpwq8utp
         B9n8Qaa0mIJMAnY9riPCBaVcPSeTQc6u7VB8OWzVTPBk4QT9ecKg857smbCm4YoTwDJ1
         UkHuSfQPCQ1y4sKVFAnCgb9Ms/9dFyvn1N57jUS/WTHmsLxa6JCRlLCvd7YlKffUIsXl
         xPNVSYDHhQKZQJDOkaMPjS7RteEZNrFy7lY63xLz9S7MaWT8F9cXKDpLPWTQD5+SIa54
         FdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BcFwvccBZsNRXg6tthMMYxCZiveruOlpyGXOybgngvQ=;
        b=djEJQuhbewQm5RAT58W317kLG/mcuZ6nc8s6jBipWemUIBqWBLsu+LHzbeIAw7ICJ+
         I/uUt/FYBCcMsAJTR1zfoNsyj9DWExMe/yWGdV0wuCAIow0hjoVdOC56r8GOindL/kWG
         CCvq6kWLROVA5ZDbyskG/NXiaQzm61ClhHqtu+xhi94BHaNiP6WwZY5/Pc5K1+IfprON
         Ml5MOyKlU/vOtLKeX/9hQnLAPK2dD33ExHMfiALOM+ddsgcqVo0NEjGsm05/3sSQxW9m
         JTmAF0Tc0KFt4brxZO0gTdkDTxm2tHwx0bOg/X3iVZthS3x1ZtyCzQViZ5ce8KD6Arsz
         vMtA==
X-Gm-Message-State: AOAM531yKfQXbmBu5CVJb6OkorPlnyNrStHBatAf4gcrMn0sz2nYJs7E
        fppzhPAW7jIdVRhP/zBf+55gnWwW9kjD3K2t1Bw=
X-Google-Smtp-Source: ABdhPJxdspMQ0M3QTYFFajPX5yAwsG+t5ziDkySCbO6inXMBWhcmZmm1k/Sy3ZAXbtQ06tz5Fln037XnGixiih6SJP8=
X-Received: by 2002:a17:906:447:: with SMTP id e7mr5694784eja.172.1607204561424;
 Sat, 05 Dec 2020 13:42:41 -0800 (PST)
MIME-Version: 1.0
References: <20201201190100.17831-1-aouledameur@baylibre.com> <20201201190100.17831-3-aouledameur@baylibre.com>
In-Reply-To: <20201201190100.17831-3-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Dec 2020 22:42:30 +0100
Message-ID: <CAFBinCCovB9e1_AwXv0Jcn3p69LN5KAdzttfZcY+=_TEZTCn6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] usb: dwc3: meson-g12a: fix shared reset control use
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Amjad,

On Tue, Dec 1, 2020 at 8:01 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> reset_control_(de)assert() calls are called on a shared reset line when
> reset_control_reset has been used. This is not allowed by the reset
> framework.
>
> Use reset_control_rearm() call in suspend() and remove() as a way to state
> that the resource is no longer used, hence the shared reset line
> may be triggered again by other devices. Use reset_control_rearm() also in
> case probe fails after reset() has been called.
>
> reset_control_rearm() keeps use of triggered_count sane in the reset
> framework, use of reset_control_reset() on shared reset line should be
> balanced with reset_control_rearm().
I think this should be updated after [0] is applied
The goto from that patch needs to use err_rearm from this patch.


Best regards,
Martin


[0] https://patchwork.kernel.org/project/linux-usb/patch/20201111095256.10477-1-zhengzengkai@huawei.com/
