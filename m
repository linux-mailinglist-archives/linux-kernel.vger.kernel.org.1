Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D861D29BEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1814542AbgJ0Q5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:57:12 -0400
Received: from smtp1.axis.com ([195.60.68.17]:38420 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1794307AbgJ0PLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=430; q=dns/txt; s=axis-central1;
  t=1603811468; x=1635347468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cYAFVC2I7kC87mONlLHOpxS5S+sZKzhdDuTQreXUrGw=;
  b=NFaT3Twfvm6/286wRqekQ8iTlIfqfcPQ3ir0QOgp1zAyb0wrq0SehgHe
   EtQYpMIwFLTsa46xOeXniVUptYSEc1J3wCcu/BmI4JGS8lpQMPiGcdmDl
   hV9vf94/I8oXyREWvIIsjJ4vD3DwidfBUJkwrbp/lol2HEfc3aUYq2733
   rYkXMWYAA/rD+M3l5xSS3+6XFaVvDRM8ol2N2Vl0xe0IXyAR1g1e37DBG
   1hjdsqDx+pY+NB/PHgXgXA069QGNkiiIPVpihVDnIynUWg1jqs9sRHh8L
   0d2KsMN1WEzzbGQxDZxZdArY/vxcuT2l/TAQlka/X55AT7NtnOaGiL/uX
   A==;
IronPort-SDR: WQ2JBOaww3AO15TYN7su951w/wGZO/qqfbDMWofm3KvD+0+tcRaKFHutyFOUdSwkd2VCttpDu8
 n17L7J0+LP3ZZyodu9Zwrq48WPY29j6K2+FkEO64wkRMXxnXx/lYKY9oPuQde1K3i6tKXufAWO
 n050c8x/00RXhsg5eXqLTsfJBCGZxFSVcEMlCLSBE/flqc12kwP9VzpaXO3zYoAT4wDx/FbmPm
 NykphuRp9525qnVEuwxt6QFWmcVciJMIKSo6Ta1oSjHXvvxnaUn2kIHM3I00CG07M/RxMyE+pq
 UQw=
X-IronPort-AV: E=Sophos;i="5.77,424,1596492000"; 
   d="scan'208";a="14470414"
Date:   Tue, 27 Oct 2020 16:11:06 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Sherry Sun <sherry.sun@nxp.com>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Message-ID: <20201027151106.e4skr6dsbwvo4al6@axis.com>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
 <20201022050638.29641-3-sherry.sun@nxp.com>
 <20201023092650.GB29066@infradead.org>
 <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027062802.GC207971@kroah.com>
 <VI1PR04MB4960C0E76374B2775D99A82192160@VI1PR04MB4960.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4960C0E76374B2775D99A82192160@VI1PR04MB4960.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 08:05:43AM +0100, Sherry Sun wrote:
> Can you help test the patch about removing the codes of reassign used
> ring, and comment on the impact for Intel MIC platform?  Thanks for
> any help.

I don't have access to MIC hardware myself, either.

But this patch is quite certainly going to break it since guests using a
kernel without the patch will not work with hosts with a kernel with the
patch.
