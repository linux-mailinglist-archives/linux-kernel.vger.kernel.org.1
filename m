Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330E52B8D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgKSI0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgKSI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:26:47 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A1EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:26:46 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id u18so6986173lfd.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 00:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8JwtN78V0y3LtuFBPrCqFfDlj9ETq7c6vrIeeVTI3Y=;
        b=Hd+x2DN6bvP8Pd1Fih8E3hCkkV0s7Cm8EIKuwmm3vuh87Pt4CAI1SQwvzy+zURl2uo
         iCt1lBxTwpCrflCetImgfDrQO2QYrlezoKBx9tGveWgLLufbGnidT7XFAhL9kd+JbTE2
         hw6u7vlYJTxM/m+HdnCaQ9ds7dYZlIoPZXJgfJeajRyWwBOIKIcCpIq+hRT79QdZNHVh
         dY64pgCwv7QCNwabWMaJMvQ+IpDl7RsrPHeQzwbrTSshsXZzm49uSCnBaDboOypxs1F8
         mQEYXd8BdjhSIwFX1qRZXWmY/ETF2kKdxkREEHcJi5dVKMnp+jr6o7MMd8iAj3z5ykwX
         7CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8JwtN78V0y3LtuFBPrCqFfDlj9ETq7c6vrIeeVTI3Y=;
        b=X8xrtwCS7dSgC7cgTt2wSNyZwHxRzbe2Mzqb6j4y+tU0sEuiWxOnz4QJKyBCKYtwO8
         ywZHtaR5FnaDjdoUSkjaoZRN9O3IaDqzSoGGWRvox4ayfdqkTYUrdKRpZ6iOa0/qHwgh
         G7ZQh8SN3VrHuCvBdDUHLT+YxD1cuTxPdRElQ45f0Yn9DljDRiE+RGSj4ni7c+83LSbo
         m61t6ws9OU2QfB+DSrkVhKWBQcY+xh1raOS02YF9t1OuNU918LTO1jStj9u6zl1LNfM3
         vNa2OFWwXMwlII8br+F6BWqZeJy4wxgY6CUFDZa7p+0xyHWcPJDDnA5qzGMAsLqmGphB
         LmQg==
X-Gm-Message-State: AOAM530wwTUMkucRYfXPHcWOxuddZM/y73W13m6JG73kDmWf77HlM/TC
        r2CiiO/RV27H+6WzoloazxLuFjnXrEC4X0AokMPSRQ==
X-Google-Smtp-Source: ABdhPJwpRKucEldYlvFjnIH3kbEU2/F5jqZXQ79w2Ac/VPAuc8Fwyu0wznu7xYvTIkwHd9lTzjFX0gzmXw63fe5dcNY=
X-Received: by 2002:a19:7b06:: with SMTP id w6mr5731102lfc.260.1605774405331;
 Thu, 19 Nov 2020 00:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20200830195748.30221-1-avolmat@me.com> <4597cef9-a9f9-bbde-69ac-dd9f96cb7c30@st.com>
In-Reply-To: <4597cef9-a9f9-bbde-69ac-dd9f96cb7c30@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Nov 2020 09:26:34 +0100
Message-ID: <CACRpkdbigTHKtfwQQSVf7EiJyG8Lby=ksBdmvBKDt0jqPXjUsA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm: sti: LL_UART updates & STiH418 addition
To:     Patrice CHOTARD <patrice.chotard@st.com>
Cc:     Alain Volmat <avolmat@me.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 9:08 AM Patrice CHOTARD <patrice.chotard@st.com> wrote:

> Is there any reason for this series not being merged ?

Did you put them into Russell's patch tracker as I asked?
I haven't seen them there.
https://www.armlinux.org.uk/developer/patches/

Yours,
Linus Walleij
