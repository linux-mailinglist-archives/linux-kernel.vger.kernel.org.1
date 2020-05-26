Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61FB1D4989
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 11:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgEOJ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 05:29:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:12703 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgEOJ3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:29:11 -0400
IronPort-SDR: d+jTClX5I0+L5e8W3uS9auM09vExF6e61j2kF0OVqMIdh6ax9ZfjrdtH5Y1L3Q/AGnn+3jNVUQ
 5yEhufWYMwBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 02:29:11 -0700
IronPort-SDR: zgcyaOJzmdHEPg9rE9q61hQ8kEuO3zkyxDgVzKRV6TU7FG25D9MqCP+h8YFquR2iICtuA4jfoJ
 hVVhQakx9Gqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,394,1583222400"; 
   d="scan'208";a="464664998"
Received: from mgpinon-mobl.ger.corp.intel.com ([10.252.55.74])
  by fmsmga005.fm.intel.com with ESMTP; 15 May 2020 02:29:03 -0700
Message-ID: <666f4c3865fcd92e7d5c8437e69399cb55fb88a9.camel@linux.intel.com>
Subject: Re: [PATCH v29 00/20] Intel SGX foundations
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "Dr. Greg" <greg@enjellic.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-sgx@vger.kernel.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, kai.svahn@intel.com,
        josh@joshtriplett.org, luto@kernel.org, kai.huang@intel.com,
        rientjes@google.com, cedric.xing@intel.com, puiterwijk@redhat.com
In-Reply-To: <20200514162054.GE9266@zn.tnic>
References: <20200421215316.56503-1-jarkko.sakkinen@linux.intel.com>
         <20200426165753.GA11046@wind.enjellic.com>
         <87d07gk24l.fsf@nanos.tec.linutronix.de>
         <20200508190226.GA31465@wind.enjellic.com>
         <20200508195635.GR27052@linux.intel.com>
         <20200514091637.GA25156@wind.enjellic.com>
         <20200514161559.GA15603@linux.intel.com> <20200514162054.GE9266@zn.tnic>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Fri, 15 May 2020 12:28:54 +0300
User-Agent: Evolution 3.36.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-14 at 18:20 +0200, Borislav Petkov wrote:
> On Thu, May 14, 2020 at 09:15:59AM -0700, Sean Christopherson wrote:
> > I'm not opposed to adding a kernel param to disable SGX.  At one point
> > there was a proposal to extend clearcpuid to allow disabling multiple
> > feature bits, but it looks like that went the way of the dodo.
> > 
> > Note, such a param would disable SGX entirely, e.g. clear the feature bit
> > in /proc/cpuinfo and prevent any in-kernel SGX code from running.
> 
> It is a usual practice for big features like SGX to add a
> "nosgx" cmdline param to disable it in case something goes
> south. We do this for all features - see all "no*" switches in
> Documentation/admin-guide/kernel-parameters.txt

Uh oh, should probably address this. Should I send v31 today with a "nosgx"
patch added? Sorry for missing this one :-/

/Jarkko

