Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5934C2E943A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 12:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbhADLm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 06:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADLm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 06:42:58 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0CFC061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 03:42:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id h16so26975102edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 03:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=kUUHeak7By77zEE1nbDrZjZ6iDrz8DI2SEFaci/HNo8=;
        b=RU8r3tfIPDFn08B0mFOH3NcvWgiJIiwTZxDxiLZajdWdHmiw34jZv37C8KTZfE4ntn
         j6zuN49YJEomqTJJSq4gDNHVt5ZfZSJiySgMHQOWFyrm53BYdBGqgi/wKVY7G7DAuKBh
         itD2GT7XF2OikvaKIJQh2vacbMktfRPCRGfItlrfQ5LIrrBZPBkIidEZ82pT/78816KT
         Ww2dkEt/BpHvSXPMtC3TqWkeYasets083NQAErW7reAFme5T7imT9yHd9cXJd2+vbjkJ
         FEricqrtLRAP3klYRTB/KxDvPw8ePyt76gEwVUDmY42S6te1EpMJ25mHbqaSCQ7lz6X3
         e89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=kUUHeak7By77zEE1nbDrZjZ6iDrz8DI2SEFaci/HNo8=;
        b=PTsWolrjZCme4jzdeE98zzwTDlgsaaX1+NSzSPEILnrQkVUGE6aaMvgLKLplwr13iu
         UvcqiIS8NLsGO46gZZtb27/GFcVpki+SczgO3S0WMzNVbzfJ5LdKuRJq6LYfWX+uoVBv
         pzE/bPjFXtnsKO3DoOmaBKInb1wNGBB3WnupRtAVuCNbEpWCgdjAP6U4nUGVbcL4kRSQ
         h/iiKCr8ob05DMj645XXdmYTyYlSBmOwU3Z1JMDW/eRXv4DVGE18yFqLGTx96gukkxRl
         P0mwzFZZG9HbZEab+WFxeMYScHoklg2E7BKP/g54Rw2TmglY0H49an7EiMjjak+mMeCT
         dj7w==
X-Gm-Message-State: AOAM530vj5zRQAjyjQiCgRiKFlDbc+JO9ct6UkNeSNv+I/cqAiel/GLW
        5P/eLtiURnlQ/kxmvKzhRoSPJA==
X-Google-Smtp-Source: ABdhPJyRwi+RW45/1B4cm4abK49cRjl9sbdLy0nc6xW8Uyqy6G/zun/bQgydWWnxMervmGfomwRPjA==
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr71619321edj.293.1609760536776;
        Mon, 04 Jan 2021 03:42:16 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id c25sm23332482ejx.39.2021.01.04.03.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 03:42:16 -0800 (PST)
References: <20200309210157.29860-1-repk@triplefau.lt>
 <1jd09k4ot7.fsf@starbuckisacylon.baylibre.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Remi Pommarel <repk@triplefau.lt>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] clk: meson: axg: Remove MIPI enable clock gate
In-reply-to: <1jd09k4ot7.fsf@starbuckisacylon.baylibre.com>
Message-ID: <1j5z4dx71k.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 04 Jan 2021 12:42:15 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 10 Mar 2020 at 09:05, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Mon 09 Mar 2020 at 22:01, Remi Pommarel <repk@triplefau.lt> wrote:
>
>> As discussed here [0], HHI_MIPI_CNTL0 is part of the MIPI/PCIe analog
>> PHY region and is not related to clock one. Since MIPI/PCIe PHY driver
>> has been added with [1], this region can be removed from the clock
>> driver.
>>
>> Please not that this serie depends on [1] to be merged first.
>>
>> [0] https://lkml.org/lkml/2019/12/16/119
>> [1] https://lkml.org/lkml/2020/1/23/945
>
> Series look good. Will apply after v5.7-rc1
>

Finally applied ... sorry for the delay

>>
>> Remi Pommarel (2):
>>   clk: meson: axg: Remove MIPI enable clock gate
>>   clk: meson-axg: remove CLKID_MIPI_ENABLE
>>
>>  drivers/clk/meson/axg.c              | 3 ---
>>  drivers/clk/meson/axg.h              | 1 -
>>  include/dt-bindings/clock/axg-clkc.h | 1 -
>>  3 files changed, 5 deletions(-)
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

