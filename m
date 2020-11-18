Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC292B8181
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgKRQIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:08:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgKRQId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605715713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BqNy/tQG7myMKclUBJ2s6npPTjs5n4WYRwYHbVNyVg=;
        b=H0igNk9D22aRDIXjT80KIsZeTlGDFjxnxGHk7nQqSXrYqUYlavH9TfP2jTeC2/kwUTdS3L
        VaRAGkohIXOO0O6eYbii3f8/L0xcBH3duLLBZqD1OINoKw/O4S5g3MRwk107f52n3re/kU
        AVO2igNYVhqUNdkTa0moeaqCAtkULNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-DZfKV5YgPiWbLUBe-DMavA-1; Wed, 18 Nov 2020 11:08:28 -0500
X-MC-Unique: DZfKV5YgPiWbLUBe-DMavA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5241D814608;
        Wed, 18 Nov 2020 16:08:27 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4ED25DA7B;
        Wed, 18 Nov 2020 16:07:48 +0000 (UTC)
Date:   Wed, 18 Nov 2020 11:07:48 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: md: dm-writeback: add __noreturn to BUG-ging function
Message-ID: <20201118160748.GA754@redhat.com>
References: <20201113225228.20563-1-rdunlap@infradead.org>
 <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com>
 <c29eeb5d-0683-49eb-f729-38b14fac7745@infradead.org>
 <20201117163147.GA27243@redhat.com>
 <20201118154944.GB545@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118154944.GB545@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18 2020 at 10:49am -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> I don't think my suggestion will help.. given it'd still leave
> persistent_memory_claim() without a return statement.
> 
> Think it worthwhile to just add a dummy 'return 0;' after the BUG().

Decided to go with this, now staged for 5.11:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.11&id=a1e4865b4dda7071f3707f7e551289ead66e38b1

