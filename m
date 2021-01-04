Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D872E9440
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbhADLo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbhADLo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:44:26 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9A3C061796
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 03:43:45 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id 6so36396563ejz.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 03:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=s9b3G+1wnt0fqvQLZfc718wWCxYrFOqLj99ZBc9EiHo=;
        b=N4K5zTpfvEf9GyU5JoMNLIDIR+zWfC22FxvyvteNXgVR4rh56MRqOLVSZtaMupaRQP
         gIo3JpiGBYilVXPLMr/DWadV17ubcrqiOsqdkylrBeGCBRjrx2p2l+rOTSfRctypDTyQ
         PSlGBmczgSBzk6oJ5c2BiMtozqaDqZUfUceiY0Gj48bEpdLY7MmiG1h20fRD7Tv7Y+8o
         4jcb1kk53TO7c75op2kUmtSLN+wWfZPQRet16PevqVfSKjTMHPS189f0QAiPxRO3tA0N
         kRyqQB4tYaGQSjRmWpEAV/8RLIbA5TSBiFW/Ikae3HP5KC8dAZsEvktm+ZXLuznoNTi2
         av9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=s9b3G+1wnt0fqvQLZfc718wWCxYrFOqLj99ZBc9EiHo=;
        b=l/mQtolG+FgK94YekIHqDDV+j8jqF/l+sYbf9o40Hfd33xTiwwcEN74jNkdZpF3TFU
         wOZITu7KK211XtT4lO7OoeuPaHJA+CdcHKW1VSNpmYFCnZfoXAmKa3X7ud6627+iCJFa
         YRGyifrt1uiPRr2ccvDdktSaZ9QRAAJDDcIW9B83pn3YhIvxUcN3sr40G5US1jqmjkTJ
         R2sHNCXNtI8U7NJnxkY2T3uWx5C9IEmwjpFUvN9n98+1QzTgpddBiGZFI1sYGj6c2gR5
         KoDK8EZgkMj5PhdAeUUiUcaP41ZDqd/3GKAtdFV7CKyi6vMz20020D56b7znDj/FDylL
         YR3Q==
X-Gm-Message-State: AOAM532Ge9o3dMFECeJkjUK0fYjzhqKrWG7/l044qK0qtKqKNieh7uoE
        1xM+7IzxAcJ7y7n+S9hrRf+e6A==
X-Google-Smtp-Source: ABdhPJwGvjTksyTEsh8ZsoIujwHjf6GyWgK9chy76WycbY1TeT6KTvHXkYeyko77ghZGFlgSLXZg9w==
X-Received: by 2002:a17:906:b793:: with SMTP id dt19mr65969463ejb.120.1609760624753;
        Mon, 04 Jan 2021 03:43:44 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id e10sm23445564ejl.70.2021.01.04.03.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 03:43:44 -0800 (PST)
References: <20201221183624.932649-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] clk: meson8b: cleanup unused code
In-reply-to: <20201221183624.932649-1-martin.blumenstingl@googlemail.com>
Message-ID: <1jwnwtvseo.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 04 Jan 2021 12:43:43 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 21 Dec 2020 at 19:36, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jerome,
>
> these patches are two small cleanups for code we don't need anymore.
> The first patch removes support for old .dtbs. I am not sure if the
> "fallback" logic still works as I have not tried this in a long time.
>
>
> Martin Blumenstingl (2):
>   clk: meson: meson8b: remove compatibility code for old .dtbs
>   dt-bindings: clock: meson8b: remove non-existing clock macros
>
>  drivers/clk/meson/meson8b.c              | 45 +++---------------------
>  include/dt-bindings/clock/meson8b-clkc.h |  2 --
>  2 files changed, 5 insertions(+), 42 deletions(-)

Applied, Thx
