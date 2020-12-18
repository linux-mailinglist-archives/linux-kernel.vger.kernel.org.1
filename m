Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7095E2DDD1C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 03:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbgLRCyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 21:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgLRCyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 21:54:52 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60012C061282
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 18:54:11 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id t22so657833pfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 18:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=XW6PmVRaru/IytMIMlK/CZMh67/ELJF7ucgpl1/y2i0=;
        b=dzdR6r5XIUBNVOi22Ml5oLPXYimd59RRjkOF4NeU/VoyLXnDfPsM3s2Ty47D0lquaI
         y4HX7My8/Ln0vUPrfHLLgVO26Trx9TKxPr7VPGye21jFstsVVGO+le7IUTjj7Is+XeI4
         RTlwAhm/gv56VZ+iK9j+ubzRf22N13Q7ap5ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=XW6PmVRaru/IytMIMlK/CZMh67/ELJF7ucgpl1/y2i0=;
        b=X/UNaptoPCJss2Qk2kLQrhJ+jSIaKxZmDxGdNGDI0GCDQefZ9rASTWJfHqd6p7HVte
         HEHGTKdxA+JZk2LKXFSh9ByDsPl38KtskQUl0h/3+l0dFIghncx9TzOHKctP3j06i+o1
         HwTX2uFqIIOCU27IK3yT0jiF1wwh2Vo5pFlN1VGjjdL1c6m9Ot7P0KkFFRONE+pMSXjk
         BGgpTFprS3IyviImtXVoXgaYcsAKxyaYbT1GqZRu4Yh7eVgiuC49aSjzbrkOiqPRzgh3
         g6woh00pLiCobzleOmuCbIvOUK9DUAloeJks8iIZDkag0g3Cp/WkihEEzEUCMDkxGcBb
         lQvg==
X-Gm-Message-State: AOAM531ATsyR96vHwLXwRBVMqkBFNkrH/rbH6e0WlvAHfUaWgYI4i//e
        pQNIWl2yEhOVq6ABaG9KRCfx+A==
X-Google-Smtp-Source: ABdhPJzWB0fH8/gYg468j09rABpwKxcDjAbAzpfTPrP3F9xH3xDvFnXNK7ZzlUfAsD6X3dqFTH1DHA==
X-Received: by 2002:a62:19cb:0:b029:19e:75c2:61ec with SMTP id 194-20020a6219cb0000b029019e75c261ecmr2221212pfz.19.1608260051481;
        Thu, 17 Dec 2020 18:54:11 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id gj1sm5899906pjb.11.2020.12.17.18.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 18:54:10 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201217142842.v3.2.Ibade998ed587e070388b4bf58801f1107a40eb53@changeid>
References: <20201217142842.v3.1.I99ee04f0cb823415df59bd4f550d6ff5756e43d6@changeid> <20201217142842.v3.2.Ibade998ed587e070388b4bf58801f1107a40eb53@changeid>
Subject: Re: [PATCH v3 2/4] spi: spi-geni-qcom: Fail new xfers if xfer/cancel/abort pending
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     msavaliy@qti.qualcomm.com, akashast@codeaurora.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Thu, 17 Dec 2020 18:54:09 -0800
Message-ID: <160826004928.1580929.14421632210433013822@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-12-17 14:29:12)
> If we got a timeout when trying to send an abort command then it means
> that we just got 3 timeouts in a row:
>=20
> 1. The original timeout that caused handle_fifo_timeout() to be
>    called.
> 2. A one second timeout waiting for the cancel command to finish.
> 3. A one second timeout waiting for the abort command to finish.
>=20
> SPI is clocked by the controller, so nothing (aside from a hardware
> fault or a totally broken sequencer) should be causing the actual
> commands to fail in hardware.  However, even though the hardware
> itself is not expected to fail (and it'd be hard to predict how we
> should handle things if it did), it's easy to hit the timeout case by
> simply blocking our interrupt handler from running for a long period
> of time.  Obviously the system is in pretty bad shape if a interrupt
> handler is blocked for > 2 seconds, but there are certainly bugs (even
> bugs in other unrelated drivers) that can make this happen.
>=20
> Let's make things a bit more robust against this case.  If we fail to
> abort we'll set a flag and then we'll block all future transfers until
> we have no more interrupts pending.
>=20
> Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI=
 based QUP")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
