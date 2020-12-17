Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0DE2DD2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgLQOWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgLQOWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:22:37 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B876C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 06:21:56 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 23so57756192lfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 06:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fEsDcXj7kC0e9QLMNZJRwfmrhQOpyffdTx2CokzQK+k=;
        b=riCzgX1IMRf2nv/TCtl+S/ZuEImnBSmdHagRA2iR74qGVwX1jubwWafisAtkUhzJj3
         ENOvThhHTo4nW3yj3tbG029Llth4Hh5JAp2slI94u4dQk524gEYVrOkD4+bpTmqiyuBt
         kYBek6VlF6V+Oo1NxpygfEdo4i1DpvjcIx3W+OCwOfID1kPt3GN9SDRITJ+s3HnGr+x6
         H5NU1L+sefw/qMFIecLB/5xzHN1G0wTL+KU7n6YxjjtY/cq1BIg/440bWC9A4sszE0Mv
         oYTPL5Vxh35Q2Z8IQ4Diib5LqWkZyvwFtC6lo5VdkDmJ77tqNL128QMhOM90akJGR3fm
         GffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEsDcXj7kC0e9QLMNZJRwfmrhQOpyffdTx2CokzQK+k=;
        b=ayoBeEvf35pWoFJ2ZvCIk2BgaYwjtkjyWM9sCRL+VO3/cGIXv1MK2g2Sls3m1D6qVi
         1uaQ6NS+TvbSEhsmsMOJrcNdBDaLKUVpQjhaY5As3gR3WvltYsSEemR2AR4bcCg8+OGz
         xEbqdkSTwpj91YstBcZhd/mrVtaDhaZ/y/Np14QI2NDWXYXddppWF0LXtPMGl/RcfXrB
         IvaIQDW0dmCXMYF7iS3qiM/ZwYsxkpeOLOnXDh9wtdE0KzGYuW6PHxsW6lJmI+QZ2HSk
         Cu7vdIO3ZnFo6HXDpg4LYPMptdJZXj9rrmthc/vh9ReFIVxY9rYGa5F9RC0hrzkRjfdl
         PwiA==
X-Gm-Message-State: AOAM532oSCBuL8dc9rwlfcTibvrMB1KVuOTcjDRdahztXglxdsOYOTsk
        jBWNNGbF0vhVsBaNRj21OLp8LFQ/0HPpMBOqxQfLJQ==
X-Google-Smtp-Source: ABdhPJyUDc+putV0OYw316T4PZsBgszWBOXNkJyofvl7KyfCUKfxWMXfSayYicYYw8zqZ8CH4DI6NBB5PmTmdGVCoDI=
X-Received: by 2002:a19:495d:: with SMTP id l29mr10494795lfj.465.1608214915009;
 Thu, 17 Dec 2020 06:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20201217083420.411569-1-lee.jones@linaro.org>
In-Reply-To: <20201217083420.411569-1-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Dec 2020 15:21:44 +0100
Message-ID: <CACRpkdbogmGxvs_VsFoB8rbq8-51s2rQWGHwTStBzozmSShT3A@mail.gmail.com>
Subject: Re: [PATCH 1/1] mfd: Standardise MFD_CELL_* helper names
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 9:34 AM Lee Jones <lee.jones@linaro.org> wrote:

> Start all helpers with "MFD_CELL_".
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Gene Chen <gene_chen@richtek.com>
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
