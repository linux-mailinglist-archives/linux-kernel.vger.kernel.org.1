Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919121E7455
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 06:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390537AbgE2EHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 00:07:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388337AbgE2EHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:07:31 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D6E52072D;
        Fri, 29 May 2020 04:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590725250;
        bh=FQn45qgKvIYKTKJhdW3v228CfAspxcLkSY3po02npIM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eg7zg5GZrpoOAJuzFeZpFF0aW8OsE98BzawVzJN/avMg7OrDWqnJMvT4tH9e0SgaO
         ZWmgUUetUEx3vVqdab3G4+f3R0RcJIuO0sI5TOco2k5ReHcMvu6798MTq8gAKjO3w6
         vhkP2j0IlHc6WjkfebBywp6B5MuPddjEpAfJz3SQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200311134115.13257-4-Eugeniy.Paltsev@synopsys.com>
References: <20200311134115.13257-1-Eugeniy.Paltsev@synopsys.com> <20200311134115.13257-4-Eugeniy.Paltsev@synopsys.com>
Subject: Re: [PATCH 3/3] CLK: HSDK: CGU: add support for 148.5MHz clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 28 May 2020 21:07:29 -0700
Message-ID: <159072524956.69627.10946881962902731416@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eugeniy Paltsev (2020-03-11 06:41:15)
> Add support for 148.5MHz clock for HDMI PLL
>=20
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---

Applied to clk-next
