Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB002F550B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 23:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbhAMW5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 17:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbhAMWlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:41:31 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A9C0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:39:33 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id b8so1876473plh.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=y7C3/EfXvdxRAVOgUDZ2takH8wh+8RemM6yt45ykHTQ=;
        b=jWSBWM1f90GuQfdAn+ekbGqXI+T0+VG/9nhPvsH1YoEX0Pvlfp9NhlP+CUsLnUIpLn
         GgUD1oB5wjrbYTXq6iDD9SeAwphAWRSHYvbG+V4zISpPuOfKL200sYaK3jk6EkpaHLjc
         yukqMmvIXUuYkPubvdOMQifXSIZjy/zD0I/eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=y7C3/EfXvdxRAVOgUDZ2takH8wh+8RemM6yt45ykHTQ=;
        b=MmDiQrl/PopKQcWbiJ9riejpiML7FeyPtxG674Vjw3Q0LChe2Wn4k2tdtfqMgtG+r/
         PldND7/JlxaARnGl4TnbNLp2lO0NvP4HXk959oPm7fqe0p9T/iqa815EkwRpBLmgf0FF
         loM5Ui/mF4Dzzu9wcfil6OCu7dVu+3uaRk5SUGkk1nOXojAPTxHwYqRMdjPX/h8Ji0jO
         cYyMnfB657o9KQl0bDvPpBs7Oa47MTbp9Spjr5KqMPhos1yw1HZO0oL2S457A9T7tbRL
         u1wmX4rbni4cLRR//1D/O6lVf2lHdpwDU8klOEX8LZRZQPtG5poFGh0kQcdhNwZX2gtu
         PcaA==
X-Gm-Message-State: AOAM531CQKydcO/SaRleJlXcov4wFQsrWW9/rz9rYQ62dSOYvXlSN4Du
        OFutucIbRvOVa/9rRfkTNkX0YQ==
X-Google-Smtp-Source: ABdhPJwz2R3vXycnrhYnCDSxIhOU0EaGilNeDT6WYkSXYHv8P/0F1Hguaw/OHB9jk73aGRNAJkADaw==
X-Received: by 2002:a17:902:b282:b029:da:fd05:7766 with SMTP id u2-20020a170902b282b02900dafd057766mr4478015plr.52.1610577573388;
        Wed, 13 Jan 2021 14:39:33 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 101sm3142739pjo.38.2021.01.13.14.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:39:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210113141426.v5.2.I9ec9c3c61eded22a5f7fbff838d23fc95ec7cfe0@changeid>
References: <20210113141426.v5.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid> <20210113141426.v5.2.I9ec9c3c61eded22a5f7fbff838d23fc95ec7cfe0@changeid>
Subject: Re: [PATCH v5 2/2] ARM: dts: cros-ec-keyboard: Use keymap macros
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dianders@chromium.org, Philip Chen <philipchen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        Philip Chen <philipchen@chromium.org>,
        dmitry.torokhov@gmail.com
Date:   Wed, 13 Jan 2021 14:39:31 -0800
Message-ID: <161057757147.3661239.1732471144881622262@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philip Chen (2021-01-13 14:15:02)
> The common cros-ec keymap has been defined as macros. This patch uses
> the macros to simply linux,keymap in cros-ec-keyboard.dtsi file.
>=20
> This patch also creates an alias for keyboard-controller to make it
> easier to override the keymap in board-specific dts later.
>=20
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
