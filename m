Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE232B6A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgKQQlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:41:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgKQQlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:41:02 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E60A217A0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605631261;
        bh=7pdIVoc+TZaIlxSArpWjtHOuX7KNxgJ7y+hDv82ymJU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IKQs2iNYHgKmfbD6Qxh+cE/IuHjFSVQ5BUk8ZmaHhmNorjLZjVGR+yGgImSVUVZMG
         15pP+91xp7AdBtE2u0/u8VlQwD7HSGFnEgqGFPO+vcOgsoHYVx/1xwbrOdqQxS7+HM
         +9i2S66TTTLVDObMENJu4IqCunoTb9kJLh+78EzI=
Received: by mail-wm1-f44.google.com with SMTP id c9so3872340wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 08:41:01 -0800 (PST)
X-Gm-Message-State: AOAM532S8RgD+iPkkCYjBptyIWFLjAm+UYTK97Pbyrhe/UWFDrO3lNp2
        KD07QBo4lPmTMm6fPBdbk0FXL05v7wI2wWxsGW4=
X-Google-Smtp-Source: ABdhPJwzgg8JK2zm2f/hcnHO/zBPrcQ6Nlb7zX5Kzp599tXVS+r9H99PunDPSqye6KQydntansJbfRHx1+iSKYhZ9QI=
X-Received: by 2002:a1c:208f:: with SMTP id g137mr536457wmg.116.1605631260076;
 Tue, 17 Nov 2020 08:41:00 -0800 (PST)
MIME-Version: 1.0
References: <20201110161338.18198-1-enric.balletbo@collabora.com>
 <20201113101940.GH3718728@dell> <c4ed34d5-83a1-98d1-580f-8f8504c5ca0a@gmail.com>
 <20201117123741.GH1869941@dell> <d4424323-25a9-9f70-b2c8-ce464180f788@gmail.com>
 <20201117160501.GJ1869941@dell>
In-Reply-To: <20201117160501.GJ1869941@dell>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 17 Nov 2020 17:40:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3mPQzDr3gzdKAoWKLVKDzysfTvJuFNKR7FM7NWLZ0dDg@mail.gmail.com>
Message-ID: <CAK8P3a3mPQzDr3gzdKAoWKLVKDzysfTvJuFNKR7FM7NWLZ0dDg@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: syscon: Add syscon_regmap_lookup_by_phandle_optional()
 function.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 5:07 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 17 Nov 2020, Matthias Brugger wrote:
> > On 17/11/2020 13:37, Lee Jones wrote:
> > > On Tue, 17 Nov 2020, Matthias Brugger wrote:
> >
> > If you want to go the route for me rebasing my tree on top of for-mfd-next
> > then I'd like to have at least a stable tag, so that it will be easier to
> > provide the pull-request later on. Would that be a compromise?
>
> I don't usually provide immutable branches/tags unless I'm sharing
> topic branches for other maintainers to pick-up, in order to avoid
> merge conflicts.

I think that's what Matthias is planning to do though. If he wants
to send me a Mediatek specific branch for the soc tree, it needs to
be based on a stable commit in the mtd tree to avoid duplicating
the commit.

      Arnd
