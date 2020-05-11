Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C1F1CE5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbgEKUmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 16:42:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:16006 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgEKUmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:42:10 -0400
IronPort-SDR: 0Alh/7U06V1VnNuhV0HnOQEz3JcYVhHOgE3p4dOpYkwGeKp0u4yhMBtTBoPHAdY34J5fcZwDH+
 3b8DI+Ksxq+Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 13:42:09 -0700
IronPort-SDR: LKlaG/En1dRbvrwA3mVaKlY2fQ31nZNZngIT2KM3BGpyo5U97izy7vury3TmaJ0w1iZnw9FyLB
 KKvlo8ZPddbQ==
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="409047119"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.254.97.196]) ([10.254.97.196])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 13:42:08 -0700
Subject: Re: [PATCH v2 06/10] x86/resctrl: Use is_closid_match() in more
 places
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>
References: <20200430170400.21501-1-james.morse@arm.com>
 <20200430170400.21501-7-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <fb864905-3c9c-20e1-4a4a-2bac1c4fbb58@intel.com>
Date:   Mon, 11 May 2020 13:42:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200430170400.21501-7-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/30/2020 10:03 AM, James Morse wrote:
> rdtgroup_tasks_assigned() and show_rdt_tasks() loop over threads testing
> for a CTRL/MON group match by closid/rmid with the provided rdtgrp.
> Further down the file are helpers to do this, move these further up and
> make use of them here.
> 
> These helpers aditionally check for alloc/mon capable. This is harmless

A typo snuck in after the original version: aditionally->additionally

Reinette
