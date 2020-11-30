Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB112C81AF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgK3KFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:05:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgK3KFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606730663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2HTRFOjw+TomkdVoKhsPrdh28bt5QNRrLXAeIOSfBdY=;
        b=GYYUTumLplVNmG4MYvwAsua3cLbAbHSLx8DRz0+XP60paCyU6JcMAxQT0AdeyOnhdytK7L
        8mHTYZ8A6Wri2M8C01HIxS1UvY4etIxj0UuIsrr4T0zRFv2YsTM62l3gnMv2BBiPstFHPz
        dWVlZQj7VZTxNPXi9s6GQ0kqA4qQ1oE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-ZeSccZCNPKqUNquGz1m8ow-1; Mon, 30 Nov 2020 05:04:21 -0500
X-MC-Unique: ZeSccZCNPKqUNquGz1m8ow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BC7F1009466;
        Mon, 30 Nov 2020 10:04:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-159.rdu2.redhat.com [10.10.112.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5195C5D9D2;
        Mon, 30 Nov 2020 10:04:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1604673513-29088-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1604673513-29088-1-git-send-email-alex.shi@linux.alibaba.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     dhowells@redhat.com, David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] certs/blacklist: fix kernel doc interface issue
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3096974.1606730658.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 30 Nov 2020 10:04:18 +0000
Message-ID: <3096975.1606730658@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Shi <alex.shi@linux.alibaba.com> wrote:

>  /**
>   * mark_hash_blacklisted - Add a hash to the system blacklist
> - * @hash - The hash as a hex string with a type prefix (eg. "tbs:23aa42=
9783")
> + * @hash: - The hash as a hex string with a type prefix (eg. "tbs:23aa4=
29783")

You should remove the dash when making this change.  I'll do that for you.

David

