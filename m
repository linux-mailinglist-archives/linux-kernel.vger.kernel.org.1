Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640E22E7D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 00:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgL3XEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 18:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgL3XEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 18:04:41 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA04C061573
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 15:04:01 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id y128so16032070ybf.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 15:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ql83ZaG5kFTGr0FRYfJCOpqal8HcPkgkn8hYS09mDDE=;
        b=lCsDfUashp3z6ValkmnpLjSij0RAg+Z8sdoIxNK5F941zulEhW1OKwAzpHpbCnVOsI
         sLGMmDP+guKpcQ6J3YcJ1M6VRHtK7/ezulZLjJtcvy6mMBpjOwm0tiZYIyGGefT5DSe2
         hJwu/hWo/eFhgfzfaw/LXvR5sD6TxX0Kgayde7RkmO/OYrry51hZn0JrNFHB+LdYFLi6
         4No7AZBdXzyA0MQUIz8xUJdw+LzD6E5El3UERt2A6at+CjeOJb4x2l33jTnE/l+InNCx
         +sSZRQT/aiFK0b+VOqdYQhC7EkvzMdG+neGDoMNHYTDmBDuOG8zwcJVuOnuXe/tMfCrQ
         PojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ql83ZaG5kFTGr0FRYfJCOpqal8HcPkgkn8hYS09mDDE=;
        b=Vg+uiJD1knwEOQeuGGP0fR61sQPL7a9L7TDWir8wutAf7pyURJrvCQXqbojFHdTVHq
         Lp6Ee5A3UHuRDXRmOebXeZHx34WPR1grQeQYkfpv8ZBhn6r3gaf5FPEiQ3MlNqbe6oZf
         3FVjnhpb2UJHZzeUDtaAVf1OjCJlSdQEOD7gQFjywlVTro8jT90JVQO+S/LQCNbO7xiU
         tsV9xnYnktMxw/eHjk0uGhbITU83u+B7khV9gmHcoEcjoyQ+U3ogS71PVPhnTnna4iWH
         1YLuDdFuZwYRpcWPeRalKImSxxpT+UifEb4vXviqQV2zdIME//wE62HkgYzWTAx4tLyC
         p9bg==
X-Gm-Message-State: AOAM530DG8Xy0Dy+Rb4ah6eHLbxjlGB5xuzA36MLAuBhyN6iPzQBf8B2
        Rdq/Oi1GXqPUJcUNALV7r7BoMNKHsDYmM2tMyVAuJojp6kI=
X-Google-Smtp-Source: ABdhPJxEfxk1Pk0IblLg2TfIh87W3VroLhRQTNc099ozpfNxp6EM10p3fTD388jHr+K6uMSsU/5GtsVXQe66RMt1Kcc=
X-Received: by 2002:a5b:949:: with SMTP id x9mr80792474ybq.33.1609369440456;
 Wed, 30 Dec 2020 15:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20201230155506.1085689-1-arnd@kernel.org>
In-Reply-To: <20201230155506.1085689-1-arnd@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 31 Dec 2020 00:03:49 +0100
Message-ID: <CANiq72=Ac+VtzYbU_Hftb-aJv2vkWN2M2GU5_Atc0q2s_otnqQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: avoid cpuidle link warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Joe Perches <joe@perches.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 4:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Change the definition of CPUIDLE_METHOD_OF_DECLARE() to silently
> drop the table and all code referenced from it when CONFIG_CPU_IDLE
> is disabled.

Re-Cc'ing Nick (Arnd's email had a wrong address).

Cheers,
Miguel
