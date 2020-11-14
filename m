Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6EE2B2EF4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 18:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgKNR1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 12:27:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42595 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbgKNR1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 12:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605374838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lfQwZC9YEADpefDeufIxu3TSYRi4xlUPbbTH8N+O+PE=;
        b=IsxiNBcx0kHvkQOm2Q0qhN0cFtXK4qe6xqeyNr+A/eikWhP+8szvdmNo2IkZmfhB//wVYm
        pcjoEkmXiRK9JZ84YNtW8fFtkA1YzOTwSNrFR56VbjnymPh+NNNKfurmIafCIjgDn7cak/
        TOc85onPbXb5MNcnyQcdRudiBNUfVuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-830PN4vbN2CZ5S5_3NWqQw-1; Sat, 14 Nov 2020 12:27:14 -0500
X-MC-Unique: 830PN4vbN2CZ5S5_3NWqQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B69E80EF8B;
        Sat, 14 Nov 2020 17:27:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-47.rdu2.redhat.com [10.10.115.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AF7E5D9E8;
        Sat, 14 Nov 2020 17:27:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <160537468016.3082569.17243477803724537224.stgit@warthog.procyon.org.uk>
References: <160537468016.3082569.17243477803724537224.stgit@warthog.procyon.org.uk>
Cc:     dhowells@redhat.com, torvalds@linux-foundation.org,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix afs_write_end() when called with copied == 0 [ver #2]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3082979.1605374831.1@warthog.procyon.org.uk>
Date:   Sat, 14 Nov 2020 17:27:11 +0000
Message-ID: <3082980.1605374831@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> -		SetPageUptodate(page);
> +		SetPageUptoodate(page);

I'm not sure what happened there.  Will try again :-(

