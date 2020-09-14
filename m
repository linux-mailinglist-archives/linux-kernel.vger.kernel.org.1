Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863912689D8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 13:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgINLSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 07:18:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:29124 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgINLSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 07:18:06 -0400
IronPort-SDR: 2NkFgbBfy8rKkJwd4fKXBxQLVz41BNObE7gt6UfegTXMaCrEnRB7NcixOFDDLKAZCAOvIkKvcL
 Ulw2ziiGdueQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="138566675"
X-IronPort-AV: E=Sophos;i="5.76,425,1592895600"; 
   d="scan'208";a="138566675"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 04:17:29 -0700
IronPort-SDR: sCI5IayTyHjzoT06TBi1gKBFO5gTH5170cYJUaTsjLbGKkSXY9zzjQI07hwSpAx3AzIPMQlNRT
 vaVwRFPJ/glg==
X-IronPort-AV: E=Sophos;i="5.76,425,1592895600"; 
   d="scan'208";a="506320521"
Received: from lhawrylk-desk.ger.corp.intel.com ([10.213.21.171])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 04:17:27 -0700
Message-ID: <02e1fa1f1622ac7a28ad8009a505218416cbb569.camel@linux.intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update Intel TXT maintainer
From:   Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
To:     "Sun, Ning" <ning.sun@intel.com>, tglx@linutronix.de,
        mingo@kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 14 Sep 2020 13:17:24 +0200
In-Reply-To: <BYAPR11MB3096662DD25482E46C8F3C0987560@BYAPR11MB3096.namprd11.prod.outlook.com>
References: <20200812122401.1751885-1-lukasz.hawrylko@linux.intel.com>
         <BYAPR11MB3096662DD25482E46C8F3C0987560@BYAPR11MB3096.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas and Ingo

May I ask you to merge this patch? I got an acknowledgement from
previous owner, I hope that this is enough for that change.

Thanks,
Lukasz

On Mon, 2020-08-24 at 15:08 +0000, Sun, Ning wrote:
> Acknowledged.
> 
> -Ning 
> 
> -----Original Message-----
> From: Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com> 
> Sent: Wednesday, August 12, 2020 5:24 AM
> To: Sun, Ning <ning.sun@intel.com>
> Cc: Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>; Mauro Carvalho Chehab <mchehab+huawei@kernel.org>; David S. Miller <davem@davemloft.net>; Rob Herring <robh@kernel.org>; linux-kernel@vger.kernel.org
> Subject: [PATCH] MAINTAINERS: Update Intel TXT maintainer
> 
> As an effect of changes in Intel, I took resposibility for supporting
> Intel TXT in Linux from Ning Sun. This patch also replaces link to
> repository, as previous one became outdated.
> 
> Signed-off-by: Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e627ed60d75a..cc70a40bba20 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9039,11 +9039,11 @@ F:	drivers/hwtracing/intel_th/
>  F:	include/linux/intel_th.h
>  
>  INTEL(R) TRUSTED EXECUTION TECHNOLOGY (TXT)
> -M:	Ning Sun <ning.sun@intel.com>
> +M:	Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
>  L:	tboot-devel@lists.sourceforge.net
>  S:	Supported
>  W:	http://tboot.sourceforge.net
> -T:	hg http://tboot.hg.sourceforge.net:8000/hgroot/tboot/tboot
> +T:	hg http://hg.code.sf.net/p/tboot/code
>  F:	Documentation/x86/intel_txt.rst
>  F:	arch/x86/kernel/tboot.c
>  F:	include/linux/tboot.h
> --
> 2.25.4
> 

