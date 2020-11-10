Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8DE2AD849
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgKJOJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbgKJOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:09:33 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2359BC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:09:33 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so16391823lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhI4bSrNDAusomml7icPJ8XO3XGcl6w6VFJS+7Es/p0=;
        b=vD8YryUlwWqsT9VdEa66fNxYuA/it6r/SYmTV+jRFCuuamiVwulurfBCPq11IybAbr
         xGjyCyHw8hR8UqCGtAYNK0zYaOaJ4Udrw7Wizl1DapYfFYVKMvlxYGcL/OvUpXDyxxEh
         cCfL6YjzgMUssT8tOHkzEWqsJjEoUW+YzZHV+I6WMQ6WsLN6Sq31TsGK6IG7T8Vp/PzI
         Qt/2NZzXicuUo3C3SSDBumm1Lo+LCM28HU+WYA4zq8PMYmyvbOfxr/WKYbQUmNabB/rg
         tzLxWH7sW0dPaYCkqdq7iq/uHOHmQYWy0vdWdYpdHwSwCbWKaLsPTbsqmIT25n5/sebB
         ym9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhI4bSrNDAusomml7icPJ8XO3XGcl6w6VFJS+7Es/p0=;
        b=p9rKxdDkzu6D4qsUnLKOyIfUm26KEuUEcqwrvOS6QcZHjNxKdLGeZa7vPuY8GpMsKM
         f9x6PltuUvmXNYpSAmVbDcC0t8Wm/O8sVqCKiaNppi6ok0MZ5cVlIVb9TUfP4ImVIybF
         K0Po2kPipcS3iHFbkSrMItiSv9NxKHs5wpdKahovII9sbir+PdVE7SYPbJRI1/q0zHvQ
         iLKvKlYaaKN8v3GMSlYT0k5i7A/1eLRDj55cO2oiCCQmL3ar1pYC1Ij8JpbwwYz+tAqU
         fG9kpHXal2Vt9Pgsx1tPliGOSyNhQYTUTND5C0Rgm0AkONxyWv10MwyAxGE3n8AuJKzO
         6qFg==
X-Gm-Message-State: AOAM533iSQhAKgDTShds/QHxdeu7GKXuLGwMf0trcqgBr7cKwrY19/zw
        Z607dkVqmGv0UUg7BfGixF4IQQtx0OSZtcTESkzZCbK3BTGm2w==
X-Google-Smtp-Source: ABdhPJx3lRtvu5f1m7IcbcJfPqqYI+rqK33E+vQGK2kAiZemb0dqFxd8r4Yzhke3xRLxmiZQAfb7jcUAcji+5x4aYxY=
X-Received: by 2002:a19:ca05:: with SMTP id a5mr4543584lfg.571.1605017370813;
 Tue, 10 Nov 2020 06:09:30 -0800 (PST)
MIME-Version: 1.0
References: <1604651795-1220-1-git-send-email-kaixuxia@tencent.com>
In-Reply-To: <1604651795-1220-1-git-send-email-kaixuxia@tencent.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Nov 2020 15:09:20 +0100
Message-ID: <CACRpkdYoboNJEBeUzo1t00byXQESHkcXqtm95HoJpr7W2nQVHw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ocelot: Remove unnecessary conversion to bool
To:     xiakaixu1987@gmail.com
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 9:36 AM <xiakaixu1987@gmail.com> wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
>
> Fix the following coccicheck warning:
>
> ./drivers/pinctrl/pinctrl-ocelot.c:732:28-33: WARNING: conversion to bool not needed here
>
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Patch applied.

Yours,
LInus Walleij
