Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC17283762
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgJEOMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:12:14 -0400
Received: from ms.lwn.net ([45.79.88.28]:47794 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgJEOMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:12:14 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 423A32E4;
        Mon,  5 Oct 2020 14:12:12 +0000 (UTC)
Date:   Mon, 5 Oct 2020 08:12:10 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: optionally disable brk()
Message-ID: <20201005081210.2231e552@lwn.net>
In-Reply-To: <7d7b1ac5-d6a7-5e43-8fb8-12b844d7f501@gmail.com>
References: <20201002171921.3053-1-toiwoton@gmail.com>
        <653873ef-2a57-37e0-1ac3-fba763652b35@redhat.com>
        <2a0f5ade-d770-c36e-50bc-ff0c8e9dacbf@gmail.com>
        <20201005061248.GN4555@dhcp22.suse.cz>
        <7d7b1ac5-d6a7-5e43-8fb8-12b844d7f501@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Oct 2020 11:11:35 +0300
Topi Miettinen <toiwoton@gmail.com> wrote:

> The point is not to shrink the kernel (it will shrink by one small 
> function) or get rid of complexity. The point is to disable an inferior 
> interface. Memory returned by mmap() is at a random location but with 
> brk() it is located near the data segment, so the address is more easily 
> predictable.

So if your true objective is to get glibc to allocate memory differently,
perhaps the right thing to do is to patch glibc?

Thanks,

jon
