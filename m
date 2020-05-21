Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026B41DC7DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 09:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgEUHls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 03:41:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25646 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgEUHls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:41:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590046907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oHQ+imPSFVixB/pE0KSN2Fs8U6r2Mmjiu0+HMJzZ/Tw=;
        b=b4JqpIwuO42nYOoiyIe2fP6uQTHrg9hwBpBJMXwnfUc3n7wRPX1qZq7FHnAuYFM6t5ia85
        4GWLnUCO00XUqO0A1XdUe0wDhWm7gda21rF54FjtC+3JD4GOwhD0TKFnUEMXTj6MXH3WUa
        jDluxP1IXfGMxgXaynZVqVWEVejcFhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-iHSdMCy9N26WBxgfRQv9uw-1; Thu, 21 May 2020 03:41:45 -0400
X-MC-Unique: iHSdMCy9N26WBxgfRQv9uw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 855D7835B41;
        Thu, 21 May 2020 07:41:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84E0379584;
        Thu, 21 May 2020 07:41:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <159001690181.18663.663730118645460940.stgit@warthog.procyon.org.uk>
References: <159001690181.18663.663730118645460940.stgit@warthog.procyon.org.uk>
To:     netdev@vger.kernel.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net 0/3] rxrpc: Fix retransmission timeout and ACK discard
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <70946.1590046902.1@warthog.procyon.org.uk>
Date:   Thu, 21 May 2020 08:41:42 +0100
Message-ID: <70947.1590046902@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've posted a new version of this with a fixed description for patch 1.

David

