Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7232E97E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbhADPAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbhADPAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:00:20 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFC6C061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 06:59:40 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m12so64963021lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 06:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0PbbGqDOcCpm7Yds/jaoVhGohWWLI5J0QeSbpytEdBw=;
        b=ZXVSRRY4kk0gtYCKkce4qcqVHrkjJ/dUT6CGBuIFPF4F7CVTQSmYftFn0AtsYyjGyP
         bJVw/wcPQBybyRs4Yt7mzzCOYGSoQVRSHEX/U7fuC4ZF/EXm3+0+3DLVu1VOG7oCorqC
         NScoo0rdOKdX2XhWeKtcPleJj+Pvit7BeJ/4rJqPHN7y+4MeY4nOjD/VSxbaUv7+TjaN
         KAXapr4ZpFyVT8VnjWkxmhcRKsaKD7YIRUQ86CD2WC8gpt+6r3Z7T/nH6ClGOShzbCbB
         VFDcVzpwyGjlePqxS/nEzGBpMYPknW62WfWQTTBRGgBV97OpdxQDLnPeNBW0oKjmN222
         imoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0PbbGqDOcCpm7Yds/jaoVhGohWWLI5J0QeSbpytEdBw=;
        b=Np6gcIt0mYo1h/iDtdGM+5SNMxPKDbHRT0mwPt3Tl/2dpBQtToXYPiSOWEvQe/Bbzn
         AO4p3gkUK/5aChLO/rd4EHUWxb7bdZ26egiuNtFrXhWFvWTYsTx11gFpFeJZBjBi1sZn
         a5RzkWYY2pp8jY0DjIzvw8PZbRub0AKifjzzA4AWPYKjIi+AoKoti+idMc3f0OvQfAnM
         uuqNKEvfcqeyMJNcat4VUoMZb89sLBNmynW7zpFgOpM1dVjcYZRp2ajV5sOOxZuvZr1i
         eYrT/8CBYSVnABgH+zUEGWr4osY1M2Q6MWcx2FOeoQuKjhQwnNezdEpQYgNvJAEceQEs
         cAtg==
X-Gm-Message-State: AOAM5303kRNB65lF7CK+eky4tWVb+FXQKIIWvHx5fKhpuPs8+vOEeHtF
        HHHJtqnA2Sp2X1PfxOs2BireeN/EqOh64xQ6fZFQ2Q==
X-Google-Smtp-Source: ABdhPJwzhEBA1rpFMkQC8lK8oOnPa8PSWwlZ+fJSN23r9dcsD/stQz7gGb0afK7Dmc9EmCCaDPLUcW+4f6HnsgJ+bxU=
X-Received: by 2002:a19:495d:: with SMTP id l29mr30750551lfj.465.1609772378873;
 Mon, 04 Jan 2021 06:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20201217144338.3129140-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20201217144338.3129140-4-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20201217144338.3129140-4-nobuhiro1.iwamatsu@toshiba.co.jp>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Jan 2021 15:59:28 +0100
Message-ID: <CACRpkdYdyZNv0QCej7ew3OLDbbHO9AtdS-+5zuGw0+MEc9bKUA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] MAINTAINERS: Add entries for Toshiba Visconti GPIO controller
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        yuji2.ishikawa@toshiba.co.jp,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 6:45 AM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:

> Add entries for Toshiba Visconti GPIO Controller binding and driver.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
