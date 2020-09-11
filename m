Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20ACA26682C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 20:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgIKSSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 14:18:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32880 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgIKSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 14:18:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08BEe7Sc125632;
        Fri, 11 Sep 2020 14:41:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=JjMUWwMmbiWNIGT99m15PKtZFg8PRnYN9ayHiEv9Bos=;
 b=z+0DIhmMX8L+F5SwotpzQRc2OQesfvFUcEYjYCEWsndFsVKV68ouNbxtBvQI7D8RpDG9
 K+JndqXtHr8CWyTZdFWSAWBvX8OjxAqY+xK/nIUYgJc6LqOdHAOgWB6DqDjkFNxwLfAT
 7FZHxbkx3xY3fUszXyiU7vVYKvsjOsrx7yImLiB2BgZoINRN3g4f6gBCpeac0xu3sbme
 h0amtYkI63XWoxdNSTXMspVY97pc+UWkHLNO6IWKJXNukS/SjeKtR5BcpY+CVGJVfc2M
 bO51JrJnhw8OrhsL4X+XJ7mVHhann1cVetQ3dLCMtBo/uBzcUDVpZWMoobcccQGdMQf1 LA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33c3anefpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Sep 2020 14:41:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08BEYVC0149029;
        Fri, 11 Sep 2020 14:41:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33cmm3ghmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 14:41:07 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08BEevRR018381;
        Fri, 11 Sep 2020 14:40:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Sep 2020 07:40:57 -0700
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: MAINTAINERS: Marking internal distribution lists
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lfhgz8gi.fsf@ca-mkp.ca.oracle.com>
References: <alpine.DEB.2.21.2009110811520.9220@felia>
        <20200911094627.GA14158@infradead.org>
Date:   Fri, 11 Sep 2020 10:40:55 -0400
In-Reply-To: <20200911094627.GA14158@infradead.org> (Christoph Hellwig's
        message of "Fri, 11 Sep 2020 10:46:27 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9740 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=2
 spamscore=0 mlxlogscore=851 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009110120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9740 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=883 suspectscore=2 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph,

> On Fri, Sep 11, 2020 at 08:37:54AM +0200, Lukas Bulwahn wrote:

>>   - ocfs2-devel.oss.oracle.com
>>   - rds-devel.oss.oracle.com

Both of these are public development lists and should be fully
functional, have archives available, etc. Let me know if that's not the
case.

-- 
Martin K. Petersen	Oracle Linux Engineering
