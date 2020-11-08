Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299F02AADC4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 23:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgKHWNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 17:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHWNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 17:13:45 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1908C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 14:13:44 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id a15so6753474edy.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 14:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zadr8S1exGYvbFBWcZYnrHIH74MhDue7HE7SBukcCYU=;
        b=ZS3/RrmUsyd26siknMWP9hBPyVlLToCszbcuKFgMMGb025nOIQgZWIQ6ZwJ147RqaH
         EKVpCGvfVXt9vXH/lM3kDv0NtYdy1S6MI12zDiuRr0rVSNKGgf7cA1IFP9WPqA3/WHhx
         Dq+e+OjQNM/qG1dGk4wPK9vKSG1IzXd3qhMRJ81vTVOvM9pFMeX6R7RtUKJlV7uONu7p
         xkW5CszwYqBngjyOQYp9KF1GlmFQuRrMu/lMpSDz7COpme/4Iw55FU4vLI98hvShL9CG
         /MqttJcFkHzxYOyF3d0ZSScmtMENwrknzgD/6v/7Vh48w332cTfu8sGP67VKtNTMqF2S
         P1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zadr8S1exGYvbFBWcZYnrHIH74MhDue7HE7SBukcCYU=;
        b=pf1O1arTItZoDX7l46WImUjyNGyWRyfYdi7jKwfVZO8zx8lT1TjaKW3PxT4/GHDMW/
         qtDhRwDebOk18V92sJrQzNG/m5IrGrhQ4uyT4oUsA4m+AFNv9NVd6o9D7M8z50gCZKMg
         DjXrreYUmT0AvLa0UAt6x5wJdgkxRolCORuociC/wWCS8g5YMQKPB9QAtQi7qdDhKZpk
         sFm7A2ifdjiE9jHZry4jn9FfWafyI0DH9+qg0rFA4nkEkv25r+gzmDIqyw1hwAOd4Lwr
         uEgWdZj55NqGYiw0swjvZgzChqHtg55nVEmpgnGGy92bgkQhbKZvQBfYzy+8a7jdY88n
         57tQ==
X-Gm-Message-State: AOAM532e9uV9RZi/Up7+AZrIAR1RMfFAhfRXjbVzXzzPgEm30yue0reZ
        Mmu9PA/w3DoTc1pB8ST4WsTur9hk47S8zT1pcWA=
X-Google-Smtp-Source: ABdhPJx7xBHJqmrYHCq3KgX31T0CG77X4kaGHcuM6zY+ZJ7+918xPieTS3Ydr8/NkwE08ivM14/Nv10OkaOKTkqFQAU=
X-Received: by 2002:aa7:c889:: with SMTP id p9mr12160883eds.110.1604873623378;
 Sun, 08 Nov 2020 14:13:43 -0800 (PST)
MIME-Version: 1.0
References: <1604378274-6860-1-git-send-email-yejune.deng@gmail.com>
In-Reply-To: <1604378274-6860-1-git-send-email-yejune.deng@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 8 Nov 2020 23:13:32 +0100
Message-ID: <CAFBinCDjzt7jjEgTcxc+dMLojmnhMzm=1FX3bEcyDC7RGu0MTA@mail.gmail.com>
Subject: Re: [PATCH] phy: amlogic: Replace devm_reset_control_array_get()
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     khilman@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        jbrunet@baylibre.com, p.zabel@pengutronix.de, repk@triplefau.lt,
        lorenzo.pieralisi@arm.com, kishon@ti.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 5:38 AM Yejune Deng <yejune.deng@gmail.com> wrote:
>
> devm_reset_control_array_get_exclusive() looks more readable
>
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
