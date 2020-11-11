Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3B52AF430
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgKKO4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgKKO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:56:29 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D611C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:56:29 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id e27so3520235lfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rivQZ+Gyx3QuncUn7XBIjPPOLaniOfHJYPZkKaC2XyQ=;
        b=wFMqaQOrP9txqLtE2MUq/5BDVuwGIOJ4qBOl8O8bRs6hNHlYRbW46F7+MRjKsLKoKr
         vFK+fLRw0bOcCx+IR7daSCKiTgvC4TM4LBYIrKCX+8iLh3ECKP7yt1JaxmF0ODamE9Vq
         19ZUtDXidztuIALealoaBH1yL9zwNqzS/2iBRdAmRb/acmGH4/Uh6XZc+a0E4pe3R1Qg
         uOUVujSgOcGBEFiOG7v/8jUitiJDBXZsDbTniHWf7hLwNr2dh7n44lohvBvaKUSlis9l
         mvk7sTNr94Lqze9Jwil2Y1R9rx0CgBhAcgPzegKFJwAkUO2asHk0KWvsVB9SW1JKwxAF
         HWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rivQZ+Gyx3QuncUn7XBIjPPOLaniOfHJYPZkKaC2XyQ=;
        b=TguZs3aWexhOmVFhQt633HGWb99BW8UBtkhVQ5W75pEl8SCj4oX/2uoMZkDhsXcW7Q
         7pGvDozPJsli2bAAFsWzEjJB69wLbZGO1OZ5mwbk3ssEpPPcsvlOz+xuiGMWlUH9WXV4
         OX8jwRcrtRsqWF9BoU4f72UzY9fpa1yJHGsMiQsoFCTiFiHs1MNv7PYj8DgQl/LTNdcY
         V7VmauzKVj3yqWx7SPe12OtbcGNXyhyyCAtD+eHr+aHLFiSY3eJq2XSZzBZUiGVQU7SG
         ei+VTGKffm0bL6EysJU188qx34syrsxPqXvRyO8J8Mx0Cfb0WH/GgtC0dEtOf/CfqW1H
         FFYA==
X-Gm-Message-State: AOAM531UJ5guihUZHrhAm9cBS2pdkZI+mRzLY9IYilzQvg+uaHS8TSjT
        CRh6QZEZB8cFcDoqIj+NAtfXOShH35+OO/i16tvnTA==
X-Google-Smtp-Source: ABdhPJwfBaWwlxbC2/Te89Fx3tc2hajIPhEhZ8zHgZBE8A/4E+0qxVyOIrLIyy7Bv5yKOODe8uQXHjo6Ugjrgs8spgA=
X-Received: by 2002:a19:546:: with SMTP id 67mr733928lff.502.1605106587819;
 Wed, 11 Nov 2020 06:56:27 -0800 (PST)
MIME-Version: 1.0
References: <20201110093921.3731-1-brgl@bgdev.pl>
In-Reply-To: <20201110093921.3731-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Nov 2020 15:56:17 +0100
Message-ID: <CACRpkdbbMcJ+GDkYZB9vZMKk6r=RAB-cSGcthVCR8zm5bYaVVg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: devres: shrink devm_gpiochip_add_data_with_key()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:39 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> If all we want to manage is a single pointer, there's no need to
> manually allocate and add a new devres. We can simply use
> devm_add_action_or_reset() and shrink the code by a good bit.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Sweet!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suppose I will get this with a pull request.

Yours,
Linus Walleij
