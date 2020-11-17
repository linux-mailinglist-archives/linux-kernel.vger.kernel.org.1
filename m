Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A862B70AD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgKQVJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgKQVJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:09:05 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DE7C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:09:04 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id 74so32105652lfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tP9cJu+hNdrnsOn172LWwEbwH/Ks2TMbbDHgDB86rj4=;
        b=aMD+GTc2hgNt5hJdJ56z4JB9b0iJKM8IpM+fayTeBlPntks9GCHZbF+X9JPBYjvwyf
         I4D04AWxW6AtXl7fxyvDYOhvJvqnU1LoFK4bMHOi5ZM1WB5Pj+l99asNfaMs+BbbWo9s
         9hNZMzF+Hkl7KJ2jJ4thTxJ0HiDbpb+0uZdymrHD9WWPspNdV9vG4I0aa6abXX6L25bt
         vq1/LBlie6cXI1Tj/OdmFf2MekXKuHQVD2hg0AQmbCZZr+rlDxenLiiOnlPWEEWHvuuh
         XQzLHgLZSfHkAWfdsWePtMRL5RKw6/gwVtsKtuBQFB16Cm2yCIMKj6gJTQmOSCQCBP9B
         enMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tP9cJu+hNdrnsOn172LWwEbwH/Ks2TMbbDHgDB86rj4=;
        b=IpPjqYkOETtwr7CVJ7txn9/VskALJwGu5IQrucE41XUA/I3rATkMlN57Op1BV8JMBt
         sAtrcLGsZOhuOlUnC8cix77tf+jwrUEBx4wd4ej9P0azGrVLEy0C5VZC3bUheGCeg/SQ
         K7URK5Z+8Lr7DbOSphvbueLuLmts0IZd6iZqG4KeAiW83uI7/qSXr7NlpHCLbSZG/K3L
         oqtgNA76is/CSU/w0trcerPVRVkuUYvcX5Xn7JA8EFxx4mUTXBLVyaxdek4GFbyO/WoW
         5aFWgPD6nIliA00NUL7RLXepsQUiprJoNPybOuB2P1AVbwbsjQI8CLlnRqYevNhP4ixL
         ew2Q==
X-Gm-Message-State: AOAM533I/cU7QXjtVzKuR+9xmPOMY5c+qdJS4+sPRY0+iclE++OKui/b
        Wmau/3ZCLxfY5Wdnqo1CqYu6IncoOnZlacHp1Q73Ug==
X-Google-Smtp-Source: ABdhPJwvNCZp8XRFkmCadWv423VbSz/2KepxoylHmLLrM3J5p/oDV3m3p0jDqJ1J5/8uIJ66xnvr0pmRzMbvuLjIh1Y=
X-Received: by 2002:a19:7b06:: with SMTP id w6mr2610499lfc.260.1605647343529;
 Tue, 17 Nov 2020 13:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20201113182435.64015-1-andre.przywara@arm.com> <20201113182435.64015-3-andre.przywara@arm.com>
In-Reply-To: <20201113182435.64015-3-andre.przywara@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Nov 2020 22:08:52 +0100
Message-ID: <CACRpkdb3fUcidrFabJ-LGQUEJmoOfF29bhOoUhRjA4OA=YBBew@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] firmware: smccc: Introduce SMCCC TRNG framework
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 7:24 PM Andre Przywara <andre.przywara@arm.com> wrote:

> The ARM DEN0098 document describe an SMCCC based firmware service to
> deliver hardware generated random numbers. Its existence is advertised
> according to the SMCCC v1.1 specification.
>
> Add a (dummy) call to probe functions implemented in each architecture
> (ARM and arm64), to determine the existence of this interface.
> For now this return false, but this will be overwritten by each
> architecture's support patch.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
