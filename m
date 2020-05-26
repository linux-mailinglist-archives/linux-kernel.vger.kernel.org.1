Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E770C1A49C5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 20:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDJSRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 14:17:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38562 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDJSRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 14:17:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id c21so1351934pfo.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ONQr1o5afMzZCc/yY5ISG7WZ6CofvcuUc7zxDzV7MHM=;
        b=CZUd7qge2u8lP+5A2CFYbP8GqcWr6nsRqjnX2/Wx1qCRxbW9lmXzKD2p75KuiGollr
         z5VZxaKweBe3SC9vGGZy5RXT0OdVhmotxXEGqQKWIZgDYJz6NVERYZkGAk9Ar244fW2W
         V7a+WWesAwrQ94LJE7zb+Y6PjFs8kgVVRSlDP1SkRCG1dvSCUBGZseeV1Sp/vF3ncPD0
         eIfaOmUrAr/FDn78ypCPPiP7h+X5bY+GWD5uYrCVwihmx12xaDll3tu6ufSdBQ0hYjez
         9xRjGrRXwAbXrVT7Tv4hH6Ym+cc5Tp3ewDIFPg8pno4P16RPNs/stvjoyd3qYcykurK5
         ZRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ONQr1o5afMzZCc/yY5ISG7WZ6CofvcuUc7zxDzV7MHM=;
        b=WnPhTFVnJkgaunjSplCU/EEuvs8YD6gEJg6EfbdLErFtfloHVVNJsZhFOwUjsLksx+
         mKalmabe4XDe+wLbgCj1B7v1np/dPbaZQjSeb3x0RQX5AgsG/htb8MQJqUv/3NRADrwq
         weDn5GW74K6Jlw4I5xkOjkprFnn+4EyXJgr5JuQ12UANLRKIQELsOPm+ulsfJ8NFXeej
         jtB9WDp4PvRFwbtmGStoBV7uU6754tEsKM7aWXfmprOZzaywY9Y8YE7/cZ/JdC2mYrMB
         BwPkX8M4DQv2EcyDH8sTbFGWscnBGPUOq8p8zBNxOGg3GfrUhiclJHkrzkln5j4v1aCy
         g3PA==
X-Gm-Message-State: AGi0PuZlVxC1YFQmPbZQSJNI8AYt//+AvVAk7sqlsackTCXusu6DdvxA
        lRyglCJAZbkY7duDPAM4XyaLXA==
X-Google-Smtp-Source: APiQypL52DjnSCNtUYpsLH+pRBgE8UJHt0b1dWHNdC3BokbWlW/fD7XAy21pIdhugLesDRkmxAS7dw==
X-Received: by 2002:a62:2b05:: with SMTP id r5mr5822275pfr.120.1586542668722;
        Fri, 10 Apr 2020 11:17:48 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j96sm2304705pje.32.2020.04.10.11.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 11:17:47 -0700 (PDT)
Date:   Fri, 10 Apr 2020 12:17:45 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, saiprakash.ranjan@codeaurora.org,
        leo.yan@linaro.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH] coresight: Fix support for sparsely populated ports
