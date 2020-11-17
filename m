Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27BE2B70B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgKQVKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgKQVKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:10:49 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FF2C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:10:48 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id f11so32133152lfs.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qvLQy5uXFpIrg6tKYvqeLz2PzWU29eE1D3GlGEf7hA=;
        b=RQGc5BDlqCxPdo6QO0uTD/X3Hcx7aIM9LLRlWuTXrjTLDGNHalufPHT/+S1VuDQ5IE
         ZfRVxzTnC/a6N8EPqu0vPEQrEZy/xiR+EYgC+CEnT3+eP5hDz3tKZNIfEnM3hoQlmjL2
         CzNNGCo6/aA9uoXrwKktURNVP2nGcbx8ZMsydDJ81n2DQPR8yVbJBC3FlyeDJ0SOOz77
         2Uu9uL4oZJMJFINAYCg1lkMPoonWbBw018agy/RRIufINIn8G3jx5XYxKdrQILDngm85
         K4krG8aRB8y2AitVMIjEjv4b8BNhYV/6oh9MxzLUSAygxd8M0evOGAHQ3nrTCkMoO53F
         yPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qvLQy5uXFpIrg6tKYvqeLz2PzWU29eE1D3GlGEf7hA=;
        b=cCbsPvziSwit5lVuhOA6oTIrJdAhAvaiPE2i6wWcBtovRVZNOmDnQeBjoaJlNTmtuP
         u/17LIho+d3buL1J3NKQoKCAvl86AOUQ/DzOR7qHp/19UH11uEDl0FxdourGBG/pGa2x
         uHb7bnQs/My1/CQc2pDA4FXn2l0dCX6oeVfTcNfzpO1rFZiHJavsPL0LIN9mj3SJiawZ
         W1Wn7qQulD8TfXVJmW8WupKIoZklWx3ov7lCplrPqDM3YFBkmZgMK6/FbqD2k3DHg9Hn
         m5BwPDN9NlIl+yI387ef3JFIafrxFDUjJUFldVneaQi+huB2Sk0HD25zrRkuIAj7Fg68
         N7Tw==
X-Gm-Message-State: AOAM532H+InSQnF2k5R+GZ/HebaWJZbs+Zh3HXjOXZsN7afPoWezj2dm
        6C9ahtgXet081z/RiJfgdSVJXx3ZhgbzmeCz8xWzAg==
X-Google-Smtp-Source: ABdhPJxkBvjPwPqdZfFC0v46RqXEY3h0mC9gU0DWW5QyqY1whnhbT6cH9oIiB3zYhnME/r0H//P+GtfhkSgfahbkzRc=
X-Received: by 2002:a19:8686:: with SMTP id i128mr2305571lfd.333.1605647447061;
 Tue, 17 Nov 2020 13:10:47 -0800 (PST)
MIME-Version: 1.0
References: <20201113182435.64015-1-andre.przywara@arm.com> <20201113182435.64015-4-andre.przywara@arm.com>
In-Reply-To: <20201113182435.64015-4-andre.przywara@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Nov 2020 22:10:36 +0100
Message-ID: <CACRpkdZq=RBrJ52vbSguTQBdyfACNQxyCLA6yvtVqZvv1ndaCQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] ARM: implement support for SMCCC TRNG entropy source
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
> Implement arch_get_random_seed_*() for ARM based on the firmware
> or hypervisor provided entropy source described in ARM DEN0098.
>
> This will make the kernel's random number generator consume entropy
> provided by this interface, at early boot, and periodically at
> runtime when reseeding.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> [Andre: rework to be initialised by the SMCCC firmware driver]
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Excellent idea,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
