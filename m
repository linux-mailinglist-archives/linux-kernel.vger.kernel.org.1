Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87BDE2BB5CC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgKTTqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbgKTTpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:45:54 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08DBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:45:53 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so11273770wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=C8pk3+3XmA9EuaPzcL+Mq85e1ZBFbHpA0gmAlogKnMU=;
        b=BhkryZi3Y2xC3KUBGfOVMsXE+KYJELfJh8pm0FQZKxYSyH+dO8wGVehK8Q38axFABP
         Ez3z/2tBYX83YxolCFpvcUEdz7Dp79qW8a5tsS7jR12MAmEd61fzeADiiR8zmVUQ1jsE
         ipMzNAwbTqNdhx46m5ZsMDFWH9KI+mssqjIxMa/Z0aKalxwPPUNL9YGTuhdhC3uNnWZ3
         Obak5Ul2plu3/f1uIumAojQ1ome9VNko+bM1tVBU0CCc0qcaX21bZgTgcnkEIU8cM5sz
         hRMj0BBKAVgvWGOaPUeNj6hIMJaIItOhasw4yo7iJjTLrx3J5G0XSCtXpjd60sE4Tc1p
         3zSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=C8pk3+3XmA9EuaPzcL+Mq85e1ZBFbHpA0gmAlogKnMU=;
        b=ZRktcLi7ms7QvHfgPD3CKkHtJ3tGmdGPsSNMxOQ02Am0KTd0FZqx7s+v2br3O22ghP
         f5LFRQnZTlyr4ssKayUv6szU7bz9U4hUteBUQiG9gN+zX2B2M25g+X3C2J9FLaevHWVr
         +bmXskjLn7KzZtw4WpOJOHwr/RJHEKbWuXmPaE80sOHJwTirUiwh4wYrChk+z+Sy8n9x
         UAE/f+aE4ieybJ52iNu7QCjrFYYKby2WxpOEATq84A7P5NjB+qWcQ/o68dEPTqDWz19q
         h0yIL2WPmLRZiTawYgcz47H6mZ2KX+jcxB74/W6mj+MF8P/IvyQ2VGHysQ1x4CmuXdS3
         +etg==
X-Gm-Message-State: AOAM533GsXbMAT29SjnlWnfa71br9frmRTup+kXdk7C4Rwqvlv38XXc6
        e8JmCjezVVoMpLBUX3ZV8b9UJZA/otP5RYhE66Y=
X-Google-Smtp-Source: ABdhPJx1s2VWNHnr6Kwi0hRZESmXdVLf3f/zB4xBFNnc+j8qo3jEUK/vscFfbY69QgDyv+MnkTHktQ==
X-Received: by 2002:adf:8030:: with SMTP id 45mr17735717wrk.407.1605901552466;
        Fri, 20 Nov 2020 11:45:52 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id i10sm6628173wrs.22.2020.11.20.11.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:45:51 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: meson-axg-s400: add support for USB and PCIe
In-Reply-To: <160589952950.11499.15261993036625823660.b4-ty@baylibre.com>
References: <20201120153229.3920123-1-narmstrong@baylibre.com> <160589952950.11499.15261993036625823660.b4-ty@baylibre.com>
Date:   Fri, 20 Nov 2020 11:45:48 -0800
Message-ID: <7hwnyfstg3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> On Fri, 20 Nov 2020 16:32:25 +0100, Neil Armstrong wrote:
>> This adds the USB and PCIe to AXG, and enables USB & the two M.2 PCIe ports on the S400 board.
>> 
>> Dependencies:
>> - Patch 1, 2, 4: None
>> - Patch 3: [1] arm64: dts: meson-axg-s400: add support for Power Controller & MIPI-DSI PHY
>> 
>> [1] https://lore.kernel.org/r/20201120152131.3918814-1-narmstrong@baylibre.com
>> 
>> [...]
>
> Applied, thanks!
>
> [1/4] arm64: dts: meson-axg: add USB nodes
>       commit: ca91acde9a9858a20522abbb2c79c6883ef9bc73
> [2/4] arm64: dts: meson-axg-s400: enable USB OTG
>       commit: 160f1630878e11668336fded29eeb0fe82fb3faf
> [3/4] arm64: dts: meson-axg: add PCIe nodes
>       commit: 9bfc5abed67ae7dcc837dd8f6d61396d1cc9ac2b
> [4/4] arm64: dts: meson-axg-s400: enable PCIe M.2 Key E slots
>       commit: eee685ef92d8cbabb2a61c45fe7d976c3ebc9b1e

FYI... these commit IDs are no longer accurate.  I relized that the USB
patches were already in my fixes branch, so needed a rebase.  I fixed
everything up locally, but the commit IDs are no longer the same as
above.

Kevin

