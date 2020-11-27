Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879122C671C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbgK0NpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:45:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730049AbgK0NpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:45:15 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 142BD2224B;
        Fri, 27 Nov 2020 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606484714;
        bh=NQw72cTse1BafEIim088HPnHlNEV5CfbLc4E4dpqY8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehWfKKP1UOOn+C9SHVlo95ZPPe30z4aTj9x50H+4+ZzjeA8MEpi7WDq7holOQ/GN3
         FMTIf16xFIHwikVU+k2jUuGfmL3Zh8PQZBHGYmgRwtBaRUspkBTh6PPWSdSe/gC0Pb
         pc/fp9G1VB1Lnd+LjxYVF5VJivjuIzVvqWGGegas=
Date:   Fri, 27 Nov 2020 14:45:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v5 1/1 RESEND] usb: typec: stusb160x: fix power-opmode
 property with typec-power-opmode
Message-ID: <X8EC6BL98dm+u+8C@kroah.com>
References: <20201127131735.28280-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127131735.28280-1-amelie.delaunay@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 02:17:35PM +0100, Amelie Delaunay wrote:
> Device tree property is named typec-power-opmode, not power-opmode.
> 
> Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/stusb160x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Now applied, sorry for missing it before.

greg k-h
