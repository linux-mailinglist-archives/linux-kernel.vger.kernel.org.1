Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6717926796C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 12:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgILKRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 06:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgILKRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 06:17:01 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BD6C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 03:16:57 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b12so8362255lfp.9
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 03:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKECHDEFAsfCQiaw3Oqc+2X4y871ON1oyOo5VwBVxoU=;
        b=GZWgtsb+HwBvoiCWCdnVOeJta82yBWMBFu+seH1V3w8jm9UcGOP2sup6VqzU0uQwTK
         W9HCrKLZr3hyNaHV8+cqowfYeJ+DkvpJsf1SgG2fC91kEKoLdB5+7EkML7/5HABKxiol
         EjSmFnIt9srKmCav0T+Jp2Cb0/WO/jCIOFrfntZMtPn1+ysJNLxpwGy2shKzeNDtJZIo
         RdTUizYFpBsdqrzSIXdXLOmxUQ4h6WosSyn8AQUjAK1ARgLl7HsdqjgJxPlOp5eG/wJ+
         f5hzS6V41ZiRjzl+EwMhq8VLO4NmQqXRFAxZhbxtJFkUwk/6VNseSuJSVVCidS/fKm4M
         vo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKECHDEFAsfCQiaw3Oqc+2X4y871ON1oyOo5VwBVxoU=;
        b=qjUjms9/NrrzV22FaXSNNxwwcb9pOOfJjswOm3Bz/rtEnoy5+vycW0HtPYW34MyN/8
         hieghCcoIPndFDtQOWRYWcPgJDuPTil0pO5CWAOPzQ9fdQ2kZbUktsNaERGNJwZ0nsMH
         jcLEh/hdNPnMDzmQNIGXA5znoLKqy4XNA6ssa4+DOJMh+QOSK12Mz2Ey6pW7Xr/hqkow
         txXZ70lufZnN3rvWg4pckWcYq1PBxrdnF6nRhHA0ncQVYA3hnAcoGCnQwt75RCBPIEAK
         xantX3JV6HdBAh9HHV1xbzFL4KLH3kvgL2EyQntzZzTcKMXIs/zLoMQSY2c3NnuF1kzi
         T7Nw==
X-Gm-Message-State: AOAM530OgH5GTizFpxKnDHm1SFbMTm3/CWejGuRyjNfoODuHed7tQvhK
        boHQIr39kP8AqiN6Dmeb+rM96/ClmdW2NnSbsGzFyQ==
X-Google-Smtp-Source: ABdhPJyVkJMjFXJhuHzLZM0ZLfMRJ8ifUjxRhdQx3zNXuU19Eq3aaNYCPsSi0wIQzevW0rSxhZdcGxwVHG+nrkUWs+E=
X-Received: by 2002:ac2:4c11:: with SMTP id t17mr1664019lfq.260.1599905815563;
 Sat, 12 Sep 2020 03:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200830224352.37114-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200830224352.37114-1-rikard.falkeborn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 12 Sep 2020 12:16:44 +0200
Message-ID: <CACRpkdbt5Da8ui4B1pd3Bk=BvRQceRcrMGyvt44T3CJhpV+tLg@mail.gmail.com>
Subject: Re: [PATCH] const_structs.checkpatch: add pinctrl_ops and pinmux_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 12:44 AM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:

> All usages of include/linux of these are const pointers, and all
> instances in the kernel except one, that are not const can be made
> const (patches have been posted for those separately).
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks a lot for going the extra mile to fix this!!

Yours,
Linus Walleij
