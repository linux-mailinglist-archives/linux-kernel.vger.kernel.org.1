Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22462A1CCE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 10:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgKAJT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 04:19:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:54232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgKAJTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 04:19:53 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FDF6207F7;
        Sun,  1 Nov 2020 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604222392;
        bh=0cz0N/T/rsg+3fv6C8LRYNPJTOKtFsw4AUUJWmA54Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X+qwWLhwfwEweqpq4o0RqHkGe2+zhOT75WI+Zcoy/3qtEii+FL8I4UBp/O8hFWbFj
         GRGwdPJf1JIxY4iq1gYDcLMoaTigDnKWK2uO3qJaN2jQhekoZzLIwu/tHqisUu7oR3
         0FhYaefBcvVSEbHAYLsLNxiyGgK8khClr/G7W3c8=
Date:   Sun, 1 Nov 2020 17:19:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     trix@redhat.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, abel.vesa@nxp.com, peng.fan@nxp.com,
        leonard.crestez@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: remove unneeded semicolon
Message-ID: <20201101091945.GM31601@dragon>
References: <20201027185756.1586607-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027185756.1586607-1-trix@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:57:56AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied, thanks.
