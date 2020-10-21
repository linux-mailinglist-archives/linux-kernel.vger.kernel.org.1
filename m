Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0D2295110
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503146AbgJUQqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404882AbgJUQqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:46:15 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732B4C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:46:13 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dn5so3222420edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NUOfNpYzEL3LD+5zJArE8vgQr+8xwXTLaDNDtvbDwA=;
        b=Wfq8T3EqHqQ8lWbnZHAcop1pwmrgYSGiQ8y+QBQzhgJvWkUVddeQVTARpQt+C6qHMN
         5CtfwdzNoX4TezJ3KM0QNKJZr+VQgbetsV+XnfEDlSw+QeXvGl4lOITQBjJU6WSH+LhM
         qFASZk18S1La+NfdRIrQ+wzrhK1Zy71XWZbv7KDb5bi9sHqiD97UjlSsB5wixNS/qxhj
         B/IEMSp8o5UuBuKJQl/P2Myf4dtM2v9NQXi81OwJsba/BaHV6mbraD5k8uev40GziwWb
         u/S6IxYevQLa41WHjF5FwPMjMZkg5le/zLXkRWoEHoHxeIIJntihdeN6k1sDu6ndFV1H
         /nLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NUOfNpYzEL3LD+5zJArE8vgQr+8xwXTLaDNDtvbDwA=;
        b=KPV71UZV1zP45H48gwhVw6XXpyiZVqUPfp+OEFnr7U7yA795dLVlxDXjQAB82luFmd
         MJupGRC2QGrFDcsNXGGvkdn6Mk+Qw1TLQXJ71i2KEqxnYe4HKQStVJ3IJOYr/vJoBqCj
         0ZkxbORVlFNi9yPjPUgZ28m8eONcv9+x5wWmm/4DFZcq2vlircM0kmE8zB8UsI8h7ffJ
         Cn32zGuLLlIG1e0Tc0S9nvHJ5JkDPicgRGejIjBbwiBLL+K/YEj63TwIqxeKcvdGI9Xo
         JnUZ+7XTgBl77fT8z0uvCyyAKXmkUYw5hFbmjIBk1SbLPEmeJz2iBlHW3jNWE84D93A7
         3kxg==
X-Gm-Message-State: AOAM533YfueIdmp7lm3wqbc5ZGKx5YkCdWciy8pmAl+8DCqNf4NP+ewU
        tCAvTeiVRNgYaIET+UAA1XGySLzZFVFUyJvj1wjxhA==
X-Google-Smtp-Source: ABdhPJxFG7eP6jPrXMEObBNGYCEE//beJ2SGdl4GivAzZsysEUsSAlvo+98dcFhiemFVn4SHy/ry0C68roOSK/sZv+Q=
X-Received: by 2002:a05:6402:1158:: with SMTP id g24mr3799631edw.323.1603298771874;
 Wed, 21 Oct 2020 09:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <1602907457-13680-1-git-send-email-hemantk@codeaurora.org>
 <1602907457-13680-2-git-send-email-hemantk@codeaurora.org>
 <20201021152714.GD3334@Mani-XPS-13-9360> <CAMZdPi8xcsrKx2eV5da98fsGt2zO3f6ARMz7WJsyDSb3CnM0FA@mail.gmail.com>
 <20201021162540.GG3334@Mani-XPS-13-9360>
In-Reply-To: <20201021162540.GG3334@Mani-XPS-13-9360>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 21 Oct 2020 18:51:36 +0200
Message-ID: <CAMZdPi-SY-r2H7RBLKoNk9yfu5umrrwYMr0ckJoxSx-iqYXdQg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] bus: mhi: core: Add helper API to return number of
 free TREs
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Hemant Kumar <hemantk@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 at 18:25, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Oct 21, 2020 at 05:43:14PM +0200, Loic Poulain wrote:
> > On Wed, 21 Oct 2020 at 17:27, Manivannan Sadhasivam <
> > manivannan.sadhasivam@linaro.org> wrote:
> >
> > > On Fri, Oct 16, 2020 at 09:04:14PM -0700, Hemant Kumar wrote:
> > > > Introduce mhi_get_free_desc_count() API to return number
> > >
> >
> > Would it not be a good idea to have naming aligned with other methods?
> > Like mhi_queue_num_free() or mhi_queue_no_free_elem...
> >
>
> 'queue_num_free' doesn't sound like getting the number of available
> descriptors...

Right, TBH, just wanted the function to start with mhi_queue since
it's about getting info about remaining size of the DL or UL 'virtual
queue'. But AFAIU, this is the number of available ring elements that
is returned here, not the number of transfer descriptors (that can be
composed of one or more ring elements), so maybe
mhi_queue_num_free_elements or something similar, I don't want to be
picky here.

Regards,
Loic
