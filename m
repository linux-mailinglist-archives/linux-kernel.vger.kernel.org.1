Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C74F28FCA7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 05:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394004AbgJPDRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 23:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393997AbgJPDRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 23:17:01 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEF5C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 20:17:01 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id d15so725221ybl.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 20:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KY/tuIGuq4k+2bQSU0FmKsN29zRHniIqcVg7NZ61R/w=;
        b=WdDINPhfc57T68jqvUDdBWyWyVF/gEZyBeklwsbWxmE+KL4lP2IqLv0ppmMlVWZLE7
         3PI+tKsw9Z9UtRWniYVXklX6XPKXNYE2ZPb2nM2RVHxTtsinV+hKpeOOoewHTFzkqpOM
         Sia6Dx1U70HrNuyU72s/v4p2N1lEG/+4WhQywpCplQLh2aKGUG03j30Gowi6qspz9lCr
         R/S47CTeRvP1SI98rm8CdS2Pc+toRswLoYn71T8eouELWSGvzkFtNtCAggC5PkezweHx
         NJXRqgiB4HuH8ujT5GutJaxo3Af15Mds8ehlLKl50bw78RyP2qtaC/VBxEhVHO3oGU4Z
         2WwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KY/tuIGuq4k+2bQSU0FmKsN29zRHniIqcVg7NZ61R/w=;
        b=swLOP3VvKbSvOxrtEUgjB6njiazEGGR9M6Mg1bm8Nz1Z+7UXNl7DmD0Wgnc1pecN09
         aF/lVXVZsZOrI5FDr4/F+QZIP4cIUMsoYhGtftdMk3MH8jiIm/NThhP8VK1lqSCP+iQH
         B1+CUvKmrSDpDedpPS7Vzx9J81RbbL3Bx9I3zSyeEe4/28bD590olcV8APGGVHO1O4NG
         siZF1TVPXmJYxAw2GKgQXb9hPpHIGe9aOohcuyC+0PWcjjvayzIWjrehkY94iRk47utJ
         F7VFDW4F6oFtOGd4bzzwOTCCsLoE3CDDwTXlIBZDVqUINozvf2Advvyi7yoL79DnIAcF
         QfzA==
X-Gm-Message-State: AOAM532b5nktQN1NzG6Ny7eyDkQyXn3PkUaOKXV4a/Cqpx167LYfunGT
        6A/uqMAeRIO7JwyiL8gg3zUl1sZmH6JtcZlacUM=
X-Google-Smtp-Source: ABdhPJxMSITNjmBnTyi3xG0VOJPxLOesJx27+MDE6Ryjk86JDubfuTei1UgWRSUJAiKGYScqf9kQCeGp2CLeALaVEg8=
X-Received: by 2002:a25:d441:: with SMTP id m62mr2141846ybf.422.1602818220915;
 Thu, 15 Oct 2020 20:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201005130128.3430804-1-poeschel@lemonage.de> <20201005130128.3430804-2-poeschel@lemonage.de>
In-Reply-To: <20201005130128.3430804-2-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Oct 2020 05:16:49 +0200
Message-ID: <CANiq72=mKdwhwAFRE57ddwywYoJ=tyQasADvxLuMJsABwt9CNw@mail.gmail.com>
Subject: Re: [PATCH v4 14/32] auxdisplay: Move init_display to hd44780_common
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 3:01 PM <poeschel@lemonage.de> wrote:
>
> The init_display function is moved over to hd44780_common. charlcd uses
> it via it's ops function pointer and drivers initialize the ops with the

it's -> its

(Already corrected in my queue)

Cheers,
Miguel
