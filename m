Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4F02C49CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 22:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbgKYVSM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Nov 2020 16:18:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:38284 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730457AbgKYVSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:18:11 -0500
IronPort-SDR: ceNgzn/C/aLEiujR1OjKKT0PYCR8V5KQmNeSGI4e0X/ecUiv1hFM1UNTtbxQjhhqMxDa46wBt4
 uuL3P6fYFHzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="256910827"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="256910827"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 13:18:11 -0800
IronPort-SDR: XvNnUUZ7cV5LVdmcE96fR6Y0baljMYMvE3vFkskYGCNjtsGLOZbFBQP1W5iN69XUpbU4CzSDj2
 W/wk5Qg5ZleQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="333144215"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 25 Nov 2020 13:18:11 -0800
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 25 Nov 2020 13:18:10 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Nov 2020 05:18:07 +0800
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Wed, 25 Nov 2020 23:18:04 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wang, Yu1" <yu1.wang@intel.com>,
        "Liu, Shuo A" <shuo.a.liu@intel.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Subject: RE: [char-misc-next 13/13] mei: virtio: virtualization frontend
 driver
Thread-Topic: [char-misc-next 13/13] mei: virtio: virtualization frontend
 driver
Thread-Index: AQHWw28j9RGT1SK8L0Gh4X46OdrLTqnZWXgg
Date:   Wed, 25 Nov 2020 21:18:04 +0000
Message-ID: <7f6181d8e80d4efb9464e9ec436800b7@intel.com>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
 <20200818115147.2567012-14-tomas.winkler@intel.com>
 <20201125160326-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201125160326-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Tue, Aug 18, 2020 at 02:51:47PM +0300, Tomas Winkler wrote:
> > +#ifndef VIRTIO_ID_MEI
> > +#define VIRTIO_ID_MEI 0xFFFE /* virtio mei */ #endif
> 
> Just noticed now that this driver landed upstream.  Can I ask that you guys
> please register IDs with the virtio TC and not just pick a number at random?
> In particular this is way outside allowed range.
> 
> IDs should also be listed in include/uapi/linux/virtio_ids.h
> 
> If people just pick random numbers like this collistions are unavoidable.
> 
> List of IDs is part of virtio spec, chapter "Device Types".
> 
> Please do this change now before this goes out to production!
Okay,  this was assigned by ACRN, my impression was it's already registered.
Will take care of.
Thanks
Tomas

