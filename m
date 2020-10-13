Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF528C768
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 04:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgJMC6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 22:58:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:18795 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgJMC6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 22:58:04 -0400
IronPort-SDR: Z3sJDwqksEqUf/+z1yTkDWQgYfSNdidXA37ssge+Bv5BZhYes1YSHszfyoNL6xlqUQyrA2azmN
 ZuuMaPzdnvVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="145700908"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="145700908"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 19:58:03 -0700
IronPort-SDR: PgN1QHkF1ECd6pUAQa4AYnu7a3wbWhvQblnD8nNXKQH7af1wXHJ7EsJkPElMICcY2PBHsnmocg
 Kc+n6RZcfi6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="345110900"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 12 Oct 2020 19:58:03 -0700
Date:   Tue, 13 Oct 2020 02:58:02 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 1/2] Documentation: x86: Rename resctrl_ui.rst and add
 two errata to the file
Message-ID: <20201013025802.GA700551@otcwcpicx6.sc.intel.com>
References: <20201013024656.700492-1-fenghua.yu@intel.com>
 <20201013024656.700492-2-fenghua.yu@intel.com>
 <30bf0281-4680-0a6a-b06b-d86633f534ad@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30bf0281-4680-0a6a-b06b-d86633f534ad@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Randy,

On Mon, Oct 12, 2020 at 07:54:32PM -0700, Randy Dunlap wrote:
> On 10/12/20 7:46 PM, Fenghua Yu wrote:
> > diff --git a/Documentation/conf.py b/Documentation/conf.py
> > index c503188880d9..b5b2be8eec22 100644
> > --- a/Documentation/conf.py
> > +++ b/Documentation/conf.py
> > @@ -36,7 +36,7 @@ needs_sphinx = '1.3'
> >  # Add any Sphinx extension module names here, as strings. They can be
> >  # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
> >  # ones.
> > -extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
> > +extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
> >                'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
> >                'maintainers_include', 'sphinx.ext.autosectionlabel' ]
> 
> Hi,
> I don't see this change described in the patch description.
> Should it be here?

My bad. I forgot to remove this change. I will remove it in v3.

Thank you for your review!

-Fenghua
