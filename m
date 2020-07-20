Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E59A226139
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgGTNox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 09:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGTNow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:44:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C89EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:44:52 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h22so20288658lji.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vO68nr1oafNwbzKJtL1z+v3Q79Ll6AjKZYEDPEkEqA=;
        b=gDzDOvQVpHdpkFi+NKXmKxqtjDztY58daL5twni4C6h+4EIfUnnCEVpJnbP1mFUICj
         ftLbeXMGXm/usp1RNih5XSmgFuVtZJ+ZnqLqBA0agifNxd8p0HXSXH+AelR/XG+33Y+x
         9pU+L/8++f7ZN4IQVW32a+JB9jcKmK22ZM1k9W4uxgbSUV6bUgXzwe6VNyIQWQ72epQR
         KXWhMmMee5//axfodVg4+2rO/wFyAGRboX16N6qHc7EqKzNQcfjGuJq4Ao31jvM3pdko
         812rlnF21uNKT0slPs0BX+7XZc+nrb8fX8k89HpyfQz4TjL6sYX/P875IZz1wlZ+gcFy
         X3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vO68nr1oafNwbzKJtL1z+v3Q79Ll6AjKZYEDPEkEqA=;
        b=roQdSMqLE7DcpfdTH1xDY9ibkf+F175TuMkI8Mpd5A1mOuzjYTlo6pFGKnNKgKWRR3
         aCe3rc+GKe1dpGyoQEr3tKhrNFHBm/wVxsc7cK8PLX7BpHPmKcLraCwkyKaiOJ+UMock
         2UuQVA3FiEdIEQKl9CQd19j+3YzEv2aZZonTtKOqR+k0azDBhGU/gRtHGzNV9bFstWCf
         vF9IaHbuNhGl2paXBsXL1ky0cQfHV75Hf5wrs0GZ5RJad2KogavvaIM6UVZGV6paG4Su
         VS4Lg9YkeX7hp5ytIcflrqEBi1YjPfhjRgZty4vNyYrOv3Z3gNd9RHen7KJuIGaOwIWd
         0FCQ==
X-Gm-Message-State: AOAM530E9tzhFBGsE/LlQYaKI6zcDR65hKTok0mOlqVIZWnuhXQR/q2i
        1mQu4DAOeyi27lwS4z0wmDCVP+mvH9xh6CqwElqoGQ==
X-Google-Smtp-Source: ABdhPJySfFYuk5Weu3/vs14ZXY0Z6epyKH9PCACT2lfCO23uU15IBzL/KHbXUx3xmTmx0XKEsAPHVqSROnnw++1dxGc=
X-Received: by 2002:a2e:7a1a:: with SMTP id v26mr9939702ljc.104.1595252690371;
 Mon, 20 Jul 2020 06:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200716233229.208750-1-paul@crapouillou.net>
In-Reply-To: <20200716233229.208750-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Jul 2020 15:44:39 +0200
Message-ID: <CACRpkdaqcAXh9qyjH_W+mwP-+KJw7jPaNx=LQYV505s9nReV-A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ingenic,pinctrl: Support pinmux/pinconf nodes
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 1:32 AM Paul Cercueil <paul@crapouillou.net> wrote:

> Add YAML to describe the pinmux/pinconf sub-nodes of the pinctrl IP on
> Ingenic SoCs.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> In-Reply-To: CAL_Jsq+nHZsbOMPpXC7NWp1etgVL57Q+o=gr6BJ6ijAq1pLJUw@mail.gmail.com

Thanks for fixing!!
For some reason this does not apply on my pinctrl "devel"
branch, am I missing something?
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Yours,
Linus Walleij
