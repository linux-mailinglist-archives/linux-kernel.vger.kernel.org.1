Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6561FFD8B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 23:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731380AbgFRVsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 17:48:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49455 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727109AbgFRVsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592516898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dc9heaTCynzHYHV4WlgGjIqZinjw20a4OkBWJ6TlbCw=;
        b=JV9ewt8km1BgAxx8lVQ03VI6iAH6eQEDPAPGTQM6hemG6Xh26HkUaBSRIKszPs/JFDTsTW
        Zvt1/lUheCKtwj+NNBeu/Ly3paPzseuD128yHjVyPewRh43TB1LATj2kRZpZejX7F8GHJ0
        MIHOCTIRiZ5GGQTAHWikfMRKGUlDEvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-S-WrlH3MNkODHHSRJHshhQ-1; Thu, 18 Jun 2020 17:48:14 -0400
X-MC-Unique: S-WrlH3MNkODHHSRJHshhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CA1A464;
        Thu, 18 Jun 2020 21:48:12 +0000 (UTC)
Received: from w520.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09F4A121A2E;
        Thu, 18 Jun 2020 21:48:05 +0000 (UTC)
Date:   Thu, 18 Jun 2020 15:48:05 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 1/3] docs: IOMMU user API
Message-ID: <20200618154805.049219db@w520.home>
In-Reply-To: <MWHPR11MB164595B754BE441255902DCA8C9A0@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200611094741.6d118fa8@w520.home>
        <20200611125205.1e0280d3@jacob-builder>
        <20200611144047.79613c32@x1.home>
        <20200611172727.78dbb822@jacob-builder>
        <20200616082212.0c1611dd@jacob-builder>
        <DM5PR11MB1435DD578488DA08A1E699ACC39A0@DM5PR11MB1435.namprd11.prod.outlook.com>
        <MWHPR11MB164595B754BE441255902DCA8C9A0@MWHPR11MB1645.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 08:28:24 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Wednesday, June 17, 2020 2:20 PM
> >   
> > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Sent: Tuesday, June 16, 2020 11:22 PM
> > >
> > > On Thu, 11 Jun 2020 17:27:27 -0700
> > > Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> > >  
> > > > >
> > > > > But then I thought it even better if VFIO leaves the entire
> > > > > copy_from_user() to the layer consuming it.
> > > > >  
> > > > OK. Sounds good, that was what Kevin suggested also. I just wasn't
> > > > sure how much VFIO wants to inspect, I thought VFIO layer wanted to do
> > > > a sanity check.
> > > >
> > > > Anyway, I will move copy_from_user to iommu uapi layer.  
> > >
> > > Just one more point brought up by Yi when we discuss this offline.
> > >
> > > If we move copy_from_user to iommu uapi layer, then there will be  
> > multiple  
> > > copy_from_user calls for the same data when a VFIO container has  
> > multiple domains,  
> > > devices. For bind, it might be OK. But might be additional overhead for TLB  
> > flush  
> > > request from the guest.  
> > 
> > I think it is the same with bind and TLB flush path. will be multiple
> > copy_from_user.  
> 
> multiple copies is possibly fine. In reality we allow only one group per
> nesting container (as described in patch [03/15]), and usually there
> is just one SVA-capable device per group.
> 
> > 
> > BTW. for moving data copy to iommy layer, there is another point which
> > need to consider. VFIO needs to do unbind in bind path if bind failed,
> > so it will assemble unbind_data and pass to iommu layer. If iommu layer
> > do the copy_from_user, I think it will be failed. any idea?

If a call into a UAPI fails, there should be nothing to undo.  Creating
a partial setup for a failed call that needs to be undone by the caller
is not good practice.

> This might be mitigated if we go back to use the same bind_data for both
> bind/unbind. Then you can reuse the user object for unwinding.
> 
> However there is another case where VFIO may need to assemble the
> bind_data itself. When a VM is killed, VFIO needs to walk allocated PASIDs
> and unbind them one-by-one. In such case copy_from_user doesn't work
> since the data is created by kernel. Alex, do you have a suggestion how this
> usage can be supported? e.g. asking IOMMU driver to provide two sets of
> APIs to handle user/kernel generated requests?

Yes, it seems like vfio would need to make use of a driver API to do
this, we shouldn't be faking a user buffer in the kernel in order to
call through to a UAPI.  Thanks,

Alex

