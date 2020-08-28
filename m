Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847DF2552B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 03:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgH1BvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 21:51:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51152 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgH1BvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:51:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07S1idOa027183;
        Fri, 28 Aug 2020 01:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0vEFas0o4yRWOhG2ENnl7n65xG6A/FN00LeWvkgsczw=;
 b=XE0VIDKyogXdQZ0qzKJ+Wu+i/b6H01FhVfL4/cLGsMMPiz9MWho9/U1pIpgkJa1Rjj19
 sM7oGO8JWZn/t6a3zVIHme05BRziso5hDoiwgxKrWYJSAOgSB2QC1f8qIBYK7iAsTaQi
 kv0oZeyi/GXxIS/bHV0m3n7k1IEJc6dTWa2s9q9CYMR+icrVTO3wCyua3wfjLR6V6c2M
 QrJpqpaAUNI1fesVfiE4z2RPjCVQJmMVs0BmoI2jqhcGJjuOysmPu18GC4rOjInK3nAj
 BGSp0PtHtHwZBJGIfMgSErcTQ1zj5UJ2aXqqdDYnKNciGHxy4nlhCNXS/NgNJ3GfAx+r Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 336ht3hjf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 01:50:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07S1oul0163912;
        Fri, 28 Aug 2020 01:50:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 333r9p44dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 01:50:57 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07S1ojq9030304;
        Fri, 28 Aug 2020 01:50:46 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Aug 2020 18:50:45 -0700
Date:   Thu, 27 Aug 2020 21:59:44 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: add a reviewer
Message-ID: <20200828015944.tk45hzuyzkabbrs3@ca-dmjordan1.us.oracle.com>
References: <20200826145923.719126-1-daniel.m.jordan@oracle.com>
 <20200827064409.GA20687@gauss3.secunet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827064409.GA20687@gauss3.secunet.de>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=901 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008280015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=901 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008280014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 08:44:09AM +0200, Steffen Klassert wrote:
> Please also consider to add yourself as one of the maintainers.

Ok, sure!  I'll take you up on that.
