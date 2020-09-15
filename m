Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119F726ADC7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgIOTkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbgIOTf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:35:56 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CCDC061797
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:35:55 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w1so4227221edr.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5DZX3eWvSoTmXVB42kPw0noPkujBlH+pDQ/FSsc/aU=;
        b=XLVJN4sTxaKStlkogEKqSBimD3s2VkE4DJj7bCKcgQvdDvr/v7YXkYisST8KKwh4B9
         hJ5NrAHVqRTIlSJE17cQdHhB6+TqDfaklrZUL3W51F+6vTFn9bcvMoQD5ghqELgV52V9
         k2z95lgSh2lNsDnFd4ULZWmRm1VI2idoOfGHAqiJDRBe3mkmREvDg8PlahBnnf5Bh3pq
         e7Tkz6YDfZ+9AUivVJkpox2bgz3uD9O67AKVAuxZxGQvDLIl4MtLw/TXBhHTEIHx+MlP
         5ERHtG8RLvLwxqbfJbSOo/TFp77kEmHm89KR1GEEuyOUhBdJDaFv/FJBRO8wkHUnFahS
         Yg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5DZX3eWvSoTmXVB42kPw0noPkujBlH+pDQ/FSsc/aU=;
        b=oFQaeQKeqs038Z/EPa6QIthKdr6oEbNl24P1abtBWTSzejFyw3AZQVpL0u5pPBXeqm
         34HaE5/tnN6DYaJJpCJs2b158qt6R/MRLdREHCupxJAwgzjFnW2zEkq919JfqCnCv1dO
         Bf+q73pgX/qVdL0MVrxu33mclrCrdbvQ01fZ+ioCurlSFF9ketbOEm2R99Jmt+Vi5cQY
         GZt1ZwTZcWpMs67BrSy+jx41MICbEDhtN69D/k1x3+I9EZSH+Z0F9rB+rMkYNkcVXqeR
         b2xCkw3y0cqxqc5m94hDVvNJf5CrPBTv+R8V8ULI3Xw/jKzGtNaf99ey2YdN8Hyg6mvd
         NvOA==
X-Gm-Message-State: AOAM531Rv9ac9LZ8HmJ0OPD/QCqE3jHlBmKr1IGQvk+SDMezGpwzZRQK
        87mHq4E5IF/Xts+tff+nZk8KhWErI15Q2kUvdVAojIyciRg=
X-Google-Smtp-Source: ABdhPJxiIi9JX5OzGcYW437my9UEkoilSioerQxNoy4e4v1R4QhmFSBQoACqmJA+TVlfnhOxlJFIHDIMBSuMURy+5W8=
X-Received: by 2002:a50:fb98:: with SMTP id e24mr23683587edq.130.1600198554625;
 Tue, 15 Sep 2020 12:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200915152432.30616-1-narmstrong@baylibre.com>
In-Reply-To: <20200915152432.30616-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 15 Sep 2020 21:35:43 +0200
Message-ID: <CAFBinCBk050aCFC6hzgaYZB219jdAdEE1djzwCpU6iQGR4CAnA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: meson: add support for ODROID-N2+
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, christianshewitt@gmail.com,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        tobetter@hardkernel.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 5:25 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> Christian Hewitt (3):
>   arm64: dts: meson: convert ODROID-N2 to dtsi
>   dt-bindings: arm: amlogic: add support for the ODROID-N2+
>   arm64: dts: meson: add support for the ODROID-N2+
for all three: thank you and
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
