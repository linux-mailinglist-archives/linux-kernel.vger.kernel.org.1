Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C127C2DF256
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 00:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgLSXwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 18:52:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgLSXwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 18:52:12 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608421891;
        bh=Gb+pCOB4Qq9ZRou+eL/UI5E0hLkTz6YWG3w8SzJxfGs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h94AHvwkom6NQM5jOzZ+8OcKMwrxnKNY37DmFp0xHG0FUTkberKdB2JGplFXZSXgU
         b4WpodQ2vhIkWmTyOyiY6N9mZLse+FX+8q8fCyQDOyXI4BsYN33io2Az35/bYVlOfs
         aRrANEhemmqO0ksrDwg3JOPEryZAMDMEP4GqdM6n9ftY9Q/ZGUcIfiO+IxUuEJBjgZ
         /pwx209XkWav5HFU/93fD65Idj6xEWg5rFRMeVS4EwI6Qqpa1oDXnQQgIqXg/o5f3Q
         LL0+FB34MUw5WWoWawwNW9/ZL6dIC4puZUbJzy1CO/aStjHP5a5inedrBc63xQXKYJ
         eYg/hUudZvNvw==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201106100039.11385-1-pali@kernel.org>
References: <20201106100039.11385-1-pali@kernel.org>
Subject: Re: [PATCH] clk: mvebu: a3700: fix the XTAL MODE pin to MPP1_9
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Terry Zhou <bjzhou@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marek Behun <marek.behun@nic.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>
Date:   Sat, 19 Dec 2020 15:51:30 -0800
Message-ID: <160842189035.1580929.16863503861561557281@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Pali Roh=C3=A1r (2020-11-06 02:00:39)
> From: Terry Zhou <bjzhou@marvell.com>
>=20
> There is an error in the current code that the XTAL MODE
> pin was set to NB MPP1_31 which should be NB MPP1_9.
> The latch register of NB MPP1_9 has different offset of 0x8.
>=20
> Signed-off-by: Terry Zhou <bjzhou@marvell.com>
> [pali: Fix pin name in commit message]
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Fixes: 7ea8250406a6 ("clk: mvebu: Add the xtal clock for Armada 3700 SoC")
> Cc: stable@vger.kernel.org
>=20
> ---

Applied to clk-next
