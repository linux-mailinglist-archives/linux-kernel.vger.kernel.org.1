Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDC32B4E97
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbgKPRyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:54:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:64547 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731494AbgKPRyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:54:09 -0500
IronPort-SDR: 0S3Tzo7mf440JBxqqc4HGtVysulprgsREZ5CR6PUzacXbF1nuTG4ocDSkU6ywyXth6s6gj+XRB
 MinB4CxFY++w==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="150635270"
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="150635270"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 09:54:08 -0800
IronPort-SDR: Jdlixqe5R54E9j8V1xGVAl0Bcy031EU+NE8I464ZLtdsj6R+Ow+Y4nFi6QYqoSRagDCjbi6Zm5
 TSpQMuix5vMg==
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="358548867"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.209.146.140]) ([10.209.146.140])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 09:54:07 -0800
Subject: Re: [PATCH 00/24] x86/resctrl: Merge the CDP resources
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <04fdd774-99e0-4b99-2d70-06cfd0ab3be6@intel.com>
Date:   Mon, 16 Nov 2020 09:54:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/30/2020 9:10 AM, James Morse wrote:
> MPAM has an equivalent feature to CDP, but its a property of the CPU,
> not the cache. Resctrl needs to have x86's odd/even behaviour, as that
> its the ABI, but this isn't how the MPAM hardware works. It is entirely
> possible that an in-kernel user of MPAM would not be using CDP, whereas
> resctrl is.

The above seems to distinguish between "in-kernel user of MPAM" and 
resctrl (now obtaining support for MPAM). Could you please provide more 
details on the "in-kernel user of MPAM" and elaborate on how these two 
usages are expected to interact with MPAM concurrently?

Thank you

Reinette
