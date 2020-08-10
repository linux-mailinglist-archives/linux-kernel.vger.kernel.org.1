Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916CB2404B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 12:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgHJKcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 06:32:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49880 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJKcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 06:32:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AAVkjP113216;
        Mon, 10 Aug 2020 10:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+d+GxCQkQc5ZOa3c/6qFetI/mxSR4YrNzjtK4MmWleQ=;
 b=BD8xD2rgLKuMfv6zj9QoD5xdWxDRtPZQtRcRrGEq1e0iDcLgTseHHQ1to8wt4WB63g15
 lqXJZWs98VKnYhwYVXuvqXyP665AzpmHkAiDwxBgBjIrBGo5EgSRheeY2unMUwWZE276
 zONQCOl3IOZrHMhVmHEUEHDk4z7ELCwZTUw4KwWj4QJBiDEppx/cjpNaCnXjVFLiJvbo
 D1UUKSyqFwQ3qZVHoyK4ggtMnK3tIA7bxTrqwGtOusWgpfBPFIATZLZsZvt9gOPWNka4
 u+rnWWi4ej3RYq5k3LZsl7RNMjiuFYQJ21W435betn0JjGSCy6LsKLWSFVbzwZFBGcOm SQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32t2ydc3t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Aug 2020 10:31:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AATMBw086210;
        Mon, 10 Aug 2020 10:31:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32u3gybatf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 10:31:56 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07AAVtxW007692;
        Mon, 10 Aug 2020 10:31:55 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Aug 2020 10:31:54 +0000
Date:   Mon, 10 Aug 2020 13:31:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Eli Cohen <eli@mellanox.com>, Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Fix pointer math in mlx5_vdpa_get_config()
Message-ID: <20200810103147.GJ1793@kadam>
References: <20200808093241.GB115053@mwanda>
 <BN8PR12MB3425E1FCC3E20A04182640D2AB470@BN8PR12MB3425.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR12MB3425E1FCC3E20A04182640D2AB470@BN8PR12MB3425.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9708 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9708 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 06:34:04AM +0000, Eli Cohen wrote:
> Acked-by: Eli Cohen <elic@nvidia.com>
> 
> BTW, vdpa_sim has the same bug.
> 

I sent a patch for that on April 6.

[PATCH 2/2] vdpa: Fix pointer math bug in vdpasim_get_config()

Jason acked the patch but it wasn't applied.

regards,
dan carpenter

