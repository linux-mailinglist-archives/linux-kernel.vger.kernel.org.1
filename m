Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FF021D08C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 09:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgGMHm4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Jul 2020 03:42:56 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:41180 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMHmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:42:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D62F86261CAB;
        Mon, 13 Jul 2020 09:42:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HEIT-oUNXO2T; Mon, 13 Jul 2020 09:42:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DC4CC6071A74;
        Mon, 13 Jul 2020 09:42:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Jw1EuLf1JemD; Mon, 13 Jul 2020 09:42:51 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id B4DF4607401D;
        Mon, 13 Jul 2020 09:42:51 +0200 (CEST)
Date:   Mon, 13 Jul 2020 09:42:51 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     tj@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ebiederm@xmission.com, dan j williams <dan.j.williams@intel.com>
Message-ID: <26112734.125046.1594626171647.JavaMail.zimbra@nod.at>
In-Reply-To: <20200704205619.11172-1-richard@nod.at>
References: <20200704205619.11172-1-richard@nod.at>
Subject: Re: [PATCH] [RFC] kernfs: Allow vm_ops->close() if VMA is never
 split
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: kernfs: Allow vm_ops->close() if VMA is never split
Thread-Index: 5s35c3UGXLSfPDR9XGUGZynzLnIxuA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "richard" <richard@nod.at>
> An: "linux-kernel" <linux-kernel@vger.kernel.org>
> CC: tj@kernel.org, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, ebiederm@xmission.com, "dan j williams"
> <dan.j.williams@intel.com>, "richard" <richard@nod.at>
> Gesendet: Samstag, 4. Juli 2020 22:56:19
> Betreff: [PATCH] [RFC] kernfs: Allow vm_ops->close() if VMA is never split

> 10 years ago commit a6849fa1f7d7 ("sysfs: Fail bin file mmap if vma close is
> implemented.")
> removed support for vm_ops->close() for mmap on sysfs.
> As far I understand the reason is that due to the wrapping in kernfs
> every VMA split operation needs to be tracked to call vm_ops->close()
> for all fragments. This is not feasible with reasonable effort.
> 
> Since commit 31383c6865a5 ("mm, hugetlbfs: introduce ->split() to
> vm_operations_struct")
> we can get notified as soon a VMA is split, this can help to relax the
> restriction.
> So I propose to allow having a custom close under the condition that a
> VMA cannot get split.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

*friendly ping*

Thanks,
//richard
