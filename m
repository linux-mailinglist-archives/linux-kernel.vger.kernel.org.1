Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C766928EFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbgJOJ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389050AbgJOJ5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:57:20 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05878206D4;
        Thu, 15 Oct 2020 09:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602755837;
        bh=o6zc4NhVMQhhirkEMvO8fyn1TbxvoJEBR61y8tv8fGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t4SG5bcDBCOl13YJ08qPeItrensbc/6YT0A6InvXc4SF9amYhULpOtK56aKFOrlAB
         FUraT20M7kcxMlfAhyrDLang6DVAFny6vr+uPujurwd11cLVteuVpldRj2tvNYigXl
         UP9nwnn8ijDcac1pvoPhQlaovAtC8oxGmA0jSkJU=
Date:   Thu, 15 Oct 2020 11:57:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
Cc:     linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4.4/bluetooth 1/2] Bluetooth: Consolidate encryption
 handling in hci_encrypt_cfm
Message-ID: <20201015095750.GA3935178@kroah.com>
References: <20201015074333.445510-1-hegtvedt@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015074333.445510-1-hegtvedt@cisco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 09:43:32AM +0200, Hans-Christian Noren Egtvedt wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes hci_encrypt_cfm calls hci_connect_cfm in case the connection
> state is BT_CONFIG so callers don't have to check the state.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> (cherry picked from commit 3ca44c16b0dcc764b641ee4ac226909f5c421aa3)

This is only in 5.8, what about all the other stable kernels?

> (cherry picked from commit 0a60996c7fa7010ea00d9b62fb6996d908a01ead)

Where is this commit from?  I don't see it in Linus's tree.

> ---
> AFAICT, fixing CVE 2020-10135 Bluetooth impersonation attacks have been
> left out for the 4.4 stable kernel. I cherry picked what I assume are
> the appropriate two patches missing from the 4.9 stable kernel. Please
> add them to upcoming 4.4 stable releases.

Why are you merging 2 commits together?  Please provide backports for
all stable kernels, if you want to see this in the 4.4.y tree.  We can
not have someone move from an older tree to a newer one and have a
regression.

thanks,

greg k-h
