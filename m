Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48761F5D72
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 22:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgFJU7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 16:59:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:4960 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgFJU7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:59:05 -0400
IronPort-SDR: WxA5p+uoDmJ4VbcbauXeav2YNxWknxvvaDV3hwkoVig2EQ7jrnddJ/iNA/+K3jMwtDscNtbOfF
 3+WWzun7nn4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 13:59:05 -0700
IronPort-SDR: /gWmaGFNqAeq/bzL2INUDgjRonw+XaBkidyl7xPn2/YlxAIu2XcIOhW96YY0r+CzZeyK0a0yhH
 shT4W2sQryag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,497,1583222400"; 
   d="scan'208";a="473566824"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jun 2020 13:59:04 -0700
Date:   Wed, 10 Jun 2020 13:59:03 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v32 00/21] Intel SGX foundations
Message-ID: <20200610205903.GF18790@linux.intel.com>
References: <20200601075218.65618-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601075218.65618-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 10:51:57AM +0300, Jarkko Sakkinen wrote:
> v29:
> * The selftest has been moved to selftests/sgx. Because SGX is an execution
>   environment of its own, it really isn't a great fit with more "standard"
>   x86 tests.
> 
>   The RSA key is now generated on fly and the whole signing process has
>   been made as part of the enclave loader instead of signing the enclave
>   during the compilation time.
> 
>   Finally, the enclave loader loads now the test enclave directly from its
>   ELF file, which means that ELF file does not need to be coverted as raw
>   binary during the build process.

Something in the above rework broke the selftest.  I'm getting intermittent
EINIT failures with SGX_INVALID_SIGNATURE.  I'm guessing it's related to
the dynamic RSA key generation, e.g. only ~15% of runs fail.  Verified that
v29 selftest fails and v28 passes.  My internal tests also pass, i.e. it's
all but guaranteed to be a selftest issue, not a kernel issue.

Jarkko, I don't have bandwidth to dig into this right now, hopefully this
reproduces in your environment.  Let me know if that's not the case.
