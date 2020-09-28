Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2D27B853
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgI1Xhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgI1Xhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:37:36 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2997C2076A;
        Mon, 28 Sep 2020 23:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601336256;
        bh=loBN+IeSLb01SQBFekIZz8J7kp88qGdvWG+Ee6P3UC4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=frYTv0jpFbDjKdQFq4wprwTs5/zwnxNx7LN/XpavDLTbJzfen4fSkEsjPHQNaoZD+
         Xjl1C7iI7riwJ5/ove1MuPsEYMnVEFX5JaJECiumrmm/7le2Fz3JMnLZAqEzVrMU1/
         y2DDmo6uX9ZJ4tQrkh13NlopsiEeO2JCgaI3RZpk=
Date:   Mon, 28 Sep 2020 16:37:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mm: __do_fault: fix pte_alloc_one spelling
Message-Id: <20200928163735.2e031fb34b5c043596adcd75@linux-foundation.org>
In-Reply-To: <20200928144836.GZ2142832@kernel.org>
References: <20200914115833.2571188-1-rppt@kernel.org>
        <20200928144836.GZ2142832@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 17:48:36 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> ping?

August 18, from Yanfei Xu:

https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-memory-fix-typo-in-__do_fault-comment.patch

