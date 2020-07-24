Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D5622CF3A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 22:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgGXUNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 16:13:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgGXUNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:13:45 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08F51206D7;
        Fri, 24 Jul 2020 20:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595621625;
        bh=iEypNWNXcDmugvnkEQtFPS8Vul1givJIWxSjWww2IIo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=O+weRMTuQJuuX/vHqxRTRBXpd7ILvA/ajvIZCJrqqYMNCEF5gHh2PXtUIVYzJif5w
         sSkgo9FfmMAlw8bKIH/6WEzKaSPnvuTsGYTB25tPxJiS9yve3P+G21aZCgCAGCzWEv
         EjHhrCoKfr7RSObIkcPwzgoGkrPTf3HNgUMt9OnQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595606878-2664-3-git-send-email-tdas@codeaurora.org>
References: <1595606878-2664-1-git-send-email-tdas@codeaurora.org> <1595606878-2664-3-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v5 2/4] dt-bindings: clock: Add YAML schemas for LPASS clocks on SC7180
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Fri, 24 Jul 2020 13:13:44 -0700
Message-ID: <159562162428.3847286.3839481479370615429@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2020-07-24 09:07:56)
> The LPASS(Low Power Audio Subsystem) clock provider have a bunch of gener=
ic
> properties that are needed in a device tree. Also add clock ids for GCC
> LPASS and LPASS Core clock IDs for LPASS client to request for the clocks.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next
