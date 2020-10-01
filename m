Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CB12803EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbgJAQ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbgJAQ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:27:55 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57215C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 09:27:55 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y11so7327027lfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0r8aBl5mTGl1Jm27+LKfiN2IGzGh3O0PaISk78rFv6k=;
        b=fp0kVPOJ0/feOwgGLmlkIO63ANEzecXNYInyD9Jr0DYTITv/iXns8CEsaFmNqkjM6X
         o+oB06moAa1RZND3ZKEyMHaCsuepB79QtGlWVrbxsSmqhB94N+wioNtg35bORV0WkKXn
         l41qR2diYCU9YMVWLqQwcfCZk/Qx0XQGIYrzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0r8aBl5mTGl1Jm27+LKfiN2IGzGh3O0PaISk78rFv6k=;
        b=PfdbdnLvc66oA3sr8UXVaSNlC6/fkyiCfj+JCAjdrkxF9By4R8yLIe1V7/w5tl4SF0
         KlAfPKDgYrkqPJChSL7oz+IK4QorPdQLvYneTNNxt3ME1JcUTi2H/i1L2zfrPaSySi4U
         ZMIFlBJoZ0MVXkpTtyzzrT8G9lAvDVXBfT41eoNPPYf2UVF/7Tz5PLPNUup5KeMvP0Lv
         6iF0Kr3tZ9nBnVCaas9huKgLLJ1uQ2bG+9NaYmId0Z1sJF0MjsaRX80oEe15RegWVgPV
         XMoMU0C+lu87PC/xi6sebrBZxR2Pknj3KejqIynxkGGAHwac06ndswofnXbY72VlxfVC
         PBgw==
X-Gm-Message-State: AOAM5303DZxKfs5KR1tBPLXmVyw41KIKr/KSHA/u2zQdxQlr9T80s4RV
        9LljKyFHeExLZOFxiTyrByOrdDlReQe49g==
X-Google-Smtp-Source: ABdhPJy/Y1yizkWy8BGzS5xNSMLftRjQiCX7b43pPDkLlrtKKJ3neSdI3Ol1wFkA9UHz6Ym8EUiBag==
X-Received: by 2002:a19:103:: with SMTP id 3mr2690911lfb.452.1601569673462;
        Thu, 01 Oct 2020 09:27:53 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id p27sm608536lfo.272.2020.10.01.09.27.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 09:27:52 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id y2so7311571lfy.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 09:27:52 -0700 (PDT)
X-Received: by 2002:a19:7fcb:: with SMTP id a194mr2732860lfd.121.1601569671966;
 Thu, 01 Oct 2020 09:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200929205807.2360405-1-evgreen@chromium.org>
 <20200929135741.3.I1bb1b0e94be3b792804e08831d6a55481e162d63@changeid> <8f467220-3ac8-c8fc-33fe-8d86904571fe@linaro.org>
In-Reply-To: <8f467220-3ac8-c8fc-33fe-8d86904571fe@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 1 Oct 2020 09:27:15 -0700
X-Gmail-Original-Message-ID: <CAE=gft5FoWpscS_9CfuCNSZxsq_CUu_AShQ=tLiW=NGL8YG5tQ@mail.gmail.com>
Message-ID: <CAE=gft5FoWpscS_9CfuCNSZxsq_CUu_AShQ=tLiW=NGL8YG5tQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvmem: qfprom: Don't touch certain fuses
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 7:17 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Hi Evan,
>
> On 29/09/2020 21:58, Evan Green wrote:
> > Some fuse ranges are protected by the XPU such that the AP cannot
> > access them. Attempting to do so causes an SError. Use the newly
> > introduced per-soc compatible string to attach the set of regions
> > we should not access. Then tiptoe around those regions.
> >
>
> This is a generic feature that can be used by any nvmem provider, can
> you move this logic to nvmem core instead of having it in qfprom!

Sure! I'd prefer to keep this data in the driver for now rather than
trying to define DT bindings for the keepout zones. So then I'll pass
in my keepout array via struct nvmem_config at registration time, and
then the core can handle the keepout logic instead of qfprom.c.

-Evan
