Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603A4287CA8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgJHTxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:53:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43788 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbgJHTxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:53:22 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098JiY01121352;
        Thu, 8 Oct 2020 19:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=TOXYoPq7dhn6DY/1xOASv8Mqfnor1vAExhw+DTAwaGY=;
 b=l+BVAMIQHQuI/buil576rcNVLNwOWWg9XHB8Kka1ny5c+3NiQAiu6yGmEmqdDyJrVkIa
 9MgaV1Ri/GwGb3JkAvufPKriR7tEfbgnRq1qEn8Uur1iz3Q9CMdV9Juq76SSP3KcEbRz
 M4IHIZgsD0WhxSzmIfrEA4GW56W3qxW459Vhm0jZBHlKjsRN804PBm7PFqa/XKVRQJqi
 Z6mgNF4EiCMlZjqlRkVn0HVljEhu1zRDQaoJJDUst+C11z1U3UWxzunfjFTnIyIij/Go
 ZThcSZYBoht2G01MamvOOHUAdX+aAmQhyS9w/3NhLRXAeOImUCsJToZVvyr6AfIPhJEC ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33xetb9vxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 08 Oct 2020 19:52:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 098JkGT2068959;
        Thu, 8 Oct 2020 19:52:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33y381mmvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Oct 2020 19:52:50 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 098JqXsO027511;
        Thu, 8 Oct 2020 19:52:33 GMT
Received: from [10.74.86.78] (/10.74.86.78)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Oct 2020 12:52:32 -0700
Subject: Re: [PATCH v6 09/11] mm/memremap_pages: convert to 'struct range'
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        david@redhat.com, joao.m.martins@oracle.com
References: <160196728453.2166475.12832711415715687418.stgit@dwillia2-desk3.amr.corp.intel.com>
 <160196733645.2166475.12840692906594512941.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <a2a740e2-424c-69ff-45a6-3d71feac5c50@oracle.com>
Date:   Thu, 8 Oct 2020 15:52:14 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160196733645.2166475.12840692906594512941.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/6/20 2:55 AM, Dan Williams wrote:
> The 'struct resource' in 'struct dev_pagemap' is only used for holding
> resource span information.  The other fields, 'name', 'flags', 'desc',
> 'parent', 'sibling', and 'child' are all unused wasted space.
>
> This is in preparation for introducing a multi-range extension of
> devm_memremap_pages().
>
> The bulk of this change is unwinding all the places internal to libnvdimm
> that used 'struct resource' unnecessarily, and replacing instances of
> 'struct dev_pagemap'.res with 'struct dev_pagemap'.range.
>
> P2PDMA had a minor usage of the resource flags field, but only to report
> failures with "%pR".  That is replaced with an open coded print of the
> range.
>
> Link: https://lkml.kernel.org/r/159643103173.4062302.768998885691711532.stgit@dwillia2-desk3.amr.corp.intel.com
> Link: https://lkml.kernel.org/r/20200926121402.GA7467@kadam
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>


For Xen bits


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

