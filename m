Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8520D2CF911
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 03:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgLECpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 21:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgLECpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 21:45:11 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602B5C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 18:44:25 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id ga15so11496003ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 18:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUPu2DUBMRAu12DXRp3pTRDt+ZwJx6w5SlC/8VGie84=;
        b=X+/2zN4Bmhn0nBYGcOfIC1rXbVGY00KmZn0QEb9HMuQX8po0pu/eEMHACi+xSLRuqo
         ZOsLL2CFmQlq41ARU5CRPgrW4QGNlnOHjnOqaKqVHKw5Qad+wFsDkQOHVsXNY3sdWl+U
         qX07t+jEzroLTKWy2AtVuycW561wYPO9dugHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUPu2DUBMRAu12DXRp3pTRDt+ZwJx6w5SlC/8VGie84=;
        b=C8kPF/7E3dOocCCXkfQck2Y+m8u1PP1eECmxMD3+k8PqR5OjPtK9v5CAoTOv4ofkIe
         hI67Z+WDD8XWGteFGQ6v8Ge20DNVgBacfLEYVjnHJbL91qSSJnnQSAAZcqIjoTOpKrcX
         CZvcyVb+tR52gIjcaJiGqG0VV3SpDd/Gn/N+zA+10BVwoHo6jxOeeYVSdq0e4CbGZP+F
         8kae7lyciKcfL8Z4hY5GOJhs/gEbTSPwPiDouLrOsaqqGmoaIhSYqa/chycjcK48pt6c
         k4tOmb432Qp5dW2d0U5IC8RtSsKJjwqORj9KXoorpHHx3pyudt41dFHxn3fgslCdTX3j
         waIg==
X-Gm-Message-State: AOAM532HPIRmuZcseJfpulWB9nqNeFGn4PtIr9jZcopkOQq/JgNh8HAU
        yW5zxaGZr4ND4bgTPClgX//0+blwy4C6Fw==
X-Google-Smtp-Source: ABdhPJx3dCZpwyNc98aCM2ssf4OA9YGLx9stX37e2Yg3LV4NHDt8izOIGn6LlM6Bjmlgob+WzmSHdQ==
X-Received: by 2002:a17:906:d931:: with SMTP id rn17mr9620534ejb.308.1607136263746;
        Fri, 04 Dec 2020 18:44:23 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id r24sm2139461edo.4.2020.12.04.18.44.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 18:44:23 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id i2so7111149wrs.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 18:44:22 -0800 (PST)
X-Received: by 2002:a5d:4388:: with SMTP id i8mr8217348wrq.262.1607136262520;
 Fri, 04 Dec 2020 18:44:22 -0800 (PST)
MIME-Version: 1.0
References: <20201204100139.6216-1-stanimir.varbanov@linaro.org>
In-Reply-To: <20201204100139.6216-1-stanimir.varbanov@linaro.org>
From:   Fritz Koenig <frkoenig@chromium.org>
Date:   Fri, 4 Dec 2020 18:44:09 -0800
X-Gmail-Original-Message-ID: <CAMfZQbw1GjxHbCfY2XCCw=o410ziBZndCQizh6fX7LTkhOq-nw@mail.gmail.com>
Message-ID: <CAMfZQbw1GjxHbCfY2XCCw=o410ziBZndCQizh6fX7LTkhOq-nw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Venus encoder improvements
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Vikash Garodia <vgarodia@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 2:03 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hello,
>
> Changes since v1:
>   * 1/4 - fixed error handling in hfi_session_deinit (Alex)
>         - keep venc_set_properties invocation from start_streaming (Dikshita)
>   * 2/4 - keep original mutex_lock (Alex)
>   * 3/4 - move msg queue inside if statement (Fritz)
>         - move rx_req setting before triggering soft interrupt (Alex)
>   * Add one more patch 4/4 to address comments for hfi_session_init
>     EINVAL return error code (Alex)
>
> The v1 can be found at [1].
>
> regards,
> Stan
>
> [1] https://www.spinics.net/lists/linux-media/msg181634.html
>
> Stanimir Varbanov (3):
>   venus: venc: Init the session only once in queue_setup
>   venus: Limit HFI sessions to the maximum supported
>   venus: hfi: Correct session init return error
>
> Vikash Garodia (1):
>   media: venus: request for interrupt from venus
>
>  drivers/media/platform/qcom/venus/core.h      |  1 +
>  drivers/media/platform/qcom/venus/hfi.c       | 18 +++-
>  .../media/platform/qcom/venus/hfi_parser.c    |  3 +
>  drivers/media/platform/qcom/venus/hfi_venus.c | 77 ++++++++++-------
>  drivers/media/platform/qcom/venus/vdec.c      |  2 +-
>  drivers/media/platform/qcom/venus/venc.c      | 85 ++++++++++++++-----
>  6 files changed, 127 insertions(+), 59 deletions(-)
>
> --
> 2.17.1
>

I haven't had a chance to review the code yet, I'll leave that for
early next week.  In the meantime I have tested the patches and found
them to be working well.

Tested-by: Fritz Koenig <frkoenig@chromium.org>
