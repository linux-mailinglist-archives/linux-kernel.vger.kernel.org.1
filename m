Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D8F2AE782
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 05:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgKKEj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 23:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgKKEj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 23:39:27 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54609C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 20:39:27 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id t143so742090oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 20:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s6myL+PM0HBWENmEOtU+P5/sAUeBj/Q2iWwgqjm+B7I=;
        b=lEX6/jY0xOENWR8XChawMbi01FunU4ScwtVNApkwyop1v3KhL8wA4mYAnAcknZRbKB
         6Csg0/xYmEvTliVPP1Coi9RdOilmoP2UWcv1ZuCejAlv/d67NzgfBzCycU4+5VAmJiXZ
         RwcsAVytUNQiY+pWaucV4e/pKA3wArGA2enXUmo/4f0k0AiqlFuy6EGuQ277lHGqRI42
         jQclJ1mM3Po0mOvrkcLtcTxGJUOAFiTM5ogpUKvyMILA7LR/XQlyroAkboJNIxiuKYbT
         IyMsIV0JRwojstdu2XUkjYhSmtl52cVuxTiPeu1v4Y7IfBWbzXbtxPlefmLhY4FqeqKI
         7dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s6myL+PM0HBWENmEOtU+P5/sAUeBj/Q2iWwgqjm+B7I=;
        b=qlD+EInMFipZ6ClRdSKGW/A6EBQmuHuV6EGj9y6jyYwT4Uv8nZVATPgZcr5/GdjpWs
         m+FokWdh/EwaKsteDyZjkgG99WFUtSxA17Il5MmYQo7+aWwLJMGAquNA4bfGJU9UxsU6
         maf+J4kCBlh57e7eNuZiBM4tsKXCSGbtmPRXLKSb31VxbCiD4P/FLgy7NoruubD5kIiW
         4pbeuy4779rDEaOihiGnfRmFFoIUp3pmXcxVz1jLJuJNypcl7WTUwFxRTF/ecL43EDnf
         4fU9QJPkWZ9PZi21ZmWuRw8DUOkh6aS0pJNEaUypP2xIVUyqbh5crpyE7ypm3R311nxb
         U4+A==
X-Gm-Message-State: AOAM532ocg8bm2V6s1+dD44ZyFAY0AisGePOdhVvO33NAIxvGekFEFyi
        w+LdhJ+bnETzgKsEz4rclm/PVw==
X-Google-Smtp-Source: ABdhPJxYdgkoOVSNdyPBmsCsuSKojJuBLc1401L/S5J5r+m8oX5GotrgrsmuepO3h0a+Clw+Ngzkgg==
X-Received: by 2002:aca:cf0c:: with SMTP id f12mr1042745oig.139.1605069566633;
        Tue, 10 Nov 2020 20:39:26 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u4sm213780oib.0.2020.11.10.20.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 20:39:25 -0800 (PST)
Date:   Tue, 10 Nov 2020 22:39:23 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Fixup modem memory
 region
Message-ID: <20201111043923.GC173948@builder.lan>
References: <1602786476-27833-1-git-send-email-sibis@codeaurora.org>
 <CAE=gft4FrAm_QHKm_dF6G0R8fkfJrYFYPMrRu0nPNrQtZ83skw@mail.gmail.com>
 <CAE=gft6JKpbcirFn9LAiDYFnM=HMfDQAYfQHAFy6NF+8J4Dmkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft6JKpbcirFn9LAiDYFnM=HMfDQAYfQHAFy6NF+8J4Dmkg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Nov 13:18 CST 2020, Evan Green wrote:

> On Tue, Oct 20, 2020 at 11:37 AM Evan Green <evgreen@chromium.org> wrote:
> >
> > On Thu, Oct 15, 2020 at 11:28 AM Sibi Sankar <sibis@codeaurora.org> wrote:
> > >
> > > The modem firmware memory requirements vary between 32M/140M on
> > > no-lte/lte skus respectively, so fixup the modem memory region
> > > to reflect the requirements.
> > >
> > > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> >
> > Reviewed-by: Evan Green <evgreen@chromium.org>
> 
> Did this land anywhere?

Doesn't look like it, so I've picked it now. Thanks for the bump.

Regards,
Bjorn
