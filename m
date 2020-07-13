Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5A521DAC6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 17:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgGMPv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 11:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbgGMPv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:51:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C938B20663;
        Mon, 13 Jul 2020 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594655488;
        bh=UeqdQ5Ai6a37CRGQJQSRCJSFMdVA0qgwG68F8CKF9Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fttp4F/t7IrpungzsmZJbKuyfRK8ZJyiRWLDJMG8UGr0TkPdeYYiQT0w90lrzTN93
         2hgezqA6OyjPncthC6dAIfyq/SnjICvycAwIlDEp39OmT4g/2I5uBDS7yYANpprCtd
         O+PvhCrvsecDYZe4LeB+BVPVu7yXeDK+xWus1uu8=
Date:   Mon, 13 Jul 2020 17:51:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: sierra: clean up special-interface handling
Message-ID: <20200713155127.GA267581@kroah.com>
References: <20200713153936.18032-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713153936.18032-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 05:39:36PM +0200, Johan Hovold wrote:
> Clean up the handling of special interfaces that either should be
> ignored or that need a larger number of URBs.
> 
> Commit 66f092ed3b94 ("USB: serial: sierra: unify quirk handling logic")
> replaced the previous is_blacklisted() and is_highmemory() helpers with
> a single is_quirk() helper which made it even harder to understand what
> the interface lists were used for.
> 
> Rename the interface-list struct, its members and the interface-lookup
> helper and restructure the code somewhat in order to make it more
> self-explanatory.

Much better, that was messy, thanks for cleaning this up.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
