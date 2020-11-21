Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7F2BBDC3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 08:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgKUHOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 02:14:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgKUHOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 02:14:14 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEF732223F;
        Sat, 21 Nov 2020 07:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605942853;
        bh=2gsmAi27bRo7R7CNFx36lA3IuPcYZAvhfGz15Jm323Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2s5auFeKAMWUv/XsdCBy682+ZP5bC+6qoUtAuOQDHeD62cSLvx6qA37M6+DZ6KBu
         vyw8RWqe2apDYKuh92YnkSyEir+tEYPXE0EpSRTRScLGi/5WJHGaghfk97UJHcNOF+
         KeRq5aRPmDowz8To9DH5ocGSt5zndT5V6WglKW6o=
Date:   Sat, 21 Nov 2020 08:14:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@google.com>
Cc:     christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com,
        smoreland@google.com
Subject: Re: [PATCH] binder: add flag to clear buffer on txn complete
Message-ID: <X7i+QcE8hhY03FX1@kroah.com>
References: <20201120233743.3617529-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120233743.3617529-1-tkjos@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 03:37:43PM -0800, Todd Kjos wrote:
> Add a per-transaction flag to indicate that the buffer
> must be cleared when the transaction is complete to
> prevent copies of sensitive data from being preserved
> in memory.
> 
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---

DOes this need to be backported to stable kernels as well?

thanks,

greg k-h
