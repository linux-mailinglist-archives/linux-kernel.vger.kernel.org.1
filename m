Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137CD2216A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 22:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGOUxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 16:53:45 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57780 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOUxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:53:44 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FKW2Du147198;
        Wed, 15 Jul 2020 20:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=62GDuwaaSfc70sN5qjgMF0+16PJauklzFTdwCeP+NQA=;
 b=HDRUmGjVogNoQNaF+paYq4QBogeS4Nvz/WFgY2AlLrnKaRn68pmjTe/94QxXbdL534Wm
 mOzej0+qFCf/s8EPSOfzAggfn4ikBqaZzn+bBbAfQnduIEDJt7tXibQL52J9rTnVYYB/
 xZ5cYOU09PDzkm3jQmhKc4y2PmxflfN6i+UgHrsqLE4cBJRwGBx5sF5o/A/1Crbrkirp
 hu+omEEhvOgh3SWEuxHMRcAfWwbnqfXWTUWEdzM8+kSdsZIJbX8jh+CCIqCTr3RucH2R
 RWH0M/TIyduSk2tyBa9sdtBWly3o5sOrYm4LMnArsuAWvCokH8+CtACW3pTempPpKk8+ 2w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 327s65m17y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jul 2020 20:53:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FKXeeZ059197;
        Wed, 15 Jul 2020 20:53:18 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 327qb8thdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 20:53:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06FKrHXb031054;
        Wed, 15 Jul 2020 20:53:17 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jul 2020 13:53:17 -0700
To:     Simon Arlott <simon@octiron.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Park Ju Hyung <qkrwngud825@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: Disable queued TRIM for Samsung 860 SSDs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1blkgo6y0.fsf@ca-mkp.ca.oracle.com>
References: <9324ef33-eedd-b965-37e8-b82e06778aab@0882a8b5-c6c3-11e9-b005-00805fc181fe>
Date:   Wed, 15 Jul 2020 16:53:14 -0400
In-Reply-To: <9324ef33-eedd-b965-37e8-b82e06778aab@0882a8b5-c6c3-11e9-b005-00805fc181fe>
        (Simon Arlott's message of "Wed, 15 Jul 2020 12:13:24 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=921 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=931 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Simon!

> Despite the unsubstantiated claim from Samsung that "the improved
> queued trim enhances Linux compatibility" this does not appear to be
> true, even on Intel SATA controllers:

I am aware of several people using 860 drives with queued TRIM. And I
haven't heard any complaints outside of the bug you referenced.

Also, I have tested both 860 2.5" Pro and 860 mSATA EVO on a few
different systems in my lab without any problems. See:

    https://lore.kernel.org/stable/yq1h87du82d.fsf@oracle.com/T/

I really wish we had some more data to work with :(

Lacking a proper heuristic I guess we don't have any choice to disable
the feature. But that's sad news for the people who currently don't have
problems since their performance will inevitably suffer.

-- 
Martin K. Petersen	Oracle Linux Engineering
