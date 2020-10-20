Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDB4294081
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394634AbgJTQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733161AbgJTQ3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:29:09 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9773022242;
        Tue, 20 Oct 2020 16:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603211348;
        bh=pRBeQL/a5RpVRZarAG306C8c1NuJIWYfe0ySwmJTqGA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=i2fiDW4JUPUQYMopwJeW41lkYqEGGsqhK8lkx7Mn/TSBJxouQki64PWOV5CKQNIvF
         cD2zH+Fd+oc2iTQMw2mF5ZbHNlAuzU7oED0ELXKymj42lp/prq7IER9qJtY6lROtS2
         SW/lEi+T9G6eYaaDIsFbbYOhunmyDv0hQALhKMC8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201017020137.1251319-1-sboyd@kernel.org>
References: <20201017020137.1251319-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: qcom: gdsc: Keep RETAIN_FF bit set if gdsc is already on
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Tue, 20 Oct 2020 09:29:07 -0700
Message-ID: <160321134713.884498.3399615301658198835@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-10-16 19:01:37)
> If the GDSC is enabled out of boot but doesn't have the retain ff bit
> set we will get confusing results where the registers that are powered
> by the GDSC lose their contents on the first power off of the GDSC but
> thereafter they retain their contents. This is because gdsc_init() fails
> to make sure the RETAIN_FF bit is set when it probes the GDSC the first
> time and thus powering off the GDSC causes the register contents to be
> reset. We do set the RETAIN_FF bit the next time we power on the GDSC,
> see gdsc_enable(), so that subsequent GDSC power off's don't lose
> register contents state.
>=20
> Forcibly set the bit at device probe time so that the kernel's assumed
> view of the GDSC is consistent with the state of the hardware. This
> fixes a problem where the audio PLL doesn't work on sc7180 when the
> bootloader leaves the lpass_core_hm GDSC enabled at boot (e.g. to make a
> noise) but critically doesn't set the RETAIN_FF bit.
>=20
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Taniya Das <tdas@codeaurora.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Fixes: 173722995cdb ("clk: qcom: gdsc: Add support to enable retention of=
 GSDCR")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
