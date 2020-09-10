Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F85E263F30
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 09:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIJH5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 03:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgIJH5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:57:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49E4020829;
        Thu, 10 Sep 2020 07:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599724667;
        bh=4pKISiYZhY3EeSnAyleLcIQNYM/Dt5k93S8IrckrwTs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=s78HttgmbSoO2M+1IKqaQXEEF0Dz6GoeOC9ac+QJmYnlh01qs9LpethP8h7oZ9lko
         ++tmd3Dp5vC0lqd6buHZM2iRVZ9kroxrRpQkf8nhB0XsqmCfBaoSy/sDiITQ7JhLMt
         X5BpSQIUP0JerYjBPciWzDYf+gc4Za0gH0aFuqps=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200829175704.GA10998@Kaladin>
References: <20200829175704.GA10998@Kaladin>
Subject: Re: [PATCH] clk: versatile: Add of_node_put() before return statement
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, Julia.Lawall@lip6.fr,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        linus.walleij@linaro.org
Date:   Thu, 10 Sep 2020 00:57:45 -0700
Message-ID: <159972466586.2295844.9075545722301677556@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sumera Priyadarsini (2020-08-29 10:57:04)
> Every iteration of for_each_available_child_of_node() decrements
> the reference count of the previous node, however when control is
> transferred from the middle of the loop, as in the case of a return
> or break or goto, there is no decrement thus ultimately resulting in
> a memory leak.
>=20
> Fix a potential memory leak in clk-impd1.c by inserting
> of_node_put() before a return statement.
>=20
> Issue found with Coccinelle.
>=20
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---

Applied to clk-fixes
