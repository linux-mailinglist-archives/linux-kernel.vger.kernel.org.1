Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989431E3C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 10:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbgE0Ig1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 04:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387811AbgE0Ig1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:36:27 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A315820723;
        Wed, 27 May 2020 08:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590568586;
        bh=ephzXhc4Nle1URJdNkJxV32ieAgRX0Nf3z2rYvzI+fk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rHknTFfnoLP25c+m3JZFlO2nyYcc2C0W72njgEGbc05kYuMwk5knTyFL3CIPZhrPH
         WEP4VswzfuhPzWh5LWGikeedjr4QcA9lh9C+qidWTI4v+N7fLMu1ORXo/O59XcU4Ox
         MaFxkrbvBtyXsWUQxe2UvgMWf9P9z3FWIPFVFwiA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200408203616.4031-1-eajames@linux.ibm.com>
References: <20200408203616.4031-1-eajames@linux.ibm.com>
Subject: Re: [PATCH] clk: ast2600: Fix AHB clock divider for A1
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        joel@jms.id.au, Eddie James <eajames@linux.ibm.com>
To:     Eddie James <eajames@linux.ibm.com>, linux-clk@vger.kernel.org
Date:   Wed, 27 May 2020 01:36:25 -0700
Message-ID: <159056858596.88029.16129045077761074418@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eddie James (2020-04-08 13:36:16)
> The latest specs for the AST2600 A1 chip include some different bit
> definitions for calculating the AHB clock divider. Implement these in
> order to get the correct AHB clock value in Linux.
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---

Applied to clk-next
