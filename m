Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567A12B70A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgKQVHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKQVHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:07:34 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53889C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:07:34 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s9so25864133ljo.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CU3SArao2TWZ4ftpyPtxC+WfyQlzJupBDnVENNWncwk=;
        b=MkMcaVbTxLTZpAT/mEkoIWFl6DigDOHiaDGRkju6/uwWFrBPkoFW8dE+HcjteM0p2u
         m+Nw4OK1do4dVQdQfbJEZJJ/8c6tyOhrf3Vn6V2ijRtDw0AkkXb88yCcxv3IG2fquPCk
         jTQMga6bREVPOmcycJ6xsqiQtbrYme2RskC6WoJ4BAI60dq/t/HGKnUFtyQZEvWQ57Xd
         AJrl6iO9BnyzTT3mOzOAA8uhVvZmT8aXGY05nL+hh2ZD0aMC+4MVKPMAzg4UaDWbQx32
         fdwgv/IxCxbM6+QQFVXHLlJ+EN/arExeCuBIk6eT68SSzVmKVhTeAyOTeEvGtw8KFP4V
         CqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CU3SArao2TWZ4ftpyPtxC+WfyQlzJupBDnVENNWncwk=;
        b=jpPrdhL/KCbw16XEi8fGruMgjfgOP1+p13oRwgIlfgImpAEm4kROC+zr+SJYyeOGpZ
         VKahoIz9wl/AkuXi+iFffGFsHd2HtD5B8w2Qj/TzXBmImv/i/nMT0ks7Nlk/LpgnWFPB
         sY9IGKuIHyfnGvBIh+THFkw15vEarUubp4cJbR9tMYOm7EWnbz2SQ5zqO0Om45HxNTLD
         Vt6f0seT8/D9BVKtF5w6eIeKKly2uqbxiE6oNenzkd86b82aipRatMhTU1ojwGCylzSi
         M9kn6EExD9kill9IidXrNNiQRsrM1s93MIDOBhP6t7oeAhdb4ILw4+npm98AYt7C5YUj
         eV9Q==
X-Gm-Message-State: AOAM532+TBjTb49RCfdAA/L0z4mr5RRAWuiz/4s+HE6CaNSN2jzGSpP8
        b27sa5SAyQq8s3tuCuA9+EoIWkY/kNcrab4EpiuMFg==
X-Google-Smtp-Source: ABdhPJzlSZ6Y0i6Nud9rh7/3FWNWHGInbx9dQe+T9a6EcffyyxO2OhLCKTS0pCIyAgcI2wFON95YKUYHAdi4nA5NKxA=
X-Received: by 2002:a2e:321a:: with SMTP id y26mr2894523ljy.293.1605647252847;
 Tue, 17 Nov 2020 13:07:32 -0800 (PST)
MIME-Version: 1.0
References: <20201113182435.64015-1-andre.przywara@arm.com> <20201113182435.64015-2-andre.przywara@arm.com>
In-Reply-To: <20201113182435.64015-2-andre.przywara@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Nov 2020 22:07:21 +0100
Message-ID: <CACRpkdZ6ufvhUXci=64sXq=7LTW0SJ-Mb-YyhpCBPQhttSRpEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] firmware: smccc: Add SMCCC TRNG function call IDs
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

> From: Ard Biesheuvel <ardb@kernel.org>
>
> The ARM architected TRNG firmware interface, described in ARM spec
> DEN0098, define an ARM SMCCC based interface to a true random number
> generator, provided by firmware.
>
> Add the definitions of the SMCCC functions as defined by the spec.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
