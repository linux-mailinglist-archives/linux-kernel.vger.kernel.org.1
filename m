Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942D82E9D09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 19:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbhADSaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 13:30:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbhADSaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:30:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF0FB21D94;
        Mon,  4 Jan 2021 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609784969;
        bh=M+ZYceuHxSxu607BknFIjQEagqcKWEToLDCHrHzKvQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dDqw+MPOOOK4kb9xXl5/Xn3RUwybNH5M7WhqjcCsQ1FGiphvuRyidBBr+ex88uUpM
         Tcah4D6j9dgqu+JuBO17ErJkPm8+4iGANHBnb+YARD5m72kL5mALXvKLW+yf73Tlb7
         MPNrm8BV/cViqhGjQXjmtIIsdYqBHPrNvYs3mR5UDU+/PcgRkxy7CiCHdyVqsLZQpy
         B7wPtZshZdZCq8sXuDZ924b/FqFlspKmimgC2qn+TN/5eotkii2ndAc9UGlztkN+S0
         W4wA6dtmvMK/PcMKCU3zVLadZ4Plxrr+dCuyZeDCcSIAJAgLuDd/mCm8TE7ofUu71j
         /VhqPtVhIN74g==
Date:   Mon, 4 Jan 2021 10:29:27 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Gao Yan <gao.yanB@h3c.com>
Cc:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <paulus@samba.org>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2]net:ppp: remove disc_data_lock in ppp line
 discipline
Message-ID: <20210104102927.2712cc10@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210101033718.45198-1-gao.yanB@h3c.com>
References: <20210101033718.45198-1-gao.yanB@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jan 2021 11:37:18 +0800 Gao Yan wrote:
> In tty layer, it provides tty->ldisc_sem to protect all tty_ldisc_ops
> including ppp_sync_ldisc. So I think tty->ldisc_sem can also
> protect tty->disc_data, and the disc_data_lock is not necessary.
> 
> Signed-off-by: Gao Yan <gao.yanB@h3c.com>

Please make sure to CC netdev.
