Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B67222B994
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 00:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgGWWeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 18:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgGWWeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:34:04 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2434C20737;
        Thu, 23 Jul 2020 22:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595543644;
        bh=d5zpWoahyeJtDv/4qlNoSNBJAbTO0288MoLfGiq+Efo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iq0lF6w89sJRIuU7HoWqGb+eUerBJT0w1P1QBQnZF5IUOOetrJVwTpIfxoGXmL+sU
         TA6E0HxOQBizKDRh8dO2doe6YnsxNXr9zLFbzxeHE9qdbye15+/CFI7UnHHHtyYuhn
         n02WSBNWZIfNAhjYsgJYoeDq3YO+j3BHti4uQTjU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200723074112.3159-3-luca@lucaceresoli.net>
References: <20200723074112.3159-1-luca@lucaceresoli.net> <20200723074112.3159-3-luca@lucaceresoli.net>
Subject: Re: [PATCH v4 2/3] MAINTAINERS: take over IDT VersaClock 5 clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-clk@vger.kernel.org
Date:   Thu, 23 Jul 2020 15:34:03 -0700
Message-ID: <159554364353.3847286.14772349373818321380@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Luca Ceresoli (2020-07-23 00:41:11)
> Marek has been the primary developer of this driver (thanks!). Now as
> he is not working on it anymore he suggested I take over maintainership.
>=20
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>=20
> ---

Applied to clk-next
