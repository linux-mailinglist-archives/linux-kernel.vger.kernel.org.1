Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E781E3946
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 08:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgE0GbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 02:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbgE0GbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:31:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37180C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:31:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k2so73755pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=GAeIH2kkVlgfDKNDvExkjEUjr7t+dLIV143r/wZ4ZCs=;
        b=mgStlcTQb+C7oOeBQLtpopl4rDpEglFL8WNYy4ZKxaew9vLvMRyQeiWwvv4K6diVMw
         RmJUO9lnsqfQiXz3gPyvtp11yp6ZgilsacHzxopa/QpbhHUWQ54qx+inj9qISvcrMqxl
         wQCfE4E5kBgBRyzkVnnyXcZ+QUuerB0c1M7WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=GAeIH2kkVlgfDKNDvExkjEUjr7t+dLIV143r/wZ4ZCs=;
        b=ma5dMu4wQ4bNfmoS9ppoE6kVL8WPYwjq9ALfK0by1Ilr7gCfnffRTCP54M9XTTs3Fa
         4/QOLPNtcccRahSZx/VBGQ/qijWJMRZGYXKmfC5/kpxVr1yPzO2N5tQ+hokL1GFtpPI8
         M7tP5Dfq/NchK//GfCwwlee1cRFJtTnYNnuKLViD8ILNQQeQmFqNBlNWvtJOANnH/bSJ
         O7CzeiAS969ehTMKATM135Fv1kpgegB9YQJQaOTkHwOEQ/+hsLcqUwe4Hjvm2Yr+J9Gj
         ESSDqDE56C0zRflbg7712qU/zBVxHQv09JAPSgA+t+KKIl7r1C6vrJKYoSHeydoSXh0b
         g91A==
X-Gm-Message-State: AOAM532u3SnGmXEXNkpLJ1atipOuueeqOA26gVtB/ixb9naMQ5VNDIZd
        nKMuLs9Gvcj6yOSIJv2MbBrOMQ==
X-Google-Smtp-Source: ABdhPJworKi8wu5+vZmXaxlggXWpRcMSuQ5Qj06+Hg0Li/MDDPoRyyIhDaY2PmECBWrcKK3Cd2MvYQ==
X-Received: by 2002:a17:90a:23e7:: with SMTP id g94mr3424943pje.210.1590561070701;
        Tue, 26 May 2020 23:31:10 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a7sm1193700pfa.187.2020.05.26.23.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 23:31:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200527054850.2067032-4-bjorn.andersson@linaro.org>
References: <20200527054850.2067032-1-bjorn.andersson@linaro.org> <20200527054850.2067032-4-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v6 3/5] remoteproc: qcom: Update PIL relocation info on load
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Date:   Tue, 26 May 2020 23:31:09 -0700
Message-ID: <159056106910.88029.925874171202462275@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-05-26 22:48:47)
> Update the PIL relocation information in IMEM with information about
> where the firmware for various remoteprocs are loaded.
>=20
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
