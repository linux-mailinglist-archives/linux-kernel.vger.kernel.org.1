Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127F127A73D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgI1GJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgI1GJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:09:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE9FC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 23:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aw4pRYiYvqKb9CqL1fOdwuFrelAGzWk2KMmcVrRrmi8=; b=g1+aFNJmve6tvgXHkY+T6EVjPy
        ULo9M14UoBvX2bIX+TdPOJuND5mWlbuAVm18mqx6g+IoUNs3rDuNrZ4ltcpCSeZiM8zJzyrsk6Jqs
        VWdVWmVm2fKR8ityFsyTABRq43CY9d0bXADX4xRZTTl1eimmIluBajmPwqdHvuXROUxOlwCx96qRB
        bh1iqsibcL8YEnFYp/0gnV0MkQNVNtE4Iqopnq6RqxsuXF74WfZdjNyL6ZntsP9Zs9XqU2ZTwe2lw
        cn45p2ETIZ2Vmtg2eBziW0YxOa2tJEGUavWUf7KTm5b7LTK8dC1EFVnCWLDq+g84c1SRK8n77wR6y
        1vH8p1xA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMmLd-0002Ux-J0; Mon, 28 Sep 2020 06:09:17 +0000
Date:   Mon, 28 Sep 2020 07:09:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 4/5] misc: vop: set VIRTIO_F_ACCESS_PLATFORM for
 nocoherent platform
Message-ID: <20200928060917.GB9387@infradead.org>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-5-sherry.sun@nxp.com>
 <20200926075123.GB18592@infradead.org>
 <VI1PR04MB49604A96195B07032826B0AA92340@VI1PR04MB4960.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB49604A96195B07032826B0AA92340@VI1PR04MB4960.eurprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 08:05:07AM +0000, Sherry Sun wrote:
> Hi Christoph,
> 
> > On Fri, Sep 25, 2020 at 03:26:29PM +0800, Sherry Sun wrote:
> > > Set VIRTIO_F_ACCESS_PLATFORM feature for nocoherent platform, since it
> > > needs the DMA API for virtio.
> > 
> > Given that VOP is a plug-in PCIe card VIRTIO_F_ACCESS_PLATFORM must
> > always be set, as the DMA mapping details are not something the virtio
> > implementation decides on, but the host PCIe/iommu implementation.
> 
> So do you mean that we should remove the check, and set VIRTIO_F_ACCESS_PLATFORM feature directly?

Yes.  In a separate prep patch.
