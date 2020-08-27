Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF01A2547AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 16:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgH0OxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 10:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727944AbgH0NSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:18:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660D02177B;
        Thu, 27 Aug 2020 13:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598534294;
        bh=9DRF5vjxvz2bBPwwyicv9rS52KeEe+a/cyEOwe688CY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fs/wJwwnyJlgB4e/TnRBgNocsAiP4wPzcZRtfwbnczIr/d4QhOMNjc0geK6PI3Ygb
         o9VMnxVMI4bDmQ1/ZWmDTLfdLcFwoWyfCscphVzrXXhcjNHgJzYqdjQPLR5WenXurU
         oGk7fx01Y6Y6+u/2ikz17QSxsE5meKxFlVYyS5a0=
Date:   Thu, 27 Aug 2020 15:18:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Security Officers <security@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add security docs to SECURITY CONTACT
Message-ID: <20200827131827.GA546898@kroah.com>
References: <20200827131330.3732-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827131330.3732-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 03:13:30PM +0200, Krzysztof Kozlowski wrote:
> When changing the documents related to kernel security workflow, notify
> the security mailing list as its concerned by this.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8107b3d5d6df..a1e07d0f3205 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15620,6 +15620,8 @@ F:	include/uapi/linux/sed*
>  
>  SECURITY CONTACT
>  M:	Security Officers <security@kernel.org>
> +F:	Documentation/admin-guide/security-bugs.rst
> +F:	Documentation/process/embargoed-hardware-issues.rst

The hardware-issues document is "owned" by a different group of
suckers^Wdevelopers, that is independant of security@k.o, so that file
shouldn't be added to them here.

thanks,

greg k-h
