Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DA828D051
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgJMOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:38:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:31811 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgJMOiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:38:05 -0400
IronPort-SDR: UDj+kBIIGjWRyXaJpS6IYKCVbCTzs6t8ZTuFXvGF+lkSuT/N05yYIB8t+bsMqm28OOFGsnUyie
 Gb70uFA+mgHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="145236777"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="145236777"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 07:38:03 -0700
IronPort-SDR: 6NDRmzr19O6k1n1a+sVz+KU5RXMOVyLbLRFGIHcQQD8QAIEJnc9HkZnMc6l/0fO3dFrVOcbgA+
 Y3oQZKlCIrJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="351122232"
Received: from nntpdsd52-183.inn.intel.com (HELO [10.125.52.183]) ([10.125.52.183])
  by fmsmga002.fm.intel.com with ESMTP; 13 Oct 2020 07:38:00 -0700
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix for iio mapping on Skylake
 Server
To:     "Meyer, Kyle" <kyle.meyer@hpe.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>
References: <20200928102133.61041-1-alexander.antonov@linux.intel.com>
 <DF4PR8401MB1035CE7DBCCD58B531748BC69B080@DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM>
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <da9bc69d-07b3-8817-bb7a-22a927b826e7@linux.intel.com>
Date:   Tue, 13 Oct 2020 17:37:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <DF4PR8401MB1035CE7DBCCD58B531748BC69B080@DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kyle,

Currently we do not have plans on supporting the Uncore units to IIO PMON
mapping on multiple segment platforms due to a variety of such platforms.
It would be great if you describe your case, I mean how you configure 
segments
on your platform. It will help to cover your configuration and determine a
common approach for the mapping algorithm.

Thanks,
Alexander

On 10/09/2020 05:11 PM, Meyer, Kyle wrote:
> Hello Alexander,
>
> Do you plan on supporting multiple segment platforms?
>
> Thanks,
> Kyle Meyer
>
> ________________________________________
> From: alexander.antonov@linux.intel.com <alexander.antonov@linux.intel.com>
> Sent: Monday, September 28, 2020 5:21 AM
> To: peterz@infradead.org; linux-kernel@vger.kernel.org; x86@kernel.org
> Cc: alexander.shishkin@linux.intel.com; kan.liang@linux.intel.com; alexey.budankov@linux.intel.com; ak@linux.intel.com; acme@kernel.org; mingo@redhat.com; alexander.antonov@linux.intel.com; Meyer, Kyle; Anderson, Russ
> Subject: [PATCH] perf/x86/intel/uncore: Fix for iio mapping on Skylake Server
>
> From: Alexander Antonov <alexander.antonov@linux.intel.com>
>
> Introduced early attributes /sys/devices/uncore_iio_<pmu_idx>/die* are
> initialized by skx_iio_set_mapping(), however, for example, for multiple
> segment platforms skx_iio_get_topology() returns -EPERM before a list of
> attributes in skx_iio_mapping_group will have been initialized.
> As a result the list is being NULL. Thus the warning
> "sysfs: (bin_)attrs not set by subsystem for group: uncore_iio_*/" appears
> and uncore_iio pmus are not available in sysfs. Clear IIO attr_update
> to properly handle the cases when topology information cannot be
> retrieved.
>
> Fixes: bb42b3d39781 ("perf/x86/intel/uncore: Expose an Uncore unit to IIO PMON mapping")
> Reported-by: Kyle Meyer <kyle.meyer@hpe.com>
> Suggested-by: Kan Liang <kan.liang@linux.intel.com>
> Reviewed-by: Alexei Budankov <alexey.budankov@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
> ---
>   arch/x86/events/intel/uncore_snbep.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 62e88ad919ff..ccfa1d6b6aa0 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3749,7 +3749,9 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
>
>          ret = skx_iio_get_topology(type);
>          if (ret)
> -               return ret;
> +               goto clear_attr_update;
> +
> +       ret = -ENOMEM;
>
>          /* One more for NULL. */
>          attrs = kcalloc((uncore_max_dies() + 1), sizeof(*attrs), GFP_KERNEL);
> @@ -3781,8 +3783,9 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
>          kfree(eas);
>          kfree(attrs);
>          kfree(type->topology);
> +clear_attr_update:
>          type->attr_update = NULL;
> -       return -ENOMEM;
> +       return ret;
>   }
>
>   static void skx_iio_cleanup_mapping(struct intel_uncore_type *type)
>
> base-commit: a1b8638ba1320e6684aa98233c15255eb803fac7
> --
> 2.19.1
>

