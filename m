Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107821E3559
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 04:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgE0CNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 22:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgE0CNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:13:40 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3DDD2075F;
        Wed, 27 May 2020 02:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590545619;
        bh=J1crIXRWWq7lQA8kuCcnAG2bwtzMoK7mjvAEeG0qXTk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dOvDZ4O/324l6fx5DrCLmOud69HFfXly454ZXD68Tkdw0D++YVinzy4a9O2OlSH1S
         6gDG4G3/Kccf+l7ZNNh0sFbEmCqim34/xWhpj3ra1FqY8vSsDBdjIGuhV1HE/tN2Cz
         xKWFQY/UG5wQ7O3Jnu59/E9oW4H8VQFpN7lz8xt8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200512181647.5071-3-dinguyen@kernel.org>
References: <20200512181647.5071-1-dinguyen@kernel.org> <20200512181647.5071-3-dinguyen@kernel.org>
Subject: Re: [RESEND PATCHv7 3/5] clk: socfpga: add const to _ops data structures
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-clk@vger.kernel.org
Date:   Tue, 26 May 2020 19:13:39 -0700
Message-ID: <159054561917.88029.9052031539246940866@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2020-05-12 11:16:45)
> All the static clk_ops data structure need a const.
>=20
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

Applied to clk-next
