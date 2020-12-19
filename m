Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829CC2DF25C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 00:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgLSXyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 18:54:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgLSXyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 18:54:19 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608422019;
        bh=Am3QqUpQVchnO6nwVTRw7tOsrDh64innkiZKcjW5amA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=G4QrLNsZytnAzTXZISjU58ZEGsmr/WqX0YK4zC67xtuGNvJApOFJ6brv4h5eCqgxk
         2I+YWdyHHbp72ajOUwd902icsVAr0x1b3T3O4qJJjOCBLsyrnSaq8NNXEu9kdBqth2
         p/lARqw9TMwMXz56wOLsmZUuYhZwQTfZDhwuH5N0MNLJgDe7OsdV8zh+3o++EUT9EC
         1HvV+4s8KO2VjIxgaud+WFdYVNy2n18DSA5MZqd9gVigcfFigAo7jvaKbnRgqutemM
         Ulv7dJhuFnuV3fghMB3B3SDDdl4E+ags20wTbsbuEqq4YhtTZCz9oMk6bGQh5MXJRu
         aFWXiGUFS1xPg==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201212122818.86195-1-christophe.jaillet@wanadoo.fr>
References: <20201212122818.86195-1-christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: s2mps11: Fix a resource leak in error handling paths in the probe function
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        b.zolnierkie@samsung.com, krzk@kernel.org, mturquette@baylibre.com,
        mturquette@linaro.org, yadi.brar@samsung.com
Date:   Sat, 19 Dec 2020 15:53:37 -0800
Message-ID: <160842201799.1580929.7725454573395361171@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2020-12-12 04:28:18)
> Some resource should be released in the error handling path of the probe
> function, as already done in the remove function.
>=20
> The remove function was fixed in commit bf416bd45738 ("clk: s2mps11: Add
> missing of_node_put and of_clk_del_provider")
>=20
> Fixes: 7cc560dea415 ("clk: s2mps11: Add support for s2mps11")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next
