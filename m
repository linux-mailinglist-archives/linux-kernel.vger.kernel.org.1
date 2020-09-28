Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E3727B529
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgI1TUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1TUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:20:39 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED1CC061755;
        Mon, 28 Sep 2020 12:20:39 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b12so2616353lfp.9;
        Mon, 28 Sep 2020 12:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWqJVzHlGh0zS1liHTgxa9/k0Wwyb2Aq2Bz1Zqwz320=;
        b=KhL+yZUxJWkWr8zKGRwtX8fZprWjsAhw4ZAYx2Bzv4QF++o5qU03/6L/gCHcxcZuRh
         2jBOAHt9fdxw2AbHr2Y2LB2eyyJHTzJxdzywXccvFTrgnlca4WkJ1d8UxBjMQXRQxnx/
         4CDzqaYhc3zRpoH3KRNvdGbTWL6Wj+O0phuVxdcD15B2ZSItm0E14OneaOj/Prtly4C1
         iifS9hXjFOWTlKXcmDjGVY/HlFGOwIA14PdyjVcts6r1MqxuIkEjz6bJFYWAOgrqKLNs
         V8mF9tG/MsRagQYiJXRb3ZdKhLYqNRb78dSNwPoTeoadk45nUmhb6Z78OtL9WwP0d8pE
         HR/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWqJVzHlGh0zS1liHTgxa9/k0Wwyb2Aq2Bz1Zqwz320=;
        b=f0adZP7haOht2kkGnYoesgzots+YiiTCRUd+5rY3fP0f0tHzqc+zHopyTaJ0e3ZUO2
         w0hiYux6vPmlsqHE8wUoGpxYclsPwLncRiokDo0jvxQV5gF/Qa/ppvOuNZrhMnD830iw
         6SoxrhEtvls4HWYiygvKpWb8Gj6RWmc764zZUKCR3nsS4m/o1MrL2y1vRJaz8rK5jDjF
         dBfUuUsSY7UaKnwHk1xWGcvlVFJJEQtHy+2rPn0CkMNEaC5KbqzOA8Qo+zBvzl6dOU1k
         Jquq7lzVZ60gGPeT20ur38hQWvOrkX4PvcJmYWk7PnR5+j7ParVTSoCcRLsO7il+82nB
         idEw==
X-Gm-Message-State: AOAM533WOL9NMrWiZll+CDmFsdoy0HMrbp9EWrfTCu1o7jQhA1xFTy2g
        qq+Ykkxxywhtsdw/tngWDbKAavVNYfjdjD/UY3E=
X-Google-Smtp-Source: ABdhPJywziMYQBuBPNOM3y1/rTq5UzFdUQP8SrrqwmA+u6qmq1pEaWFc48K4iCRdRfV1i9JbsC84qbWCObXxB+ZFY2g=
X-Received: by 2002:a19:c355:: with SMTP id t82mr1041111lff.251.1601320837698;
 Mon, 28 Sep 2020 12:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200928090455.34364-1-ran.wang_1@nxp.com>
In-Reply-To: <20200928090455.34364-1-ran.wang_1@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 28 Sep 2020 16:20:26 -0300
Message-ID: <CAOMZO5CrGi-=DCH8tfit2qZN7nJOGkfyN05g6ncu6MmrMT+2wA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: fix endianness of rcpm
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Biwen Li <biwen.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ran,

On Mon, Sep 28, 2020 at 6:14 AM Ran Wang <ran.wang_1@nxp.com> wrote:
>
> From: Biwen Li <biwen.li@nxp.com>
>
> Add little-endian property of rcpm for ls1028a,ls1088a,ls208xa
>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>

You missed your Signed-off-by tag.

What about adding a Fixes tag?
