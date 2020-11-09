Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362AB2AC4C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgKITS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgKITS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:18:56 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28210C0613D4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 11:18:56 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y16so5718094ljh.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 11:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bu0ThKEY7iNNAWO1Gs5nfun8XEbY1iHpVPn66H13xho=;
        b=MXu1FiX/P8KsnLg7KwJk3Dr/HoYUiRRYwLCjf1j8Ckk0cbMDjVN32AAjT2KTOKu/1C
         ZsjaDNl2c19oeNtpL5x5MKJpucyMROnOwR9d0EjWq+xjdsWxzl6pyZdjQnZHMP0+6tRz
         eSfz9fClJxrmCocEbBKr62POOEUtZPpu7Jl8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bu0ThKEY7iNNAWO1Gs5nfun8XEbY1iHpVPn66H13xho=;
        b=VvwVQA4lJm3dBx5VuAxVXITv7D7nMQwm1abDV34uIVEaSL0R/rm7qeVXxj0i8YkRZ8
         8hZ0Mt2nqIfvp4USwvjC9ZmOmRJ7yMQFKrRqMI7Zs13/oPqlqCBprylftmgt+6UM8iCc
         HUU2qVx6s7ZWULiSuS5ZfHbDhDOhOxZ6kRcXuquUs5AoBiRbjJsK56SvrV7eefBjYFSf
         UPmtUVnUjlYjjQ4VqlAC4P+a5vmybB/utqYO1tC/BcsklhMa7gUnH59wgc0zk6IQ/R82
         zjafpve9tJTHd71lhegxRZz6W8ys+NWJk6KLy7KiNRWRMx7e89R9ccoBTuY6G80uWfLE
         Ik5w==
X-Gm-Message-State: AOAM5339OQwm4qCHXeiiddVC+ouxNsSKTuvCqjD3/v3ZuFfIwUc5LpBq
        zLK6oOi0/oiETszqAsbrcA2whC7vzKrDYg==
X-Google-Smtp-Source: ABdhPJyaRm7VJX+bNBi/nDJMxoezL2qRZ+jT4yGtoNNTYnq31zsP4+WfuLBumX0FhzvU02FBpDFDQQ==
X-Received: by 2002:a2e:9f08:: with SMTP id u8mr249592ljk.352.1604949533463;
        Mon, 09 Nov 2020 11:18:53 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id x18sm1857344lfc.73.2020.11.09.11.18.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:18:53 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 23so11753417ljv.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 11:18:52 -0800 (PST)
X-Received: by 2002:a05:651c:1074:: with SMTP id y20mr4049301ljm.432.1604949531557;
 Mon, 09 Nov 2020 11:18:51 -0800 (PST)
MIME-Version: 1.0
References: <1602786476-27833-1-git-send-email-sibis@codeaurora.org> <CAE=gft4FrAm_QHKm_dF6G0R8fkfJrYFYPMrRu0nPNrQtZ83skw@mail.gmail.com>
In-Reply-To: <CAE=gft4FrAm_QHKm_dF6G0R8fkfJrYFYPMrRu0nPNrQtZ83skw@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 9 Nov 2020 11:18:14 -0800
X-Gmail-Original-Message-ID: <CAE=gft6JKpbcirFn9LAiDYFnM=HMfDQAYfQHAFy6NF+8J4Dmkg@mail.gmail.com>
Message-ID: <CAE=gft6JKpbcirFn9LAiDYFnM=HMfDQAYfQHAFy6NF+8J4Dmkg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Fixup modem memory region
To:     Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 11:37 AM Evan Green <evgreen@chromium.org> wrote:
>
> On Thu, Oct 15, 2020 at 11:28 AM Sibi Sankar <sibis@codeaurora.org> wrote:
> >
> > The modem firmware memory requirements vary between 32M/140M on
> > no-lte/lte skus respectively, so fixup the modem memory region
> > to reflect the requirements.
> >
> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>
> Reviewed-by: Evan Green <evgreen@chromium.org>

Did this land anywhere?
