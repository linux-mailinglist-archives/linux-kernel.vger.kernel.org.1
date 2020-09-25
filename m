Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE71277E33
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 04:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgIYCvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 22:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIYCvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 22:51:04 -0400
Received: from X1 (unknown [104.245.68.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACD0C20888;
        Fri, 25 Sep 2020 02:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601002264;
        bh=9iiDwn+SaGZ5mDb8sDbkHSkqvTf2xFnRKAi2IgQ2rT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xT3a/BgpifRvKsK4eavNKFzc7lYONbRZq3JgQuGFKmUEG0/Qu8hqBXpJDF+GLcrID
         ZkfRgyv8L+pAeEOHa0h4CoEPyhzXz7j4SzLn7RlrD3s6HqpgtpsNQz6qqa+GaKjYA+
         93ynesWZxI9iFDG04H/HSOOG48T6wUX16wQulRFE=
Date:   Thu, 24 Sep 2020 19:51:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [v3 1/2] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
Message-Id: <20200924195103.8d6cc9fcd60802baef3107c6@linux-foundation.org>
In-Reply-To: <4adef7e1-039f-0ef6-1231-5522a43e4095@linux.microsoft.com>
References: <1600305709-2319-1-git-send-email-vijayb@linux.microsoft.com>
        <1600305709-2319-2-git-send-email-vijayb@linux.microsoft.com>
        <4adef7e1-039f-0ef6-1231-5522a43e4095@linux.microsoft.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 14:27:30 -0700 Vijay Balakrishna <vijayb@linux.microsoft.com> wrote:

> Can this patch be included?  As Kirill is ok with patch now.

He is?  I can't immediately find that email.

Do we have an acked-by?
