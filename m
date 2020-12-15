Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D188B2DB047
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgLOPmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:42:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48964 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730266AbgLOPlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:41:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFFUwFH137034;
        Tue, 15 Dec 2020 15:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=VXn3dyH40XOavVCYaFMYMqecD+e8HpJUyZHTeN17JCw=;
 b=bxVTRULTmAXxFUYHTfoI7I2+XPWvnNvZCdIKytYv6yTQa0BXVHBk5MucJDmUlyxqheCY
 yrntw77ixLSkn2irNs/na5oRERXrOucr0ezL4vMuB+fmI/J65vjxOJZ36V4ti7gfKnUW
 xADRzGOC/+KiGLxobApxFr7wxcYOvKy2Zfb/8XJ6PU7e2AJkXczN5ddcN5upumPzkeJY
 CgYcdMEVKiCfvNWrswoW7bZnNAlLxhnVLDPt+FSppHz8RSvyVODicyTEFkUFcdpNSk+B
 OYbpTgsg+2TCBeH8QcZvdWypa+pqXVDOLeUPz2vk1VolIRfVupFwOhvZBCklXNccpSiQ SQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35cn9rb7q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 15:40:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFFV017179049;
        Tue, 15 Dec 2020 15:40:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 35e6eqm6f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 15:40:56 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BFFer9A028061;
        Tue, 15 Dec 2020 15:40:54 GMT
Received: from revolver (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 07:40:53 -0800
Date:   Tue, 15 Dec 2020 10:40:43 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@google.com>
Subject: Re: [PATCH] mm/mmap: Don't unlock VMAs in remap_file_pages()
Message-ID: <20201215154043.cqdr6pktkokz4hkz@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andrew Morton <akpm@google.com>
References: <20201215141300.1436976-1-Liam.Howlett@Oracle.com>
 <20201215145040.GT2443@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215145040.GT2443@casper.infradead.org>
User-Agent: NeoMutt/20200320
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=974 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=986
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [201215 09:50]:
> On Tue, Dec 15, 2020 at 09:13:00AM -0500, Liam R. Howlett wrote:
> > @@ -3025,25 +3025,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
> >  
> >  	flags &= MAP_NONBLOCK;
> >  	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> > -	if (vma->vm_flags & VM_LOCKED) {
> > -		struct vm_area_struct *tmp;
> > -		flags |= MAP_LOCKED;
> 
> I think you need to keep ^^^ that line because the vma needs to stay
> mlocked.
> 

Yes.  I missed that this is transferred through by calc_vm_flag_bits()
in do_mmap().  I will revise the patch.

Thanks,
Liam
