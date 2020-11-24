Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB462C2028
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbgKXIiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbgKXIh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:37:59 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606E1C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:37:59 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id s9so21010107ljo.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2H8XWRLs/cbmJeRBTAh4/48CwYXMne1DsJ3h7TEz2GM=;
        b=j82cKN347mqaeqLKt04crgSBJJhiSMO8zoQY1YHiSWBV5gT/+AAOjpGTyfh+o9Q3mc
         KHFXiUvWy4L8mloe3qazA7AGbiCOUmr9MI79Q8Qorm6PeTTm7W3gZgRNltxjOQjEyIaV
         4yfbQpXwQYNq0j0PqKL1VReBP4VB7paculjpmhWTKHB/ToDqwDyfAMXNgYE7uGXZilfe
         kMDoIaflhclMeVnN++SvYryLZ1aI9eBBg2U4nzuo2aMqgT4KwU/L0BiEvKj/Gh4JQwfY
         hrsNjQFpooCvU9CbZVDQUeFqZLbna0MQ08epM/Lx2YIiHqjlHEYsRgzvYxyfT11OnGue
         MOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2H8XWRLs/cbmJeRBTAh4/48CwYXMne1DsJ3h7TEz2GM=;
        b=ZRn+cCJSJcoAyITGXiwMZ3DFLNJhIXagNuBD64rj5z9ha/iQOg5GBDiS5ErUV0ZWqU
         TfG/vTe7gqs0Ss1theUo1Npd4mQwRQEsnwCEdXCMXvdm/MWstCNXMKlGQVEAPPgFgz/e
         RsVlsUB5RpqdyNKxUGmVSIdKHqceSCwqmKldipQzcGqxb2G+5fnWpblfgwsb6jrVpdjW
         8tev9qsWUo5HTXHOaJs6zsMJg9Nn76DYseSI4BJeA99ot2ZfIp7q7LK9XIN6/T7rRGkQ
         S8cexeSI2yKGFa5OgfV0/oQkCIgFE0f/+rrNSoflgK7XMgHT4P9snfZpOrLQ7v8pu/k7
         t1Pg==
X-Gm-Message-State: AOAM533Af4mYnFc0ax1J0+4SUBeYEgOeBdA8b0o55ZpjA8vsJKQtibdT
        EE+565v9xFs6iebT21tOTUiUITPJSZ18+Bi22W1IfA==
X-Google-Smtp-Source: ABdhPJxGrELU+sr+1kgkl/qdZ/XZwXL4XRm5dMDFIKZ0RZe+Cq1K9uCu5AlgW+v6i3cT7KOpEXWCGVfu8zUwNKOSIdo=
X-Received: by 2002:a2e:93cd:: with SMTP id p13mr1323677ljh.144.1606207077648;
 Tue, 24 Nov 2020 00:37:57 -0800 (PST)
MIME-Version: 1.0
References: <1604570192-15057-1-git-send-email-rnayak@codeaurora.org>
In-Reply-To: <1604570192-15057-1-git-send-email-rnayak@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Nov 2020 09:37:46 +0100
Message-ID: <CACRpkdYcdrC+xbaoZ6dEePtRcD3hqAdotQq=jddOC8=OMa6EFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add sc7280 pinctrl bindings
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 10:56 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:

> Add device tree binding Documentation details for Qualcomm SC7280
> TLMM block.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v2: Consolidated functions under phase_flag and qdss

Patch applied.

Yours,
Linus Walleij
