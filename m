Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C67A2EF0E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbhAHKvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbhAHKvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:51:21 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E5AC0612F5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 02:50:41 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i5so7459406pgo.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 02:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUYexvGQkq4ls/OimwsO5Jd0RZqGFOW3s7MoFq9zFTo=;
        b=YJkyuQWXhbFLgxwObjUfAmF83zKljdj7aMi/D0QeB/d+QLVbsGCvwyase5VS/GWSpg
         Es1unRr4cp3Fvy24ZBffOLz0Lfh11nBkmofiM2flPrgjewamfaSpMXKulclYD2Pltylo
         jrH2DnIwA96hZC5n+910xx3mFFG4aCgPnl1+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUYexvGQkq4ls/OimwsO5Jd0RZqGFOW3s7MoFq9zFTo=;
        b=ac8o1aZlTK+zWGmvYo4Il22CCPsJ6GPnYBWnP8DF5TFpU3gW9Hn68hHihWziNsjA0R
         ranzAOdB33dX1dnGLHCrK4Mc17qyd+9h9Fpo40B+1tkdlO0eP8eJz51MyZVzSfGgkh+d
         Yi/QXabcapcb/ElfOxp+ztCilFelFg6ni55hSgCaqp/q/r87FSWSl/djIrofXqnSLh9B
         czRN4FWLmP0LOIfNa14Pu3vjVEZzazXzN8O+dsd7RsYV8TAx4cO+vSx8lS6+9HDkA8lH
         7sCxMbtF5Dk4Cz86MM0unFMoFxBtMFfrZPVHTNogigNsPKUA72QlwVzAue2dhvgy94Px
         qhiw==
X-Gm-Message-State: AOAM533CEmwHYjAIK9vPeNRRN1FQsaGuce9L7QPtbf44pcemr+yOMLca
        xV5JRXu7hi6GT/TUG+9BFlIO3A4zCJqnpFcUh4GorA==
X-Google-Smtp-Source: ABdhPJznWhv1cTUN3HY6O/t1DpDD7sg3cxH33OEwBKtFZhXYshd0vUiYpemVN8VSwVvSOQqG6eW9FQ92uaiCom4uJ+4=
X-Received: by 2002:aa7:8813:0:b029:19d:cd3b:6f89 with SMTP id
 c19-20020aa788130000b029019dcd3b6f89mr3048408pfo.42.1610103039797; Fri, 08
 Jan 2021 02:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20201229142406.v5.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
 <1610087648.24856.41.camel@mhfsdcap03>
In-Reply-To: <1610087648.24856.41.camel@mhfsdcap03>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 8 Jan 2021 18:50:29 +0800
Message-ID: <CAATdQgAfRTxbzG4tJ-ftX7M6wrYFR6v+ji+-nSk_dTRTMXzXwQ@mail.gmail.com>
Subject: Re: [PATCH v5] usb: xhci-mtk: fix unreleased bandwidth data
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-usb@vger.kernel.org,
        Tianping Fang <tianping.fang@mediatek.com>,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 2:34 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> On Tue, 2020-12-29 at 14:24 +0800, Ikjoon Jang wrote:
> > xhci-mtk has hooks on add_endpoint() and drop_endpoint() from xhci
> > to handle its own sw bandwidth managements and stores bandwidth data
> > into internal table every time add_endpoint() is called,
> > so when bandwidth allocation fails at one endpoint, all earlier
> > allocation from the same interface could still remain at the table.
> If failed to add an endpoint, will cause failure of its interface
> config, then the other endpoints in the same interface will be dropped
> later? you mean some endpoints in an interface may fail but without
> affecting its function?

Yes, drop_endpoint() is called for a failed interface when set_interface()
fails to switch alt settings, but set_configuration() does not call
drop_endpoint().
TT data seems to remain allocated until a device gets removed.

>
> >
> > This patch adds two more hooks from check_bandwidth() and
> > reset_bandwidth(), and make mtk-xhci to releases all failed endpoints
> > from reset_bandwidth().
> >
> > Fixes: 08e469de87a2 ("usb: xhci-mtk: supports bandwidth scheduling with multi-TT")
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
>
