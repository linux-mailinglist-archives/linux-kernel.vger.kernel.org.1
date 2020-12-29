Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BB12E723F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 17:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgL2QXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 11:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgL2QXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 11:23:54 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1627C061793
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 08:23:13 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qw4so18718732ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 08:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpOzHh6y1INWl7zzSelCcrj9eLoAEtCjCcdN755O9hI=;
        b=yyzqXn4Ea75b1WKZ6qQf1rODlgLK1tmfni7cQLFs1EG9AZrp47FrdDE1qQXF8ZM7LK
         KXLnjc1juo+pdBy/pbmU08uMAggNq5QV0RLpl038md17GVMhp/qWcA+ON8AykeWGC6XP
         pVOASRH1JTF8eC6ehOOw/SHpVzPjw1GP5DEG6u8sQ9q2mGENNGl8A8HHZEzIqySz6k/C
         wVPU1Jovmg9KxljjOTcg8YRQv5rBdSh3GPooct+upLzu21KP+5KUBFJN3+T3y7wTvRKa
         kVdMwTWznaBWAXHGW9hBDfS8HK6i9+66iZc2z5L0PstBhcWYRXpSfIKTuwmch/ceoU8d
         GTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpOzHh6y1INWl7zzSelCcrj9eLoAEtCjCcdN755O9hI=;
        b=Moe6PtXCrkUsSZYRH4wQ3wSZkfbECQiUiBtAvgZcZgnd0NWnvTMxG4+itvcSu4O1sP
         W/cPFMesspSRNwJ5GzBQSDeLyyex60cf/N1jqV7yZtIr2iWWa9xv38jA2ltP7zD9Ir1a
         YJgcNCq5Zhzmk1/4JiFl4XGAybpohd5CKt9Dn3ryB6nVws2YWD74Kl8yg6o529LEFNgl
         +wOHteCoRLawWOS9tCZXYcgAVVyLOkqCgF6kjyEEXo9Jb51myCToeK+Y08GTSsBv6Kcx
         y/lbJrxxXf3HmX5fXa7PbMH3JZmWU0nCAoxt8j/VyRep0xYI+uceDZh5gczzavlZxWzg
         Ip+w==
X-Gm-Message-State: AOAM532u9kO4de+CEdo5UTZxulqmMDEtJO0iVmChcT1jrNZUHEzrFpZ1
        TogZPcEYopO9Q6Zzx9z1Vfy3jp6ka3Dn183U5PmEww==
X-Google-Smtp-Source: ABdhPJzQB8HPp8RbHxPIG3HohPpgFl6lQXZoYVkykPnmeLXH1HQsdysVfr5bbJG18L958b6h3Hld0UL1W3vbvFZnOBg=
X-Received: by 2002:a17:906:2b50:: with SMTP id b16mr45072726ejg.255.1609258991366;
 Tue, 29 Dec 2020 08:23:11 -0800 (PST)
MIME-Version: 1.0
References: <1609191951-15590-1-git-send-email-tharvey@gateworks.com> <20201229130629.GD4786@sirena.org.uk>
In-Reply-To: <20201229130629.GD4786@sirena.org.uk>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 29 Dec 2020 08:23:00 -0800
Message-ID: <CAJ+vNU3hWOdXUoogCH0U_WvYaMMaFBYs8D30KEg96ctgkhBqyQ@mail.gmail.com>
Subject: Re: [PATCH] regmap: irq: do not allow setting irq bits during ack
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>,
        Robert Jones <rjones@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 5:06 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Dec 28, 2020 at 01:45:51PM -0800, Tim Harvey wrote:
>
> > Some interrupt controllers may not de-assert their interrupt if
> > bits are set when acknowledging the bits that caused the interrupt.
>
> > Take care to not apply the mask to the status until we are done
> > acknowledging the interrupt and take care to mask the bits according
> > for the ack_invert state.
>
> I can't understand what this commit message is trying to say, sorry.
> Which bits are you talking about when you say "if bits are set"?  Isn't
> acknowleding the interrupt clearing the bits asserting the interrupt?  I
> can't tell what the problem you're trying to fix is.

Mark,

If for example status=0x01 the current code for ack_invert will write
a 0xfe to clear that bit which ends up setting all other interrupt
bits keeping the interrupt from ever being de-asserted. With the patch
applied a status=0x01 will result in a 0x00 written to clear that bit
and keep other's from being set.

Tim
