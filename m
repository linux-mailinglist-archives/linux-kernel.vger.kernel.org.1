Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9052E6E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 07:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgL2G2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 01:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgL2G2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 01:28:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991D8C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 22:27:21 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id l23so1014141pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 22:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GgdE70V3wvBcQA9RrpEicG3Yu8LjbkyE0wwy+vna/fc=;
        b=Hy1pUncbifpEXVsZ1rsp7zn/GHtS/pfJxMXLP7gCdNqoS60q+g86Q+kirTATC7Hpu5
         74SRiPMwZYMyG2XLA7t6/dFFbP6mJslDrTM3Sl29r8GPdFbYyAQT4nvNid7acab/2/oc
         /OaeMPAHeYduzH616k6Piw74wCmANekupEIY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GgdE70V3wvBcQA9RrpEicG3Yu8LjbkyE0wwy+vna/fc=;
        b=q5Y6h9TMyCRaxGFsfoxivFNaPG7O7xSKaFAShJXjqGYt0fPHMRseKbBGuSG6c4YChX
         ighzTx+anASh8EpixD9b1or2CQuZm88m2vtmh8rTm9Ot8EEWi1Ykdf5iw6kNz0SzVLk4
         hRW+8ISTArGbmjDUKP1sDDDHim/DH/opqRk/mkUQ5tCBdnIDGLBZmlPnDAUkzABxzWG4
         b99hQqVCyojWR67hF6IR8E9jxLQU13rVODjolmCSFzm5qVgxsc0hI4g+yu/nHTK4tay8
         Y2vHRnapLZPOOmUCgpgTusUteXzXHZ58pckTQctek3X4OmR60BUxGfW9z++Hht889ar/
         gYvQ==
X-Gm-Message-State: AOAM531RxwAL4sn0KD9Jichw5eV+45i+vmmyaygqzC0TwEgyycKN/kGP
        GF1JxmH7jwWRXgdLnV3uE/yiMh428ujvEd37xpeSnA==
X-Google-Smtp-Source: ABdhPJy0ZjRbXZDk7+wJsqBfIMAP2iVJqXvigcqHG4DG+JiHMg1BQBc5Tv77Mxs3mV3iqOK48E46qGkeIllmeRqI7kE=
X-Received: by 2002:a17:90b:1c10:: with SMTP id oc16mr2628210pjb.144.1609223241122;
 Mon, 28 Dec 2020 22:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20201214131640.v3.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
 <20201214163945.v4.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid> <X+nr65vhINCw8fCL@kroah.com>
In-Reply-To: <X+nr65vhINCw8fCL@kroah.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 29 Dec 2020 14:27:10 +0800
Message-ID: <CAATdQgAv_M6-xf1XhQoEnyAwMuXTo-GZ6xog4X1Qu4MtBnncTA@mail.gmail.com>
Subject: Re: [PATCH v4] usb: xhci-mtk: fix unreleased bandwidth data
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-usb@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 10:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 14, 2020 at 04:39:53PM +0800, Ikjoon Jang wrote:
> > xhci-mtk has hooks on add_endpoint() and drop_endpoint() from xhci
> > to handle its own sw bandwidth managements and stores bandwidth data
> > into internal table every time add_endpoint() is called,
> > so when bandwidth allocation fails at one endpoint, all earlier
> > allocation from the same interface could still remain at the table.
> >
> > This patch adds two more hooks from check_bandwidth() and
> > reset_bandwidth(), and make mtk-xhci to releases all failed endpoints
> > from reset_bandwidth().
> >
> > Fixes: 4b0f7a77fb3c ("usb: xhci-mtk: supports bandwidth scheduling with multi-TT")
>
> This is not a git commit id that is in Linus's tree :(
>

Oops, I apologize, I sent a new v5 patch with
Fixes: 08e469de87a2 ("usb: xhci-mtk: supports bandwidth scheduling
with multi-TT")
