Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E552A19F802
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 16:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgDFOcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 10:32:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48057 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728406AbgDFOcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586183541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bs9O8CfSCjvxWFFcdHv5mM9YqkNdF8ds5U/VAdCzyFw=;
        b=C3nhFrZOZDa4yNKgTo8LXE1EPTnJxAQqx2AHxT/+Ia/DamhcHy7DBqQ3KC2ujmyUOD7ZRL
        vW9jg7avE65GUsRGVQSuqMfTzYsHl2Of5MuqY3aDhPn9t7tHH7yxVLhoUjhPMJGlxtXjDJ
        hGgZr4do0HvRa7DlFeVxjlEvvPbhK8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-7Z6zlaeENrSBANbE3-7d-Q-1; Mon, 06 Apr 2020 10:32:17 -0400
X-MC-Unique: 7Z6zlaeENrSBANbE3-7d-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB74413F7;
        Mon,  6 Apr 2020 14:32:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-224.rdu2.redhat.com [10.10.112.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8DFD39D368;
        Mon,  6 Apr 2020 14:32:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200406023700.1367-1-longman@redhat.com>
References: <20200406023700.1367-1-longman@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <102081.1586183529.1@warthog.procyon.org.uk>
Date:   Mon, 06 Apr 2020 15:32:09 +0100
Message-ID: <102082.1586183529@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> wrote:

> +static inline void kvfree_sensitive(const void *addr, size_t len)

Linus suggested making it non-inline.

David

