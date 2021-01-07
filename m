Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257012EC79E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 02:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbhAGBRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 20:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbhAGBRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 20:17:04 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B399C0612EF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 17:16:24 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id i25so1481056uat.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 17:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ys5x3Hi0zH7+JlDh7fjI+nX5FQdopXUEBUJ1iI++p8U=;
        b=Zve0Z+9a2dNXkVsqaPlsZDG2KQC7hmJDVi5edVEQ2QC8q4SFs/ePqltyig2+Ql5XNe
         cxUxol26N09c3cpPW+C+/UNZOIc0kSK0eQzRTZetIhT7RY4zLBEqDh/zmFiFLAIJE4Tm
         ayBdsW8WSsmDV88kVuLdl4lEeCMkx3NRgf12w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ys5x3Hi0zH7+JlDh7fjI+nX5FQdopXUEBUJ1iI++p8U=;
        b=HbtHlwhYaUyMnEdkq7esLTWHv5usxqYwi8r46JX1rREtMRaMwhlfKoKrC3hnmZursy
         ORPoGp7nXUaybgkDkv/kKsCP/2ahAeeIaxp/o/GwuyxMamtQf3HdKfoMJcEmfgmXS3yE
         2k3gK4Bgcl182aZ4Y/5aOL1/EfkAC9CDom0NTtivlttgqJR2IjV7Av0+xwMVcacMyeE8
         5V0R0SHmH+byoDeXeX1js2YkNyWoMd+sMcrT1VIk9vEj9LbFxEMdtO7oBXNpgIV7PW2H
         16h77ptr+O8fB3ekN3QM7+WVCCt3xYvoJtChzQbNryd/Jzlk/KqnJj1kYS0S+iZo8B+7
         1TnA==
X-Gm-Message-State: AOAM531bDzwDRy/Ga1nMO0WsJUB8cjn4XDtov2ooJ2ulGs8rIGf4QFWf
        uUBKK3T1Sz7ZUUKPCi+tjhDWoVzfdOd9jw==
X-Google-Smtp-Source: ABdhPJws8fN8bZby0sDc+7OCbjFAUO039ROLtCWv8KCav5ItlJMK4M+d4k0834TiaogvdgMkkP9kTw==
X-Received: by 2002:ab0:74d2:: with SMTP id f18mr5853583uaq.48.1609982183497;
        Wed, 06 Jan 2021 17:16:23 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id s4sm559203vsp.10.2021.01.06.17.16.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 17:16:22 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id p128so1240126vkf.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 17:16:22 -0800 (PST)
X-Received: by 2002:ac5:cde4:: with SMTP id v4mr6061479vkn.21.1609982181965;
 Wed, 06 Jan 2021 17:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20201205004709.3126266-1-swboyd@chromium.org>
In-Reply-To: <20201205004709.3126266-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Jan 2021 17:16:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XjzBLTPMqOf1NK0pjXiZWrLT227nksxhMqaFG6GxAqjQ@mail.gmail.com>
Message-ID: <CAD=FV=XjzBLTPMqOf1NK0pjXiZWrLT227nksxhMqaFG6GxAqjQ@mail.gmail.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: Add support for a front proximity switch
To:     Stephen Boyd <swboyd@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 4, 2020 at 4:48 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Some cros ECs support a front proximity MKBP event via
> 'EC_MKBP_FRONT_PROXIMITY'. Map this to the 'SW_FRONT_PROXIMITY' input
> event code so it can be reported up to userspace.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/input/keyboard/cros_ec_keyb.c          | 5 +++++
>  include/linux/platform_data/cros_ec_commands.h | 1 +
>  2 files changed, 6 insertions(+)

This seems really straightforward.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Given that it touches a header file owned by the Chrome OS maintainers
and a driver owned by input, how should it land?  One maintainer Acks
and the other lands?

-Doug
