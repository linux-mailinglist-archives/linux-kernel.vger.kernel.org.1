Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D272817EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbgJBQaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:30:05 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:33353 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:30:04 -0400
Received: by mail-ej1-f68.google.com with SMTP id c22so1481468ejx.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 09:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NmuASYfCVRDr2iLzydnzYtbC57t7PWn5hJ24ngFnw+A=;
        b=eiocrGcZGRRB+xmJQgs8HDQFjbY+BLd406ir/st7nCcwho716BKOxfVBByaGgl3NTg
         A6YW6cT5CRviCkIQI9p9/M9N0Mi+OrSx5gvj7ebAGVV4GJ7j7c4cFhRiXg47IlDlZN5T
         WMSkkmIby6MhEMw2u2EaSY3Fw3l7VQAGhab7+toRQz9b4PcaM1qd3oOR+D0EEQprw2yb
         bDeFKhJMrSc78ryO7YqcYJJRwmZjBLzXyOaLRpQ68q3EyIpGLf7+9bdmXe63PW146AUz
         4eJlJYXWmx2KqQjsJtTSckQy6Wz0iMw909lr9mfCHL+Ejwho3ktCr4WTE0Ump5zAkd9W
         p65A==
X-Gm-Message-State: AOAM5304SG8PW5VBSd1csMlOx/bXdJ+Vt8Js0MCojcpCdkTmwjDQSM8H
        awhyeOYlHnCveFaVltt6D5k=
X-Google-Smtp-Source: ABdhPJy5JKo4/ZsU95nYWl9XHoS2d/DXY0H7Q4UDI/GGeGNd2h4paMPaz2+a7Ir0z3yOHzLYkDBj8Q==
X-Received: by 2002:a17:906:4dc7:: with SMTP id f7mr3173601ejw.261.1601656203038;
        Fri, 02 Oct 2020 09:30:03 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id t4sm1444928ejj.6.2020.10.02.09.30.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Oct 2020 09:30:02 -0700 (PDT)
Date:   Fri, 2 Oct 2020 18:30:00 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, HS Liao <hs.liao@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [PATCH v3] mailbox: mediatek: Fix handling of platform_get_irq()
 error
Message-ID: <20201002163000.GA6464@kozik-lap>
References: <20200827182507.4938-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827182507.4938-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 08:25:07PM +0200, Krzysztof Kozlowski wrote:
> platform_get_irq() returns -ERRNO on error.  In such case casting to u32
> and comparing to 0 would pass the check.
> 
> Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Fix subject.
> 
> Changes since v1:
> 1. Correct u32->int,
> 2. Fix left-over '!'.
> ---
>  drivers/mailbox/mtk-cmdq-mailbox.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Any comments here? This is a bugfix.

Best regards,
Krzysztof

