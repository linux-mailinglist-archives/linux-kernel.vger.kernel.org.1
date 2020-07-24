Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AA422C278
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 11:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGXJmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 05:42:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbgGXJmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:42:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 701C7206EB;
        Fri, 24 Jul 2020 09:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595583728;
        bh=UTbUq984n65wlovPvPVfXGRpofUx4w/DmHnikEOryGE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ECYqlR/GScqnb+tq0jHokTteIwsz4ohh3GaN0EqiuPHbTTtywrv7Ug8SWGoemvjNp
         SqX8ZppyOPtA+ZhgxwbfIbCYgDLW0ZUTXfnb8czdb80DfhPOrgNmGpiGEb480fgT0J
         vGrYJ/HTPTRkvENvC4mr06RzVjJYneS9egaNHRfc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200622090935.213833-1-sboyd@kernel.org>
References: <20200622090935.213833-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: Clean up kernel-doc errors
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 24 Jul 2020 02:42:07 -0700
Message-ID: <159558372766.3847286.7662762683733987681@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-06-22 02:09:35)
> Two things aren't documented causing kernel-doc to fail when checking
> the core clk.c file. Fix them so that this file is clean.
>=20
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
