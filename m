Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253CC2DA273
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 22:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503616AbgLNVPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 16:15:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48140 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgLNVPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 16:15:30 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BELERYL175832;
        Mon, 14 Dec 2020 21:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=GQjDIQKin3GVQbr2gdSBNgBsWJpDaR3hothv+5CQkvU=;
 b=Nz+xOD2PEHalMGOc6K/jzl8RKPmkiq6+enQBDah148/6JCmsE/eRcqbrfAxTTn6YX8go
 7l0coQAWdTQi2tyzv7AW91+S/QFhG9R0GY3kLvlH5yXd5zaJ7oVDSlZ8mbSAdP53Jvf1
 8ZHPQgUe7mdp9GlC6Nth2dUFNy7EJEloZObyM7ZvA1zybROSSuii+HZ37nDa4YH128GM
 VvZ3yPM0cWJkLr6Pz6IhHmj16yk7DIlP7CD8lpdrjecg+DI/YvhOrClgGx7QVS/iwpm4
 RQwUfwNS0/to3hLZjTEaOR2xim2IYF/oRJ4c1gnBiqh+89ISJhtFjaUpzzT0dlxrNVyM dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35cn9r7hs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 21:14:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BEKt5qa135880;
        Mon, 14 Dec 2020 21:12:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 35e6jq0tuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 21:12:46 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BELCjh6017162;
        Mon, 14 Dec 2020 21:12:45 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Dec 2020 13:12:43 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 736126A00F4; Mon, 14 Dec 2020 16:14:47 -0500 (EST)
Date:   Mon, 14 Dec 2020 16:14:47 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] (swiotlb) stable/for-linus-5.11
Message-ID: <20201214211447.GA18041@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9834 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140140
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9835 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Heya Linus,

Please git pull the following branch:

git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.11

which has a generic (but for right now engaged only with AMD SEV) mechanism to adjust a
larger size SWIOTLB based on the total memory of the SEV guests which right now require
the bounce buffer for interacting with the outside world. Normal knobs (swiotlb=XYZ) still work.

Thank you!!

Ashish Kalra (1):
      x86,swiotlb: Adjust SWIOTLB bounce buffer size for SEV guests

 arch/x86/include/asm/mem_encrypt.h |  2 ++
 arch/x86/kernel/setup.c            |  6 ++++++
 arch/x86/mm/mem_encrypt.c          | 31 +++++++++++++++++++++++++++++++
 include/linux/swiotlb.h            |  8 ++++++++
 kernel/dma/swiotlb.c               | 20 ++++++++++++++++++--
 5 files changed, 65 insertions(+), 2 deletions(-)
