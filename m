Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA52FE9C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbhAUMRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730453AbhAUMPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:15:37 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7A5C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:14:56 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 3so2223731ljc.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=40qqDLkfea9y6OAb5ktyENQV282P5G22MREwSllTT1s=;
        b=REYHSpWzRJc4jlFKOTGI+n80ucjxpLigXsu9sA6k/P54iZetHhyOEU/7gHWcHuwFks
         Y8Fq9by/7bMcAtY5w4/OLqLpf2RDbqzDnyWXXP26vTRFFac8i8t5OvnTebZDYejFyXAc
         8oj+LZjlcVFbPTkurZAluWqnocUs6n/et5yPoHoNONK/ora1X0A+qMeTeQ4gRRaAY/BE
         gD3uNwHmCeCK3q++FIgWticPQDxPv4QPU7oZ820nrMqH2X7lcukCX77x9d4LWZNuSRLV
         +njaFi5h9KBk0u4186wfvI8IIk7tJFB48838N+X2qvdBEtGUCtuMdRUal9CTrIsdmVx2
         Qv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40qqDLkfea9y6OAb5ktyENQV282P5G22MREwSllTT1s=;
        b=EIDfuwJxTNPLakh8L3PIRjBlhFjOf4zaEKmerpqhrSBvUUHza7OsEv9nimjRU+CAC/
         lUuW+0IwKGfJNaGHYRLslqZ+baBTSab9+rpuZLwLBRisDYG8nxzT+oagVBtS5uEKeF9s
         Cp/vZZuJqMknAX3cyYBf37qOcV5bIOMG1oOnBa5wnjkLVO68PKModM1fLJftW8f8P5x7
         NiEB6jVyBH8/TrhFFWT7qRsJiInAVbbyNA0NyimMUoShp6cshrPEsuJEF1IrhYe2rQ7p
         a2X1mWJnTFc/fLBGsX7aSxT6tWaKZrPRJq0fJWmZ1o2UM+dw+xeEzkwaWP7BFSqWv8TW
         KMTw==
X-Gm-Message-State: AOAM530auqez8jJpVl8uymPbQBOc7y1PKqL8mibdvKIfKR7YnW67TE+q
        cunOeV66vOzGfGlEYr0OXYvcPMhP2vGqjwf29zDhTA==
X-Google-Smtp-Source: ABdhPJy2fxQbX+ssVabN78RgBkSZl7bLPKTEB7esp42mWKBp3zco9enxdBZD3V98VlxKTic50RsPmtGe/Ph00vtWkKk=
X-Received: by 2002:a05:651c:1312:: with SMTP id u18mr6827042lja.200.1611231295019;
 Thu, 21 Jan 2021 04:14:55 -0800 (PST)
MIME-Version: 1.0
References: <20210120132045.2127659-1-arnd@kernel.org> <20210120132045.2127659-6-arnd@kernel.org>
In-Reply-To: <20210120132045.2127659-6-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 13:14:44 +0100
Message-ID: <CACRpkdYXkfgRzhYTCCyJBaXhHrkS53=nUr5EAcXdwnK5Zu7L=A@mail.gmail.com>
Subject: Re: [PATCH 5/5] pinctrl: remove ste u300 driver
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 2:21 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The ST-Ericsson U300 platform is getting removed, so this driver is no
> longer needed.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
