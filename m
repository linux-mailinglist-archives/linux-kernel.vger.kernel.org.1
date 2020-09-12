Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC040267962
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 12:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgILKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 06:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgILKKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 06:10:38 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC87C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 03:10:37 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b12so8352030lfp.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 03:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDTYW3trvJhHdaQhRFqDVdIqzcok74e7pbHeU+yogTA=;
        b=a0OfaWjMNAUmatft5DHcMJCpcnT45zK5jdP/4JhxgcfIa0Y133kYVJ613Yl/XPRUIN
         vZgnToloBgjePkBogAawPrCQ3/Y0qlCDfrhdlSISvq+ywNzw0TxaEXT0iFYZNgcggtMS
         KztpalH8ZsyaUUrP5zZaLwfL6ocKKAfW6Oe8AICzITsn1njl42GKxufhCFB9ksSCJXTM
         Tyi44ZAQeY6A/3tPzbpB/EB8qn1TkKlMVe+C3luy1KVoA8OpY5fpRvk5FGW1CN0uJAO/
         YCeXZDZSTzyXxPs+MzEK1n8Ep2iz0dJ2Fee9JZXmJDqdQrUwTE8H+IuimABpFQj2segi
         cRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDTYW3trvJhHdaQhRFqDVdIqzcok74e7pbHeU+yogTA=;
        b=JgDX0AsWvMFk3azxBFWw2Gqk6MjT/tr2Zwt1ASqrnjrqND+Y2/7sFNhNn82XP63ek+
         cGXj9vYr4zPIa3aVTmsw4nFU+Uogu/OtGytWR89ZhnUtAca0Cemi6Evbp3cbVA0oMEbs
         6XvVEfnTyeBoSvaqujyQYrY0AiS3ZVwq4qn+eqV/8rxfwbq6IFmZijW7BR2egnytU/CX
         2UQO/fmhdD4RAZ+0eYLV3hJyk9ZVlxqVx/vJ8HqBq/8YTYRQSdckFiqTWCrBmK2HlqpU
         2XMQ8JJSysTxqtrazEufPxX3VnBlbtbyxHlNYyKhU8nOvJufoVxSOKRBriqYn94yj2vU
         AmVQ==
X-Gm-Message-State: AOAM532W2AittXH12HXPEbzCAnI/jkzWi4asH4ksAYdvsQhjhLZcls9M
        KgU2+Ln+EtKB8CKGryqVs61mb3FCMJIgpIcZ5OGoaA==
X-Google-Smtp-Source: ABdhPJxTOAgaEnT6FSfqJfn6/7PDv7Rc9QfJO8+OWRg0oI/ayMmxaHnaiS/hAfgtTxf5T0oIxgxuuHzDXr96RDEjciI=
X-Received: by 2002:a19:6c2:: with SMTP id 185mr1451633lfg.441.1599905435954;
 Sat, 12 Sep 2020 03:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200829174154.GA9319@Kaladin>
In-Reply-To: <20200829174154.GA9319@Kaladin>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Sep 2020 12:10:25 +0200
Message-ID: <CACRpkdbmRAoBp-r+U5_yQOfGcS7UWrzZWb+0XXFHb4bD=OJA6A@mail.gmail.com>
Subject: Re: [PATCH] bus: arm-integrator-lm: Add of_node_put() before return statement
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 7:42 PM Sumera Priyadarsini
<sylphrenadin@gmail.com> wrote:

> Every iteration of for_each_available_child_of_node() decrements
> the reference count of the previous node, however when control is
> transferred from the middle of the loop, as in the case of a return
> or break or goto, there is no decrement thus ultimately resulting in
> a memory leak.
>
> Fix a potential memory leak in arm-integrator-lm.c by inserting
> of_node_put() before a return statement.
>
> Issue found with Coccinelle.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

Patch applied.

Yours,
Linus Walleij
