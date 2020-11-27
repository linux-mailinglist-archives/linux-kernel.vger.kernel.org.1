Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C12C6658
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgK0NIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:08:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730069AbgK0NIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:08:00 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E987B21D7A;
        Fri, 27 Nov 2020 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606482480;
        bh=yEWT8yD9oRORktPdkDenJyadykuE0kyiolVtHRsxdHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/9RMs/Lk0qJsHgGqlYAZGfhW6KFi6eOV7v7iVF3ePVpFnnquSxjK1RhOq2MAuEkW
         IV5t58M2RC/DOyoaFuh/4L3lhM80uteriqBgjg0CBsA3pMWxJiKB2/kqZallMfq4ty
         KwAcpyjbizESECkuTvlATzYqGroK1lDPu9FldFKg=
Date:   Fri, 27 Nov 2020 14:07:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jun Li <lijun.kernel@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v5 3/5] usb: typec: stusb160x: fix power-opmode property
 with typec-power-opmode
Message-ID: <X8D6LgTHMpk2gph9@kroah.com>
References: <20201106165805.31534-1-amelie.delaunay@st.com>
 <20201106165805.31534-4-amelie.delaunay@st.com>
 <e97a537a-9c7e-cd98-8ffa-93abae087128@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e97a537a-9c7e-cd98-8ffa-93abae087128@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 02:01:29PM +0100, Amelie DELAUNAY wrote:
> Hi Greg,
> 
> gentle reminder for this patch, lost in the middle of a DT series (DT part
> already in stm32-next).

Odd, I don't see this anymore, can you resend just this one so I can
apply it directly?

thanks,

greg k-h

