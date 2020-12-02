Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D20A2CB690
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgLBIPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgLBIPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:15:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038BDC0613D4;
        Wed,  2 Dec 2020 00:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8oE2Yc7YE7u7dolscX1PToo/lXblCtSzMf78LGUfOfQ=; b=qPKBXqiw2fKPrKZd+2C9iasZ1c
        JPqH87yU9Jrxb7qZ9gVoMW3uMVjFvKD5Pnn9Kwm+1BZLByPm9s5kDSFNgQrwVM4wu8CFi+WpSoEu/
        M1yVeQN73H4TYYVG2kPNjTMWdw43WPR/lj5AmPU7RR4D0BypWcw8pZbAb8sFoL4rAgF7R1HpxNqqy
        kwJr9Ju7bdg6irqdRtiRNcsyye7fEtH9XUFcpmJBckIFRbaRRSnZDgYL3/fAoCHWs6CH4uqDHJWzt
        jzqwvR2vKGsjmikPxB/64W8/K8UZ+JlYdmNww7DIYKs7mMKB1g1irAqSQxGQINVRAm4tvMjmuFrIT
        Dmc28XGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkNHK-0004ys-SM; Wed, 02 Dec 2020 08:14:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 624D63035D4;
        Wed,  2 Dec 2020 09:14:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5419F2C87A73C; Wed,  2 Dec 2020 09:14:22 +0100 (CET)
Date:   Wed, 2 Dec 2020 09:14:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 15/16] refcount.h: fix a kernel-doc markup
Message-ID: <20201202081422.GG3021@hirez.programming.kicks-ass.net>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
 <afb9bb1e675bf5f72a34a55d780779d7d5916b4c.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afb9bb1e675bf5f72a34a55d780779d7d5916b4c.1606823973.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:09:08PM +0100, Mauro Carvalho Chehab wrote:
> The kernel-doc markup is wrong: it is asking the tool to document
> struct refcount_struct, instead of documenting typedef refcount_t.
> 
> Fix it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks!
