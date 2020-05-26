Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C41C6108
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgEET2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 15:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgEET2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:28:23 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7975206B9;
        Tue,  5 May 2020 19:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588706902;
        bh=Yr3TQpeq70JjThAV/5vG6MVwKJzSlkrhF5dMaLEdqM0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dcku2eH2BmPmUgxbGP+OoSfkmbJZtg1891jJlQ2Qt73crzD6MNGuTpeHQtt9xxm7q
         2IzxPdgKZkvx9qGKgq8mlxVYOjkdFmGtruxF5ZT0nFIwQGxp4qNOYpXB5Lu+7felZi
         PpJkOehG8Z+uUA0t4j+wqeUA2rMUrkpUiUJGFK2I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200503190327.153249-1-christophe.jaillet@wanadoo.fr>
References: <20200503190327.153249-1-christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: clk-xgene: Fix a typo in Kconfig
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        mturquette@baylibre.com
Date:   Tue, 05 May 2020 12:28:22 -0700
Message-ID: <158870690209.26370.14224464671343137404@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2020-05-03 12:03:27)
> s/Sypport/Support
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next
