Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F0C2CA7E9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404068AbgLAQO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392050AbgLAQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:14:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D495FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RnGA5Cc3+ZrsRdSAsahPpcoJsQNEjff88u4YaGWhsTo=; b=Wfmg+OHNLDPR49wJEmpRclrDIL
        S/j2mvnUegPbrs/9gS8CEPrHBj3ZJdlgiEphxf5H3JArP3fPnUW51xQrParI1vllsGyd6hAAuZBi/
        Z33Y8vgdwRtk8DiZhL7rodrxT1kGfxQ2RhC6ygMiEOOXy8ogQJ6ReiYIXUj3Q790mVbYU6s2sxPVv
        FQsZ/7CM8JNw9PUPkorYK77AWtajra0DKaoIbwp1x1WJ6Y71WlIxAibzMjVjTHluawX+PrGAxGXpd
        MgAnRa5IP4s52F/AZQNWo2XA5GblqbE0AwrzJQDtT9RJgT0RoS4g/YgC+a9G8K4VlGsrTWSquX8Jq
        yuwd5dJg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk8IA-0003By-KE; Tue, 01 Dec 2020 16:14:14 +0000
Date:   Tue, 1 Dec 2020 16:14:14 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        masahiroy@kernel.org, ndesaulniers@google.com, joe@perches.com
Subject: Re: [PATCH] genksyms: Ignore module scoped _Static_assert()
Message-ID: <20201201161414.GA10881@infradead.org>
References: <20201201152017.3576951-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201152017.3576951-1-elver@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why not use the kernels own BUILD_BUG_ON instead of this idiom?
