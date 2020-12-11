Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826D72D7030
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 07:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395502AbgLKG2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 01:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395494AbgLKG21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 01:28:27 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4101EC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 22:27:47 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id b5so317277pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 22:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NZCqNrXpIQOHB+clR8WgE5i45yw+bOFU7a6qyf9U0g=;
        b=Yj8ERgL7ftmm8JcEBoewVHYgPQQHMrBW7T9cqPbsOUJqWlStcwMOoWjOCDBpo/gH2b
         MNnMTibwIfcFnNGUH1IT66nG6hveH887dJ43icRzCcrqSHs+fmX2ORvCQcdaJWzVCNlM
         yOleujohBJZUz/3XayBixb1wwaOeMS3xu7ZaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NZCqNrXpIQOHB+clR8WgE5i45yw+bOFU7a6qyf9U0g=;
        b=S1vPzKFt1Vk7APnaGxj9pSZ4p2IoEMf63TOvUO2JXam4mA75k9ysXh+Vq77i/ZMhU+
         eD+wsr7DRJqJxDLyR7TAThuD2OQlEoe+ExxSzJEwDF079lsEbDIegiwzv9w4f+rpNtRc
         Lqi8rV7TGgA2rRBHlAklm3muOgMeP/hdHj2J7DrG7476lbl/2WvlRfmqj09Ph/mnfg7j
         Z/5yekR39XnQgBHVUxwkCxhBvWEfbYBq9U+s/hcRf26Y70UtHxKP6z+kjgxCiuP6pMCv
         BcVxF4lztcdcYIipEr9GlfHHumRy7Qvdelj+qjFlYk8yhRvqNDA27VVxHFoqayxFS9Qe
         vpgg==
X-Gm-Message-State: AOAM5336oCf8gSLb/W9oc5s7bl57mTI4Biwcwm1h2Mh7AFGz2YfS2uH+
        HuAc1J5VlbCPDYgprNBo172fkjCIWh3Q6LJfSS3jfg==
X-Google-Smtp-Source: ABdhPJw9a6EUufsiEyEhuZXX3ZGfuxO+oyyeGpF2rgFDPWlkOqpOTbp+QOOQKOzUTUbZHQMB5Q518KWuPZaf2zD/J8o=
X-Received: by 2002:a17:902:a502:b029:da:f580:bc35 with SMTP id
 s2-20020a170902a502b02900daf580bc35mr9802625plq.60.1607668066723; Thu, 10 Dec
 2020 22:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20201210104747.3416781-1-ikjn@chromium.org> <20201210184700.v2.3.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
 <X9H/ZVpHf2Owd6rj@kroah.com>
In-Reply-To: <X9H/ZVpHf2Owd6rj@kroah.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 11 Dec 2020 14:27:35 +0800
Message-ID: <CAATdQgCZjzoiiReoL-0X5VgWXcEzPsg5B_=SBFFD7dp1Gmvgog@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] usb: xhci-mtk: fix unreleased bandwidth data
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-usb@vger.kernel.org,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
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

On Thu, Dec 10, 2020 at 6:57 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 10, 2020 at 06:47:47PM +0800, Ikjoon Jang wrote:
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
> > Fixes: 0cbd4b34cda9 ("xhci: mediatek: support MTK xHCI host controller")
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
>
> Shouldn't this be the first patch in the series?  You don't want a fix
> to be dependent on code style changes, otherwise it is really really
> hard to backport it to older kernels that might need this fix, right?

yes, you're right.

This patchset also requires
"4b0f7a77fb3c usb: xhci-mtk: supports bandwidth scheduling with multi-TT",
which doesn't have a Fixes tag.

I think I can change Fixes to point to that commit (4b0f7a77fb3c),
as this unreleased bandwidth data is much more impactful to
TT bandwidth.

Thanks!

>
> Can you re-order these patches please?
>
> thanks,
>
> greg k-h
