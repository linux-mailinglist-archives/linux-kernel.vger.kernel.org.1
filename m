Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B4B1E20BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 13:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388869AbgEZLOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 07:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388748AbgEZLOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:14:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849DCC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:14:10 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id m18so23963925ljo.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b95M1qQh0VwLNbffB8TC+GO9hdEpk++WQAqAR1kMuGk=;
        b=CyyFzJoY9V+UOZE9Zq5BHN5OPMjRTB9U0j20sE/x7pReF4+V9W78PVIUWrwHBYLzMP
         rLOAbtJHzzZTHEmz7PD4BPZpE6TnctpFocBmp3tkUNdkOnz3onsvuyYAG+ov/WWmiUlE
         nd90Psp70XfId9AEk8N4EPX+Sm31SmlSezJEdRLSVbPPF8O0NDZoftwRR+Ka0SvHJuKa
         ZPYoT5Qj0cZq6yhAeaEf0UaPTK2Tfd8Ge2G9zHcT2c+vEZB14JbiLZQayt43q87LxwMf
         l7oXh4oxF8t18Zd195Xj12CKw+e3AVYxCRdI1PAQ3BP8IaS6WdUJPskZQxA5yzegdpy3
         /qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b95M1qQh0VwLNbffB8TC+GO9hdEpk++WQAqAR1kMuGk=;
        b=J+DbALsEAcv8E4M+ILG7W62ShRRguik4nJbGpJ8f8MgEGfrAG9guEmF5I0Mr6iHT8K
         +tAiIFvY+NGdWRvDgEtwUCCKxMYVocweAfBm4bDpJbBkKNmnK5qitsClvifp7Qf3/BYW
         /cRNjY1wekbbrlhDlE9aRdsN+YTZ0MhwvlX3xfXkDRNvptgY99nqRPjUMftmA/SfJySz
         rHabkVJ3d+grxPi23XN4BbVr1ZK97sG36weahBCtgf+kFE/wQyjgwSS/+B8DaNZp4gjS
         ia7E3ZYltBbvc+JmJTYB8OddBN2C2DXOhHXRVuIoo1asecmSgzcgHVesBjguIwUnPwPJ
         2S/Q==
X-Gm-Message-State: AOAM533tOLAPLjTn7nFtIaw89WRaTHJFnf7E67H2416DAn2i/Oo8MHWq
        FPREuuLFejaZ9EAegr0IwxPuZznvfjY16gxcMOypEg==
X-Google-Smtp-Source: ABdhPJwI/7tMWVQBuQb05BL+Cu99HZR22lWtX466GsK/CcdoTAdF2CJS2VzlilKepOXhDSo6yGbqfQJQ5ReghXHYW2g=
X-Received: by 2002:a2e:8e91:: with SMTP id z17mr369834ljk.144.1590491647997;
 Tue, 26 May 2020 04:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200526104717.3181-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200526104717.3181-1-dinghao.liu@zju.edu.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 May 2020 13:13:56 +0200
Message-ID: <CACRpkdZi=UaGES_bupj_fQB+sPj5zOvONdCn7_Rs_j9mcukAAQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] iio: magnetometer: ak8974: Fix runtime PM imbalance
 on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 12:47 PM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:

> When devm_regmap_init_i2c() returns an error code, a pairing
> runtime PM usage counter decrement is needed to keep the
> counter balanced. For error paths after ak8974_set_power(),
> ak8974_detect() and ak8974_reset(), things are the same.
>
> However, When iio_triggered_buffer_setup() returns an error
> code, there will be two PM usgae counter decrements.
>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>
> Changelog:
>
> v2: - Change 3 goto targets from "power_off" to
>       "disabel_pm". Remove unused lable "power_off".
>       Move 3 PM runtime related calls to the end of
>       the function.

Thanks for fixing this Dinghao!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