Message-ID: <20200410181745.GA13684@xps15>
References: <20200409110316.409148-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409110316.409148-1-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thu, Apr 09, 2020 at 12:03:16PM +0100, Suzuki K Poulose wrote:
> On some systems the firmware may not describe all the ports
> connected to a component (e.g, for security reasons). This
> could be especially problematic for "funnels" where we could
> end up in modifying memory beyond the allocated space for
> refcounts.
> 
> e.g, for a funnel with input ports listed 0, 3, 5, nr_inport = 3.
> However the we could access refcnts[5] while checking for
> references, like :
> 
>  [  526.110401] ==================================================================
>  [  526.117988] BUG: KASAN: slab-out-of-bounds in funnel_enable+0x54/0x1b0
>  [  526.124706] Read of size 4 at addr ffffff8135f9549c by task bash/1114
>  [  526.131324]
>  [  526.132886] CPU: 3 PID: 1114 Comm: bash Tainted: G S                5.4.25 #232
>  [  526.140397] Hardware name: Qualcomm Technologies, Inc. SC7180 IDP (DT)
>  [  526.147113] Call trace:
>  [  526.149653]  dump_backtrace+0x0/0x188
>  [  526.153431]  show_stack+0x20/0x2c
>  [  526.156852]  dump_stack+0xdc/0x144
>  [  526.160370]  print_address_description+0x3c/0x494
>  [  526.165211]  __kasan_report+0x144/0x168
>  [  526.169170]  kasan_report+0x10/0x18
>  [  526.172769]  check_memory_region+0x1a4/0x1b4
>  [  526.177164]  __kasan_check_read+0x18/0x24
>  [  526.181292]  funnel_enable+0x54/0x1b0
>  [  526.185072]  coresight_enable_path+0x104/0x198
>  [  526.189649]  coresight_enable+0x118/0x26c
> 
>   ...
> 
>  [  526.237782] Allocated by task 280:
>  [  526.241298]  __kasan_kmalloc+0xf0/0x1ac
>  [  526.245249]  kasan_kmalloc+0xc/0x14
>  [  526.248849]  __kmalloc+0x28c/0x3b4
>  [  526.252361]  coresight_register+0x88/0x250
>  [  526.256587]  funnel_probe+0x15c/0x228
>  [  526.260365]  dynamic_funnel_probe+0x20/0x2c
>  [  526.264679]  amba_probe+0xbc/0x158
>  [  526.268193]  really_probe+0x144/0x408
>  [  526.271970]  driver_probe_device+0x70/0x140
> 
>  ...
> 
>  [  526.316810]
>  [  526.318364] Freed by task 0:
>  [  526.321344] (stack is not available)
>  [  526.325024]
>  [  526.326580] The buggy address belongs to the object at ffffff8135f95480
>  [  526.326580]  which belongs to the cache kmalloc-128 of size 128
>  [  526.339439] The buggy address is located 28 bytes inside of
>  [  526.339439]  128-byte region [ffffff8135f95480, ffffff8135f95500)
>  [  526.351399] The buggy address belongs to the page:
>  [  526.356342] page:ffffffff04b7e500 refcount:1 mapcount:0 mapping:ffffff814b00c380 index:0x0 compound_mapcount: 0
>  [  526.366711] flags: 0x4000000000010200(slab|head)
>  [  526.371475] raw: 4000000000010200 ffffffff05034008 ffffffff0501eb08 ffffff814b00c380
>  [  526.379435] raw: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
>  [  526.387393] page dumped because: kasan: bad access detected
>  [  526.393128]
>  [  526.394681] Memory state around the buggy address:
>  [  526.399619]  ffffff8135f95380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  [  526.407046]  ffffff8135f95400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  [  526.414473] >ffffff8135f95480: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  [  526.421900]                             ^
>  [  526.426029]  ffffff8135f95500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  [  526.433456]  ffffff8135f95580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  [  526.440883] ==================================================================
> 
> To keep the code simple, we now track the maximum number of
> possible input/output connections to/from this component
> @ nr_inport and nr_outport in platform_data, respectively.
> Thus the output connections could be sparse and code is
> adjusted to skip the unspecified connections.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Tested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../hwtracing/coresight/coresight-platform.c  | 74 ++++++++++++-------
>  drivers/hwtracing/coresight/coresight.c       |  8 +-
>  include/linux/coresight.h                     | 10 ++-
>  3 files changed, 62 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 3c5bee429105..c57373b49b42 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -67,6 +67,7 @@ static void of_coresight_get_ports_legacy(const struct device_node *node,
>  					  int *nr_inport, int *nr_outport)
>  {
>  	struct device_node *ep = NULL;
> +	struct of_endpoint endpoint;
>  	int in = 0, out = 0;
>  
>  	do {
> @@ -74,10 +75,16 @@ static void of_coresight_get_ports_legacy(const struct device_node *node,
>  		if (!ep)
>  			break;
>  
> -		if (of_coresight_legacy_ep_is_input(ep))
> -			in++;
> -		else
> -			out++;
> +		if (of_graph_parse_endpoint(ep, &endpoint))
> +			continue;
> +
> +		if (of_coresight_legacy_ep_is_input(ep)) {
> +			in = (endpoint.port + 1 > in) ?
> +				endpoint.port + 1 : in;
> +		} else {
> +			out = (endpoint.port + 1) > out ?
> +				endpoint.port + 1 : out;
> +		}
>  
>  	} while (ep);
>  
> @@ -117,9 +124,16 @@ of_coresight_count_ports(struct device_node *port_parent)
>  {
>  	int i = 0;
>  	struct device_node *ep = NULL;
> +	struct of_endpoint endpoint;
> +
> +	while ((ep = of_graph_get_next_endpoint(port_parent, ep))) {
> +		/* Defer error handling to parsing */
> +		if (of_graph_parse_endpoint(ep, &endpoint))
> +			continue;
> +		if (endpoint.port + 1 > i)
> +			i = endpoint.port + 1;
> +	}
>  
> -	while ((ep = of_graph_get_next_endpoint(port_parent, ep)))
> -		i++;
>  	return i;
>  }
>  
> @@ -171,14 +185,12 @@ static int of_coresight_get_cpu(struct device *dev)
>   * Parses the local port, remote device name and the remote port.
>   *
>   * Returns :
> - *	 1	- If the parsing is successful and a connection record
> - *		  was created for an output connection.
>   *	 0	- If the parsing completed without any fatal errors.
>   *	-Errno	- Fatal error, abort the scanning.
>   */
>  static int of_coresight_parse_endpoint(struct device *dev,
>  				       struct device_node *ep,
> -				       struct coresight_connection *conn)
> +				       struct coresight_platform_data *pdata)
>  {
>  	int ret = 0;
>  	struct of_endpoint endpoint, rendpoint;
> @@ -186,6 +198,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
>  	struct device_node *rep = NULL;
>  	struct device *rdev = NULL;
>  	struct fwnode_handle *rdev_fwnode;
> +	struct coresight_connection *conn;
>  
>  	do {
>  		/* Parse the local port details */
> @@ -212,6 +225,13 @@ static int of_coresight_parse_endpoint(struct device *dev,
>  			break;
>  		}
>  
> +		conn = &pdata->conns[endpoint.port];
> +		if (conn->child_fwnode) {
> +			dev_warn(dev, "Duplicate output port %d\n",
> +				 endpoint.port);
> +			ret = -EINVAL;
> +			break;
> +		}
>  		conn->outport = endpoint.port;
>  		/*
>  		 * Hold the refcount to the target device. This could be
> @@ -224,7 +244,6 @@ static int of_coresight_parse_endpoint(struct device *dev,
>  		conn->child_fwnode = fwnode_handle_get(rdev_fwnode);
>  		conn->child_port = rendpoint.port;
>  		/* Connection record updated */
> -		ret = 1;
>  	} while (0);
>  
>  	of_node_put(rparent);
> @@ -238,7 +257,6 @@ static int of_get_coresight_platform_data(struct device *dev,
>  					  struct coresight_platform_data *pdata)
>  {
>  	int ret = 0;
> -	struct coresight_connection *conn;
>  	struct device_node *ep = NULL;
>  	const struct device_node *parent = NULL;
>  	bool legacy_binding = false;
> @@ -267,8 +285,6 @@ static int of_get_coresight_platform_data(struct device *dev,
>  		dev_warn_once(dev, "Uses obsolete Coresight DT bindings\n");
>  	}
>  
> -	conn = pdata->conns;
> -
>  	/* Iterate through each output port to discover topology */
>  	while ((ep = of_graph_get_next_endpoint(parent, ep))) {
>  		/*
> @@ -280,15 +296,9 @@ static int of_get_coresight_platform_data(struct device *dev,
>  		if (legacy_binding && of_coresight_legacy_ep_is_input(ep))
>  			continue;
>  
> -		ret = of_coresight_parse_endpoint(dev, ep, conn);
> -		switch (ret) {
> -		case 1:
> -			conn++;		/* Fall through */
> -		case 0:
> -			break;
> -		default:
> +		ret = of_coresight_parse_endpoint(dev, ep, pdata);
> +		if (ret)
>  			return ret;
> -		}
>  	}
>  
>  	return 0;
> @@ -627,6 +637,11 @@ static int acpi_coresight_parse_link(struct acpi_device *adev,
>  		 *    coresight_remove_match().
>  		 */
>  		conn->child_fwnode = fwnode_handle_get(&r_adev->fwnode);
> +	} else if (dir == ACPI_CORESIGHT_LINK_SLAVE) {
> +		conn->child_port = fields[0].integer.value;
> +	} else {
> +		/* Invalid direction */
> +		return -EINVAL;
>  	}
>  
>  	return dir;
> @@ -672,10 +687,14 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
>  			return dir;
>  
>  		if (dir == ACPI_CORESIGHT_LINK_MASTER) {
> -			pdata->nr_outport++;
> +			if (ptr->outport > pdata->nr_outport)
> +				pdata->nr_outport = ptr->outport;
>  			ptr++;
>  		} else {
> -			pdata->nr_inport++;
> +			WARN_ON(pdata->nr_inport == ptr->child_port);
> +			/* Do not move the ptr for input connections */
> +			if (ptr->child_port > pdata->nr_inport)
> +				pdata->nr_inport = ptr->child_port;

How you are using the current ptr as a scratch pad for input port was definitely
a brain twister this morning...  I would certainly appreciate a richer comment
so that I (or anyone else) doesn't have to go through the same process the next
time around.

>  		}
>  	}
>  
> @@ -684,8 +703,13 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
>  		return rc;
>  
>  	/* Copy the connection information to the final location */
> -	for (i = 0; i < pdata->nr_outport; i++)
> -		pdata->conns[i] = conns[i];
> +	for (i = 0; conns + i < ptr; i++) {
> +		int port = conns[i].outport;
> +
> +		/* Duplicate output port */
> +		WARN_ON(pdata->conns[port].child_fwnode);
> +		pdata->conns[port] = conns[i];
> +	}
>  
>  	devm_kfree(&adev->dev, conns);
>  	return 0;
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index ef20f74c85fa..f07bc0a7ab88 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -990,6 +990,9 @@ static int coresight_orphan_match(struct device *dev, void *data)
>  	for (i = 0; i < i_csdev->pdata->nr_outport; i++) {
>  		conn = &i_csdev->pdata->conns[i];
>  
> +		/* Skip the port if FW doesn't describe it */
> +		if (!conn->child_fwnode)
> +			continue;
>  		/* We have found at least one orphan connection */
>  		if (conn->child_dev == NULL) {
>  			/* Does it match this newly added device? */
> @@ -1029,6 +1032,9 @@ static void coresight_fixup_device_conns(struct coresight_device *csdev)
>  		struct coresight_connection *conn = &csdev->pdata->conns[i];
>  		struct device *dev = NULL;
>  
> +		if (!conn->child_fwnode)
> +			continue;
> +
>  		dev = bus_find_device_by_fwnode(&coresight_bustype, conn->child_fwnode);
>  		if (dev) {
>  			conn->child_dev = to_coresight_device(dev);
> @@ -1061,7 +1067,7 @@ static int coresight_remove_match(struct device *dev, void *data)
>  	for (i = 0; i < iterator->pdata->nr_outport; i++) {
>  		conn = &iterator->pdata->conns[i];
>  
> -		if (conn->child_dev == NULL)
> +		if (conn->child_dev == NULL || conn->child_fwnode == NULL)
>  			continue;
>  
>  		if (csdev->dev.fwnode == conn->child_fwnode) {
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 44e552de419c..7f8d2b39aee2 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -90,10 +90,12 @@ union coresight_dev_subtype {
>  };
>  
>  /**
> - * struct coresight_platform_data - data harvested from the DT specification
> - * @nr_inport:	number of input ports for this component.
> - * @nr_outport:	number of output ports for this component.
> - * @conns:	Array of nr_outport connections from this component
> + * struct coresight_platform_data - data harvested from the firmware
> + * specification.
> + *
> + * @nr_inport:	Number of elements for the input connections.
> + * @nr_outport:	Number of elements for the output connections.
> + * @conns:	Sparse arrray of nr_outport connections from this component.

s/arrray/array

Please rebase your work on my the coresight-next branch.  Other than the above
this patch looks fine to me.

Thanks,
Mathieu

>   */
>  struct coresight_platform_data {
>  	int nr_inport;
> -- 
> 2.24.1
> 
