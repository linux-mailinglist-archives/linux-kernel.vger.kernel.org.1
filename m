Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDD727F6F4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 03:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgJABGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 21:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbgJABGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 21:06:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79E2C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:06:00 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so2520416pgf.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 18:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=zL8xjJsBADSVoFlPgbDkouIEkvt2AYMvyMdtXFtG7H0=;
        b=NekKWeDWpuTY8U9ohdARon+7nvpPaHnrKRcwi+C6KMdA92wc1YUP8+9/KpJU/80/L5
         11cFT+pJ2QVtraJ5wqgLJqH5km1fF8BVLQvSyDi43Vr5/xBik+CieplcYZPu4UVAXSkH
         r6V7i5Tu9IUs49Ki0zFsQM/cRcJxUtVsdnobA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=zL8xjJsBADSVoFlPgbDkouIEkvt2AYMvyMdtXFtG7H0=;
        b=fNKdYTGlFSw/7QWCIYClFeDgrYNFYSwp17pZ4AdCU6jaUgZLN5xW4cGhQHvoPCvLNV
         pORoPzAQVSPGAdd6hPLbGLwtSV/5Pd7PqJStlhQSfNl2d7RQaG7JRFF6I348YhxxEiWM
         JRTn69C0eEnvPJ1TVTXYJXqMCFVDHdH1VPJReKCOiiSAL9kdl4jWxotlE6RKKlkvGJ35
         GrS5sZLuDHJweOrXwb5DGIY55fow62BR73OJ5SjdMidQA3ohxoXk/BOxnDGCEoLhW+UC
         qE+P2+ONnZibS6sDmC8/3G61lTRvHw2P5rIEt+VENweAgU/M28lzyTzGyjKH/r0Bvb9l
         WRlw==
X-Gm-Message-State: AOAM533YgSW9Z9Hv8BDt6+dVKWc49hxLFoTMRJo+f6Zt8k3qHWilb28K
        GFvTy25qj5ChpkWmo+l3NOqPSQ==
X-Google-Smtp-Source: ABdhPJxCtxu+w+3zMHtbrJqtldE0NgWYgFsgY++8k0lwgPQq/FpT1yNpnZZQr0gNut6bRotLDDAuOg==
X-Received: by 2002:aa7:8f21:0:b029:142:2501:39e0 with SMTP id y1-20020aa78f210000b0290142250139e0mr4760606pfr.47.1601514360152;
        Wed, 30 Sep 2020 18:06:00 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id k5sm3917793pfp.214.2020.09.30.18.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 18:05:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <07de71c5-71d0-fbf1-8aa7-c039aeb9dffd@gmail.com>
References: <1601376452-31839-1-git-send-email-sanm@codeaurora.org> <1601376452-31839-5-git-send-email-sanm@codeaurora.org> <07de71c5-71d0-fbf1-8aa7-c039aeb9dffd@gmail.com>
Subject: Re: [PATCH v3 4/5] arm64: dts: qcom: sc7180: Use pdc interrupts for USB instead of GIC interrupts
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Date:   Wed, 30 Sep 2020 18:05:57 -0700
Message-ID: <160151435796.310579.15010135021160402839@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sergei Shtylyov (2020-09-29 04:41:19)
> Hello!
>=20
> On 29.09.2020 13:47, Sandeep Maheswaram wrote:
>=20
> > Using pdc interrupts for USB instead of GIC interrupts to
> > support wake up in case xo shutdown.
>=20
>     s/xo/of/?

No it is xo. If anything it could be capitalized because it's the
pin name and usually stands for "crystal oscillator".

>=20
> > Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
