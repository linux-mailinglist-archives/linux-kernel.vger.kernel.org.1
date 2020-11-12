Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74032B0463
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgKLLx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:53:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41346 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbgKLLwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:52:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id v20so5767686ljk.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xeIxKSXAFIucEStiMPJy2kOgKe0FiyFd2v0/6ZVQ1QU=;
        b=gCs8p34Zg2L2/Q22YscbElq0Al7CQEqleoS3yZ5JmT1evQA0HKJC0JQj6tcq7uP/5W
         Q9hkbcnp1g9OyTU5SG2rfDCYGHGLxdlGXcs3/ZsiV8R1zE1T4iMnMAoHfZ38fKMK5GJp
         +vAAzp0P4jbjKFejTRsysIbqg2WOP8oHZ/5FKpnnw4n98f93dJ6vG79P9vtSoird6LOt
         MQMD+TrXsVh7pt1PO/qCcRTcq2mdjXtweOjUBdFHGUfaFwFsLBwZbW9J38qlfoh5Gwpw
         8NJhAT8ITHkvtBDgKOKiWgWTzyk6SBUJUsJaDGzHaVD9hi/ApUe1CjiCJTysbNmlzfsq
         alXg==
X-Gm-Message-State: AOAM531jnhAw1gjWm4E2wxcpMI65AkTsNKlZuPJDI9a0D2VVsIL73rGo
        i9plnb16I41AIvsxkvwbyWLEOqSDoOVGfg==
X-Google-Smtp-Source: ABdhPJynjI0b+cH0LHiuqd8tpqrm2F+imoYiwcGKp5xC5Ge9K66sNzsc9E520c2MUNN1NT5qPXdG8Q==
X-Received: by 2002:a2e:b605:: with SMTP id r5mr9396654ljn.346.1605181948518;
        Thu, 12 Nov 2020 03:52:28 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id y6sm534939lfh.99.2020.11.12.03.52.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 03:52:27 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id j205so7958450lfj.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 03:52:27 -0800 (PST)
X-Received: by 2002:a19:e04:: with SMTP id 4mr2783488lfo.193.1605181947272;
 Thu, 12 Nov 2020 03:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20201106213655.1838861-1-lee.jones@linaro.org> <20201106213655.1838861-21-lee.jones@linaro.org>
In-Reply-To: <20201106213655.1838861-21-lee.jones@linaro.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 12 Nov 2020 19:52:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v66qjLmQEAQdNqpx6HZ2A6O=BqygAn2uepFXUYM0ArZV8A@mail.gmail.com>
Message-ID: <CAGb2v66qjLmQEAQdNqpx6HZ2A6O=BqygAn2uepFXUYM0ArZV8A@mail.gmail.com>
Subject: Re: [PATCH v2 20/23] mtd: nand: raw: sunxi_nand: Document
 'sunxi_nfc's 'caps' member
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris BREZILLON <b.brezillon.dev@gmail.com>,
        Qiang Yu <yuq825@gmail.com>, Dmitriy B <rzk333@gmail.com>,
        Sergey Lapin <slapin@ossfans.org>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 7, 2020 at 5:37 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/mtd/nand/raw/sunxi_nand.c:250: warning: Function parameter or member 'caps' not described in 'sunxi_nfc'
>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Boris BREZILLON <b.brezillon.dev@gmail.com>
> Cc: Qiang Yu <yuq825@gmail.com>
> Cc: Dmitriy B <rzk333@gmail.com>
> Cc: Sergey Lapin <slapin@ossfans.org>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

FWIW,

Acked-by: Chen-Yu Tsai <wens@csie.org>
