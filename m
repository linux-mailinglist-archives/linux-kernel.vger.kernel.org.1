Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14492B5BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgKQJiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:38:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:57794 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgKQJiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:38:02 -0500
IronPort-SDR: CmVeAxJX6sCmDwgOnJxM5l3LbrlcKeRBBq+zfAyojWZwSqbL7ttjGDkD5RZ/a/s7yL2PQqqF+D
 he6xXVuHyYlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="188948140"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="188948140"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 01:38:02 -0800
IronPort-SDR: 9Wb/Cym2213UyVcj5mi74cfc0lLAdtzPdRhFanxLYRQnQZ3Z18AHfBKRaupYDmSYGKSFT1Y8Uu
 J8rzXAJQztXw==
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="543972342"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 01:37:59 -0800
Date:   Tue, 17 Nov 2020 17:40:38 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Ashok Raj <ashok.raj@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] x86/microcode/intel: check cpu stepping and
 processor flag before saving microcode
Message-ID: <20201117094038.GA22602@chenyu-office.sh.intel.com>
References: <20201113015923.13960-1-yu.c.chen@intel.com>
 <20201116122735.GA1131@zn.tnic>
 <20201117022518.GA17555@chenyu-office.sh.intel.com>
 <20201117091837.GA5719@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117091837.GA5719@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:18:37AM +0100, Borislav Petkov wrote:
> On Tue, Nov 17, 2020 at 10:25:18AM +0800, Chen Yu wrote:
> > If I understand correctly, the only place that invokes
> > save_mc_for_early() is in generic_load_microcode(). While in
> > generic_load_microcode() only microcode has a newer version will be
> > saved by checking has_newer_microcode(), and this function leverages
> > find_matching_signature() to check if the candidate is of the same
> > signature. So when it comes to save_microcode_patch(), the signature
> > already matches. In case save_mc_for_early() will be invoked by other
> > function in the future, it is okay to add this check too.
> 
> The important aspect is that you need to save in intel_ucode_patch
> the *exact* patch for the CPU you're running on. The code above that
> in save_microcode_patch() adds patches of the same family/model but
> *not* same stepping to the microcode cache in case we want to support
> mixed-stepping revisions. And those you don't need to check for exact
> match.
> 
> What I'd like, however, is to get rid of that mixed-stepping support -
> which is total nonsense anyway, if you ask me - and that would simplify
> the code a *lot* more.
>
Ok, got it, thanks.

Best,
Chenyu
