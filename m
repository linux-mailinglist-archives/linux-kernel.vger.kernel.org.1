Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A1E2CD3BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388774AbgLCKeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:34:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41532 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgLCKep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:34:45 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3AP3p7117317;
        Thu, 3 Dec 2020 10:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=TEhTRIN7rFpOA7sX+QvScPL0U2A4SN0Yj7HS3C0kpTE=;
 b=WQ3PEb7gzHJxQE/naB5w9UwVi5g+GBzURGK24Isqphf7mqdA01BYqE8cba19rCD0Tkh8
 om2Qt+MNOaQGsqEt67J98m9Xc41zFK1dZfXDj+CkPi55CgGHR4CxUyX5mwlu2oWqA8ca
 Rz5mmoVM0i1nCjytU/WpFz078gEKD7j5l7/9pbeYdJ2gSUHE0lEvkjQdAgr3uYHTtpas
 9uAENQ/vZ/FJLBASnejGUrV0CoAn/S+JnorF9IDcu6bNymDTvm8WUn7GWQ5kpVSgWg5s
 R87vPoT9rPpdMDsLDbpIJj8+b7PuNv/49Mz/188jVYFS6ITFp+fgPRy7jxqQtjzbVSsw Vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 353c2b57q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Dec 2020 10:34:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3APQSe080729;
        Thu, 3 Dec 2020 10:34:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3540g1fs7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Dec 2020 10:33:59 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B3AXwW4021196;
        Thu, 3 Dec 2020 10:33:58 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Dec 2020 02:33:57 -0800
Date:   Thu, 3 Dec 2020 13:33:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
Message-ID: <20201203103351.GR2767@kadam>
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like a "Fixes-from: Name email" tag for when someone spots a bug in
a patch.

I think we should not give credit for style complaints, because those
are their own reward and we already have enough bike shedding.

regards,
dan carpenter

