Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136401CFB57
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 18:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgELQwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 12:52:15 -0400
Received: from wind.enjellic.com ([76.10.64.91]:43770 "EHLO wind.enjellic.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgELQwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:52:14 -0400
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 04CGpPiZ024098;
        Tue, 12 May 2020 11:51:25 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 04CGpOTZ024097;
        Tue, 12 May 2020 11:51:24 -0500
Date:   Tue, 12 May 2020 11:51:24 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     "Hui, Chunyang" <sanqian.hcy@antfin.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com
Subject: Re: [PATCH v29 00/20] Intel SGX foundations
Message-ID: <20200512165124.GA24058@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20200421215316.56503-1-jarkko.sakkinen@linux.intel.com> <20200512115551.GA84010@sanqian-dev-0.10.0>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512115551.GA84010@sanqian-dev-0.10.0>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Tue, 12 May 2020 11:51:25 -0500 (CDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 07:55:58PM +0800, Hui, Chunyang wrote:

> > You can tell if your CPU supports SGX by looking into /proc/cpuinfo:
> > 
> > 	cat /proc/cpuinfo  | grep sgx
> 
> Tested-by: Chunyang Hui <sanqian.hcy@antfin.com>

> Occlum project (https://github.com/occlum/occlum) is a libOS built
> on top of Intel SGX feature. We ran Occlum tests using patch v29 on
> SGX hardware with the Flexible Launch Control (FLC) feature and
> didn't find any problems.  As Occlum core developers, we would like
> these patches to be merged soon.

Do you use the Intel PSW or your own?

Are you using the standard ECALL interface or did the tests run with
the new VDSO entry and exception handler?

Have a good day.

Dr. Greg

As always,
Dr. Greg Wettstein, Ph.D, Worker      Autonomously self-defensive
Enjellic Systems Development, LLC     IOT platforms and edge devices.
4206 N. 19th Ave.
Fargo, ND  58102
PH: 701-281-1686                      EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"I had far rather walk, as I do, in daily terror of eternity, than feel
 that this was only a children's game in which all of the contestants
 would get equally worthless prizes in the end."
                                -- T. S. Elliot
