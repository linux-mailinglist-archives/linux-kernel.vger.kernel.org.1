Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C615291460
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 22:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438977AbgJQUoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 16:44:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:8463 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438575AbgJQUoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 16:44:00 -0400
IronPort-SDR: GVfuU/vjIQzo54VfwN/sxi7UwmPTWUo6ALEboSRPA/dVs8/mKPIEwdFLci4Jt+uABePWnAnO90
 v8lWUD4RbaIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9777"; a="231022120"
X-IronPort-AV: E=Sophos;i="5.77,388,1596524400"; 
   d="scan'208";a="231022120"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2020 13:43:59 -0700
IronPort-SDR: azrEbX3RBsr8P90LZ41LgQb9ACTLFt+kuhQvuaRF4ay6R+nB3zgFHIoSSvLhweLJ2eOnasEQ6c
 u5EyLDJ82/9A==
X-IronPort-AV: E=Sophos;i="5.77,388,1596524400"; 
   d="scan'208";a="532156923"
Received: from hebenstp-mobl3.ger.corp.intel.com (HELO localhost) ([10.252.54.12])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2020 13:43:48 -0700
Date:   Sat, 17 Oct 2020 23:43:43 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        haitao.huang@intel.com, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, sean.j.christopherson@intel.com,
        tglx@linutronix.de, yaozhangx@google.com, mikko.ylinen@intel.com
Subject: Re: [PATCH v39 00/24] Intel SGX foundations
Message-ID: <20201017204343.GA63732@linux.intel.com>
References: <20201003045059.665934-1-jarkko.sakkinen@linux.intel.com>
 <f5ace1d5-8530-8bfb-9a4c-937355399020@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5ace1d5-8530-8bfb-9a4c-937355399020@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 12:06:52PM -0700, Dave Hansen wrote:
> On 10/2/20 9:50 PM, Jarkko Sakkinen wrote:
> ...
> > You can tell if your CPU supports SGX by looking into /proc/cpuinfo:
> > 
> > 	cat /proc/cpuinfo  | grep sgx
> 
> This is only true *after* applying this series, right?

Yes, that's correct.

/Jarkko
