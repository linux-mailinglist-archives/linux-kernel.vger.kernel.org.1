Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F155258CB6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 12:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIAKZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 06:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgIAKZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:25:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDA4C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 03:25:41 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q13so851709ejo.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 03:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DBY03aljOyI/2fhPi5fgkXmtcr1ZgjsMqOgg6fOIlH8=;
        b=ZvssPmbeG6XDh2TWAE2Wd4jboUyecQ9Z9B7+kp1ntN0VP2oEbf7XObj9ZD2vPNS9Q0
         asc6ijuQ/UyS8orgtyeO9KVXLLCLoCG8KDIeKTX94lP9x0TCB7DiBoIAwFI8W/vSD1z2
         G6Wdnk6WR9iltPjeKLoH3vq6U9J+Wr8LdXqbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DBY03aljOyI/2fhPi5fgkXmtcr1ZgjsMqOgg6fOIlH8=;
        b=PhTg2vMWvk0b9u8HKzpq3bDD2hHTKgxEtJD6RibX5BuVluTL7l/edq1pja4Bt5orcP
         QRv2I3JBIa0L/TCuOuETASuuXtsQaCO7aTE1fCY7qNOMOzKF1E8rZsxBbZjnECNYcYLg
         8x1jK1fF17BFB5xRvepIny/C6cSHD6DSer/MuCbeNhdyXpWk9/sgm8ijK7ycc5w+4ESK
         jthm52vGkJyfvUtWxkDrIgfbRtUK0OPzrOMMMgfAZuXFhF0SKIv/BhdHiU+Tgj8eXeq1
         iRHY8gYavfB3xrElSRcMAf2P/3Uz1F4d582uBFfr0YbuJVk4K9wfmUKi9RRjVP/i0VXA
         +R+g==
X-Gm-Message-State: AOAM531YMTzT1VmdZkd49DQUatwUB3MU+wiZPVszjnVkVdPEpASDpnEU
        uaXUxKhnZbU0g9y5w+CovPvqY8Q3W8KeRzMgjoE2ew==
X-Google-Smtp-Source: ABdhPJxoLwkmE9GI/4RYl7jfvvcWo/Kls6xYJUneBBMoNdmQ04dudp2j2v1X//3rzOVafeyuohPwjIghls3Gymh8JzU=
X-Received: by 2002:a17:906:150b:: with SMTP id b11mr840127ejd.234.1598955940451;
 Tue, 01 Sep 2020 03:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200831082917.17117-1-jagan@amarulasolutions.com>
 <20200831082917.17117-7-jagan@amarulasolutions.com> <0e286dbd-36e7-54cf-b901-4718d5f7ee6d@gmail.com>
In-Reply-To: <0e286dbd-36e7-54cf-b901-4718d5f7ee6d@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 1 Sep 2020 15:55:29 +0530
Message-ID: <CAMty3ZCux4dz_qE4ie1r3mOeEzxTfrCkb_riiV-9694poEd+tg@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] arm64: dts: rockchip: px30: Add Engicam C.TOUCH 2.0
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On Mon, Aug 31, 2020 at 3:38 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi Jagan,
>
> A dtsi file with only an include and no changes isn't useful.
> Are you planning to add something to it?

Yes, some WiFi/BT bits (with LVDS if OF used), but the idea of having
separate dtsi is as per the Engicam's hardware topology. C.TOUCH2.0 is
a Carrier board like EDIMM2.2 and each as its own purpose and possible
to use or update as per customer needs. Maintaining separate dtsi
files for a carrier board will easy for customers to use the same SOM
and create their own carrier hardware. This was the customers can just
add their own custom carrier and reuse existing topoply in Mainline.

Hope you understand, the structure of these dtsi files.

Jagan.
