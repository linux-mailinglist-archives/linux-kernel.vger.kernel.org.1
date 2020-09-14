Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175D82697A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgINVW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINVW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:22:58 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1303C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:22:55 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id q8so828631lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3Raf4UC9rPf9/2GIe2y0keKdeGhWb4NBqALKLPqApw=;
        b=XlZnKz9G6ag4oJchL/qYdMihrdnCJSGrMK2k4uKNZUz8h2Ur50bvs3KAXwwzSCfsWu
         5hK1CEXx20iItEGnGjkEIW/UEbebefnBx9aDPjsYIAhRTILgxN6xlQ3L8K039YxjzGrp
         m72maCaoZZwAoKcyd0QXUvLrcrs5GjaiEiweQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3Raf4UC9rPf9/2GIe2y0keKdeGhWb4NBqALKLPqApw=;
        b=LrYA+6R7n1q//eihNjOaQgnvCvSBfBfxdkPe51Pt1YwSjFIki7iiN75+9qnBaxOIkT
         O+xKQ2/85jlyYjPZ71FhD3xhFv7hNp0SgznK4v/MRzn29jh5HrrbJja9rBghmtxTOrQi
         iRK4v+pmBnlO6QALrXQjVBy3DXZI+Lvmf5EhGbyAIatLl8ycE+WZJV83odi+pmk1aKmf
         ZvPPPiOs5F51xreB0Runl3pcMPKYzLlTuTjvM/Li0LYowXgjktWkEB4N0/uanT78njzd
         bGyit6UZIP3+4OM4lW8hKcMf9VQadeuNxUdbhqGrZf2V2+wAoiX1TEs5LVeM4Z9ccDva
         g0bw==
X-Gm-Message-State: AOAM531nCE07eq6PxlZ/hAJRW0QAFMvB8J0ptPRq0Faj9oCK+VDTDA5j
        /9MAvAgs0VKmzrOAZv2VmDMgLjlAclBliA==
X-Google-Smtp-Source: ABdhPJzHtOyTRStXiKGq3eRGIL/CfRxvvEj9rRAVtTAHRWi9yR+ZaPHLWyceSGLgsKJ4KjWKtIu+Ow==
X-Received: by 2002:a19:6418:: with SMTP id y24mr4631670lfb.388.1600118573028;
        Mon, 14 Sep 2020 14:22:53 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id e8sm4248861lja.93.2020.09.14.14.22.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 14:22:52 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id y4so921050ljk.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 14:22:52 -0700 (PDT)
X-Received: by 2002:a2e:9497:: with SMTP id c23mr5361525ljh.124.1600118571616;
 Mon, 14 Sep 2020 14:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200914182112.513981-1-swboyd@chromium.org>
In-Reply-To: <20200914182112.513981-1-swboyd@chromium.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 14 Sep 2020 14:22:15 -0700
X-Gmail-Original-Message-ID: <CAE=gft6=XxMs0z=oB3CyHETcg9Ahhrjw220JPfbhVWpA7aBZzA@mail.gmail.com>
Message-ID: <CAE=gft6=XxMs0z=oB3CyHETcg9Ahhrjw220JPfbhVWpA7aBZzA@mail.gmail.com>
Subject: Re: [PATCH] interconnect: qcom: osm-l3: Mark more structures const
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 11:21 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> These structures aren't modified at runtime. Mark them const so they get
> moved to read-only memory. We have to cast away const in one place when
> we store into the data member of struct icc_node. This is paired with a
> re-const of the data member when it is extracted in qcom_icc_set().
>
> Cc: Sibi Sankar <sibis@codeaurora.org>
> Cc: Evan Green <evgreen@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
