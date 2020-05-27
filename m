Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9AB1E33D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 01:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgEZXmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 19:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgEZXmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:42:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D66D0207D8;
        Tue, 26 May 2020 23:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590536525;
        bh=QEWird265mk1GlMLo+zNPmoKJzyahnxjMwGIEmQdINw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lp5l750Xyu1zmTDS6FhIoTi8xDIbgFtvRddgxIS6cvkkZQ1qPF926joakdkigxkO/
         tNI+1L7g8SAFZ7U8wnp5gRB9G7kuBguloHo+rZOPthCOwBEQtsbXplNTUjo9sye9pI
         pAzYBYjpkvxjsWXU7cFbDb+mOdPBFUZxTa3R18Ek=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200516080806.1459784-1-natechancellor@gmail.com>
References: <20200516080806.1459784-1-natechancellor@gmail.com>
Subject: Re: [PATCH 1/2] clk: bcm2835: Fix return type of bcm2835_register_gate
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Date:   Tue, 26 May 2020 16:42:04 -0700
Message-ID: <159053652408.88029.5210144839543172586@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Chancellor (2020-05-16 01:08:06)
> bcm2835_register_gate is used as a callback for the clk_register member
> of bcm2835_clk_desc, which expects a struct clk_hw * return type but
> bcm2835_register_gate returns a struct clk *.
>=20
> This discrepancy is hidden by the fact that bcm2835_register_gate is
> cast to the typedef bcm2835_clk_register by the _REGISTER macro. This
> turns out to be a control flow integrity violation, which is how this
> was noticed.
>=20
> Change the return type of bcm2835_register_gate to be struct clk_hw *
> and use clk_hw_register_gate to do so. This should be a non-functional
> change as clk_register_gate calls clk_hw_register_gate anyways but this
> is needed to avoid issues with further changes.
>=20
> Fixes: b19f009d4510 ("clk: bcm2835: Migrate to clk_hw based registration =
and OF APIs")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1028
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Thanks. Applied to clk-next.

>=20
> base-commit: bdecf38f228bcca73b31ada98b5b7ba1215eb9c9

Please don't base on some random linux-next commit though.
