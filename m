Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3542C8077
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 10:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgK3JAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 04:00:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727898AbgK3JAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 04:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606726729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nDg6iDpe09BGQ2ds0qWGfXNObs01XEbQ2U8+SA4vu50=;
        b=dEuk8vRmIRv+Bt4T8kPmo43+dvn14/4YrcfwcQKVplgyPKvOeZcIUtfU7qMRKnr4eQjhAA
        cU+xTmsxzHgekUFbucqfJpdYcp3PMnH0gJMcBgvbgKx18+0mxRLmM5PirLkVOPa7ZRz/41
        ZZNw9udUE62qTcygWeLu06nBCWDd56A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12--wQ3umdLNvW5c761S-VEyQ-1; Mon, 30 Nov 2020 03:58:44 -0500
X-MC-Unique: -wQ3umdLNvW5c761S-VEyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E619E80EFB0;
        Mon, 30 Nov 2020 08:58:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-159.rdu2.redhat.com [10.10.112.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F156C10016FB;
        Mon, 30 Nov 2020 08:58:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201129044514.GH39488@kernel.org>
References: <20201129044514.GH39488@kernel.org> <20201127191543.2854306-1-trix@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     dhowells@redhat.com, trix@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: remove trailing semicolon in macro definition
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3048452.1606726722.1@warthog.procyon.org.uk>
Date:   Mon, 30 Nov 2020 08:58:42 +0000
Message-ID: <3048453.1606726722@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> I'm in-between whether this is worth of merging. The commit message
> does not help with that decision too much.

It is worth merging.  It might cause problems for someone using it in the body
of an if-statement, say, if they don't put braces in, but do put a semicolon
on the end.  I'll add it to my branch.

David

