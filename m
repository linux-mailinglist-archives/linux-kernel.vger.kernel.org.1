Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5211F483F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 22:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgFIUpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 16:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgFIUpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:45:13 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C09207C3;
        Tue,  9 Jun 2020 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591735513;
        bh=RSuipI8ccFhupS8paxcrC8x3jfSLQR5eHEjMopWyIZ8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=q5FDQdcoI0uoFZsasvuO7pKZNkFvuUuO/a28X6QWt0jlJWtoGKuMVg6zRH+lJYbpD
         UYsWUlWYIaNR/lu9CoOMFoIsAvPjSeCz8X+ZDNLZJ5nTGaa5x+6TXUCyH8QphvwYOJ
         7DnaVjxtilm2C3+veT4TPYCoWrUKAZQuNwzn0r7s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200605065258.567858-1-lkundrak@v3.sk>
References: <20200605065258.567858-1-lkundrak@v3.sk>
Subject: Re: [PATCH] dt-bindings: clock: Add a missing include to MMP Audio Clock binding
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Tue, 09 Jun 2020 13:45:12 -0700
Message-ID: <159173551263.242598.12514933024861447567@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-06-04 23:52:58)
> The include file for input clock in the example was missing, breaking the
> validation.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reported-by: Rob Herring <robh+dt@kernel.org>
> ---

Applied to clk-next
