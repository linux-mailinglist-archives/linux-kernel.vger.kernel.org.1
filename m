Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AB02FFD63
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbhAVH3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:29:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbhAVH3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:29:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B929E239D4;
        Fri, 22 Jan 2021 07:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611300499;
        bh=FSQvS1mxQiNwmE+kAQd4ONtyh1eej92CZf62V2knvt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dAPvlTgpMbSEt8MO6PTAfDaroqA8pRJGBl3WeTkqa2D7DCWDEejiOnMT+tRd0RJaA
         En+Co9KMkCyySpbOS5hpMzL7hzNUDnTWAVigMGgjlb797cGxS9wH/e8rAex6Btp9Du
         idNgWYULAWI1vmcdfw/iytoBft4ZZYbdCMMEvAJ0=
Date:   Fri, 22 Jan 2021 08:28:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ricky_wu@realtek.com
Cc:     arnd@arndb.de, bhelgaas@google.com, vaibhavgupta40@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] misc: rtsx: init value of aspm_enabled
Message-ID: <YAp+jzr3x2H0wdBs@kroah.com>
References: <20210122033348.15187-1-ricky_wu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122033348.15187-1-ricky_wu@realtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 11:33:48AM +0800, ricky_wu@realtek.com wrote:
> From: Ricky Wu <ricky_wu@realtek.com>
> 
> v1:
> make sure ASPM state sync with pcr->aspm_enabled
> init value pcr->aspm_enabled
> v2:
> fixes conditions in v1 if-statement
> v3:
> more description for v1 and v2

This needs to go below the --- line.

And there is no description of what the patch does anymore :(

Please fix up and do a v4.

thanks,

greg k-h
