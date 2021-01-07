Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFB42EE8B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbhAGWaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:30:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:12757 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbhAGWaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:30:03 -0500
IronPort-SDR: UfuOZDwrtAm8+/FTa+YphTnwqo+wQz9/kqYxdAMlCyMyr44o4cS88LwxeuGTk4SEIFUAbj93PV
 CpF5BpY4J6QA==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="176728705"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="176728705"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 14:29:16 -0800
IronPort-SDR: GzC942YKdS29oUlMaYhhxheHOEXQ50ohrsnXrMzcAUig5MAMgCsJiGcXO3bGdcBXVnhOsvxdi8
 5u6Vv0DHV53Q==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="566279705"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.132.29]) ([10.212.132.29])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 14:29:15 -0800
Subject: Re: [PATCH] x86/kernel/cpu/resctrl: replace 'of->kn->priv' with
 of_rft()
To:     zhouchuangao <chuangaozhou@gmail.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org,
        zhouchuangao <zhouchuangao@xiaomi.com>
References: <1609758533-14337-1-git-send-email-zhouchuangao@xiaomi.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <614d7092-6234-a8e1-456a-752dcbf23f4f@intel.com>
Date:   Thu, 7 Jan 2021 14:29:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1609758533-14337-1-git-send-email-zhouchuangao@xiaomi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/4/2021 3:08 AM, zhouchuangao wrote:
> The use of 'of->kn->priv' to get rftype can be found in several
> places in arch/x86/kernel/cpu/resctrl/rdtgroup.c, which may reduce
> readability.
> 
> So replace the direct use 'of->kn->priv' with inline function
> of_rft(), which is more readable.

Readability can be subjective. The current assignment appears succinct 
and in my opinion the additional layer of indirection does not improve 
the readability.

Reinette

