Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804A22E8853
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 20:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbhABTk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 14:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbhABTk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 14:40:26 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14270C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 11:39:46 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id j17so22219954ybt.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 11:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZd1IcLptnzDJ9yC5SOmyx2eu91igeGhIPrRDbnjT1A=;
        b=Af6nPHDnT4bVn/ADUgyRjBt2AgA5ifrT4Od7IOODjOSCF376Ww9Lmnt7s58se8snS8
         a/kuj9PqWy9zTjsUb0VZE8gkBH0513N8q9uv/xp0ncG0iH1x1uJqZOzFulSK2CaoaXf1
         dHHcrgfFkC6NWG/8b4VZ3slsTZrJUj5w58BCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZd1IcLptnzDJ9yC5SOmyx2eu91igeGhIPrRDbnjT1A=;
        b=jL40v3vr9CTynHFnxP7rIS9RgK1SCYL0A/0CL9Zc8MFaA9zS85kUPWwAzjm0EcFgzt
         7+Yf+eH1HM0dxAg7iiKn8Pp8D6hbEgsWZnYzOk6fwg4kENzETQa8UHK4yQi99DE4z0G2
         fxVpJfQcRBJChUxgIcBzNo/wpELRc+51EA3RmElnkYrvAciKPYVG2c7JzSegPlaoy/dt
         tQtw3wULvTtimmplxNkfSjqVcTGmAwV/tuWUMm28+0XoranwrItoSDXfe6bqZdfjpGLA
         BMMnwE9cnWAjUkUfbdtsi8a7goG3CQdRgRvWR9JpfN1Chxvdmu28N/nS4DUHSt2gGuwA
         wnRw==
X-Gm-Message-State: AOAM531v5sIQMtnj3bBRFHaMLCuOTD1Y/XhWOEDu1I2rNyBFJ+HOq+Ql
        x0J5qy8RhEfIbl1B/VI2C53m4+q8glcpTDfdXhkrAg==
X-Google-Smtp-Source: ABdhPJwg6CsFmUq8iIDUHfqRXA167oJOIeM0c6MY/+ekW1c+5R8pI69VLwVr7KSEfeyZJb3gBHb/E3uEOSVQZJ4WctU=
X-Received: by 2002:a25:3a04:: with SMTP id h4mr81215834yba.285.1609616385131;
 Sat, 02 Jan 2021 11:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20201221174751.1.I025fb861cd5fa0ef5286b7dce514728e9df7ae74@changeid>
 <X+rKPhJrQaykPxri@google.com>
In-Reply-To: <X+rKPhJrQaykPxri@google.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Sat, 2 Jan 2021 11:39:34 -0800
Message-ID: <CA+cxXh=HH-UAt747OYRwaaABdJpT8r=TvrYcFah7PQ1vHqYutg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: input: cros-ec-keyb: Add a new property
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thanks for reviewing my patch over the holiday season.
Please check my CIL.

On Mon, Dec 28, 2020 at 10:18 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Philip,
>
> On Mon, Dec 21, 2020 at 05:47:57PM -0800, Philip Chen wrote:
> > This patch adds a new property `google,custom-keyb-top-row` to the
> > device tree for the custom keyboard top row design.
>
> Why don't we use the property we have for the same purpose in atkbd.c?
> I.e. function-row-physmap?
>
Because this property serves a different purpose than function-row-physmap.
`function-row-physmap` basically links the scancode to the physical
position in the top row.
`google,custom-keyb-top-row` aims at specifying the board-specific
keyboard top row design associated with the action codes.

In x86 path, the board-specific keyboard top row design associated
with the action codes is exposed from coreboot to kernel through
"linux,keymap" acpi table.
When coreboot generates this acpi table, it asks EC to provide this
information, since we add the board-specific top-row-design in EC
codebase.
(E.g. https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/board/jinlon/board.c#396)

In ARM, we don't plan to involve EC in the vivaldi support stack.
So `google,custom-keyb-top-row` DT property is our replacement for the
board-specific top-row-design in x86 EC codebase.

> Also, instead of specifying keycodes in this array we should use
> combination of row and column identifying keys, like this:
>
>         function-row-physmap = <
>                 MATRIX_KEY(0x00, 0x02, KEY_F1),
>                 MATRIX_KEY(0x03, 0x02, KEY_F2),
>                 ...
>         >;

This mapping between row/column to function keycode is fixed for all
Chrome OS devices.
So we don't really need to host this information in DT.
Instead, I plan to hardcode this information in cros_ec_keyb.c.
(Please see the array "top_row_key_pos[]" in my next patch: "[2/3]
Input: cros_ec_keyb - Support custom top-row keys".)

The only thing that could make the function-row-physmap file different
among boards is the number of top row keys.
But this information can be derived from the length of
`google,custom-keyb-top-row`.
So we don't need a separate DT property for it.

Thanks.
>
>
> Note that the last item in the triple is purely cosmetic in this case,
> you can change it to 0. It is row and column that are important.
>
> Then the mapping will work properly even if we change keymap, for
> example from userspace.
>
> Thanks.
>
> --
> Dmitry
