Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5122DB547
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgLOUjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:39:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbgLOUcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:32:21 -0500
Date:   Tue, 15 Dec 2020 12:31:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608064300;
        bh=2DxS0lmS1153LcET2EORWRgvx53xR07A0YekQd37GUo=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=u56R7ZoXfjS2tyqA1cGdPpKNlIeYov2VbPR0rbzfKeFGhhB1ECuI1ShddW4pBBr/I
         VI4IZTMsaxtBPBQL/cRmKKM8SJj0UmnOZdoIqrTUcs4kA6XgtXq0B92As5B4LkE0YH
         AHL+FktpyTa+iUK3QW/ZapJbnsS3nitwD9yMFhsZuawM440OiYxtI2uk0in77qj4i8
         Ou/VTNTpBOoy+LFsvvpSjfSTBLpou7oQhU1eJ2Qp9LlpRoD5IQ58xYbcY97N9D8za6
         UOqfmAE+2flBObhW1mGkSbizcsHHhSyKyoSf7L2mljsuPDCy7lWazX7wZ2j7EJzTFC
         5E52TdOht/GSw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, David S Miller <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [Aspeed,ncsi-rx, v1 1/1] net: ftgmac100: Fix AST2600 EVB NCSI
 RX issue
Message-ID: <20201215123139.27fd45cd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201215192323.24359-2-hongweiz@ami.com>
References: <20201215192323.24359-1-hongweiz@ami.com>
        <20201215192323.24359-2-hongweiz@ami.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 14:23:23 -0500 Hongwei Zhang wrote:
> Fix AST2600 EVB NCSI RX timeout issue by removing FTGMAC100_RXDES0_RX_ERR bit
> from macro RXDES0_ANY_ERROR.
> 
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>

Thanks for the patch. Please repost CCing the netdev mailing list so it
can be merged to the networking tree (which I assume is your intent).
Please also include a Fixes tag pointing to the commit where the
timeout issue started (even if it's the first commit of the driver).
