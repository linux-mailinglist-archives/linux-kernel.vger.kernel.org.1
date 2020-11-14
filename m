Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873DE2B30E0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 22:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKNVAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 16:00:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgKNU77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 15:59:59 -0500
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5942242E;
        Sat, 14 Nov 2020 20:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605387599;
        bh=CVhcELNHGDJeD6M6OtXOaCXhZiojf65RjCbtjNj/52s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XaogDyR4QoLWUiUknaKwa/6s7otzZQ6l3ZP/PukPRZfMfDX1J+UHsOMWDj+hO27iF
         eoo2WhimgEo3NqakWtMKDxCDIlDtrD6Pdy2Caq6875/FS+Is+4fXxL+8JouqA6HEqQ
         M+K//gZDSORniFvL8v+UqHBFl2weg73cfNe1q8AI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201021163847.595189-1-jbrunet@baylibre.com>
References: <20201021163847.595189-1-jbrunet@baylibre.com>
Subject: Re: [PATCH 0/2] clk: add devm variant of clk_notifier_register
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Date:   Sat, 14 Nov 2020 12:59:57 -0800
Message-ID: <160538759797.60232.1575446972976252677@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2020-10-21 09:38:45)
> This patchset adds memory managed variant of clk_notifier_register and
> a first usage of it the amlogic clock controller of the g12 SoC family.
>=20
> Jerome Brunet (2):
>   clk: add devm variant of clk_notifier_register

I'm not sure if we want to document these in the devres document?

Documentation/driver-api/driver-model/devres.rst

It would be nice if that thing could auto-generate the list of devres
APIs somehow.
