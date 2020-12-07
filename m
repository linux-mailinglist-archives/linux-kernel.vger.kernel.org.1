Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C82D1AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgLGUoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:44:03 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:33926 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgLGUoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:44:03 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fce93e90001>; Tue, 08 Dec 2020 04:43:21 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Dec
 2020 20:43:21 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 7 Dec 2020 20:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvEhYFWAz0gEr/1qnCmhWMuB+7lA2XzQUirJ8eL+qe6eK+g4wwpK56ohRgtELSC49/M1ITFhGYbRR0Jn9CtIuXFhn5uJmokLrtZprrle0xmdz9pqqZhybkBpwfelq+FwdDUeQhm2sWdYOCHpvYiGW1iI1ohdSvKS3k66SVCCGYdFl3B9goxUXyQgbAJX5MOK2/J4GH+drnlQczr+w/ctwRjGp6/0bDU4MozWVCkEVqTBB1TwvQ9rYA8fsewMPrgkH1zsNIDZbARqAdg1AFOYxcO5jzcHBdrYStR5b0IUYvljuM3uv9/12DzSd42bMZn25nfo5OMrM4qFc0Q1FX+trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAXL0JUFRI/sJSE0Zl9qqwiAQ0uPNAX6NGvIzluJNqs=;
 b=BwPyYnaQaeuF3pn9zCs6xQqnUDFfvbnWdPs81YL/ZqVUUjTc2iHn+FjP/dBEPuL+26zW6cJx+Eq8EM+aMtebWgwsItuIHQwH95iGrXXnsMYNMDkrXYej0woG4RnP9Mvpbjt89bUplKVuE5VO/NcGiovpOo5N4H01d9ohe4LKHZqP3ZeCg6zV9oUlodjC1pg4NdYJ4Sw8gv4HuvLZiUtVAaXDy8FPBt40xawkz5W1OR2GHZ1jLGypzvna7DjOFNqxzp4w5JcAIjJBEI4o0tV1i3T5gZeIAQOoW1lcNd+i2/VorRE2Ev2slF3SUuYKndCVK7hKK2JY7+iYuVLoK+IrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 20:43:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 20:43:17 +0000
Date:   Mon, 7 Dec 2020 16:43:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>
Subject: Re: [PATCH -tip v1 3/3] seqlock: kernel-doc: Specify when preemption
 is automatically altered
Message-ID: <20201207204316.GF552508@nvidia.com>
References: <20201206162143.14387-1-a.darwish@linutronix.de>
 <20201206162143.14387-4-a.darwish@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201206162143.14387-4-a.darwish@linutronix.de>
X-ClientProxiedBy: MN2PR11CA0030.namprd11.prod.outlook.com
 (2603:10b6:208:23b::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:208:23b::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 20:43:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kmNLo-007fHh-Dv; Mon, 07 Dec 2020 16:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607373801; bh=jAXL0JUFRI/sJSE0Zl9qqwiAQ0uPNAX6NGvIzluJNqs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=o75t/JvEgdh6zYyETzYbtRc/sJHI25l/Y54Y1dZux0AaHrllvOXraNyQXeG/e0HC7
         5Ksd1+8YES16tt2/7yLdYzKpaQkZfUyiuDaikFKINOThGAJly6gXi8fc3XvZN4wSeO
         UZfhNMrNm0vruBuNzL+L6ZQnzMwUUnIKBuitW08GkkySChI0fo+q3MBygX2RQTLd7K
         cDaKSPnsQgDlSllxG9w5QALd2yeFbMHHfxSdOup+UUlw/VKEBjh9J1xwfD7CYlzMAa
         /VY9RenNl4iVxkcbdHA5c64ytvsGy9TczsFyuKLZIrpPcr/HhPU+hm2tAvOvb+mrtx
         hPEPQSblldsww==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 05:21:43PM +0100, Ahmed S. Darwish wrote:
> @@ -519,11 +524,10 @@ static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
>   * write_seqcount_begin() - start a seqcount_t write side critical section
>   * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
>   *
> - * write_seqcount_begin opens a write side critical section of the given
> - * seqcount_t.
> - *
> - * Context: seqcount_t write side critical sections must be serialized and
> - * non-preemptible. If readers can be invoked from hardirq or softirq
> + * Context: sequence counter write side sections must be serialized and
> + * non-preemptible. Preemption will be automatically disabled if and
> + * only if the seqcount write serialization lock is associated, and
> + * preemptible.  If readers can be invoked from hardirq or softirq
>   * context, interrupts or bottom halves must be respectively disabled.
>   */

The thing that was confusing is if it was appropriate to use a
seqcount in case where write side preemption was not disabled - which
is safe only if the read side doesn't spin.

We seem to have only two places that do this, but since this comment
reads like it is absolutely forbidden, it is still confusing..

To make it clear a read side API to work with the seqlock for
non-premption cases would be nice, then the language could be 'must be
non-premeptible if using read_seqcount_retry(), but if using NEWTHING
then it is not required'

Jason
