Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3FE2B051C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgKLMnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:43:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:60504 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgKLMnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:43:50 -0500
IronPort-SDR: otbR1JLwLu1RBxt6bzxquAa1N3WDBUkrkQLoC7YsQkjB5q1cpoqinH1jMkBAwv857eZKizHW2j
 2geA9X9OjzVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="167717469"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="167717469"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 04:43:48 -0800
IronPort-SDR: fsFIy+cgjj5mCIALl4pFdwQtH9jpbeYRKJ+LkG20X3MmxlB61B5wkqSOhDDYdp7CfF7ZMlVneK
 4/3UU/iW/AwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="429188768"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 12 Nov 2020 04:43:46 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 12 Nov 2020 14:43:45 +0200
Date:   Thu, 12 Nov 2020 14:43:45 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3 2/2] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <20201112124345.GS1224435@kuha.fi.intel.com>
References: <20201023214328.1262883-1-pmalani@chromium.org>
 <20201023214328.1262883-2-pmalani@chromium.org>
 <20201110115453.GI1224435@kuha.fi.intel.com>
 <20201112024055.GA1367855@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112024055.GA1367855@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 06:40:55PM -0800, Prashant Malani wrote:
> Hi Heikki,
> 
> On Tue, Nov 10, 2020 at 01:54:53PM +0200, Heikki Krogerus wrote:
> > On Fri, Oct 23, 2020 at 02:43:28PM -0700, Prashant Malani wrote:
> > 
> > I've now come to the conclusion that this is not the correct approach.
> > Instead, the whole identity, all six VDOs, should be supplied
> > separately with a "raw" sysfs attribute file after all.
> > 
> > The three attribute files that we already have - so id_header,
> > cert_stat and product - can always supply the actual VDO as is,
> > regardless of the product type, so they are fine. But these new
> > attribute files, product_type_vdoX, would behave differently as they
> > supply different information depending on the product type. That just
> > does not feel right to me.
> 
> OOI: I'd like to understand the reservations around this approach. Can't
> userspace just read these and then interpret them appropriately according
> to the id_header as well as PD revision (and version number) if that's exposed?
> The only thing I see changing is how we name those product_type_vdoX
> sysfs files, i.e product_type_vdo0 == passive_cable_vdo OR active_cable_vdo1
> depending on the product type.
> 
> That said, perhaps I'm missing some aspect of this.

I don't think the userspace should have to interpret any of these
VDOs. If the userspace has to interpret the information, then the
userspace should interpret everything for the sake of consistency (so
the "raw" attribute file).

But I still think that defining separate device types for every
product type would be the best way to handle the identity. We could
then have sysfs attribute files that are specific for each product
type. It does not even matter that some of the product types are going
to be removed. We will have to handle all of them in any case,
including the ones that were removed. This way things would be much
more clear for the userspace.

The only problem IMO with the separate device types for each product
type is that we don't always have access to the Discover Identity
result. It means depending on your system we will claim the
partner device type is "default" (no identity information) or the
actual product type. That is also a bit inconsistent, but is is
acceptable? I would really like to here what Greg thinks about all
this.

> > So lets just add the "raw" sysfs attribute file. We can think about
> > extracting some other details from the product type VDOs once the
> > specification has settled down a bit and we can be quite certain that
> > those details will always be available.
> > 
> > Would this be OK to you? I think we should be able to dump the data to
> > the "raw" sysfs attribute file with something like hex_dump_to_buffer().
> 
> FWIW, "raw" option SGTM (the product type VDOs can be parsed from the
> buffer since the format is fixed).

Well, I'm starting to think that what if we just prepare patches where
we propose separate device type for every product type? Of course, if
they are OK to you?


thanks,

-- 
heikki
