Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB892279E7A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 07:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbgI0Fm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 01:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgI0Fm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 01:42:27 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A5F1239EE;
        Sun, 27 Sep 2020 05:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601185347;
        bh=ZjXx0SooA9sSMx6d9n9piTmE3umRXqI62zHOyhR7uXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6C8XAEL/E0uvZm2zhMF1PsNofbT4YqJ712Tq36rjD52IjrJv0teglO4Jn/GBr3IX
         dACR8VuRKGryVNI2/OOSKl9jsMgnTpMs749rKR63+eVizcXZovI2IVUUmbT2ZGKYno
         nA+46jMARJ4DeX3i+RYWcYDpEpj+/1M+c93gSsEI=
Date:   Sun, 27 Sep 2020 07:42:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Liu, Shuo A" <shuo.a.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v4 00/17] HSM driver for ACRN hypervisor
Message-ID: <20200927054222.GA699448@kroah.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <8235ade4-eb61-aed1-bd9a-9db0134cb64a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8235ade4-eb61-aed1-bd9a-9db0134cb64a@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 08:24:39AM +0800, Liu, Shuo A wrote:
> Ping...

It's been less than a week since you sent this.  Please relax and if you
really need reviews, get them from within Intel, where you can impose a
deadline on those developers.  Otherwise, your patch is in good company:

	$ mdfrm -c ~/mail/todo/
	993 messages in /home/gregkh/mail/todo/

And will be handled when I get to it.

thanks,

greg "Intel still owes me lots of liquor" k-h
