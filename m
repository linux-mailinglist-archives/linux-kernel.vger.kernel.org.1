Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D262E7D11
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 00:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgL3XAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 18:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgL3XAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 18:00:04 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1925C061573
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 14:59:23 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id y4so16058173ybn.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 14:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RU308TXsbRKNQN2D8ohXVQ2eDdwaXONiiW/rBgQevQ=;
        b=idDEdsz/GPnE8+03n8GbAQP8dEY0GWW1lsccljxTO6i4Xr5CsbUSSasgvRfD8gcoU1
         tm5FWzCU5zbHz0vnEKY7Oze459K4se1vAy7szEmcrGFDRmfLuV32qjITeHDM3JwqMX7D
         EWsQu4S5CrnAc2K5PA9mLdMKmMZXI/qrVuul7fAOcO79Xb0FguHXJe40Q2OK8UyfwrSn
         qG0SgK9FFq/BH5ET6J38n+yxz+HX3isb3KuJjEcLpTDO8yDzZhLBmt9vppUP9Mupi0qR
         LN6LAMYAuSv0r9+AhtBLcWQsP6dUmPhdNmmkolQPMW2ClzC2SDwCJWTVZj9pZOH/55S8
         zEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RU308TXsbRKNQN2D8ohXVQ2eDdwaXONiiW/rBgQevQ=;
        b=ddHv4Xp5Mg2BPXbULUIPYFjyHQACJ+zt2comr435Vw3HQ7ODakbdNWbfW9eZy+myuh
         MZu7NSG/nAu51kRzgT/AuMQDQtXaRBFTgkaOqBh1X++dXgiYILZbh/GexQRuoscAVmBS
         QqdBR3vbTESwYdxN3cAwX8Xi/lxkGDGtFdMp/hneSIa1bBkUWqOp+j0aIr2CUZ3tCpZc
         yvqXKNdlrWVB+HItwTnOqO2now3fHeu9VIC0tgufoTrzMG3eipStwMI1hUl7q7wzghc1
         s0mkiqsJB+oOSLfJCJsZZh6SseLwc7HWQ+XmxFnfDGPG3+M1oZkgxpk3KAu3wQr4rXD/
         3K5A==
X-Gm-Message-State: AOAM532XweFsabyqwrjuBuagK+aOYL/dQTyt33ac3uT288ZWMs/BS/9h
        XIdz5cpiY5PVr+JdIj0g79XSFJPY0N8hLn/O0KI=
X-Google-Smtp-Source: ABdhPJzR6kVReO5N0Ik74PGivRNTqa6ryMECBOSHBewR5OARaSLDIr/EIRcUwnBWFDkD92Pvzt73VKYDA/iFtASJDQU=
X-Received: by 2002:a25:538a:: with SMTP id h132mr74350594ybb.247.1609369163085;
 Wed, 30 Dec 2020 14:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20201230155506.1085689-1-arnd@kernel.org>
In-Reply-To: <20201230155506.1085689-1-arnd@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 30 Dec 2020 23:59:12 +0100
Message-ID: <CANiq72nWDo8HmqdMZbZSHHucF4h9pZPj4UGjuj28Bavc7Whc=Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: avoid cpuidle link warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Joe Perches <joe@perches.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 4:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Change the definition of CPUIDLE_METHOD_OF_DECLARE() to silently
> drop the table and all code referenced from it when CONFIG_CPU_IDLE
> is disabled.

Looks good,

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
