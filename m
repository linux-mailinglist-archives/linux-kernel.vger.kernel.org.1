Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D622AEE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgKKKP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:15:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbgKKKP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:15:59 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D2EA20825
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605089758;
        bh=fj/d+uUSa66ZXaIECxvpPkifnEUL90fECrea16eIp0M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w/TRaMICMK+LsuUIxKTT+0VMfl7UhviTUY8AbG2saPsB6F0YnX1CPDLgBHfOW7DT1
         SdIKAeLjiGcBGfzZbioSFRel6QCaMQ9suSsk/fq5vdW7ZAJfnUgun9uSCSp/yYHfb2
         4el+Q35N1YieGgcBmRuD7TiRFcE4FQTHYoyUsNpQ=
Received: by mail-oo1-f46.google.com with SMTP id z14so298058oom.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:15:58 -0800 (PST)
X-Gm-Message-State: AOAM533UsIaabcOj5G23kmzaJhrFfpQaB5x2/N6Vdn6sjmq1yO7s2yXZ
        Hjc72Z2T8V2NCuIcixVyonReuzqLmNRwO1/qDkw=
X-Google-Smtp-Source: ABdhPJwtNRXuWaEVN4XEu7vmXIZ5rZS3ocIXzp7zkmE3duoxizMeqxoGQhMBm/S09yPMpYnA+Rj7vu2Tl0Q8WWLpQF0=
X-Received: by 2002:a4a:a217:: with SMTP id m23mr16529435ool.26.1605089757445;
 Wed, 11 Nov 2020 02:15:57 -0800 (PST)
MIME-Version: 1.0
References: <20201110161338.18198-1-enric.balletbo@collabora.com>
In-Reply-To: <20201110161338.18198-1-enric.balletbo@collabora.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 11 Nov 2020 11:15:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2HJ6ROzMNGNc8A-qz02x0x9Aj0g0BXCe9v57ob6THk+g@mail.gmail.com>
Message-ID: <CAK8P3a2HJ6ROzMNGNc8A-qz02x0x9Aj0g0BXCe9v57ob6THk+g@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: syscon: Add syscon_regmap_lookup_by_phandle_optional()
 function.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 5:13 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> This adds syscon_regmap_lookup_by_phandle_optional() function to get an
> optional regmap.
>
> It behaves the same as syscon_regmap_lookup_by_phandle() except where
> there is no regmap phandle. In this case, instead of returning -ENODEV,
> the function returns NULL. This makes error checking simpler when the
> regmap phandle is optional.
>
> Suggested-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
