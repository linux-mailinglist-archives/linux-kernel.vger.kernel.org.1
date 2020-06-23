Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2308620583C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 19:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbgFWRF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 13:05:29 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3414 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733122AbgFWRF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:05:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef2362a0000>; Tue, 23 Jun 2020 10:04:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 23 Jun 2020 10:05:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 23 Jun 2020 10:05:27 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 17:05:19 +0000
Subject: Re: [RESEND PATCH] mm: fix migrate_vma_setup() src_owner and normal
 pages
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200622222008.9971-1-rcampbell@nvidia.com>
 <20200623114018.GA17496@lst.de>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <a0dbf913-2bd0-b032-596e-520e678d5b5b@nvidia.com>
Date:   Tue, 23 Jun 2020 10:05:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200623114018.GA17496@lst.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592931882; bh=LpQ2zGZVOmahHX1vAuLi7+PQSkr9TwEwLTdZ3LbL6gU=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hSZPAH15zaLQF486x5J9/6yhimjviSDyMYm7jy00lfHnH7tWVEF7cnoWErsxd60kO
         JGyaj0N9upMFlptBi9qOUQzQLedslYPhQ6sn7pVblFTvuSV8jQsSuaQcxzh1cr/JXm
         R0hD1VJFftGd8IMWTk2cftrZX46K7nKt13cALpKQaLA9RSAg8r1JBGp7rS7a49Eagf
         kn36hMlJfjCl0LIBWndRbxIIG7PxwC/Nuql8fL4qtU0Q6Md+VVg2OMaBPOtpGfPFtI
         Q2ghwd99WyjCvJuWpBy0J4qxxv2deKp6CP37F+h36Uw7/VgQaCshtcBfbyXbYakaNn
         oi42ZF1t9U/ow==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/23/20 4:40 AM, Christoph Hellwig wrote:
> On Mon, Jun 22, 2020 at 03:20:08PM -0700, Ralph Campbell wrote:
>> The caller of migrate_vma_setup() does not know what type of page is
>> stored in the CPU's page tables. Pages within the specified range are
>> free to be swapped out, migrated, or freed until after migrate_vma_setup()
>> returns. The caller needs to set struct migrate_vma.src_owner in case a
>> page is a ZONE device private page that the device owns and might want to
>> migrate. However, the current code skips normal anonymous pages if
>> src_owner is set, thus preventing those pages from being migrated.
>> Remove the src_owner check for normal pages since src_owner only applies
>> to device private pages and allow a range of normal and device private
>> pages to be migrated.
> 
> src_owner being set means we want to migrate from device private
> memory to normal host DRAM.  What kind of problem do you see of
> not touching already present pages in that path?
> 

The problem is that migrate_vma_setup() invalidates the address range so any
previously migrated pages to device private memory have to be faulted in
again. By having the PFN of those device private pages in the src array, the
driver can reinstate the device MMU mappings and avoid the page faults.
