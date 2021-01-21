Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8012FE44D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbhAUHrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbhAUHqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:46:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 189C52396D;
        Thu, 21 Jan 2021 07:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611215142;
        bh=mixHPt/ihTHTK+S1giCmJV/xpmx+9AtQGmWtkT5kkAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZaWDKzIl9YuT1XMYZLu5HJ2wDGUdi8Opmm+laj3J7PcwwdCMHN/TBx1jmfMAAssSe
         qUFlW1Di6oPKaONpqTcQcaH/fqgp/VeBmCzU3aOAmwbe9o9BybcyTp9aw41mjkNLuu
         rT82l+K37avxtpFgddANBCmnvSrGac6jjD4anEvM=
Date:   Thu, 21 Jan 2021 08:45:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ricky_wu@realtek.com
Cc:     arnd@arndb.de, ricky_wu@realtek.corp-partner.google.com,
        sashal@kernel.org, levinale@google.com,
        keitasuzuki.park@sslab.ics.keio.ac.jp, kdlnx@doth.eu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtsx: pci: fix device aspm state bug
Message-ID: <YAkxIYvpGYQfd/bz@kroah.com>
References: <20210121072858.32028-1-ricky_wu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121072858.32028-1-ricky_wu@realtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 03:28:58PM +0800, ricky_wu@realtek.com wrote:
> From: Ricky Wu <ricky_wu@realtek.corp-partner.google.com>
> 
> changed rtsx_pci_disable_aspm() to rtsx_disable_aspm()
> make sure pcr->aspm_enabled to sync with aspm state

Can you make this a bit more descriptive?


> 
> BUG=b:175338107
> TEST=chromeos-kernel-5_4

What are these lines for?

> 
> Signed-off-by: Ricky Wu <ricky_wu@realtek.corp-partner.google.com>

This email does not match your From: address :(

> Change-Id: I4b146dcdaaf2f2a965381c32780b0b110d751258

Please use checkpatch.pl before sending patches to us :(

And why did you send this twice?

thanks,

greg k-h
