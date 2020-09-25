Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BA727816B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgIYHW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:22:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:38420 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbgIYHW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:22:29 -0400
IronPort-SDR: vcs10zRlHQTra3oCaoxB4U23pCPmuOKyN5cYe9uY3Ws9bE0B7z5QkjyFXPYqdeknqJ8pdxqLS9
 yApBr3xyPVcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="158812855"
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="158812855"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 00:22:28 -0700
IronPort-SDR: xRGeQaMP4MSN19+92GBWi587nSfcwAjwliO/2PrbY2eFIvoMIScjBSPDfh9Ckj4exm4+KKYwuo
 WQf4g1xF9Ofw==
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="487356474"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 00:22:25 -0700
Date:   Fri, 25 Sep 2020 15:22:24 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20200925072224.GE15894@shbuild999.sh.intel.com>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
 <51821d92-8c77-7661-5cf6-bd5dbe0cdbaf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51821d92-8c77-7661-5cf6-bd5dbe0cdbaf@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 12:38:30PM -0700, Dave Hansen wrote:
> On 9/21/20 10:27 PM, Feng Tang wrote:
> > +static void parse_text(void)
> > +{
> > +	FILE *file;
> > +	char *line = NULL;
> > +	size_t len = 0;
> > +	int ret;
> > +
> > +	file = fopen("cpuid.txt", "r");
> > +	if (!file) {
> > +		printf("Error in opening 'cpuid.txt'\n");
> > +		return;
> > +	}
> 
> This mostly looks fine to me.  A few things about cpuid.txt, though...
> It needs to be read out of *some* location which is not the current
> directory.  Maybe:
> 
> 	/usr/share/hwdata/cpu.ids

Good point! User won't run it inside a kernel source tree folder. And yes,
there are already similar pci.ids and usb.ids in the same folder, we coud 
do this in the 'install' part of Makefile

> or something.  It also needs a "-f" argument to override this default
> location. 

Ok, will add.

> I don't know if there's a better per-kernel place to put this
> file, though.

Device tree's dtb file may be similar, but it's also outside of bzImage.

Thanks,
Feng
