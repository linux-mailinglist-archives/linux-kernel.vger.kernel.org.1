Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3291D21F7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 00:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbgEMWYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 18:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbgEMWYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:24:11 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D9842054F;
        Wed, 13 May 2020 22:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589408650;
        bh=U41NlTPB0wfHYGDiF7XrS0IZZShwSsBDVPRsEKu+oSo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J9weGmeOcUpSqZh7nMWcNIPqMaxCgtwgoiJcT4adpsLMP/TM8EvrZ5jEvMyDmvOR7
         mh8izVKACNOMaoOOXejYUSQl+9shTLi4G2kaBjiizaipWkIyzBf3VmTWoxiZsaym0o
         tWIpquxllmVJoKeD5kqlfISqmrITnE5QUzDU6nZk=
Date:   Wed, 13 May 2020 15:24:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <charante@codeaurora.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: reset the zone->watermark_boost early
Message-Id: <20200513152409.ed90e927cf0a3832378fb723@linux-foundation.org>
In-Reply-To: <ea46cdfd-526c-5109-2c09-263effb676dd@codeaurora.org>
References: <1589204408-5152-1-git-send-email-charante@codeaurora.org>
        <20200511131155.0b40ee443c3367e8f748b16f@linux-foundation.org>
        <1cf5e778-eae1-fc71-aed4-d84d664d79dd@codeaurora.org>
        <ea46cdfd-526c-5109-2c09-263effb676dd@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 15:16:53 +0530 Charan Teja Kalla <charante@codeaurora.org> wrote:

> So, yes, this problem is got fixed with the changes made in this patch.

OK, thanks.

Could you please prepare a v2 with a changelog which includes the
additional info in your two replies?

