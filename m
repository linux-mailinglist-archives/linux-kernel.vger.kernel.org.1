Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42C3278FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgIYRun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYRun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:50:43 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8403C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:50:42 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 7so1884502vsp.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XTu8OyKxLxDq7oVeW0UHiIi1xzAS6hi7NHVEBbA27eE=;
        b=BLbLfT7hWjeXq5fNCkVJGX5rULzdOlLfE+9OFb235c1LHq7Ah6oU+MQR+GGjx2gJNL
         KBf9yjX5DU+uhnYYUZQX9ar9XeXoy6MMsGKsate9XSc1JRAaPBrs5raF422OzDvirxCj
         zG7VP1HOqFxqaMe4JuS4vpZmioJt0xjJRMsuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTu8OyKxLxDq7oVeW0UHiIi1xzAS6hi7NHVEBbA27eE=;
        b=gVahWG17k/Ndh3LdWe5gGHy4RWk+QDdtE+x6KA7prDi1+jUk34N0EPkGNOKy54QNC4
         GPPpFGru7U+sh38O/C9/YV9V0qnSTOz1uSqiKHLTwGcya/AuBoDgJyDvx16XMwsfaMdO
         MhuIKdtsowLIicL0XX/+4l0JxrdX/d+w9XgfAC3MvF0EmlNSmSonjlGp913+qo0hzfTz
         YHjwtf903NwzJ4wR3+MLPFQerC2qNGWgVE0Ps50zGPq2QBRm8krKT+m1kI3bm606cU1R
         3xEJQW4STzWkcFlmpg+KVglJKk63rmb2+N6WVIrTFcLwT0Sn0HOSwvkcYxmEwCz874c1
         7H+g==
X-Gm-Message-State: AOAM531QeLLJCAdug+haVJulil+lAfhNwXwA4EDVIN1PcOCyvjrGS1ay
        8qXuWOLlG3+gRZ+I0qvbPQJJCYpn/o0eFA==
X-Google-Smtp-Source: ABdhPJyb6Usvoj0LEaXi20mHb3hS7HIgSONjaFILOgT6GHbq2MhKm3WhZGgbQQCxP4zQWtUlkGjnRQ==
X-Received: by 2002:a67:fe57:: with SMTP id m23mr542130vsr.56.1601056241955;
        Fri, 25 Sep 2020 10:50:41 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id d5sm448789vkf.39.2020.09.25.10.50.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 10:50:41 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id b4so838135vkh.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 10:50:41 -0700 (PDT)
X-Received: by 2002:ac5:c297:: with SMTP id h23mr525690vkk.21.1601056240705;
 Fri, 25 Sep 2020 10:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200925162604.2311841-1-swboyd@chromium.org>
In-Reply-To: <20200925162604.2311841-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Sep 2020 10:50:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xq5PmKnzLwb3b6scigBhsx5vz6sXAztZSFSVYW8Vr80A@mail.gmail.com>
Message-ID: <CAD=FV=Xq5PmKnzLwb3b6scigBhsx5vz6sXAztZSFSVYW8Vr80A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: cros-ec-keyboard: Add alternate keymap for KEY_LEFTMETA
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 25, 2020 at 9:26 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> On newer keyboards this key is in a different place. Add both options to
> the keymap so that both new and old keyboards work.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm/boot/dts/cros-ec-keyboard.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
