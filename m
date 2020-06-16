Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91331FA566
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 03:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgFPBJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 21:09:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29764 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726327AbgFPBJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 21:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592269752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ETWPRcEqi2xYFGp+N9uQV1NdwMdzaSSeQcMx7Y54xII=;
        b=fynY8KlQ0wPJzTOR0hB2QsARRE4CEPkp/T2nON5CPUOHx17+uJOem06QxjBhmwLQ6EnMEf
        S1ODIS8HxlGXYUR6v2hmkD4J1Jde7N0jTXl0KJz+J5BB5bolwwVCeuXbx2IxC8v9CUGYg2
        bDicH8/OgRGsjQ09ipKTJvWQKuh20ps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-IK-OBL4MO1ew5gV1Gmu6rw-1; Mon, 15 Jun 2020 21:09:10 -0400
X-MC-Unique: IK-OBL4MO1ew5gV1Gmu6rw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BE8010059BA;
        Tue, 16 Jun 2020 01:09:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-66.rdu2.redhat.com [10.10.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 079B060C05;
        Tue, 16 Jun 2020 01:09:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200615232751.GA22366@embeddedor>
References: <20200615232751.GA22366@embeddedor>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] afs: Use array3_size() helper in afs_extract_to_buf()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <761786.1592269747.1@warthog.procyon.org.uk>
Date:   Tue, 16 Jun 2020 02:09:07 +0100
Message-ID: <761787.1592269747@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gustavo A. R. Silva <gustavoars@kernel.org> wrote:

> Use array3_size() helper instead of the open-coded version in
> afs_extract_to_buf(). These sorts of multiplication factors need
> to be wrapped in array3_size().

For afs_deliver_cb_callback(), this adds redundant checking, as does the one
on the kmalloc() on the preceding line:

		call->buffer = kmalloc(array3_size(call->count, 3, 4),
				       GFP_KERNEL);
		if (!call->buffer)
			return -ENOMEM;

because directly above them is a range check:

		if (call->count > AFSCBMAX)
			return afs_protocol_error(call, afs_eproto_cb_fid_count);

limiting the array size to 50.

Further, note that it's *not* a 3D array.  3 * 4 is the element size and is
constant.  I've written it that way as the block is 3 XDR units, but the block
size is actually 12 bytes.

The one in the kmalloc() should also not be using array3_size() for the same
reason.

David

