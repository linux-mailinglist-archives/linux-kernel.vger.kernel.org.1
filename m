Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2316229296B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgJSOgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:36:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:27828 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbgJSOgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:36:19 -0400
IronPort-SDR: XblkRj9kdr1+fszkmO8ZNGzydpYRt5sxVHERDFg5mZYfDqMwJ8ryYD/HyAN9e/EACV18DA6LFV
 DZQ7CFO5NZ9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="146335260"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="146335260"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 07:36:15 -0700
IronPort-SDR: UrYELa678aNDwCWLQH5wjRhWyy/sp0mxJO2iuLvsAOR5UBE8E9J1marG1rUARVP+2OILbXdtrm
 NtSLl4AnQzpA==
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="532646948"
Received: from nlsegerl-mobl1.amr.corp.intel.com (HELO [10.212.182.88]) ([10.212.182.88])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 07:36:14 -0700
Subject: Re: sound/soc/sof/sof-audio.c:375 sof_machine_check() warn:
 inconsistent indenting
To:     kernel test robot <lkp@intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <202010190917.V19qtBGc-lkp@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d4eb5888-1a9e-60c3-d01f-5601b559741f@linux.intel.com>
Date:   Mon, 19 Oct 2020 09:36:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202010190917.V19qtBGc-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/20 8:41 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7cf726a59435301046250c42131554d9ccc566b8
> commit: 285880a23d105e5d34b311b0c44061dffb07e405 ASoC: SOF: Make creation of machine device from SOF core optional
> date:   10 months ago
> config: i386-randconfig-m021-20201019 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> sound/soc/sof/sof-audio.c:375 sof_machine_check() warn: inconsistent indenting
> sound/soc/sof/sof-audio.c:380 sof_machine_check() warn: ignoring unreachable code.

we provided a fix for this:

[PATCH 3/4] ASoC: SOF: sof-audio: remove goto used for force-nocodec support

but I don't see it in Mark's tree. That was part of the series
"[PATCH 0/4] ASoC: SOF: cleanups for 5.10" shared by Kai Vehmanen on 
September 30.

I don't recall what happened with this series?
