Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7741B2CC6FD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbgLBTu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLBTu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:50:26 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C8BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:49:45 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id y22so5363669edv.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4zVKv31l9LwL3Zi4B8JT0gj993gpH7RCpWinLvDi7E=;
        b=byQyw/rCL5WknSDvg9jzcJEnKqJFKemYbGne+EUvhUj8t5k9O3Q/QZI0W6c05Zr4BI
         QrIAQi4wO6osAp8+496SSnvNUYZX0NfF1w6HWnT62bWZEm0chWZafcbdP9M1im9i3T2j
         a9AIKcDuqLkZbh5LPogefnLtIwxYg+kuCZShM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4zVKv31l9LwL3Zi4B8JT0gj993gpH7RCpWinLvDi7E=;
        b=E5rLq/tRmUpuVgGoTpYuuXLMV1kCSO6aVP+n2LJO8WckKc5UWSmoKCWv/VoMz8dkxH
         rdL7kVp3nrOKPiTnIp9mLps9MMZiB/dYr5fsXy6N5j8N9BLgjrnoiOdNRbEKSXGcBIsR
         QjPp2RQW5aChlcygy1+GqG5bknEZJcJ/mRN+MWn521xe6SfZ4hRtw9WZz41CoXbA2E+3
         WPO2+Ob/GhnHiNxSpa9cnFjEYXJRe918nzLUzjiGbWO2MbN+JQIp+FHM3MaVXbwwKRBd
         hJ1RqVn8rrP0M1FopdGat0gCPqQOc8wLG5m3cFMikce2Fa5XZVUWehKdtxU5smEhdXQ8
         bEkQ==
X-Gm-Message-State: AOAM532fxMSwUnyrF1JBoobjX0Pa0gwGPW0WO4mC+U2DS9/72nOJUH4w
        TyJuh7+knlAaHeSGBEQGrydZoapeefN1UOrPGUBofg==
X-Google-Smtp-Source: ABdhPJyLqCrQDo0WAkZCtFXQ7s4sFX+7alpkAXw0xb1TCKSXZo0NyihOD93VW32Bi3OFBEu7xQk/JSWapKckYhn5e3M=
X-Received: by 2002:a50:b404:: with SMTP id b4mr1532187edh.369.1606938584379;
 Wed, 02 Dec 2020 11:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20201202194149.180058-1-jagan@amarulasolutions.com> <20201202194810.GA110502@kozik-lap>
In-Reply-To: <20201202194810.GA110502@kozik-lap>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Dec 2020 01:19:33 +0530
Message-ID: <CAMty3ZAnpVdMEkw=ksS=-PTqm0TJowheFBxajRnwBxtR_sgoTQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable REGULATOR_PF8X00
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 1:18 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Dec 03, 2020 at 01:11:49AM +0530, Jagan Teki wrote:
> > Enable PF8X00 regulator driver by default as it used in some of
> > i.MX8MM hardware platforms like Engicam i.Core MX8M Mini SoM.
> >
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> You will have to send v2 of entire patchset, so wait with this till you
> have everything ready.

Thought that the defconfig is unrelated to dts(i) changes. Okay.

Jagan.
