Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1B41E3BA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 10:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbgE0IOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 04:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387566AbgE0IOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:14:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D5C2215A4;
        Wed, 27 May 2020 08:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590567259;
        bh=sNNmG0cTdLLy7b3yFmzQ1Wka7gK77HZTE8IJ1WgDr5g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=B5Vd4iwJGZ/B+rETNRCUGw9OdegjBIFMpPIZZ+zcav6kbxIlaW0uIoAuej7D4Vesd
         x/IbJ5Z8EUYiE7jcboRBrls30PAlp67QqD084Zv5SJMbA6Mj/37q/2jWp8OtB6aYUO
         UhL23ilKa1Sb08bZ2j3RehdIWXNTHt58pup2400Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200322140740.3970-1-avolmat@me.com>
References: <20200322140740.3970-1-avolmat@me.com>
Subject: Re: [PATCH] clk: clk-flexgen: fix clock-critical handling
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     patrice.chotard@st.com, avolmat@me.com
To:     Alain Volmat <avolmat@me.com>, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com
Date:   Wed, 27 May 2020 01:14:18 -0700
Message-ID: <159056725840.88029.11402589340387170761@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alain Volmat (2020-03-22 07:07:40)
> Fixes an issue leading to having all clocks following a critical
> clocks marked as well as criticals.
>=20
> Fixes: fa6415affe20 ("clk: st: clk-flexgen: Detect critical clocks")
>=20
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---

Applied to clk-next
