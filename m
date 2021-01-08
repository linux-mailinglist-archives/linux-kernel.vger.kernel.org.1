Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703DB2EED36
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 06:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbhAHFp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 00:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbhAHFp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 00:45:29 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA25C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 21:44:49 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id w3so8638456otp.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 21:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dN7XgZiaahG9n5z68abqbWJt/hKn0HehLbVW0HG4KYk=;
        b=F4LCR8SFeymr3L6I9IMpBAqOjln4fubvxWUuu6ZbsmU6xWctmjkVDqa+j23NsdZUeJ
         2lbqgRfSx8pm609CeYUMden0X8f5qH0Irp+ydwQKmqYgw8Z/6D4RTFRsSX+YyUOd119c
         9Bfc29kUfbjj8Aexwzt4aip5WXjbRpz8nWT6aOd1V3JMENtdyA4LHiQiG8eJpurVTeIy
         ZwdlHbwIKT5W3nTD4Enql9zHaIfSiBNnraX9hviwAlz9ArpOFQOtMUtvUr4i/JL0AFLg
         PJB5KhL9JJxqUQvAYTMixwTdGoG2EKKDtBMXClSsECz+IZ25fZyF3dIntGJugRg4O1B2
         N8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dN7XgZiaahG9n5z68abqbWJt/hKn0HehLbVW0HG4KYk=;
        b=OPefr3SApUfkaou6Ptm+Lt05L6uYqZpmC0ftovEFZEamtiZ1qGWSOHGpSGWJJRT4U0
         PdjPaRqxLpxPwRpTaWm+uj7WyUOtX/ZEPFHG3bYRmIn08Pe1f2Zmpv6Fn8sjLCtOjUzR
         0elL7dFRodwSuyMESRVy03SURnFlDXUoZ9MeqC3b37/FkUKzEH1PCEPY5SHY54GJ4eaM
         Xj+b3MdcPfHE15yApAgqlOlYgouJ7qbButFtufP5RnjRzp3e90/3+3y6J7jrCKu2VpNu
         xYvYu8VPqWeITYYQcfw8RFOy86I5jPqYaS8xJl+m2CsQFnS77tKiOQjmpNGXMR6oZQzi
         bC0A==
X-Gm-Message-State: AOAM531W9CMiOup3TAP6l1iZy/wptjZfal1uuqBzWpc7WnrMx9j8fnai
        aVcZuVgOq237RDfm8L7HlXyNRI8mqm4xl1vLWcM=
X-Google-Smtp-Source: ABdhPJxqkHD8/hZsHWha7Yg6Ebl6JiAOdmUjcNyUQaZ32Ho/phTwGNlSwM+/HgMhRNU7VRuWjAVkOMCF0dWpbckONuk=
X-Received: by 2002:a9d:730e:: with SMTP id e14mr1531093otk.74.1610084688599;
 Thu, 07 Jan 2021 21:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20210108025155.31556-1-dqfext@gmail.com>
In-Reply-To: <20210108025155.31556-1-dqfext@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 8 Jan 2021 06:44:37 +0100
Message-ID: <CAMhs-H-xJZUkm78eJcP8QctB9HFfVtMqWC=gM7E-6WfqwPgn0A@mail.gmail.com>
Subject: Re: [PATCH] staging: mt7621-dts: remove obsolete switch node
To:     DENG Qingfang <dqfext@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        NeilBrown <neil@brown.name>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rosen Penev <rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 3:52 AM DENG Qingfang <dqfext@gmail.com> wrote:
>
> This was for OpenWrt's swconfig driver, which never made it upstream,
> and was also superseded by MT7530 DSA driver.
>
> Signed-off-by: DENG Qingfang <dqfext@gmail.com>
> ---
>  drivers/staging/mt7621-dts/mt7621.dtsi | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
