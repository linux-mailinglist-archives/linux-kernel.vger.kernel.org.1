Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC5F2FA380
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405253AbhAROrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393078AbhAROlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:41:19 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD394C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:40:38 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c6so10724667ede.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsWzXboGpAJXv9vpOlbeGOk+81oA2YvwloCKYrLMFOA=;
        b=Sa+U/OWQL6mMt+GIu8fw+fY3FrA92oQkIoCvTUAxBuDml0tIvY+55vicO5xc/llY4z
         FLGIC2cx1PavtQE/eMv+O2Y8OzG7nCrchtQFCxIoszPklxhGOXyVgk6UTRkEQ6HYVzoU
         6RJ4cy94/cDhlMawXGpKsksQgBOYBpOoc9qvb/lPxdiCc04d4wjskYsO3P5YG7hX6BjE
         /Z9XgrjkYVsIalX2Pl42T0UEjvMbElAphUH9WJrv59ozXxHZSuF0AmZ3fpozimgdtRBG
         EIWFaC44fjtWunq3DZJvCWlkTCMwGNLruBCOWkymat70cqloPEg7ZEWo0empYpTohV5S
         uUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsWzXboGpAJXv9vpOlbeGOk+81oA2YvwloCKYrLMFOA=;
        b=OCay99R7hbx4vDp6IxC1+hxf0EPMUh/qVwSwYBHL9NkDQrzo8+7DXiqNr7fi3+Qdzj
         vRUbXSgRUvoFP9NkAq6ezAfZHhiP/L+DGs0gmxl9/NoD754YVcTaDV90uJ7B+wZeM/XQ
         qTM3DEENISXW4VeWmE07/mrVSnTR2bMm8wrR5lcdyTdL4WdXlamLPrGukSWvxYoIbV83
         7/bKFXCcK+jCzs5GoSHMYk848uiqdzqyH0q6EZVI6Bg5CbdnfVEy8lT9A1UFzPfXjkGH
         cwpY22UYyzDvJCn2Na8wWhkEsIZG2hi2tTmVkolS3QrTiERo5PDQvLt/CAx1W4OJVS6d
         LNoA==
X-Gm-Message-State: AOAM531lw0CX+k44Ys0Oyw55WgGczbhnXhxmHEij/bIPrFVXes5qqXuq
        Jcn+ZJPn4vE/bcNDoKCwTDSGi51jaAt5iEVy4t+oEqOoa0rRpbE8
X-Google-Smtp-Source: ABdhPJwLNPR8KiRG/OWK0LNSj/48WXKaO0d52vcSqoLDePBstbl1RKIENlGJbPQ8fZgnnILWh2zdon/teynoT3D7aIA=
X-Received: by 2002:a05:6402:26c9:: with SMTP id x9mr6443592edd.365.1610980837381;
 Mon, 18 Jan 2021 06:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20210118113334.966227881@linuxfoundation.org>
In-Reply-To: <20210118113334.966227881@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 18 Jan 2021 20:10:26 +0530
Message-ID: <CA+G9fYsVb-4L65-YjNxVhGWeQySQAQVyQGudDtbmzfZq4g4vFA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/43] 4.19.169-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux-stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021 at 17:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.169 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Jan 2021 11:33:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.169-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


MIPS: cavium_octeon_defconfig and nlm_xlp_defconfig builds breaks
due to this patch.

> Al Viro <viro@zeniv.linux.org.uk>
>     MIPS: Fix malformed NT_FILE and NT_SIGINFO in 32bit coredumps

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

-- 
Linaro LKFT
https://lkft.linaro.org
