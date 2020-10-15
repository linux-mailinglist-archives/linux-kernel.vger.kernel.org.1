Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A33128EFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389083AbgJOJ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389050AbgJOJ57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:57:59 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B863F2222E;
        Thu, 15 Oct 2020 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602755877;
        bh=NbgguV+tTYQyQbpkay9yvIt4vURAsT2ICqIQUIqcKao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oU6E11+decTUIAptKo/I7kL6g6KPYHtOEg/FyaKt9zvffMojBn4mTTottrMWkSqnE
         cH7oRyzAfZEPqRfZ3yYWCrMJKcEwYklnGxx4Pg7aLb4UYE+l7CCzrlXQ9CY6BPHGUs
         WRF3jQqwF/J8nnQeDCTeK9W1MLcbh6RCZhRFnYEU=
Date:   Thu, 15 Oct 2020 11:58:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
Cc:     linux-kernel@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4.4/bluetooth 2/2] Bluetooth: Disconnect if E0 is used
 for Level 4
Message-ID: <20201015095830.GB3935178@kroah.com>
References: <20201015074333.445510-1-hegtvedt@cisco.com>
 <20201015074333.445510-2-hegtvedt@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015074333.445510-2-hegtvedt@cisco.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 09:43:33AM +0200, Hans-Christian Noren Egtvedt wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> E0 is not allowed with Level 4:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C page 1319:
> 
>   '128-bit equivalent strength for link and encryption keys
>    required using FIPS approved algorithms (E0 not allowed,
>    SAFER+ not allowed, and P-192 not allowed; encryption key
>    not shortened'
> 
> SC enabled:
> 
> > HCI Event: Read Remote Extended Features (0x23) plen 13
>         Status: Success (0x00)
>         Handle: 256
>         Page: 1/2
>         Features: 0x0b 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>           Secure Simple Pairing (Host Support)
>           LE Supported (Host)
>           Secure Connections (Host Support)
> > HCI Event: Encryption Change (0x08) plen 4
>         Status: Success (0x00)
>         Handle: 256
>         Encryption: Enabled with AES-CCM (0x02)
> 
> SC disabled:
> 
> > HCI Event: Read Remote Extended Features (0x23) plen 13
>         Status: Success (0x00)
>         Handle: 256
>         Page: 1/2
>         Features: 0x03 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>           Secure Simple Pairing (Host Support)
>           LE Supported (Host)
> > HCI Event: Encryption Change (0x08) plen 4
>         Status: Success (0x00)
>         Handle: 256
>         Encryption: Enabled with E0 (0x01)
> [May 8 20:23] Bluetooth: hci0: Invalid security: expect AES but E0 was used
> < HCI Command: Disconnect (0x01|0x0006) plen 3
>         Handle: 256
>         Reason: Authentication Failure (0x05)
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> (cherry picked from commit 8746f135bb01872ff412d408ea1aa9ebd328c1f5)
> (cherry picked from commit f263237a1709a6dbf1dc9945187f1e64c53a4b73)

I do not see this commit in Linus's tree.

> ---
> AFAICT, fixing CVE 2020-10135 Bluetooth impersonation attacks have been
> left out for the 4.4 stable kernel. I cherry picked what I assume are
> the appropriate two patches missing from the 4.9 stable kernel. Please
> add them to upcoming 4.4 stable releases.

Same thing as before, we need this in all kernels.

thanks,

greg k-h
