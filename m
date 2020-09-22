Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858CD2749AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgIVT7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIVT7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:59:34 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B718221E8;
        Tue, 22 Sep 2020 19:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600804773;
        bh=ko86j4eJVn/gqX1GowgA/ZepwfEpTucQ77XDZkPwucU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BsFx2w2ERwj/4fd2OPsoOVbjjbtig9ux3fOx0p6aJ+wFulOupGW2c9p0MQb7a9zyB
         HE2ANBrx0ev/RHtBx98azFBSenxF6stYmmD2FEYN2w24MGyeu2rEdNf2qvmhieecgi
         IAXP9dYHigU3buULJ+3T+PTG/9cTXBndAwqkCBa4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200907085740.1083-4-t-kristo@ti.com>
References: <20200907085740.1083-1-t-kristo@ti.com> <20200907085740.1083-4-t-kristo@ti.com>
Subject: Re: [PATCH 3/3] clk: keystone: sci-clk: add 10% slack to set_rate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com
To:     Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, ssantosh@kernel.org
Date:   Tue, 22 Sep 2020 12:59:32 -0700
Message-ID: <160080477208.310579.10011892284968417590@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tero Kristo (2020-09-07 01:57:40)
> Currently, we request exact clock rates from the firmware to be set with
> set_rate. Due to some rounding errors and internal functionality of the
> firmware itself, this can fail. Thus, add some slack to the set_rate
> functionality so that we are always guaranteed to pass. The firmware
> always attempts to use frequency as close to the target freq as
> possible despite the slack given here.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

Applied to clk-next
