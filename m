Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122F92B6950
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgKQQDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:03:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:58471 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgKQQDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:03:43 -0500
IronPort-SDR: sIK4wotKrdYhe6Ui4An37FFZlPAyTE/uaM/mnn0PN1yiALgWBVj4SBe0GHsfmNRm+0EFPucgCp
 J8gt2n4U1kdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="232567101"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="232567101"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 08:03:42 -0800
IronPort-SDR: MgMJFhvz1WxqBDp0qQDWfbasziMLBzN+LgGtFfziH2qf6LA11nU1BNpLEiRw0szajESBOa5X3Q
 gCdgNHn3F5Fg==
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="310254823"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.252.34.253])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 08:03:40 -0800
Date:   Tue, 17 Nov 2020 17:03:31 +0100
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 8/8] rpmsg: Turn name service into a stand alone driver
Message-ID: <20201117160330.GA15538@ubuntu>
References: <eb7f6707-4483-3e1a-1e39-7f32fbf437e0@st.com>
 <20201111144942.GA6403@ubuntu>
 <c31b8427-baca-5c77-6420-b592c57a3a7b@st.com>
 <20201112115115.GA11069@ubuntu>
 <945f377d-1975-552d-25b2-1dc25d3c3a46@st.com>
 <2d25d1aa-bd8a-f0db-7888-9f72edc9f687@st.com>
 <20201116151028.GA1519@ubuntu>
 <e5e49e1a-dc2a-ce16-425c-d2d87f415868@st.com>
 <20201116224003.GC3892875@xps15>
 <50549519-d9ff-9048-a3d8-dab02bfda096@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50549519-d9ff-9048-a3d8-dab02bfda096@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 12:42:30PM +0100, Arnaud POULIQUEN wrote:

[snip]

> diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
> index 5bda7cb44618..80c2cc23bada 100644
> --- a/drivers/rpmsg/rpmsg_ns.c
> +++ b/drivers/rpmsg/rpmsg_ns.c
> @@ -55,6 +55,39 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void
> *data, int len,
>  	return 0;
>  }
> 
> +/**
> + * rpmsg_ns_register_device() - register name service device based on rpdev
> + * @rpdev: prepared rpdev to be used for creating endpoints
> + *
> + * This function wraps rpmsg_register_device() preparing the rpdev for use as
> + * basis for the rpmsg name service device.
> + */
> +int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
> +{
> +#ifdef MODULES
> +	int ret;
> +	struct module *rpmsg_ns;
> +
> +	mutex_lock(&module_mutex);
> +	rpmsg_ns = find_module(KBUILD_MODNAME);
> +	mutex_unlock(&module_mutex);
> +
> +	if (!rpmsg_ns) {
> +		ret = request_module(KBUILD_MODNAME);

Is this code requesting the module in which it is located?.. I must be missing 
something...

Thanks
Guennadi
