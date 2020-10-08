Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5003A286C82
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 03:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgJHByI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 21:54:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgJHByH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 21:54:07 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48551207C3;
        Thu,  8 Oct 2020 01:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602122047;
        bh=lV3i+9ypzLKkJz3H47NnyJWPoQ8C3bvpjkcCNkKvoKY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=reB3SrSx28A7TStUli82aUX7kqaxX8dn4Tyzi2zMW4h5WyU5q8Sb5G3rVUlrulvej
         5xtI72kTaGPUPpqEVuyn7CTxcceuA4nthzbJ93gBCeu1A/MQtr9t3s1JEPDQuWuWpY
         8HSCRDDRMib1C0z9vqfefCQkh0IBxsBo/y2OCPKE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1j1rimjkr7.fsf@starbuckisacylon.baylibre.com>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr> <1601233948-11629-11-git-send-email-Julia.Lawall@inria.fr> <1j1rimjkr7.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH 10/18] clk: meson: use semicolons rather than commas to separate statements
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Valdis =?utf-8?q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Neil Armstrong <narmstrong@baylibre.com>
Date:   Wed, 07 Oct 2020 18:54:05 -0700
Message-ID: <160212204583.310579.15787381299278211019@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2020-09-28 02:47:24)
>=20
> On Sun 27 Sep 2020 at 21:12, Julia Lawall <Julia.Lawall@inria.fr> wrote:
>=20
> Hi Stephen,
>=20
> Do you want to take all the clock related patches directly ?
>=20
>=20

Sure that's fine.
