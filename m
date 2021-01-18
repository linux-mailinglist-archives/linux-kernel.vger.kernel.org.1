Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A172FA56D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406157AbhARP7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405877AbhARPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:31:54 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539EFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:31:14 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id n8so9825663ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GmHEGCdwQHARp3B4YMUOnTLBy+5mVFsyu+/MErTxaXw=;
        b=kyEp7GIhT1v4d/7XAS32gC6Y1US3M+nKBTOFWVEf8C31ny/J+VWn4Ah5Y7uUK1IPzY
         6G8JJvkv2YC/1Brh51oHQ2vy7aUVI500kvBmDewIuR2SIpI2mxd7lOLydmSFIpMAxDBu
         YG/tnJ2KzkgIlCt4gnfCoiDnL7tKIg6PD26SMQkjY520+Tvd5JOJdZg3t36tzc+a9caq
         sTRUihx2NOoYODclssvdAA3iBdTP0iFwlMNpxKLs4tNQ6jciOVTvXkqFtyMNgJZksINe
         Tf2W2DGwsbAc9vmJZaLrQiSucsfW/Qj+pVka1cD49FdKgZrfVgripRXwJ2BEj47qec6x
         82ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmHEGCdwQHARp3B4YMUOnTLBy+5mVFsyu+/MErTxaXw=;
        b=L5sQywxF6/daQFW/DyOCMP35X6Hq7rql+wTTwOrIx2u5em1jYErHF4MPqZQInsxTyT
         HOLotSFoCVpRZwux0OqH47qz43PgzT21SqpimqrbyO6eo6r3zoEf3psQbAjh4Vcmg8JO
         fnWokhYyCflvuLwQgbIl2LCdSWbDz0I2ad6Ljd+6xCShs+OscqH502h4iEbknhlNLcVs
         ELg6Dgufb+JAa0l6xyN9pQ+4QFxGU/H+3tIs6JYwhC+8c1mjSk6B6TpsMpg7Irkn4fvq
         x72oC/Ld458ZpWh21dga39U2WiQ36Pj1aRV3wytxpW8e5jfw8H+CtKerndB4WTFqlcHN
         BfEA==
X-Gm-Message-State: AOAM530Cjcg6ZRZhrBgACCiKIL3eGCJ15BOrI5fB8Cwqxrw6WADtPbAD
        RHYqGT5aXGuC1qtsvFl3ZO4h5Nwj2IL8cF4ARmGWPQ==
X-Google-Smtp-Source: ABdhPJxcvXvcSXWa0CL8Ppd+eKUAmT4SoQgGohbGuNGPnTU3j8aHn2PbJKj6LH/2Zxb6tlIimw60klS5OZnI5ezoc30=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr93368ljo.368.1610983872916;
 Mon, 18 Jan 2021 07:31:12 -0800 (PST)
MIME-Version: 1.0
References: <1610705349-24310-1-git-send-email-abaci-bugfix@linux.alibaba.com>
In-Reply-To: <1610705349-24310-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jan 2021 16:31:01 +0100
Message-ID: <CACRpkdZHFdUGarbV7Dpf0unde3KYYQ98aHq5V91JYTaetw+fag@mail.gmail.com>
Subject: Re: [PATCH] drivers/pinctrl/bcm: Simplify bool comparison
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 11:09 AM Jiapeng Zhong
<abaci-bugfix@linux.alibaba.com> wrote:

> Fix the follow coccicheck warnings:
>
> ./drivers/pinctrl/bcm/pinctrl-ns2-mux.c:856:29-38: WARNING:
> Comparison to bool.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>

Patch applied.

Yours,
Linus Walleij
