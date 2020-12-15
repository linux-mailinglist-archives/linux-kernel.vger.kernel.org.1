Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A729E2DA518
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 01:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgLOAzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 19:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgLOAyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:54:49 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BC1C061793;
        Mon, 14 Dec 2020 16:54:09 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id 15so21459408oix.8;
        Mon, 14 Dec 2020 16:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jgwr0b/sBVKsgL8w068J7d7YYBY9apYQaCRhZY+dA34=;
        b=tbZPN9GraqPXE92iD9fUl6HVslxYDTCqAWyhFRuUmNRz5r33jAEXW9kY4xzQMrvKPy
         EdWaimHGMs5JbpmjIqLns0xz1FKTZCtZxX9z5KoDWwtDF41970Ikrhq9ZPpxu0ylw6kG
         3XKhJKjUQwPoCMZE/pAjyKFXsqw7UbIHC13FU1jk/d0lEnX7hJT1bpDNdtfCAH1H2bCy
         87yZx/UoUhX8fealQsWjKb0b5AA4SP7OcLUQgBUBQyeRgfAhIV88XoOPza31IPP3cy3B
         D5aVDHgK6uupVT6Weilcdz9HkgpI4THAB8dpZHi7WxCe3gjBDN6ti4wqhtJp3+1ij0Vi
         L29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jgwr0b/sBVKsgL8w068J7d7YYBY9apYQaCRhZY+dA34=;
        b=BSNpuaxR9wTAdivSH7Eb6ftoG6xzvib+G77pPSx1t390iscXRnIPZxtpAi2ZKvBxWI
         gkG8QkcXAS8F1CZ6XbKQQJliAvl7Zft3Mra/WJ/S6CQlo4Nm+04Vo+3bxjt6JSXP1Afv
         VpLLVGIE2klUAkzMVBgm11IhlZWf2hBE7plCKGEmnK/1tMoK8m2tdGBs4MaZj10qaMlw
         EfYl3ArOdGQL9KRl2u4kNKJt3V3vy169lzd997OiHxaoS6M3TJzGgNphC6zJyHpl+r5e
         7AISgJ8iXxUJJNucE3gN8LOHpfGVHNtNvQ09CInPX+A9WbuP/MAfCelHjIlbtQMDDx81
         Gpig==
X-Gm-Message-State: AOAM533aQFifNUzOfjz2SiSabWRVMvFml4zmV9TyyZu0n1E04qK3E/Ax
        PQtAttiLRh2IH9rrXcBx/SdOFOqzihw=
X-Google-Smtp-Source: ABdhPJz5svAmooIEUis52Tw9I3iic1Uk7bxUiLFX/g61bnZgBb+YmrWDatE1GqXsovkVZOzQYedbEA==
X-Received: by 2002:aca:b254:: with SMTP id b81mr19840108oif.42.1607993648336;
        Mon, 14 Dec 2020 16:54:08 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 100sm25959otm.27.2020.12.14.16.54.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Dec 2020 16:54:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Dec 2020 16:54:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Barker <pbarker@konsulko.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] hwmon updates for v5.11
Message-ID: <20201215005406.GA232073@roeck-us.net>
References: <20201214213044.27252-1-linux@roeck-us.net>
 <CAM9ZRVs3gBoYYQ+M1qUiLpuFTD0c_vxdNgDTXoXisne-Y8ZwQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9ZRVs3gBoYYQ+M1qUiLpuFTD0c_vxdNgDTXoXisne-Y8ZwQg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 10:06:23PM +0000, Paul Barker wrote:
> On Mon, 14 Dec 2020 at 21:32, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Paul Barker (3):
> >       dt-bindings: hwmon: pwm-fan: Support multiple fan tachometer inputs
> 
> Should this one go in at this stage? The patches to implement support
> for multiple fan tachometer inputs are still outstanding. So the
> dt-binding will be left documenting a feature which isn't yet
> supported.
> 
I don't see a problem with that, the patch has been in -next for weeks,
and I announced that I applied it.

Is that a formal objection ?

Guenter
