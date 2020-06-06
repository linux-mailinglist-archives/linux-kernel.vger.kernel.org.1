Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB71F0816
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 20:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgFFSKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jun 2020 14:10:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:38522 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbgFFSKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 14:10:04 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 056I9CBj006803;
        Sat, 6 Jun 2020 13:09:12 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 056I9AdG006802;
        Sat, 6 Jun 2020 13:09:10 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 6 Jun 2020 13:09:10 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-nvdimm@lists.01.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v10 6/6] powerpc/papr_scm: Implement support for PAPR_PDSM_HEALTH
Message-ID: <20200606180910.GW31009@gate.crashing.org>
References: <20200604234136.253703-1-vaibhav@linux.ibm.com> <20200604234136.253703-7-vaibhav@linux.ibm.com> <20200605183655.GP1505637@iweiny-DESK2.sc.intel.com> <87wo4kfk58.fsf@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo4kfk58.fsf@linux.ibm.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 06, 2020 at 06:04:11PM +0530, Vaibhav Jain wrote:
> >> +	/* update health struct with various flags derived from health bitmap */
> >> +	health = (struct nd_papr_pdsm_health) {
> >> +		.dimm_unarmed = p->health_bitmap & PAPR_PMEM_UNARMED_MASK,
> >> +		.dimm_bad_shutdown = p->health_bitmap & PAPR_PMEM_BAD_SHUTDOWN_MASK,
> >> +		.dimm_bad_restore = p->health_bitmap & PAPR_PMEM_BAD_RESTORE_MASK,
> >> +		.dimm_encrypted = p->health_bitmap & PAPR_PMEM_ENCRYPTED,
> >> +		.dimm_locked = p->health_bitmap & PAPR_PMEM_SCRUBBED_AND_LOCKED,
> >> +		.dimm_scrubbed = p->health_bitmap & PAPR_PMEM_SCRUBBED_AND_LOCKED,
> >
> > Are you sure these work?  These are not assignments to a bool so I don't think
> > gcc will do what you want here.
> Yeah, somehow this slipped by and didnt show up in my tests. I checked
> the assembly dump and seems GCC was silently skipping initializing these
> fields without making any noise.

It's not "skipping" that, it initialises the field to 0, just like your
code said it should :-)

If you think GCC should warn for this, please open a PR?  It is *normal*
for bit-fields to be truncated from what is assigned to it, but maybe we
could warn for it in the 1-bit case (we currently don't seem to, even
when the bit-field type is _Bool).

Thanks,


Segher
