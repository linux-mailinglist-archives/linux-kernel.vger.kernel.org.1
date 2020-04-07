Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5D1A16BB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 22:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDGUYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 16:24:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22720 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgDGUYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586291071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4/CqPjYKIqhLe6o90l4etdHa0avAv3myBuxrGVzJJlk=;
        b=Rs5QZ5k0xvm+54gwbwIXO7SKbvbAFNEcVXp/QdDklfl4KaE7lz8jM1P5zWz+E8WF3RPanj
        vXNrV1j7Ddjx3xqKfeQ2PK4elQQUxshRsfntpXaqNB4Pm+a/p6FRx8l1/xEKsxl8qE63Fo
        YoGTSa+pozMOqwyux9Z+qhROwXfFunc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-60P6iwMSPu-ID1hyPHX0oA-1; Tue, 07 Apr 2020 16:24:30 -0400
X-MC-Unique: 60P6iwMSPu-ID1hyPHX0oA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50574190D341;
        Tue,  7 Apr 2020 20:24:28 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-180.rdu2.redhat.com [10.10.117.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D52ED19C7F;
        Tue,  7 Apr 2020 20:24:26 +0000 (UTC)
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data
 objects
To:     David Howells <dhowells@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
References: <20200407200318.11711-1-longman@redhat.com>
 <694135.1586290793@warthog.procyon.org.uk>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <025eb655-4c3f-6196-7f55-2987022c9b42@redhat.com>
Date:   Tue, 7 Apr 2020 16:24:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <694135.1586290793@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/20 4:19 PM, David Howells wrote:
> Waiman Long <longman@redhat.com> wrote:
>
>> sensitive data objects allocated by kvmalloc(). The relevnat places
> "relevant".

Oh, sorry about the typo. Maybe Andrew can fix it.

Cheers,
Longman

