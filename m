Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B251B27B84D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgI1XgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgI1XgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:36:05 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1026F2076A;
        Mon, 28 Sep 2020 23:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601336165;
        bh=K6+N90by/AN+fqbPOBNLj0Ir8XD++33D9Ge+XcBFjxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vb+1C4TAJWJoMTwcxTxYm9O4u+MeR0Gv6LouutJ3XHiiMJVZNoJjrI5zfTIZrfFv4
         DjGKxiZqj/+Ua1vQOZbGF22AxUYkwi5iH0aI/wJ1bVxUADgbdllCFZrjHEZUsazkDX
         6OE5I3NPWX7N7U9ctf8khnlswy+9CyjUEyowoP2Y=
Date:   Mon, 28 Sep 2020 16:36:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mm: remove unused early_pfn_valid()
Message-Id: <20200928163604.a2c64a16bdc7e68985f53443@linux-foundation.org>
In-Reply-To: <20200928144900.GA2142832@kernel.org>
References: <20200923162915.26935-1-rppt@kernel.org>
        <20200928144900.GA2142832@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 17:49:00 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> ping?
> 

Merged Sep 24.

https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-remove-unused-early_pfn_valid.patch


