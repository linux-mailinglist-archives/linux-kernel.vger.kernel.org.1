Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B362A001A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgJ3IeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgJ3IeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:34:02 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E2620739;
        Fri, 30 Oct 2020 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604046841;
        bh=4VJTnbmp7NWwK1xGQze/bMYhxqLqSQGgQwrZ3xPyfg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nhVQMn82giyuUoqp0Uz5wzni6cmXqsGuaiyaiQjL86hfJWN4UJh9v8MDYR+LT8NLm
         TnIdvdO8IBsHkNq9lPcRUjEFn6AYCcevPqh/krkcBE+4xfN+bHlqIerwMT4HnSZuR9
         4MebKNR4jt6oyGUtu7BS30KWKC7MVQ/CZezm34xs=
Date:   Fri, 30 Oct 2020 08:33:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] kernel.h: Drop unneeded <linux/kernel.h> inclusion
 from other headers
Message-ID: <20201030083356.GC32163@willie-the-truck>
References: <20201028172826.41635-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028172826.41635-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 07:28:26PM +0200, Andy Shevchenko wrote:
> There is no evidence we need kernel.h inclusion in certain headers.

Did you run some tools to determine this or is it just a hunch?

Will
