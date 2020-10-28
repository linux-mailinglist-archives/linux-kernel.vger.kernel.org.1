Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361BD29D3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgJ1VsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:48:07 -0400
Received: from smtp1.axis.com ([195.60.68.17]:30468 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgJ1VnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=411; q=dns/txt; s=axis-central1;
  t=1603921393; x=1635457393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f6nefk6qLvt2N+SlLRUmIvEhqqqWIvL3vPC/cV/yIqI=;
  b=JFutFMlEXQj4Ik3vmFcmSxvzlTpSCnoXFJKhzB7jn2Va5vAUoRSNE3hT
   6eVTlLnG+x2m2bfY0VACnluLrYZSRKflSlR2sDPtIR3xmOAEf9YPLPT++
   BcnoOHcbiAmz37chcjs39YONCbIxPynEXcO9u8K5vl/nMdVwT1NMiqdxO
   xBhEvpg2oD0IDo5U0uS6M+iNcKv5D2BsnenwzaEbBXgGFirGgXWih4n9N
   FM8zTi/OLs9cd2pzrxb+D/RMiObUG33GisCxrZq3InyMZO+of6h4BkDCI
   fK3IAXRWS8enZEqwWZMSj78GwdsjQEpTxF5ChZOP4QjJtkhkYilz7RuwA
   Q==;
IronPort-SDR: 3D9ztP36IlKFWadXfPM2MkLYOmGgK6qkHF7krwn55t2zdK/xtPPl6hkHJkP3JGlYrpKB+xHsE1
 K7Kck1EhEA4kXyPvY+VPbVVn3GuywioinswjVdu1WAJ/0zrFOBrEtfE7LoLJjKSi/1GqlhnOI/
 xcW444Vdi0+CBtbTRa8xQUqYDagFcN9y1n6JtkjADQH9xgchGaFEsvhAJ1x31Al8qruyquFM3o
 hRh9JX8FG6yOd7W4Q9sOhWnDqQEbPU68yB2w758jd4b78+z5Vag9bnbdRYoMkFB0GtY/dCeGLX
 5eY=
X-IronPort-AV: E=Sophos;i="5.77,425,1596492000"; 
   d="scan'208";a="14495663"
Date:   Wed, 28 Oct 2020 10:09:20 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Greg KH <gregkh@linuxfoundation.org>, <sudeep.dutt@intel.com>
CC:     Sherry Sun <sherry.sun@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "fugang.duan@nxp.com" <fugang.duan@nxp.com>
Subject: Re: [PATCH V5 0/2] Change vring space from nomal memory to dma
 coherent memory
Message-ID: <20201028090920.xaryai7bnknxphqf@axis.com>
References: <20201028020305.10593-1-sherry.sun@nxp.com>
 <20201028055836.GA244690@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201028055836.GA244690@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 06:58:36AM +0100, Greg KH wrote:
> Have you all seen:
> 	https://lore.kernel.org/r/8c1443136563de34699d2c084df478181c205db4.1603854416.git.sudeep.dutt@intel.com

No, that link doesn't work and I can't find that email from Sudeep in
any of the archives:

 https://lore.kernel.org/lkml/?q=f%3Asudeep.dutt%40intel.com

Sudeep, perhaps you could try to resend the patch?  Thank you.
