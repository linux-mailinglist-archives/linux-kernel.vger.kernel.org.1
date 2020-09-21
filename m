Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E139F27337F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 22:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgIUUHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 16:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgIUUHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 16:07:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C027FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 13:07:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d9so10256026pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=AlaOoj5U8m2P/REWaLVWAETneQOfeX+pZHRa7JtDSF4=;
        b=f0yBwq9ua+qdjOCG6vn+3kaP22P1cY5PInD+ibNgbd/aHNTT7S8qHE7eFOY3ydNi//
         /5w79PRdWCAUVjzEB8erGf/nZRM9PcmqT0x2A/pWuwLezPY1tKewYpqzUWRDAebqtG/s
         U6q0XLN6zkS4oXW3Lw6v/KHVPkP3BS9vZ/mp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=AlaOoj5U8m2P/REWaLVWAETneQOfeX+pZHRa7JtDSF4=;
        b=LWcgYGG80AdB+sIPXAToBnIzXwHox2cG1UErzlLoqbFKw+htMQceUEaevsdic50CBu
         jNNSO1usMG9r+6+TeizTbinrznluU9uY5u/pubHCbOrb9sDNBFh1qn1hq6VHXjcUaUcz
         3e01hM2rUgnqGR9uZXGxXnor4bSZlG8adhjxAmX0K0EXs/2Gn5GtDbhm5L0Hmj8lPAFl
         HdDi9fzflB5RY5FWzjVTF3Y/Hr11BYm0s+WSiFfllYqUezZBl9cnsN+KpjD5GQB3ZN4Y
         +4yuwUTqqfpdX57zRotLEIa4+ZCUfkqmoO8+t76VO4LSStiA3NjWpJBU8jFTh1xmomzC
         X6fA==
X-Gm-Message-State: AOAM532fzaeT0b7fXR8zz4EwL6eafAJtMzWYzmTD2ewOdedXtCxKYcaP
        w6irypIlSK38q8mJtn6G2oYtAQ==
X-Google-Smtp-Source: ABdhPJxddrWMwrfYN0JMc7XwtqcK/4YMKiP3KYQmU9PGpgN7qWprcAbkvUC+EF7+rsNBDcVst4acZA==
X-Received: by 2002:a63:eb58:: with SMTP id b24mr972895pgk.178.1600718830284;
        Mon, 21 Sep 2020 13:07:10 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id f18sm13938548pfe.153.2020.09.21.13.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 13:07:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200918174512.v2.2.I3c57d8b6d83d5bdad73a413eea1e249a98d11973@changeid>
References: <20200918174511.v2.1.I997a428f58ef9d48b37a27a028360f34e66c00ec@changeid> <20200918174512.v2.2.I3c57d8b6d83d5bdad73a413eea1e249a98d11973@changeid>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Switch sc7180-trogdor to control SPI CS via GPIO
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, akashast@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Mon, 21 Sep 2020 13:07:08 -0700
Message-ID: <160071882844.4188128.5172158545089744293@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-09-18 17:45:28)
> As talked about in the patch ("arm64: dts: qcom: sc7180: Provide
> pinconf for SPI to use GPIO for CS"), on some boards it makes much
> more sense (and is much more efficient) to think of the SPI Chip
> Select as a GPIO.  Trogdor is one such board where the SPI parts don't
> run in GSI mode and we do a lot of SPI traffic.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
