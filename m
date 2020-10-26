Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2278298528
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 01:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420913AbgJZAk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 20:40:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:38839 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1419148AbgJZAj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 20:39:57 -0400
IronPort-SDR: nZUK7amPIaJy5hxBO08W6lQD4PlZNqmOPMlxocHOruDKmiTsAxiWqPnjPb/tBNi0Shei5r//oj
 Q1RoJVo8JPIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9785"; a="147720108"
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="147720108"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2020 17:39:56 -0700
IronPort-SDR: kk4/u03Svf9CouLivIiEfjeC1MbwHD4xeDi5HkGJacsX/2EFQWOIx2yZM2sVZ4nHsW4VNnrXWL
 1ly0ER9dWGqQ==
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="467730757"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2020 17:39:53 -0700
Date:   Mon, 26 Oct 2020 08:39:51 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>
Subject: Re: [PATCH v5 00/17] HSM driver for ACRN hypervisor
Message-ID: <20201026003951.GC12408@shuo-intel.sh.intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <3caf45a7-29f8-09cb-035b-44d453262f97@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3caf45a7-29f8-09cb-035b-44d453262f97@intel.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Wed 21.Oct'20 at  8:19:10 -0700, Dave Hansen wrote:
>How widely is ACRN used?  It is some little Intel toy hypervisor, or is
>it already seeing broad use in the world?  This, for instance, seems to
>have a backport:
>
>	https://github.com/teslamotors/linux/tree/intel-4.14

So far as i know, ACRN is not widely used now. But it indeed has a
commercial IVI (In-Vehicle Infotainment) product "Chery EXEED" [1].
Today ACRN also has several design wins in industrial domain. For tree
of teslamotors, we were unaware. I think teslamotors' tree was derived
from [2].

Thanks
shuo

[1] https://projectacrn.org/acrn-project-chery-exeed-launch/
[2] https://github.com/projectacrn/acrn-kernel
