Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2312CFD72
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgLESdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbgLES2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:28:11 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B90C09426A;
        Sat,  5 Dec 2020 05:15:04 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lt17so12804062ejb.3;
        Sat, 05 Dec 2020 05:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8o7C47mB38s85XcvCijMc+zoOV85Gbl1fF1zykKK2A=;
        b=ehA4WdgUGbq22fwAm3y4OBweeMpJTXerhxaWslqQ4Vl+DM3bh/rJyncIN8TGQCJp7v
         +pONQHJ27Et8EsMYGgv05jPDXA/sFBnQreVlkiWiZbzhLPWSL2hYjIPXSbBXUYfwRpvt
         oh0Fidbh4EAkjRO6m5ghdWsD60AHB0VxL6ZpKa+YfS8N6b8LjNZMmDj7TWCqYWsh0zuS
         JxC6oIQnt3j5+jlldpVKD+obZ1z0iEsZ2vM0bPvWXZYyhcE0qlnkr5j/Crc4gqopVcTp
         eVx18QeFuQ8VvFdjMyaOn38Ymm6kMMZO6WXh96MvGD+P1CnTwO3S1xh9bSylTRhvm5JN
         83jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8o7C47mB38s85XcvCijMc+zoOV85Gbl1fF1zykKK2A=;
        b=hFQmwLowbdAAhYYwzJn9UeYCn5YbJucGlx5gxS2sNCAqMmN6dpaFG0nLElxnhP3pnR
         fWkComPOkti/OgjyWhLqX9++zhBOS8h3anZVKphyKRlQuuKlK3GEpwHXjnPkmgJNgaJ5
         5qxjolCxdNH8gPqarO8UKh262xjkGcntGwlod/y3Hq0BMuMio88+sYP714PJ0+L2dJ8M
         nzWZUuVB2wBg7Jy42az/VyOK+TczIIVbKAeQuRGh1yswbFdQRLRs/U1vsMzmjwykaTXD
         t7K/AC371t1Se22wIAjUZfuSn/FUGK692ilDDhUKB3iY5HgD2Y5nEnE6vJO3J+btss34
         CHDA==
X-Gm-Message-State: AOAM532eEnYkNAJAMVBNQcihqKVqA9TRNSa2AGHl1uiol40KZTMiS5kv
        GwMswvNGCEGnoY4hfv3d12aqNAs01gJOquyg6dM=
X-Google-Smtp-Source: ABdhPJzme9AKXTJnSuYTOpepNetqcogw7CI3kypUAmJFl0nNPidR6OLesg0UxKun/7vC2Dx849caZKNINoRwmIzj+sw=
X-Received: by 2002:a17:906:71d3:: with SMTP id i19mr11302981ejk.187.1607174102676;
 Sat, 05 Dec 2020 05:15:02 -0800 (PST)
MIME-Version: 1.0
References: <14754fd95378b78eb9a0a3f8b6bab13f7263c7f1.1606828668.git.stefan@agner.ch>
 <a899168379ce425b35eea4a369504fd75977bd71.1606828668.git.stefan@agner.ch>
In-Reply-To: <a899168379ce425b35eea4a369504fd75977bd71.1606828668.git.stefan@agner.ch>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 5 Dec 2020 14:14:51 +0100
Message-ID: <CAFBinCAdQ7PdJ8OpM9iu2fM_7C7KEbWoP9UaFya+uA-ktUs4eg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: meson: g12b: w400: fix PHY deassert
 timing requirements
To:     Stefan Agner <stefan@agner.ch>
Cc:     khilman@baylibre.com, robh+dt@kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        christianshewitt@gmail.com, jian.hu@amlogic.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 2:21 PM Stefan Agner <stefan@agner.ch> wrote:
>
> According to the datasheet (Rev. 1.9) the RTL8211F requires at least
> 72ms "for internal circuits settling time" before accessing the PHY
> egisters. On similar boards with the same PHY this fixes an issue where
> Ethernet link would not come up when using ip link set down/up.
>
> Fixes: 2cd2310fca4c ("arm64: dts: meson-g12b-ugoos-am6: add initial device-tree")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
with the "registers" typo above fixed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
