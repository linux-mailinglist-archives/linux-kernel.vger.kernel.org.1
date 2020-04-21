Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D1B1B254F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 13:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgDULsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 07:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDULsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:48:14 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DF2C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:48:13 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j3so13594352ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hr0urbAhdYYXsm2dSDM+ijiOf6geNis17wmxjM94cEM=;
        b=XkEhAU5R5PYd4McD+1unOUpGqJ+vG8hqHZerVpdqaxtNv/lweY2dl7oRy19/HKkxBt
         Sx3x5ca1ZStLuJy+AdQbI8yJ9B4iqaGI1ocVw0Bcpeq2QiHZZ51nGYIeNPHDUgYwHvN4
         7D4gjQaQDPKW/NoJP3m/YyjSVuv/iV/QMLFN/MEcU3VKj+Budv9l9GZ4FuWv6ZYPlv99
         PxLX/JENwG3COtZUNYNrQO8pQj2qEjjnSrJrTzrsCWddSkdKvU9JeE7O3QW2CoY1r4pp
         wg6IjnuFPY74IfKjviVQ/splfUr6HVn+OvYVztelLIGqihWmWCwCCdlREIeWnlvi6Tjs
         gI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hr0urbAhdYYXsm2dSDM+ijiOf6geNis17wmxjM94cEM=;
        b=jyhRaSCJ0g4mG/6fTSUxmlHjPR5jlv1BjnEC2dl2FcunGLUWOHY5qf1RjDpuxUG9R5
         giWw6FJTrxozcOV78jLL1FC5cfvIU4nEG4Ezd4OCHBOzct/sWk3WVnc+gtSm50o2Wx1A
         J2HPXvSxkTA338W9jAr5GQw6zAlBSwitQ4tNR1L8QgTdmS6pOlzayg7VhS+dHw18AWcj
         4BxDblR5o6srtfVemENuKPPVrS3TsQp+jyPM7PX8D0lnz9IIVL6drR1u2S9DNmBv1JvZ
         ZTFGFR7taBlUF5m5zOtpJarwOY3yGXBmLp7lhFLqQAETeTwS8lPBS44oammTYRCiUVCH
         tRig==
X-Gm-Message-State: AGi0PuaO9zkEPdE7qH1glpY72Oug+XA3DltmBZpbR5KSz4scPR71YxK+
        2MBQI4kGjK2ynjteH735RTQ8mKQjQCqS7wtlRFeFJQ==
X-Google-Smtp-Source: APiQypLcKHjcdphSZ9nRGKZ2ueyTjflZeCK32oJlzvi4dYlpx1i0PUweOppmGjOEfSA8LIjTtsPU7HYnWrcKMM0x2zI=
X-Received: by 2002:a2e:585a:: with SMTP id x26mr14023189ljd.179.1587469691923;
 Tue, 21 Apr 2020 04:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200420080409.111693-1-maco@android.com> <20200420080409.111693-2-maco@android.com>
 <b546eff4-616a-8488-fc11-9b7e23d44bcf@acm.org>
In-Reply-To: <b546eff4-616a-8488-fc11-9b7e23d44bcf@acm.org>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 21 Apr 2020 13:48:01 +0200
Message-ID: <CAB0TPYHXCRq-SVGsNBviyCAyP75oKam77W9vdsyri9fzA2tp+g@mail.gmail.com>
Subject: Re: [PATCH 1/4] loop: Refactor size calculation.
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 3:22 PM Bart Van Assche <bvanassche@acm.org> wrote:
> How about using the SECTOR_SHIFT constant instead of "9"?

Ack, will do.

> Please also change the "kill_bdev should have truncated all the pages"
> comment into something like "return -EAGAIN if any pages have been
> dirtied after kill_bdev() returned".

Sure - would you prefer this to be in a separate change?

Thanks,
Martijn

>
> Thanks,
>
> Bart.
