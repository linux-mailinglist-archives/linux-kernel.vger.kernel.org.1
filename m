Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446682A7ADC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgKEJoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgKEJoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:44:01 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD17C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 01:44:01 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id v19so885983lji.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fiir3cs5BIpMPK0iWGpD2ThmHy/2pshy4RnyFAgMk+c=;
        b=zXfMrbFGxsDPNcew9ePdDEatydPgID3NVAQwF6vYCBO9qqkf7ZZXYD1scw5CYR/C/O
         gQDyYfRjOdhCMdy/3EXTkZOGXdRrYggs286zU9qbt2qEeEjQROT3Tn8F0RGOauNRb/+E
         JXLC1DdU5Qx9FKT6BOoV856o7QAmrfECMN99MWIC2fViQJsoWnB11MsAvVyMAhOU+INl
         kueH98gMrAU7wXFrUv75Xq8cEw0tNaDo1Szpdk7LpQfhvA5SFcDNQjHu/hSJQ86aZLAA
         uiQET85Ndm+AuutO+W9BUTNF4Bb/2iO03PBCp828vewhQL064TRYL0hPKhPegRZAWQeQ
         1UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fiir3cs5BIpMPK0iWGpD2ThmHy/2pshy4RnyFAgMk+c=;
        b=l1gcWAh+w6QOghGLPw6kNqEmySvddv0FQ1twJPE3zwqonRkvugXz4jQD8GfzzwJz1Q
         xnUoIvu7qmQ/CGhu6d2LwkQPK9gzyq85v2IhWYRn3EYNK0+3jPVntbCuqp+VcM5CLecO
         5fCx14hjUz6H8KhL9Oc0cNuBzNEyhFzsYApT7uF49SJe3ZWXPkcqqKxeE7G9KcyXrJRq
         acC/GXi/1v1MujAvvWUIVceaYHgBvGSlI6JWY2zE8XIusXiQSaRv39x3XLfvfGKl4X0u
         1uKBIlbs2IHaJ3X6A2F7jp+gfl2Jipjnirrbor4130AzLJJaLNt4n8niT56LQQNVd4ya
         qKhA==
X-Gm-Message-State: AOAM530iDH1mAYnHEA3UAiMcRrc/3EKl8xaHRyJjtbSkQaEG0FKCJEf7
        /QgdmZHKnTxCmnt+S7cuhxQ1Icf/Wmi28qmjK4mEJA==
X-Google-Smtp-Source: ABdhPJxkkaqC2wZ8LOOXXjMLKnX26vsGQzSULmY+F/v48CjdY03gPv2euRri5IvoFQWubR8J93pEdvAcrXazw5NBFRQ=
X-Received: by 2002:a05:651c:1050:: with SMTP id x16mr625184ljm.100.1604569439670;
 Thu, 05 Nov 2020 01:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20201019141008.871177-1-daniel@0x0f.com> <20201019141008.871177-5-daniel@0x0f.com>
In-Reply-To: <20201019141008.871177-5-daniel@0x0f.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 10:43:49 +0100
Message-ID: <CACRpkdaF1+PqZaMOb9WQSV57GHsTbch84etNH765pEWa6VmgFA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] ARM: mstar: Add gpio controller to MStar base dtsi
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 4:10 PM Daniel Palmer <daniel@0x0f.com> wrote:

> The GPIO controller is at the same address in all of the
> currently known chips so create a node for it in the base
> dtsi.
>
> Some extra properties are needed to actually use it so
> disable it by default.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Eventually this should go through the ARM SoC tree, but
it is fine to send with the rest of the patches, I will simply
just apply 1-3.

Yours,
Linus Walleij
