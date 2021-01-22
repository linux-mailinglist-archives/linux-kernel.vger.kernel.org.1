Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D19F300B43
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbhAVSbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbhAVSZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:25:06 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953DCC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:22:12 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id g3so8997951ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HMx5WULUEpo/GvYQe+DCnONeXIBdpeEzpvbY3sfaTEo=;
        b=DwcEicKGOYG979Ms2/RsOcxdbOz+6kqfBTvMCmL8ufwGuQ/rK5qyX7QuTJCk4wvbsO
         i9J//LKcBcsVEQ8c93Ni1iHpIwhrM20bEd+ISp8s36j4xB0AuBDW9L9frbr0XNiLwdun
         t/6c1S0CH+y4E6nlDlHafdV440DEKfHG48iCc3jvdEY51H1tpHbCVbj7bDtPYe+uv1Yh
         taOgih7Ix7utI2mosWqZIBhJTP3d8fujK/K6gDHBbIJiIkAA2IOT1xe2/3gW2npwkdrh
         GSeuU329T4e7WAYw0VgZwKfAVBzPxhTBitw+Tdk0hLrWj1+7rJF3VRw18XGyhiuv8+Cv
         dN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HMx5WULUEpo/GvYQe+DCnONeXIBdpeEzpvbY3sfaTEo=;
        b=Ze9SXNi7oNQhMlkRLULdYS0d59qAsZNvVA991Y101UHnCg2v65KSSV9yLyKitk5SUc
         Xnvh2eJuKr70iEpbVng3eiPFfzArHhNqTBu8WgL0iqO7cHhdsfq7yEg3Mqq8TyKzLojC
         qQZWtGSW0qGb4nSpOpSHyG8Kv1B3KTNkty6WcGm2yeMlwtgMz+amJ+i0Wyh0SotsmDQL
         PVZjLoNrSkzAHs/YnbChIvUVbAQE5WL4MefJnG3imKd8UkIC84WI9Ray2mhRxJzFf+1K
         s6TPv9Cb+Tdy17ycc/rcOv1DVsM6A8kaOJ/HOZfznlz2R23/+iYFu+TI/ktLSOlzavDc
         LygA==
X-Gm-Message-State: AOAM5321aW5eip1tcC7bN0uQgZkI/fuzkL3deQDf1OMT4JEyQ7RoQSeH
        fd713HbikgV1DIYThnS6cJxlaw==
X-Google-Smtp-Source: ABdhPJympufxTHr/CGIxRKqJYH6dIPcW3Ml2RciAkM8LEv9zc6ESKWuYW7wxKbZwNgkP1pWqgIEfDg==
X-Received: by 2002:a17:906:af41:: with SMTP id ly1mr110739ejb.491.1611339731290;
        Fri, 22 Jan 2021 10:22:11 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id w18sm4942368ejq.59.2021.01.22.10.22.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:22:10 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/6] block, bfq: first bath of fixes
 and improvements
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210122181948.35660-1-paolo.valente@linaro.org>
Date:   Fri, 22 Jan 2021 19:22:08 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <721F90B0-837A-4EBE-90CA-35C88C2A57D3@linaro.org>
References: <20210122181948.35660-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 22 gen 2021, alle ore 19:19, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi,
>=20
> about nine months ago, Jan (Kara, SUSE) reported a throughput
> regression with BFQ. That was the beginning of a fruitful dev&testing
> collaboration, which led to 18 new commits. Part are fixes, part are
> actual performance improvements.
>=20

The cover letter was not complete, sorry. Here is the missing piece:

Given the high number of commits, and the size of a few of them, I've
opted for splitting their submission into three batches. This is the
first batch.

Thanks,
Paolo

> Jia Cheng Hu (1):
>  block, bfq: set next_rq to waker_bfqq->next_rq in waker injection
>=20
> Paolo Valente (5):
>  block, bfq: use half slice_idle as a threshold to check short ttime
>  block, bfq: increase time window for waker detection
>  block, bfq: do not raise non-default weights
>  block, bfq: avoid spurious switches to soft_rt of interactive queues
>  block, bfq: do not expire a queue when it is the only busy one
>=20
> block/bfq-iosched.c | 100 +++++++++++++++++++++++++++++++-------------
> 1 file changed, 70 insertions(+), 30 deletions(-)
>=20
> --
> 2.20.1

