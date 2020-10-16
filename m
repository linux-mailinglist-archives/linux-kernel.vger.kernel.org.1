Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4129F28FCB7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 05:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394138AbgJPDZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 23:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394131AbgJPDZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 23:25:59 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F73C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 20:25:59 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id x20so748197ybs.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 20:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g+MCSHQfgSORuZx/1XnTQkQ53w9FR3g4o7/ENoC+YN8=;
        b=UZnBO6UTtk0gYB1onefNKWD2zbE3haDtOYM1nzUDRD/LZYG22i8lCL8lWTS0zqFxox
         iLL4MAR0UejpyPlAdoxx2G6QC5L+bnnqUOMaCzNFHrlAX/Xs0sTurBZNOh5ir/uERaGB
         136NRHJLaEDmUYzJpzBnX9qOLunWLg7kdUJsNtUinM1Jy43WuhQ2+4ce0hgJuGaf/LIa
         YOC3J8KfcfdXe7ODtweuuy1BtmqIzpGu0F9ALxECQ7TldSHEYGRcP3CuioxQvR/UfLHN
         bQantwqzKZ1hmo+A869kiuRu8TrnjUn769clLqmnqWLsy3WV1rCTnaaKvLXjyzBDTvMK
         MTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+MCSHQfgSORuZx/1XnTQkQ53w9FR3g4o7/ENoC+YN8=;
        b=iJDtFlPN5xT/0o5eaMqiWOa+mxZ4uzvn4dPc4GBaweRWZQuE6bZ49PewPOewCMu65N
         CDVZ5ovHoo8qY+X3RCl8cKmlDMUrA81VjvzIPAHSRpBqpS3ioJCToQKJySBw7U1Ywvu1
         4GOqzdAmu2hKhV0OLDZz4z/CqHkjaoB/5nEzAeVNxV+KnU+eLmBoLkakSlB75+95Ny7G
         wsEcm9kAR800bQ+aSggjQ50t9e99VTfp645dF7kxgC7Czctv4EL5os+w48aPcZGBg5kC
         hpee+KpJFRCLOtydlOL/tlcctVEv36GcU6ApwBLjrj3Hfc8Y3p66r0RSnmM3RT0gWpFo
         sESQ==
X-Gm-Message-State: AOAM532Pc9XMd3Ht3qCVIzLWMNeqqkxuCP+xXcJzAoOXQwMIG+VpGcTW
        aX7VfH8AZzbG/4bAe64xnETwJ8fS2XWofGJbzv0KgsYc
X-Google-Smtp-Source: ABdhPJyKI6L8DyDkisiPLTscatUksMoppTzwuicXNMRj/WQJKOaVelOE7ZyQKHFom28UiW+dkQQteqTRLT0KPXs5qx0=
X-Received: by 2002:a25:3b4b:: with SMTP id i72mr2313633yba.22.1602818758479;
 Thu, 15 Oct 2020 20:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201005130128.3430804-1-poeschel@lemonage.de> <20201005130128.3430804-20-poeschel@lemonage.de>
In-Reply-To: <20201005130128.3430804-20-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Oct 2020 05:25:47 +0200
Message-ID: <CANiq72kaDBJX5mc8UwrzdTs7my_Eb96o5bU6v-+FQ5wydmw6pQ@mail.gmail.com>
Subject: Re: [PATCH v4 32/32] auxdisplay: add a driver for lcd2s character display
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 3:01 PM <poeschel@lemonage.de> wrote:
>
> +       while (*esc && i < LCD2S_CHARACTER_SIZE + 2) {
> +               shift ^= 4;
> +               if (*esc >= '0' && *esc <= '9') {
> +                       value |= (*esc - '0') << shift;
> +               } else if (*esc >= 'A' && *esc <= 'Z') {
> +                       value |= (*esc - 'A' + 10) << shift;
> +               } else if (*esc >= 'a' && *esc <= 'z') {
> +                       value |= (*esc - 'a' + 10) << shift;

This should also probably use hex_to_bin() or similar (see my other
comment on patch 24) and/or share the implementation as much as
possible.

Cheers,
Miguel
