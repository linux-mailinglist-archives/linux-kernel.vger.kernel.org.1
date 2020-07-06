Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98942161D3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 01:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgGFXEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 19:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgGFXEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:04:16 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1137320723;
        Mon,  6 Jul 2020 23:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594076655;
        bh=NN0zw6E+k1d9OSCRphweuAXQl0YWLIAiZehjtdeXUhI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SJ7lfb3wtS7Ro4s6pnM5O6styAzoxY3NoA3FIkMSOaqyzksaUZDPG0W/qE0+2QzbK
         xI6Tmked0/xDQwGZzIzeZPO01PSlQEzmLcBa50cM9QTZmSFNgeMTkF6wAHFrjOcSOo
         YKrh4a5hLBDj44+JZ2tii883O820MzmOEuCHTn4c=
Date:   Mon, 6 Jul 2020 16:04:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        vbabka@suse.cz, willy@infradead.org, thomas_os@shipmail.org,
        thellstrom@vmware.com, anshuman.khandual@arm.com,
        sean.j.christopherson@intel.com, aneesh.kumar@linux.ibm.com,
        peterx@redhat.com, walken@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, digetx@gmail.com
Subject: Re: [RESEND Patch v2 0/4] mm/mremap: cleanup move_page_tables() a
 little
Message-Id: <20200706160414.ad1ff64c5efc2d0abd087dab@linux-foundation.org>
In-Reply-To: <20200706220648.qfzwnitoswbbkdnw@master>
References: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
        <20200706100819.flwgozlstn3zl66u@box>
        <20200706220648.qfzwnitoswbbkdnw@master>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 22:06:48 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> >The patchet looks good to me. I have few nits, but nothing substantial.
> >
> >Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >
> 
> Hi, Kirill
> 
> Thanks for your review.
> 
> Andrew,
> 
> Do you want me to send another version or you would like to adjust it
> directly?

Please resend?
