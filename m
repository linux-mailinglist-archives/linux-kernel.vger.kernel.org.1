Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A1C1CC2FD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 19:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgEIRFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 13:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgEIRFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 13:05:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31E282184D;
        Sat,  9 May 2020 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589043934;
        bh=TNwiGuU59AdvUvN9asdWl7nZzKASsxAJBDv7IGkPFr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WaOxtm11ka0eex5A8IsSAhiIQBAAbnR1SlGVN+p5m/ApPhE02EghMulZ9Tou7XakE
         7HY+DjVjwBpIcsK4hpuUu+FsG5MLegFztrLn++fr1ADvBPMEJG7w3sIGb3tCOYnVB0
         53m6aX7zpOBwe9pbkk2fIKjqHJCKTio5j3vjQXHw=
Date:   Sat, 9 May 2020 19:05:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Harshal Chaudhari <harshalchau04@gmail.com>
Cc:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver: Adding helper macro for platform_driver
 boilerplate.
Message-ID: <20200509170532.GB2482887@kroah.com>
References: <20200509100716.11044-1-harshalchau04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509100716.11044-1-harshalchau04@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 03:37:16PM +0530, Harshal Chaudhari wrote:
> From: Harshal <harshalchau04@gmail.com>
> 
> For simple module that contain a single platform_driver without any additional setup code then ends up being a block
> of duplicated boilerplate.
> 
> This patch add a new micro, module_platform_driver(), which replace the module_init()/module_exit() registrations
> with template functions.

Please properly wrap your changelog text.

And fixup the Subject line to match other patches for this driver.

And the text needs to be revised a bit to say what this really is doing,
as what you describe is not correct.

> 
> Signed-off-by: harshal chaudhari <harshalchau04@gmail.com>

Finally, this does not match your "From:" line for the patch, which
means I couldn't take it even if all of the above was correct :(

Please fix up and resend.

thanks,

greg k-h
