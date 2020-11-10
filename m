Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F772AD9A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbgKJPFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJPFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:05:02 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4590AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:05:01 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id d142so3301300wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=mnaZygEEW1L0eKNF/s9ZSCOZcbczK0jgd2fEk5wQNyQ=;
        b=dFrJt5SYmJLmd7L4u3fAU9JCBeewE2bpolNKNt6xGHVlTdyJBdODzAIPF3IkGIidJv
         Ps3vPKmpq+99RI48jh9h3oSLMFt08WOe+BHrfmvce/OJ3Fz1jgk7PzKlrzzZ7czqeZjf
         rYfFk2e/04fh5iKdrYJb/wgQPSDxRxHseX8Hn5tdDza5KusU7sHQoN2/aoy4IFsGqM9s
         yljSFjtW/A8PpIz2XFN0OMaoBrrXotbHnwnm+XWT7bP7YNMcyc/jdGV5sd5cJfMT2jG6
         PjEtuZXfIEHNUetIOtJSUTHsg889CrZDqCuqV2NavrW4uYgbE2MUc3J9MqbvL4uwDeXC
         tsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=mnaZygEEW1L0eKNF/s9ZSCOZcbczK0jgd2fEk5wQNyQ=;
        b=RAllAwF7TdLbEtVJOxCvD1gsh/sr0APE4pGv1j7EvKI+//L6DWf+ZrmEjXi7rG0epQ
         ThfdRmt5kOMvb71T9wFg79cdO4tqoxAfRV+9zmvlEFxUsEcXAfhbzpHBBueABNeQ7Esm
         9g/qFfqREUrskiPjW3yZPDJ21tcicJDEjJSCLGJEc2bCBf8phWJxRbtVPBe0F8nADX88
         690av1s1N+n6bCSyeoajs+MKgeyDn0seJaR/CfjiInYL2jsB04ZtVWUA0Lg1Dh3S0/kV
         g0xJkU58BBEjkiztISfllI4WL3Hy1sFWwXlGKgMonzRf/dOOSsUU7ANQtcSwSPBWE5PZ
         8ZYA==
X-Gm-Message-State: AOAM531QW9aGLkd+xmYnzA9rx9P5Tyaj8xclQBa2rKk5v2FT3rD18QvC
        knLgPfd5D/USP7xXCzj9OLaTmA==
X-Google-Smtp-Source: ABdhPJzUBuNa3CBkQzOs1OJPVLefwvgQPpcWsF5MW6vdx8EKZK2HrPJkUvozcAucIrRAmP5DrGcUrQ==
X-Received: by 2002:a1c:2803:: with SMTP id o3mr68858wmo.97.1605020699866;
        Tue, 10 Nov 2020 07:04:59 -0800 (PST)
Received: from localhost (253.35.17.109.rev.sfr.net. [109.17.35.253])
        by smtp.gmail.com with ESMTPSA id d3sm18037975wrg.16.2020.11.10.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 07:04:58 -0800 (PST)
References: <e4e6cc45-bc18-40ec-035e-fdb45b9a8f46@gmail.com>
 <87o8lf74j5.fsf@nanos.tec.linutronix.de>
 <CAPDyKFosR2wd=jqADBF_dNd3kCMbM4oDAHyxiYC-5RF=SZ_E5A@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Brad Harper <bjharper@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
In-reply-to: <CAPDyKFosR2wd=jqADBF_dNd3kCMbM4oDAHyxiYC-5RF=SZ_E5A@mail.gmail.com>
Message-ID: <1jzh3p9rs6.fsf@starbuckisacylon.baylibre.com>
Date:   Tue, 10 Nov 2020 16:04:57 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 08 Oct 2020 at 11:08, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Thomas, thanks a lot for helping out and looking at this!
>
> It looks like the testing of the patch below went well. Are you
> intending to queue up the patch via your tip tree?
>
> If you need any help, just tell us!
>
> Kind regards
> Uffe
>

Hi everyone,

Do we have a plan for this issue ?
I've had Thomas's change in my tree for a month, so far, so good.

Cheers
Jerome
