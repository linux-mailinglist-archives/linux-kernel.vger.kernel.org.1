Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97581AE913
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 03:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgDRBDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 21:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgDRBDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 21:03:02 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE76C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 18:03:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e2so584902eje.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 18:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qs6wrAd2usiw5E/NvfsaWD9NmqabIB9KmK4sn2np7kI=;
        b=U4x5PtWjYno+y9kpXnPl1TultiRn27j4BA37HWNBlr8kBkFNbIKmdMCjn5+3qALEe6
         dRH3LlE3dIu3QUb/4qxHvQ9l4xMOL9Mb/kG0fdw89qIxkUEdLh7LgPPZdg/O0R+zWCWz
         DW9rBf94bWBr7s2zss5IpNuRxdZPbLRIPLmgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qs6wrAd2usiw5E/NvfsaWD9NmqabIB9KmK4sn2np7kI=;
        b=ZAb3rRrV/K01SrR/TVZJb5z8jufa6XgF54UawPQbQj8AErCPbQBvWUMEmmpcrZe4WE
         ym5K+09edcTdRslo/kfJS1ylBsoyXaESwjtPz1NSBLWYivR1tzIklpstWOxHfMAkpTfu
         6hnAf9Rwc4lJDrP4cM6B2PgDV3tKQVRavayzPhJpF6jdIE8ajS+lSHqFn5Ix62QeIX7N
         HQOcrSoRcg0zct8+6rRP5IUyW2br+A8I49tXxIieaVYqegZwfrKper8yJXTqdi23BKGo
         SozO8MaDlOpgpexPxR80v8Pdw7S1PvDFVqJf31KNx71etwvu+6oHzdgJBnyrPQ3qK/JJ
         3BbQ==
X-Gm-Message-State: AGi0PuaQPqY4FFC6aXzp7l5+z1I+EmYHe3nBTYxFjpJkwFl6ptc35Q4O
        aaercmtU25IDgYuI8eZcRsc6khThNTE=
X-Google-Smtp-Source: APiQypJPpJ6Lk50PJe3Is8FZU6xFxtNmsEkgqbBzt5VNbudJ9JJ+faJcrMfQ6IZ3poP/df/n43BT3Q==
X-Received: by 2002:a17:906:496:: with SMTP id f22mr5611444eja.311.1587171780422;
        Fri, 17 Apr 2020 18:03:00 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id qo12sm1583107ejb.14.2020.04.17.18.03.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 18:03:00 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id r7so2808534edo.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 18:03:00 -0700 (PDT)
X-Received: by 2002:ac2:4859:: with SMTP id 25mr3711879lfy.59.1587171355790;
 Fri, 17 Apr 2020 17:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200205194804.1647-1-mst@semihalf.com> <20200206083149.GK2667@lahna.fi.intel.com>
 <CAMiGqYi2rVAc=hepkY-4S1U_3dJdbR4pOoB0f8tbBL4pzWLdxA@mail.gmail.com>
 <20200207075654.GB2667@lahna.fi.intel.com> <CAMiGqYjmd2edUezEXsX4JBSyOozzks1Pu8miPEviGsx=x59nZQ@mail.gmail.com>
 <20200210101414.GN2667@lahna.fi.intel.com> <CAMiGqYiYp=aSgW-4ro5ceUEaB7g0XhepFg+HZgfPvtvQL9Z1jA@mail.gmail.com>
 <20200310144913.GY2540@lahna.fi.intel.com> <20200417020641.GA145784@google.com>
 <20200417090500.GM2586@lahna.fi.intel.com>
In-Reply-To: <20200417090500.GM2586@lahna.fi.intel.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 17 Apr 2020 17:55:44 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM9mrkGfxtVVNWkqnDNzcok2LAqdfVbQL2RV7yWE0tMWw@mail.gmail.com>
Message-ID: <CA+ASDXM9mrkGfxtVVNWkqnDNzcok2LAqdfVbQL2RV7yWE0tMWw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: cherryview: Add quirk with custom translation of
 ACPI GPIO numbers
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        stanekm@google.com, stable <stable@vger.kernel.org>,
        Marcin Wojtas <mw@semihalf.com>, levinale@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Michal (bouncing)

On Fri, Apr 17, 2020 at 2:05 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> I wonder if we can add back the previous GPIO base like this?

Thanks for the patch! At first glance, it looks like the right kind of
thing. Unfortunately, it doesn't appear to work quite right for me.
I'm out of time for today to look any further, but I (or perhaps
someone else on this email) will try to follow up next week sometime.

Cheers,
Brian
