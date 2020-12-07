Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAC72D1497
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgLGPZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLGPZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:25:07 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2E9C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 07:24:27 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id o11so10081495ote.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 07:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePZ6odnGRSIS18NlRzl4CISfk4V5dznqUnLHErxLtDg=;
        b=TWIMTcRamXlWkOYwMtcuIRzEiBXJETLPYIaGzWBFS6suPAEOACnOqrLBcNLhiDfiqe
         LASrxZEZeI+luhgqmCA7KfeBqbnbq7dNc4foKDXcG1P5Ido5OCsGfY4to6qszZNRDyUS
         xHbKHyt80xrrDHGkQ7034QLNYHOWiySq9EOOc0MtMXO8g8U78o0gRjAcye6gVFA1DntB
         pF0tYRkju0GkS0S6T1XUIb4FASAObsp9QbeBwWd2qNT/+13WOmQaMYh2pzBmZh9xBMHr
         0R6X5FcDsCN+LFzy6U3lVrhIfkN1mmaBr8/VEvzkbDiQlr7hYyJBcu2LhVMXcyz676+B
         nVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePZ6odnGRSIS18NlRzl4CISfk4V5dznqUnLHErxLtDg=;
        b=TpXdcxduB1rV0W1GRj4ojbNES2kFy5zVO0t619aMf0wvWti/HTnz8Gz5OP2GhRbIaY
         X8AIIYZWEqzlrIPpEVRcdSvoCKUlqqN+/UVxDj1OZ0cl+ljBqmEmYmpDT1mqxN7YlGyt
         TPyHmC/kU8qMsvb30TG6Fa1bPC+1zAlHzNuG0gCqWtvtLewjLNvLLV1yu2V78Kz4wrTc
         sI0EimQfjzHaPgVjN68DCe2XWkBqmkpJBGK6B1jedjK7DL2izEIv2+JzovfB05cz3MSP
         Gk7/DU1rk9KXr/JYDgK7PF+hj8sUokgfg2X4WmSNelv1+C/CHngLSsqoXYXCHi8NKja8
         YiVA==
X-Gm-Message-State: AOAM530oM4ZHD6fxTd/16060BZt9Ek2laABNyLgdElt0c4lM5N0T1doe
        EXKpQDxGcR5qVbPTjhIdM5xRSsww3HT2S2TjCGA=
X-Google-Smtp-Source: ABdhPJyNVjZ4VuT3LH/Munmg27VQUTdViaFTKTLAmWZ80U+7lq/lrBDDlLf80f7MS2V9eWrh7pkaST+yNtpI1z2lcQ4=
X-Received: by 2002:a9d:889:: with SMTP id 9mr13436548otf.6.1607354666928;
 Mon, 07 Dec 2020 07:24:26 -0800 (PST)
MIME-Version: 1.0
References: <20200429165347.48909-1-rminnich@google.com> <2124367.HovnAMPojK@sven-edge>
 <CAP6exYJ7QR+Y7Vsumecx_3rUC4cNY4xJj4e6759S8US6FX7ADg@mail.gmail.com> <2560223.mvXUDI8C0e@ripper>
In-Reply-To: <2560223.mvXUDI8C0e@ripper>
From:   ron minnich <rminnich@gmail.com>
Date:   Mon, 7 Dec 2020 07:24:15 -0800
Message-ID: <CAP6exYK75zwqhtrMykMqPepPfq=S95UEByy61D136aPKCBBSRQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: parser: cmdline: Support MTD names containing one or
 more colons
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-mtd@lists.infradead.org, John Audia <graysky@archlinux.us>,
        Adrian Schmutzler <freifunk@adrianschmutzler.de>,
        jstefek@datto.com, Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I pinged the person again. Hope to hear today. Sorry for delay.

On Sun, Dec 6, 2020 at 11:52 PM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Friday, 27 November 2020 19:54:30 CET ron minnich wrote:
> > Thanks, Sven, for your patience, I will indeed try to test this next week.
>
> Any test results?
>
> Kind regards,
>         Sven
