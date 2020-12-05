Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3539A2CFC93
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgLES3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgLES3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:09 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7033AC061A51;
        Sat,  5 Dec 2020 03:51:45 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id c7so8622119edv.6;
        Sat, 05 Dec 2020 03:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hd3HS1nRGiOdMm5T7QTs9bBnrJ+T0eTd0OHKFt9TJM=;
        b=OQYNEf2uJdfHMQnh+CsubPaAu5uKQx4mJCqeL4MCG4CUH8i1yrmV0z6Be7aYVqBOHT
         63m+s4TsGqrrLl0xK0yoOmLqIzkrubm22Lj2NxzlpB+WrY6uXT9d/frREYJX8ZdMrDPC
         zWQ3dbYiLDoOnKkHh3DvLHteJEhV+PP6s7qSS8mGAImzxqchIEuwE7cmxEXEiINZdQDx
         sCZXMoivvH0VqZKWWgU5C8neJ09AU3ICwf/y2mXGe31fsI1KKCzDqrrxdMTRYQwfoHb0
         U1saovH2q/Zinm5jumRt10HNk7zj40nPWYhyi14EStWuQy+PCyusQZzkMSb3QWth9uAO
         UJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hd3HS1nRGiOdMm5T7QTs9bBnrJ+T0eTd0OHKFt9TJM=;
        b=oQUbGXFoXdw+s6dNgFBboISAFWv1GTV2UcL9LjfqALZBNp0eAbf+vUPwMR7tLdoPvD
         lciLZjeQiFvou4GjgINTgOodui+TS4fmN3WAAqnj64eLP08fAIAgp5bhtL0g9BEXx/gt
         x6TsILpf4wnFGx+yCYQzsoAoOcxl8mNpGepNfjxWAvBncsY7xBZLkLvQsrh/Wmz8a2hU
         G+lRyjMSQAJQsyW69Ew1AneiclbDJRhQC62TmmkL7FayG9GpXvrBuNpe+QwOvxBq6O7T
         xYS6qmy295N3MXw6/E/Yeiyg7AhYwlEWMbiEFsyflACsQY/1QCSTHUDe/3IoABbic5hT
         nK2Q==
X-Gm-Message-State: AOAM532loyJKDSMb/066+EdI4jHjE0zaMC8+O8vAOtlbEgrPbMWGJlU5
        MY3jn4930cGR0THzSPOpeK4Ll6J3BxHbmPa6vHM=
X-Google-Smtp-Source: ABdhPJyTmxH/J6AxpvkQV8Zl0g2e2O5aFVksrEY/jFlL2+JuuumDaJabPFMHoTqSD0/L1it3ad9vJWHnKSwlWMxNXGs=
X-Received: by 2002:a05:6402:949:: with SMTP id h9mr11596537edz.301.1607169103997;
 Sat, 05 Dec 2020 03:51:43 -0800 (PST)
MIME-Version: 1.0
References: <20201126050440.6273-1-christianshewitt@gmail.com>
In-Reply-To: <20201126050440.6273-1-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Dec 2020 12:51:33 +0100
Message-ID: <CAFBinCAUede5uaqnkSHqmwmMuTnZpdhbJAUE11q32y60SW0D2Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: add KHAMSIN IR remote node to SML5442TW
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 6:05 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> Set the IR keymap to the KHAMSIN remote shipped with the SML5442TW.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
