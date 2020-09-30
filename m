Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115E127DEE9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 05:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgI3DUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 23:20:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:26996 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgI3DUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 23:20:01 -0400
IronPort-SDR: DFiK/akRMQSrXTdBCOSrE9PJmAdFVz3bcpT62m3XUYEGhN2fuqnOmvtR0Uieg90YDSdbqAYEOB
 fpNeamSvfcSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="150006803"
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="150006803"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 20:19:57 -0700
IronPort-SDR: R5ndLVjh4n4owuZfDaSMx+qaaVsnhnBSI3csNnLVfCfApQ4tyT5Pd9m6FwwR+Imjnq9muqhYUA
 DKZzkFmnIHmQ==
X-IronPort-AV: E=Sophos;i="5.77,320,1596524400"; 
   d="scan'208";a="457502301"
Received: from xinpan-mobl.ger.corp.intel.com (HELO localhost) ([10.249.35.239])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 20:19:54 -0700
Date:   Wed, 30 Sep 2020 06:19:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH 05/13] x86: Add early TPM1.2/TPM2.0 interface support for
 Secure Launch
Message-ID: <20200930031952.GA880396@linux.intel.com>
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <1600959521-24158-6-git-send-email-ross.philipson@oracle.com>
 <20200925054313.GB165011@linux.intel.com>
 <bf1d8df9-ec79-2cc6-534f-ce1f0a58f123@apertussolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1d8df9-ec79-2cc6-534f-ce1f0a58f123@apertussolutions.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 07:47:52PM -0400, Daniel P. Smith wrote:
> TrenchBoot's AMD Secure Loader (LZ). The former is not well supported
> and the latter will be getting maintenance under TB. While this is not
> preferred, we had to weigh this versus trying to convince you and the
> other TPM driver maintainers on a significant refactoring of the TPM
> driver. It was elected for the reuse of a clean implementation that can
> be replaced later if/when the TPM driver was refactored. When we
> explained this during the RFC and it was not rejected, therefore we
> carried it forward into this submission.

What does it anyway mean when you say "RFC was not rejected"? I don't
get the semantics of that sentence. It probably neither was ack'd,
right? I do not really care what happened with the RFC. All I can say
is that in the current state this totally PoC from top to bottom.

> > How it is now is never going to fly.
> 
> We would gladly work with you and the other TPM maintainers on a
> refactoring of the TPM driver to separate core logic into standalone
> files that both the driver and the compressed kernel can share.

Yes, exactly. You have to refactor out the common parts. This is way too
big patch to spend time on giving any more specific advice. Should be in
way smaller chunks. For (almost) any possible, this is of unacceptable
size.

I think that it'd be best first to keep the common files in
drivers/char/tpm and include them your code with relative paths in the
Makefile. At least up until we have clear view what are the common
parts.

You might also want to refactor drivers/char/tpm/tpm.h and include/linux
TPM headers to move more stuff into include/linux.

If you are expecting a quick upstreaming process, please do not. This
will take considerable amount of time to get right.

/Jarkko
