Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B910A28D8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 05:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgJNDG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 23:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728951AbgJNDG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 23:06:29 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0A0721D81;
        Wed, 14 Oct 2020 03:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602644789;
        bh=e5ZZW8Evy4Vsa2lFW1Oz0N8yfFimMbqiALC26nRm/rI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Oi0wjkLRrNgxjswCaZX5CIY3gN3xdd3wPB8RSSUPj0vmt16LZ5FM2USUNdJP8MFOA
         kAqex6CKUU+t22JclSRQvq58TNqMBp8eNe88/E3ByEzhBG2El0F2kIr/CTDTLjQTcg
         uCnP8f37sPeZTrrI6ehuE6T/Rxl7c6VcmqichKOA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200903015048.3091523-3-paul@crapouillou.net>
References: <20200903015048.3091523-1-paul@crapouillou.net> <20200903015048.3091523-3-paul@crapouillou.net>
Subject: Re: [PATCH 3/5] clk: ingenic: Don't use CLK_SET_RATE_GATE for PLL
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>
Date:   Tue, 13 Oct 2020 20:06:27 -0700
Message-ID: <160264478758.310579.1897903039659830056@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2020-09-02 18:50:46)
> CLK_SET_RATE_GATE means that the clock must be gated when being
> reclocked. This is not the case for the PLLs in Ingenic SoCs.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Applied to clk-next
