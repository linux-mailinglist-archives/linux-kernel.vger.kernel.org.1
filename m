Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D412581A4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 21:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgHaTP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 15:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgHaTP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 15:15:56 -0400
Received: from X1 (unknown [65.49.58.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69CBE2068F;
        Mon, 31 Aug 2020 19:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598901356;
        bh=GDy1fsI36v2ZyxfLvzTCNTXvzujrkKd4Gu/L2okdFrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=atYzD5gpMnIG6BFdeJ/em0LdLf1SHIZektt7yokFaON6dBOuazpy6TdDZ1BDD4kRJ
         7ibDldGN9Kh+T9Fz1RkWQHzdztYTxNdYBenNZkEWvazPxsPj0n9jfVuGJHpOk3HtB7
         QYaGjrSXSPNiPT7D2uOWcEtCkPml7P6EQnn8sEac=
Date:   Mon, 31 Aug 2020 12:15:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-Id: <20200831121553.8be5dcdbdbc5256846ac513e@linux-foundation.org>
In-Reply-To: <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
        <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 13:53:36 +0200 Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> 
> 
> On 28.08.20 16:03, Gerald Schaefer wrote:
> have some feedback soon if option 1 or option 2 would be acceptable 
> from a common code perspective. Andrew, who of the mm people would 
> be the right one to decide?

Jason and John Hubbard are doing most of the work in there at present,

Both patches look OK to me from a non-s390 perspective.  Unless we plan
to implement Jason's more-general approach this time, I'd be inclined
to defer to the s390 people as to the preferred implementation.
