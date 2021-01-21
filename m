Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A132FF390
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAUSuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:50:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:34213 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbhAUSYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:24:54 -0500
IronPort-SDR: Wr9K5kRXm+M2qYzf9teUbIRFmUzKIR8hGS7+VEDIOVz1xub/TVXrg7eH7K3rP8Q84N3weqxNi4
 oIiIvU9mYAkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="243391528"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="243391528"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 10:22:55 -0800
IronPort-SDR: UolsxcPDFQqUMw3ucIJXzf/7FfIYKRQJgHsxWAXoy8HTtczihnQcRCoCKIQgEIQbLRlqPCfOZj
 uwPA+2o/YDhQ==
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="354860719"
Received: from swehrlex-mobl.amr.corp.intel.com (HELO [10.212.61.64]) ([10.212.61.64])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 10:22:53 -0800
Subject: Re: [PATCH] soundwire: debugfs: use controller id instead of link_id
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        yung-chuan.liao@linux.intel.com, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com
References: <20210115162559.20869-1-srinivas.kandagatla@linaro.org>
 <20210119145220.GS2771@vkoul-mobl>
 <45300dc3-00b0-497b-804e-f7f1e857f32a@linux.intel.com>
 <57d5f1bd-50fa-30ab-03c0-260460e45d61@linaro.org>
 <6d4d4a6b-f28c-81db-4e67-2b5b94116fa4@linux.intel.com>
 <1fad2388-27d0-7014-818d-1272fa70ed9b@linaro.org>
 <33fe8455-01b4-f867-4974-a3e867c930f0@linux.intel.com>
 <feee8676-33fe-7929-8b6c-6abe3a09159a@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <35ae5919-f511-bbe9-7273-2dee11795db4@linux.intel.com>
Date:   Thu, 21 Jan 2021 12:22:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <feee8676-33fe-7929-8b6c-6abe3a09159a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> index b6cad0d59b7b..f22868614f09 100644
> --- a/drivers/soundwire/debugfs.c
> +++ b/drivers/soundwire/debugfs.c
> @@ -19,13 +19,14 @@ void sdw_bus_debugfs_init(struct sdw_bus *bus)
>                  return;
> 
>          /* create the debugfs master-N */
> +       bus->controller_debugfs = debugfs_create_dir(dev_name(bus->dev), 
> sdw_debugfs_root);

	bus->dev = &md->dev;

dev_name(bus->dev) does not describe a controller at all but an 
individual master.

We might as well just change the information as:

snprintf(name, sizeof(name), "master-%d-%d", bus_id, bus->link_id);

you get the system unique ID and controller-relative ID, and you can 
decide to ignore one or the other on different platform.
