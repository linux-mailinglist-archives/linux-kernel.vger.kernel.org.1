Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A012F514F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbhAMRna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:43:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:4356 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbhAMRna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:43:30 -0500
IronPort-SDR: Kp69nqHSG3+b3kXR6/WJ8obMWLHWNQyQBjgXNBSOaD1aX5uTbJTlTpcfgv0A7cYmmMoO+3lPjZ
 DdvwR0axAK6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="196884514"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="196884514"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 09:42:49 -0800
IronPort-SDR: qE6Ke/otCVTeeWsTZXNl2dRdYO0gk4NNCbCcsk4w9OY0CIOeG0lyKCpfcYJaEiF0MGQSDO6eED
 edk9vJA2+cjA==
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="353565688"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 09:42:49 -0800
Date:   Wed, 13 Jan 2021 17:42:42 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        gustavo@embeddedor.com, rdunlap@infradead.org,
        reinette.chatre@intel.com
Subject: Re: [PATCH V4] arch: kernel: cpu: x86/resctrl:  Takes a letter away
 and append a colon to match below struct member
Message-ID: <X/8xEq6jJGgXzPFO@otcwcpicx3.sc.intel.com>
References: <20210113020333.29803-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113020333.29803-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 07:33:33AM +0530, Bhaskar Chowdhury wrote:
> s/kernlfs/kernfs/
> s/@mon_data_kn/@mon_data_kn:/

May change the message to describe the problems like:

Fix typo "kernlfs" and add missing ":" to match with other comments.

> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
> Changes from V3: Fix the subject line typo stuc to struct and mention cpu architecture
> 

Please read Documentation/process/submitting-patches.rst.
It talks about the subject, description of problem, changelog, etc
for submitting a patch.

Thanks.

-Fenghua
