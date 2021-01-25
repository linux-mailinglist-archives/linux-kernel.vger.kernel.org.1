Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC02302E73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbhAYV4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:56:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:26851 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732997AbhAYVzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:55:38 -0500
IronPort-SDR: UgOAQ2Y37DwEde+wVNrP0TURWnN3HvHbtZed8Ocsh+EIr0M2mu0jUnHaciASBVhMtvr9+loMh/
 HVSUItaKtTmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="243888423"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="243888423"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 13:54:54 -0800
IronPort-SDR: I0+abZd4zAGdotiSlfcecsXBkdivRWAlN7K4u+lcuJ5kiSV7XWRH6RtTDJ+je+J4PMCTYaM2zB
 HLyUCXxXEODQ==
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="350447758"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 13:54:53 -0800
Date:   Mon, 25 Jan 2021 21:54:52 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        David Binderman <dcb314@hotmail.com>,
        Babu Moger <babu.moger@amd.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/17] Miscellaneous fixes for resctrl selftests
Message-ID: <YA8+LHYEM12DgJhf@otcwcpicx3.sc.intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
 <YA8uZYiGFzee+UHD@otcwcpicx3.sc.intel.com>
 <1d4c6c2c-55a7-d55d-e859-c2eccee25383@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d4c6c2c-55a7-d55d-e859-c2eccee25383@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 02:52:09PM -0700, Shuah Khan wrote:
> On 1/25/21 1:47 PM, Fenghua Yu wrote:
> > On Mon, Nov 30, 2020 at 08:19:53PM +0000, Fenghua Yu wrote:
> > > This patch set has several miscellaneous fixes to resctrl selftest tool
> > > that are easily visible to user. V1 had fixes to CAT test and CMT test
> > > but they were dropped in V2 because having them here made the patchset
> > Just a friendly reminder. Will you push this series to the upstream?
> > Maybe I miss something but I don't see this series in the linux-kselftest
> > tree yet.
> > 
> 
> Sorry I am a bit behind on reviews. I will pull these fixes in this
> week for 5.12-rc1 and will let you know if I would like changes.

Really appreciate your help, Shuah!

-Fenghua
