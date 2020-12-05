Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BED2CFF51
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 22:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgLEVlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 16:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEVlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 16:41:39 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A87EC0613CF;
        Sat,  5 Dec 2020 13:40:59 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id cw27so9628823edb.5;
        Sat, 05 Dec 2020 13:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTqcO35AxhvxIViibGh/0qnvfwCpCuI7G7hw7DZWNnw=;
        b=KXX3O1HHwWY11/RaM9Dzz5CFPEnVqO2861yhp3Zq4BJAOClLzmkJQU5EKrGUqCvAIr
         8/9e2kWmnbhnzIeV+79jDpKC/tvBaleKhpv4uByO9genTkmUpPF5QMarNrn+m8v8oM6u
         30Grfl4Zl4TvrjKwMAqtgfgOj+gwM4bv8G7vqh3+E00U+8wCFGo5fRJfzTLm8+uc+jR6
         aoZPSml45VJLtp4iZsHJsQFuYUuIEHT4QPdfocOKIfVuYYmQeXKp838tIlYla+ZnIdSo
         mce6OSIO17VuyA6L4jHAe8j/tr9LL6GbpkliVKUV36wFqTOg++8Wx1w4FZpDGit9qqgg
         5r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTqcO35AxhvxIViibGh/0qnvfwCpCuI7G7hw7DZWNnw=;
        b=CznZ+Hl5cSPtKNwQqI5BuB8ArRD/ix4gCGA/M77Sp2wc/SB4HMajeDH0TIO8le8k8M
         H6lu7Ki4Fr2JbttpCDl6sM0lWTwq2lxvnQTVjuzBgqX0A6Luorhwr6KA9A4IMK/2xf81
         3j9Y0xRvNEnPNfTKztk1jjG3GARu7JQ8zINfItPNXDDlu0r9SXDD/khUgaAX2h9w4R44
         x2LfcLHZLVbWAp6b3k4wx4W7kPwYJmz5SSeSvRS4XjoKPAFiAxS0AG3FJPA2AZ8R7aaR
         LKUJIpGJIID2aEtLgJW9/GND4ZMzTNwn9oIzYIkC5fBVQB79iF3GUWoRVjLBscobLyJI
         Hbww==
X-Gm-Message-State: AOAM530mJD+qUMGrShF9ChPSjNe/Q+mzLw9VuLH2ZeZTvPxlVw/7c0eA
        bKhliVud2rr8evTbT51scfM1ovmm6H8CqWze5QS0zlULmIs=
X-Google-Smtp-Source: ABdhPJxe+385+jD4f2RXs8pWDhUP+JX/l0jq10BncAnwZ19s8shIO75ed+mOWOsL/O5LZJo8/tufqelytA96zlmZuHE=
X-Received: by 2002:aa7:de0f:: with SMTP id h15mr1839845edv.110.1607204457924;
 Sat, 05 Dec 2020 13:40:57 -0800 (PST)
MIME-Version: 1.0
References: <20201201190100.17831-1-aouledameur@baylibre.com> <20201201190100.17831-4-aouledameur@baylibre.com>
In-Reply-To: <20201201190100.17831-4-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Dec 2020 22:40:47 +0100
Message-ID: <CAFBinCB-pSeN8rWrLz8doZKdeB=_sRL5osS7yF=UT6itcpXnnA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] phy: amlogic: meson8b-usb2: fix shared reset
 control use
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-amlogic@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 8:02 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> Use reset_control_rearm() call if an error occurs in case
> phy_meson8b_usb2_power_on() fails after reset() has been called, or in
> case phy_meson8b_usb2_power_off() is called i.e the resource is no longer
> used and the reset line may be triggered again by other devices.
>
> reset_control_rearm() keeps use of triggered_count sane in the reset
> framework, use of reset_control_reset() on shared reset line should
> be balanced with reset_control_rearm().
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> #
on Odroid-C1+
