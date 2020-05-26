Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 103301A2D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 02:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDIAxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 20:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgDIAxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:53:12 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5BAC20857;
        Thu,  9 Apr 2020 00:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586393593;
        bh=RSc+yL/VO14aC0/210vKAc1GSuXmJW4M6U6zQD4b218=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QKaVHmmZTVK06npEemcudHoYOCs2BsKd1rtjMEamtNH9TuaYl0m3r23pii1GGoB7w
         sGGggHbJca+Om5vA/10uh/w+qIkBiexKeIS2OUkSNvwzRGpLjFYZFdmfDGoV7RtWpk
         6ioNgLu7cV57PV0gFVa1W7QbXe/CZUV5gg1GGtqc=
Date:   Wed, 8 Apr 2020 17:53:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Aslan Bakirov <aslan@fb.com>, Michal Hocko <mhocko@kernel.org>,
        <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v5 1/2] mm: cma: NUMA node interface
Message-Id: <20200408175312.14a055276b676edaefe636e2@linux-foundation.org>
In-Reply-To: <20200407163840.92263-2-guro@fb.com>
References: <20200407163840.92263-1-guro@fb.com>
        <20200407163840.92263-2-guro@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Apr 2020 09:38:39 -0700 Roman Gushchin <guro@fb.com> wrote:

> From: Aslan Bakirov <aslan@fb.com>
> 
> I've noticed that there is no interfaces exposed by CMA which would let me
> to declare contigous memory on particular NUMA node.
> 
> This patchset adds the ability to try to allocate contiguous memory on
> specific node. It will fallback to other nodes if the specified one
> doesn't work.
> 
> Implement a new method for declaring contigous memory on particular node
> and keep cma_declare_contiguous() as a wrapper.
> 
> Signed-off-by: Aslan Bakirov <aslan@fb.com>
> Acked-by: Michal Hocko <mhocko@kernel.org>

This should have had your signed-off-by, as you were on the patch
delivery path.  Please send it along?

