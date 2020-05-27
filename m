Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC101E3557
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 04:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgE0CNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 22:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgE0CNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:13:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D852075F;
        Wed, 27 May 2020 02:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590545617;
        bh=IwxnxiVekdvclJFXIl0VJdKo//Uj+nkClBVcy1rxNJg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tHCLyFzcgkEVVmE03OzYnvkcl4mp1LxbMihjh2FODY0Ubh4iICQlqkJ1bnzL6G467
         zgBv1Zt/Zi2lcqAe6qlGhlrzs+Z5s3HKwfwlKqrMM+x6VMjSwlJqmc0WVe27PpAykg
         Q5yahePVJ6g0Bg9hvtV9MZK/qpijjPADlmeuFSuI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200512181647.5071-2-dinguyen@kernel.org>
References: <20200512181647.5071-1-dinguyen@kernel.org> <20200512181647.5071-2-dinguyen@kernel.org>
Subject: Re: [RESEND PATCHv7 2/5] clk: socfpga: remove clk_ops enable/disable methods
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com
To:     Dinh Nguyen <dinguyen@kernel.org>, linux-clk@vger.kernel.org
Date:   Tue, 26 May 2020 19:13:36 -0700
Message-ID: <159054561620.88029.2462675181381923936@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dinh Nguyen (2020-05-12 11:16:44)
> The enable/disable clock ops are already defined in the standard clock
> ops, so we don't need to assign them.
>=20
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---

Applied to clk-next
