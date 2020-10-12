Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8548D28C3CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbgJLVLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:11:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53452 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgJLVLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:11:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09CL4RJb161007;
        Mon, 12 Oct 2020 21:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=L3Sb8vcOf2Mz1CizllpDz5GKGlYv+BP7RakyyG6PVWs=;
 b=INsllxDnYGF0dhK5pD/d7VpQVH/1wBq2tQJc7mRZk6KavbRR88C4ejMT1oIo5drhVGES
 Dr/e7J+schXYq1X5kqPMuPyTf83Sz6ERQtBuBwTA0gjeiueyZzxVxYPlH829lLrh5VLj
 1V0gsfRgSxKi02VCpkPzdnzelW3a+I1bADW+DBO3FGqwC5mwoLjzDGRXr0sY7pkdXU4O
 gwhbSZpWiQNqc4HrX9DAhhCObLwajXPaw/05bYcw3VVX5LBmCsmrmUkPvzzoo26EVP7k
 T/yl3e3mocD3ixPjCz9SU9VgDTeLIWCQo94Djuw4vfpnvgTrRIXMGyqoB1WU//oRzmkn Iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 343pajnsye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 21:11:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09CL5TY6070247;
        Mon, 12 Oct 2020 21:11:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 344by19gxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 21:11:07 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09CLB5TL032217;
        Mon, 12 Oct 2020 21:11:06 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Oct 2020 14:11:05 -0700
Date:   Mon, 12 Oct 2020 14:11:04 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, dchinner@redhat.com,
        sandeen@redhat.com
Subject: Re: -next: Kconfig asks about XFS formats when I don't have XFS
 enabled
Message-ID: <20201012211104.GD6559@magnolia>
References: <20201012102039.GA1588@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012102039.GA1588@amd>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=2 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9772 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=2
 impostorscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 12:20:39PM +0200, Pavel Machek wrote:
> Hi!
> 
> I don't have XFS enabled, yet I'm asked if I want to support its old
> format:
> 
> +config XFS_SUPPORT_V4
> +       bool "Support deprecated V4 (crc=0) format"
> +       default y
> 
> This needs to have dependence on XFS_FS.
> 
> +         This option will become default N in September 2025. Support for the
> +         V4 format will be removed entirely in September 2030. Distributors
> +         can say N here to withdraw support earlier.
> 
> This seems... "interesting", contrary to "no regressions" rule.

Oops, yeah, that should be gated on XFS_FS.  I'll send a quick fix.

--D

> Best regards,
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


