Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FC42B8272
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgKRQ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:57:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbgKRQ5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605718658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJ2Qc8RyyYf71yqtHDr0ytNLgJOQ31gbzsZeEcW9UFo=;
        b=dawcZkCp6ZHipqgo5zCjZ/1OyiqqfaWKwmLqNat9rySeF7+bfpPpAWK3XBlQWv+VvDLYl8
        SeAHvn/ZmqxgJLJjqxSoSzJyOzCXZhBp5skyLmbj98uYtMHFXr/K/bPtAI57OQ52WW64oi
        75Iy5V996OYaa6GZbF6SIlsGeg+80Js=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-ni52JxXcOJ-E-OO4q9QjFQ-1; Wed, 18 Nov 2020 11:57:34 -0500
X-MC-Unique: ni52JxXcOJ-E-OO4q9QjFQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB7BF8A8F03;
        Wed, 18 Nov 2020 16:57:32 +0000 (UTC)
Received: from localhost (ovpn-115-101.rdu2.redhat.com [10.10.115.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7474A1E5;
        Wed, 18 Nov 2020 16:57:32 +0000 (UTC)
Date:   Wed, 18 Nov 2020 11:57:30 -0500
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC] Add kernel-doc test script
Message-ID: <20201118165730.GL1509407@habkost.net>
References: <20201030144713.201372-1-pbonzini@redhat.com>
 <20201030144713.201372-3-pbonzini@redhat.com>
 <20201113152106.7b4a07ee@lwn.net>
 <20201113223912.GK17076@casper.infradead.org>
 <20201117212452.GM1235237@habkost.net>
 <20201117213051.GA29991@casper.infradead.org>
 <20201117223612.GN1235237@habkost.net>
 <16145b8b-3213-8bc9-1826-d3ae006f78fa@infradead.org>
 <20201118130344.GD1509407@habkost.net>
 <b0d6dc09-49ea-f96e-278a-6fc0f78de810@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0d6dc09-49ea-f96e-278a-6fc0f78de810@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 08:32:35AM -0800, Randy Dunlap wrote:
> On 11/18/20 5:03 AM, Eduardo Habkost wrote:
> > On Tue, Nov 17, 2020 at 04:23:49PM -0800, Randy Dunlap wrote:
> >> On 11/17/20 2:36 PM, Eduardo Habkost wrote:
> >>> Add a kernel-doc test script to tools/testing/kernel-doc.
> >>>
> >>> radix_tree_lookup_slot test case provided by Matthew Wilcox.
> >>>
> >>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >>
> >> Very good idea.
> >>
> >> I have had a kernel-doc test source file for (?) 10-12 years,
> >> while I was the docs maintainer.
> > 
> > Is that test source file recoverable somewhere?  It probably has
> > useful test cases not included here.
> 
> Sure.  Of course, it may be out of date by quite a bit.
> I last updated it in 2016:
> -rw-r--r-- 1 rdunlap users  41737 Jun 17  2016 megatest.c
> 
> (attached)
> 

Thanks!  Are the contents licensed under GPL 2.0?

-- 
Eduardo

