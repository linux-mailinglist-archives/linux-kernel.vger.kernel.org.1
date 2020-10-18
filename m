Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8260C291867
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 18:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgJRQvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 12:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgJRQvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 12:51:21 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA379C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 09:51:21 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w141so9745583oia.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 09:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xbr1iyCmVHPM8Z+0u2tLKLLy6qAswXo6NMqrcz7V/s=;
        b=bVmfFn6awNB2/CzdrTTm8RdDtSDSR1opWIX65757pAPRZOR2YjHuhqFxHX8hb8fIYE
         8JuBeBOMUPZYPL6S5zDmexyXyLkcGeRph0QvN24V7R2V14hXZNAX1hzdFe4mMtTih9av
         jYgBE8RkfkUCb7IgAOsT8rrHBLAkbuv32059BgeNWiuJ1odC5+DV2Nxnv6GbNdlR5dlv
         4evZxNC4MgD6YqEWntQBJ3hqUnAmoxyuf4XmW5sVEJkgG6E8hSuMZYLbGBkObAaeI6Zu
         pFtbv9vaEzeEulumMjhigOI0KwFaU2ctt4dTg34JvI29Tr8NMEFqOusLbG3xLdAEZeLP
         z5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xbr1iyCmVHPM8Z+0u2tLKLLy6qAswXo6NMqrcz7V/s=;
        b=uAkmivC/q5gXsZFvBNhXWfX65OlaKbpUtVbAYzYyBgKb3e20NitJzFmuA4om8CzaPL
         cC7DX9J00fUveccPbG4LAdDI5ewBAKY5FL9M1DgY1hrehLT10QLut9+GYtlsXbkpOpqz
         7aDxj5t6TNxH9zlTfbhvj0RQPQ+zaP8u31Poe2RwxjLvxalf4dYbrVP6ablk4Rf2q14h
         mRrD2F+HX+nEp+2ieJfYYsSGsDeMfkneTsSG9/MheyKjhFGMeK/aNPjnBJHylAIoYLER
         VpExCNdHv8vfrCbch/GqsE6hPEC6+qxVOrGnV2S0IzwRDn/wPveZHwh/tc75D2LrNZYv
         2cHw==
X-Gm-Message-State: AOAM530LfCkPze5ft6Q5ixE93bin2os2il10nyvH8aY6XmaYO3cM7wkg
        9cVs3hslM7Rp10EU4IcKGaUhCDUsXHoaVccOOOU=
X-Google-Smtp-Source: ABdhPJyhWxhBMikpLU46CQ8PBjaY8lh36ICXoqo8ZC1BdgFdxeS4VGUomctZm0OHXL2F63/qOB1raHyV8+QYoHdebzc=
X-Received: by 2002:aca:d5d2:: with SMTP id m201mr8910518oig.74.1603039880960;
 Sun, 18 Oct 2020 09:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201017162732.152351-1-dwaipayanray1@gmail.com>
 <1ad9c5f49e10a192f0c6efb1116f3f0d31adce74.camel@perches.com>
 <CABJPP5DuQ_Y0LLS5BzNXUWyxjzp9ts5kgEH-3+7Pn7PPjq0Ljg@mail.gmail.com>
 <eda7a64b4af42ba1fb66a5b3704780cf3f761951.camel@perches.com>
 <CABJPP5Cr3giDJkJvBDd62iwx6y6r1dFhaVXp9jYXS8Y6k9b09A@mail.gmail.com> <e417e506c23ad56b2618204071c86e8a6ec2cb85.camel@perches.com>
In-Reply-To: <e417e506c23ad56b2618204071c86e8a6ec2cb85.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 18 Oct 2020 22:20:53 +0530
Message-ID: <CABJPP5CPgT4VHP9-xiWNVbPDVjDykPsE4kWTFgDmzp553H3o8Q@mail.gmail.com>
Subject: Re: [PATCH v5] checkpatch: add new exception to repeated word check
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 12:41 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2020-10-18 at 12:10 +0530, Dwaipayan Ray wrote:
> > print index(" \t.,;?!", '');
> >
> > It output 0 in my case. So last words on a line seems to work.
> > I don't know if this changes with the perl version though.
> >
> > So given this, will it be necessary to change end_char to ' ' ?
> > or perhaps change both start_char and end_char to a ' ' to maintain
> > uniformity?
>
> It seems it's fine even back to perl 5.6, so it's fine as is.
>
> cheers, Joe
>
Okay thanks!
Please let me know if any other change is needed
or if it's good to go.

Regards,
Dwaipayan.
