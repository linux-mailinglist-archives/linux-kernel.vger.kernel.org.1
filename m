Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7A0275D20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgIWQPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgIWQP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:15:28 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F45208E4;
        Wed, 23 Sep 2020 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600877728;
        bh=xFMBpHqHQ47dz75/sLHzf/RHR2JiOBSOkXLJ6FUvN78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tUQ7uEDXLyn3IgUJDWxAmBNXsVxncDvnllQVOnFuWexxTmD7KLJIs3GuZ177Z/rim
         +sRfvZWfafriM+wuUPF3qAtA+SagnQoas9O5eeQsCo3uOWJnTf6FVWBrpiDlwhD4Pr
         ZXr+hdSRpLcbapsVb6RWPUoKeo9WLlv75qCHyUxk=
Date:   Wed, 23 Sep 2020 09:15:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wilken Gottwalt <wilken.gottwalt@mailbox.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] net: usb: ax88179_178a: add Toshiba usb 3.0 adapter
Message-ID: <20200923091526.38237551@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200923075209.GA145354@monster.powergraphx.local>
References: <20200923075209.GA145354@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 09:52:09 +0200 Wilken Gottwalt wrote:
> Adds the driver_info and usb ids of the AX88179 based Toshiba USB 3.0
> ethernet adapter.
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>

Please repost your patches and CC netdev@vger.kernel.org.

