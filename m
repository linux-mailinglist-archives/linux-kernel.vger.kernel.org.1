Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566542881B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 07:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbgJIF3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 01:29:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:30356 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbgJIF3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 01:29:05 -0400
IronPort-SDR: xL6tOJTfdjhVRDapG2B2GYd8cGYYQu+A4962mNsD0UKqOBPvsVMXEqMFMLD76919cyuuFQD0fm
 zuiQaOOe7hBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="145310413"
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="145310413"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 22:29:04 -0700
IronPort-SDR: LWWohiNF4nf29TrmlXFM0drYnjKBFVaoogV8CbVVA8j7e3Ahgrlq97n7XG3QfY1d3whu0feUgO
 SRvCxungziAQ==
X-IronPort-AV: E=Sophos;i="5.77,353,1596524400"; 
   d="scan'208";a="343683912"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 22:29:00 -0700
Date:   Fri, 9 Oct 2020 13:30:45 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] platform/surface: Move Surface Pro 3 Button
 driver to platform/surface
Message-ID: <20201009053045.GA25017@chenyu-office.sh.intel.com>
References: <20201008143455.340599-1-luzmaximilian@gmail.com>
 <20201008143455.340599-6-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008143455.340599-6-luzmaximilian@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 04:34:55PM +0200, Maximilian Luz wrote:
> Move the Surface Pro 3 Button driver from platform/x86 to the newly
> created platform/surface directory.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>
Acked-by: Chen Yu <yu.c.chen@intel.com>

Thanks!


best,
Chenyu
