Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4477521E41A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 01:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGMX7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 19:59:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:1426 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgGMX7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:59:52 -0400
IronPort-SDR: jRdCxX3ddymZcPJEyNQvFvJOsYdGtlfDAzPZQSpm93aRHS9GyKIQ0RqDMWjh4ZkmFIi3Xcs7IU
 4mRuNio582Ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="166868034"
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="166868034"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 16:59:52 -0700
IronPort-SDR: qsq2yBxR10pHB8Lc3k1Zz2JLNOxTDE7i6V0nEudebYj9gL7zHColkwU/hLJQXtOdLFs3uUDg+9
 ePL24yhzEo0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="269856299"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jul 2020 16:59:52 -0700
Date:   Mon, 13 Jul 2020 16:59:42 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Brendan Shanks <bshanks@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, ebiederm@xmission.com,
        andi@notmuch.email, Babu.Moger@amd.com
Subject: Re: [PATCH v5] x86/umip: Add emulation/spoofing for SLDT and STR
 instructions
Message-ID: <20200713235942.GA28683@ranerica-svr.sc.intel.com>
References: <20200710224525.21966-1-bshanks@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710224525.21966-1-bshanks@codeweavers.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 03:45:25PM -0700, Brendan Shanks wrote:
> Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
> processes.
> 
> Wine users have found a small number of Windows apps using SLDT that
> were crashing when run on UMIP-enabled systems.
> 
> Reported-by: Andreas Rammhold <andi@notmuch.email>
> Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>

FWIW, tested on hardware with UMIP.

Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Thanks and BR,
Ricardo
