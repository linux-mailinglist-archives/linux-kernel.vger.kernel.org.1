Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC8C227B87
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgGUJTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 05:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbgGUJTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:19:42 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D32A420792;
        Tue, 21 Jul 2020 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595323181;
        bh=iWSM5sXQBJiu2/PDHyjMEVSdorbsAd0mMLH0MoE6yL0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=k0PcAnU2G2Dcb1gik0r5DAyFmzIwE1Dgn5Sqp7oV26zQBsqQDyEZtfuN93RIxphym
         qmoed8RV8WypvdDLOAfmvic2mHeu3sozsWHYBW+Qy7sXJZeIH8BYReZJGQBeKmYcfn
         PAhJ6YaVqCa1WcZ2uri/3v67UZDVnQQQmnBKSL4g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200716122620.4538-1-aford173@gmail.com>
References: <20200716122620.4538-1-aford173@gmail.com>
Subject: Re: [PATCH V3] clk: vc5: Add memory check to prevent oops
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dan.carpenter@oracle.com, luca@lucaceresoli.net,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Date:   Tue, 21 Jul 2020 02:19:41 -0700
Message-ID: <159532318111.3847286.6874293188283317151@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Ford (2020-07-16 05:26:20)
> When getting the names of the child nodes, kasprintf is used to
> allocate memory which is used to create the string for the node
> name.  Unfortunately, there is no memory check to determine
> if this allocation fails, it may cause an error when trying
> to get child node name.
>=20
> This patch will check if the memory allocation fails, and returns
> and -ENOMEM error instead of blindly moving on.
>=20
> Fixes: 260249f929e8 ("clk: vc5: Enable addition output configurations of =
the Versaclock")
>=20
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
> V3:   Fix spelling error, and use the style of checking (!variable) inste=
ad of
>       (variable =3D=3D NULL)
>=20
> V2:   Fix an issue where a goto was going to use an unitialized variable.

Is the patch from Colin also needed?
https://lore.kernel.org/r/20200625132736.88832-1-colin.king@canonical.com
