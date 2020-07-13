Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79D21BC44
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgGJRb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 13:31:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:5578 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbgGJRb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:31:57 -0400
IronPort-SDR: YKKXh/gAA+ekFZk0/vqM2im3uLEA8CClM2r1DIkrQoQyxsmufXJZgIe4CYGsRvW78cFfHybPSm
 ZX2s7B2zDR3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="135725518"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="135725518"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 10:31:56 -0700
IronPort-SDR: FcFPPJHbsF3Sawwv4Q5N2TnUc5kA2EADWIOYsjYMOShwW4bXFZ3J4avDdEZBCfo4ud355ZwnD1
 Qsksbff2s4QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="306614586"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2020 10:31:55 -0700
Date:   Fri, 10 Jul 2020 17:31:54 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com, kuo-lang.tseng@intel.com,
        ravi.v.shankar@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 0/4] x86/resctrl: Enable user to view and select
 thread throttling mode
Message-ID: <20200710173154.GA290028@otcwcpicx6.sc.intel.com>
References: <cover.1592841671.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1592841671.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Boris, Thomas and Ingo,

On Mon, Jun 22, 2020 at 09:43:27AM -0700, Reinette Chatre wrote:
> V6 upstream submission available from:
> https://lore.kernel.org/lkml/cover.1589922949.git.reinette.chatre@intel.com
> 
> Patches apply against v5.8-rc2
> base-commit: 48778464bb7d346b47157d21ffde2af6b2d39110
> 
> Changes since V6:
> - Rebase against v5.8-rc2
> - Add Andy's Reviewed-by tag to patch 4

Do you have any comment on this series? Is it possible to push this series
into 5.9?

Thank you very much!

-Fenghua
