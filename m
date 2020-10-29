Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942BC29F8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 00:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgJ2XLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 19:11:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:59186 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ2XLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 19:11:49 -0400
IronPort-SDR: ibVbVr6CDrKseBbH63J9SbOSWgbLymGjmXX7yFCpflfNd9gEAuRVUx7GXdqTGmHQSQOANBlVNC
 Pai2tojomq2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="186327158"
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="186327158"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 16:11:48 -0700
IronPort-SDR: JolEFaBDlx2IAtLQIJnyJ/QvJL78z2UIBQqS/pGEKimxJAKqI5TAAhCptY1J5KES9mWq8YvQCO
 UNRb+DsyLfZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; 
   d="scan'208";a="526911580"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga005.fm.intel.com with ESMTP; 29 Oct 2020 16:11:47 -0700
Date:   Fri, 30 Oct 2020 07:09:20 +0800
From:   Philip Li <philip.li@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [Build fail] i386 & nvdimm is unhappy
Message-ID: <20201029230920.GA32559@intel.com>
References: <87sg9wodp1.fsf@nanos.tec.linutronix.de>
 <CAPcyv4hBSwdDocpgFh2=qbVQN=Mc+15cW4cV5m_S-SxVCYY=mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hBSwdDocpgFh2=qbVQN=Mc+15cW4cV5m_S-SxVCYY=mA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:52:42PM -0700, Dan Williams wrote:
> On Thu, Oct 29, 2020 at 3:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Dan,
> >
> > x86 32bit build fails with the config below with this:
> >
> >   ERROR: modpost: "phys_to_target_node" [drivers/nvdimm/nd_e820.ko]
> >   undefined!
> 
> Acknowledged, I'm on it.
> 
> Wonder how 0-day missed this or I missed the 0-day report?
Sorry about this Dan. Can you share some info like which kconfig and bad commit?
We will investigate this to provide update in earliest time.

Thanks

> 
