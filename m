Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83F22FEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 03:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgG1BZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 21:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgG1BZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:25:27 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B01A220809;
        Tue, 28 Jul 2020 01:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595899526;
        bh=9uiYFObWP6iP+8WICpx1Fzt1ZrJo4Ih9DA64NR0QOug=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=xyVUKixG9Ga831lfABQCANz6vvcNRvfzZrlXAL/ADh0LdbkMQgqmZpGbbWxnQcxQa
         753UMYDzP0IUsKvGrh1KP6vMw07TpDdEGrX8nkHNs5+4nZUQ/YGYouWjs9o7IP6E3L
         7rp+Ui2BPtH3/av2aTKdNJJ8a9kSAJ4pHpyqgCII=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200610113837.27117-1-matthias.schiffer@ew.tq-group.com>
References: <20200610113837.27117-1-matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH] clk: qoriq: add LS1021A core pll mux options
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Krummsdorf <michael.krummsdorf@tq-group.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 27 Jul 2020 18:25:25 -0700
Message-ID: <159589952570.1360974.12026401235468882356@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Schiffer (2020-06-10 04:38:37)
> From: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
>=20
> This allows to clock the cores with 1 GHz, 500 MHz and 250 MHz.
>=20
> Signed-off-by: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---

Applied to clk-next
