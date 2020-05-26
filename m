Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A01BAFC7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 22:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgD0Uvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 16:51:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:30236 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgD0Uvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:51:47 -0400
IronPort-SDR: 6fgNlV5v213iuEbC0nf+y43R+9SrMHbU97rvrXcwpv8+p1tyLcDGN3lxBBcP+BBCPIpTZ/tu2e
 HM/7JynLkqCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 13:51:47 -0700
IronPort-SDR: OzjFzowdiAAi7ko+rI7XAZrtRA1KQSqppc5kR0KuQeUaV/9XsuF+JR/9ixe+1kaIKzk5G/F4YW
 jqykhlmsh48Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="275604013"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 27 Apr 2020 13:51:46 -0700
Date:   Mon, 27 Apr 2020 13:50:51 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 4/7] x86/msr-index: Define IA32_PASID MSR
Message-ID: <20200427205050.GE242333@romley-ivt3.sc.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com>
 <1585596788-193989-5-git-send-email-fenghua.yu@intel.com>
 <87sggqsd9j.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sggqsd9j.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 01:22:00PM +0200, Thomas Gleixner wrote:
> Fenghua Yu <fenghua.yu@intel.com> writes:
> 
> > The IA32_PASID MSR (0xd93) contains the Process Address Space Identifier
> > (PASID), a 20-bit value. Bit 31 must be set to indicate the value
> > programmed in the MSR is valid. Hardware uses PASID to identify which
> > process submits the work and direct responses to the right process.
> 
> No. It does not identify the process. It identifies the process' address
> space as the name says.
> 
> Please provide coherent and precise information.

Ok. Will change to address space identification.

Thanks.

-Fenghua
