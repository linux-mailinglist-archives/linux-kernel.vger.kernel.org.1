Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CEE2EA201
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 02:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbhAEA7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 19:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbhAEA7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:59:53 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D525BC061793
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 16:59:12 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id q10so15494220vsr.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 16:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZxuuYiPtHc6s2Zy+bkt3Y3hl+3F1jPre2w81KvLQfw=;
        b=bLCWFQwUTYyKbRkiIoiB0WKRGHiO3kAx3ufaAPHtT2TOxGQyZ+iwlCyGaHOVutCFt8
         q5LeZvTxDacbRLXvM8hzOzxPxf7h3iqUKECM9t8nJPDIaLWVic/i3BKLA0AtVs2Q8Krc
         wYCSvi9xrIo0R29+QXHGzBiJA5s6hrcffWLdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZxuuYiPtHc6s2Zy+bkt3Y3hl+3F1jPre2w81KvLQfw=;
        b=TeF6BZPgGnvTjLbW2C6CQGJyBoYJ5yLfi/JLKDjy70nSO+OV3ShpALjrgBpuTX4EeE
         it+HV8U5m5l6D54ZYYqPkLW1haxAqBn8wpToB33xgOvycrWKh3Ju+63tX/V8HVInib+X
         SNCKWPoPc4nKhJa1TTImMtnoQzY7Znh8Tr006BYgIJat0DplMKghHxgcuWaT2kLIT+iL
         EMzLaNC6XvzxXkfWZgXKL2bkK1ccUuTgPE48KQDdm8DJfZQAkwucLqSsV/GikdaNOk7g
         17LN0RrBPQZsFvv6xWpDbAHjt8Trt7Cvxga2J+xvzgzjiq0Omr+cOSOQRUtqspCxv6f+
         RaMg==
X-Gm-Message-State: AOAM532Npm2/q9FHtqK4P+1d+H3Epv9QLaMk7J+hVOWybG+YivEp2QPu
        kf6VYSlNVGUlvNv8Bp8NgqpjK+cSDJXMb0RpflFh0g==
X-Google-Smtp-Source: ABdhPJzB/3Kn2M1TyHyXiaHLvCJYLcm7dAyGmWlRcLpFicTs5UuECGJOIcH1VSh+UbCaJXtfJZqxaSnDWiCRv2KQVsI=
X-Received: by 2002:a67:ff03:: with SMTP id v3mr44806304vsp.48.1609808352096;
 Mon, 04 Jan 2021 16:59:12 -0800 (PST)
MIME-Version: 1.0
References: <20210105001119.2129559-1-drinkcat@chromium.org>
 <20210105081111.v6.3.I3af068abe30c9c85cabc4486385c52e56527a509@changeid> <20210105003430.GA5061@kevin>
In-Reply-To: <20210105003430.GA5061@kevin>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 5 Jan 2021 08:59:01 +0800
Message-ID: <CANMq1KCjucCWW+FE=JEegw_OmPPuEFRXPBLTmjrc-k7cpBrASQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] drm/panfrost: devfreq: Disable devfreq when
 num_supplies > 1
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, hoegsberg@chromium.org,
        Fei Shao <fshao@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 8:34 AM Alyssa Rosenzweig
<alyssa.rosenzweig@collabora.com> wrote:
>
> > GPUs with more than a single regulator (e.g. G-57 on MT8183) will
>
> G72

Duh, sorry, yes. I will fix that in v7.
