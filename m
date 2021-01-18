Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E502F9A60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbhARHPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732333AbhARHPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:15:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB999223DB;
        Mon, 18 Jan 2021 07:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610954064;
        bh=hCWebAPLeYSL/h5UpeWik/RoOrhK6BFudicBxFOzRdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FibNKVXTHBP4dEO7q8R6/khVAeHd0+PE9TwSAy0HBTARvgPFqkIc/QWFUn2C11ZcH
         kQgnXSDQtUqCknj4lCkcDtoFo1VmF2ufhC+1QV+h4pjle7u+gT+JHTubcFOekLZ2Wz
         3LvAJGkdaukpHhPift9OP2clvIw5UEawppjELJ9MC/WCNyZi4Zwfe8i3+MRnEYZzrM
         pKO5AhAbQelqAeMnYgwzW2nMxlxl0ayVjsuuxiu8w3s+ptUat0ZCCbyxm7uAY+WO1q
         2z1jPcjP6hGJN5IdXQ73kpoj+xuw/s4aJmvTWMcKhtnLS9u4xe0GolDBjRElQVSHTS
         wSYXbLZlyMUaw==
Date:   Mon, 18 Jan 2021 15:14:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add section for NXP i.MX clock drivers
Message-ID: <20210118071418.GN28365@dragon>
References: <1610542388-12078-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610542388-12078-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 02:53:08PM +0200, Abel Vesa wrote:
> Add a section for NXP i.MX clock drivers and list myself
> as the maintainer.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
