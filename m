Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6E6302F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 23:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbhAYWzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 17:55:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732684AbhAYVev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:34:51 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10PLVp4Z146855;
        Mon, 25 Jan 2021 16:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Urd9Qgx0jzy/GiFaI6Fka0/iTbjR61vvK2y71xJUzCs=;
 b=GyJSSThZUGykNwgncp8KGVXjPeegIpfZXLyCba1j0C5P0KOBqZ4nQSAvNyJVYFEOkz5N
 Ndm5a4mhonp0qqGw+bpcEdeL9eYnH2Z2BGOUlJNYppGta80jXPTWwCNym7En5Fps0UPT
 SVrSKkHf1WhcdZs7bn5KQRCw0NMwwoLLwkkYURgErTwfT8N7gJo2a822wGT5bGc3VCIB
 sM0Jxlp5Orakt2pfwbc+pZwsghnjOultWXdRmwazJCTg0iSPnh3MrP+ZwGF/+LXevwdp
 IjgLrHIrXNXK0rtB+Hii8uBpJkoKV4xCZwSkTgadyZy7tdFFRCVqVyGLqZ7V8IbMBRFS Ag== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36a4tnhp3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 16:33:56 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10PLSQtN011069;
        Mon, 25 Jan 2021 21:33:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 368be894m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 21:33:54 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10PLXiL937945808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 21:33:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA407AE04D;
        Mon, 25 Jan 2021 21:33:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91370AE051;
        Mon, 25 Jan 2021 21:33:50 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.26.126])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Jan 2021 21:33:50 +0000 (GMT)
Date:   Mon, 25 Jan 2021 23:33:48 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc5
Message-ID: <20210125213348.GB196782@linux.ibm.com>
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
 <161160687463.28991.354987542182281928@build.alporthouse.com>
 <CAHk-=wh23BXwBwBgPmt9h2EJztnzKKf=qr5r=B0Hr6BGgZ-QDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh23BXwBwBgPmt9h2EJztnzKKf=qr5r=B0Hr6BGgZ-QDA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_09:2021-01-25,2021-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101250107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:49:39PM -0800, Linus Torvalds wrote:
> On Mon, Jan 25, 2021 at 12:35 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> >
> > Quoting Linus Torvalds (2021-01-25 01:06:40)
> > > Mike Rapoport (3):
> > ...
> > >       mm: fix initialization of struct page for holes in memory layout
> >
> > We have half a dozen or so different machines in CI that are silently
> > failing to boot, that we believe is bisected to this patch.
> 
> That commit reverts cleanly - so if you can verify that reverting it
> fixes your CI machines, I think that that's the right thing to do for
> now, unless Mike can figure out some obvious "Duh!" moment from your
> working dmesg.

Unfortunately not, at least at 11pm :(
Maybe tomorrow I'll have something smarter to say.
 
> Mike: should we perhaps revert the first patch too (commit
> bde9cfa3afe4: "x86/setup: don't remove E820_TYPE_RAM for pfn 0")?

I wonder, maybe actually this one is causing troubles?

Chris, would it be possible to check what happens if you revert only
bde9cfa3afe4?

>                 Linus

-- 
Sincerely yours,
Mike.
