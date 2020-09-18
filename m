Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9F727024D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgIRQeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:34:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:27064 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgIRQeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:34:12 -0400
IronPort-SDR: 9QJbJYSv4Cc4+Zg2zMoF2jNFRyRHQH/eZ57T5u/MKJYHmVHvd/5IWNb6La+Ft/qcVO8JsgXfJS
 kR+RlGoBHgEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="147737622"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="147737622"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 09:34:12 -0700
IronPort-SDR: 368iF8lNNNJtcHQcXpEZmzXrUY2fnvQecHdPyz65lt2kH2f9yUG4fDtw6Ibmvb86QAq77uWMBl
 OALF90MRS2UQ==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="484272346"
Received: from jcwillar-mobl.amr.corp.intel.com (HELO [10.209.152.54]) ([10.209.152.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 09:34:11 -0700
Subject: Re: sound/soc/sof/sof-audio.c:375 sof_machine_check() warn:
 inconsistent indenting
To:     kernel test robot <lkp@intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <202009180938.MRPYiW6t%lkp@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <32834bc5-36b1-3365-18bc-f4496b6e1fde@linux.intel.com>
Date:   Fri, 18 Sep 2020 11:34:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009180938.MRPYiW6t%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/20 8:50 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4cbffc461ec91287c4cb1d0e27b01b988d0b8fba
> commit: 285880a23d105e5d34b311b0c44061dffb07e405 ASoC: SOF: Make creation of machine device from SOF core optional
> date:   9 months ago
> config: s390-randconfig-m031-20200917 (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> sound/soc/sof/sof-audio.c:375 sof_machine_check() warn: inconsistent indenting
> sound/soc/sof/sof-audio.c:380 sof_machine_check() warn: ignoring unreachable code.

Ack, fix is on its way. Thanks for the report.
