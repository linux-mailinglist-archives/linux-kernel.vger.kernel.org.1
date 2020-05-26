Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5E01E26B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 18:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgEZQTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 12:19:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36496 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728280AbgEZQTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590509945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hN2Hvu1E+MNK/Jpuu31JE8GIcAFc/Q6IIqnIGW+R/bo=;
        b=AGd+jNU2aPlXPYpsco2UQwyOR3TNGbYpa9FtuJ4uQoBwXhPKETclfSck9AIh7W1sNmIZ6S
        am0aBfLCOgUsTAoQTrH6wcetjEJno+Fj9++wZKXUcZVpKemCLX1tNqAaEu+7A7lpp7ShUI
        N6O1/m7uEeKOlKd5q1Me0K6KWpzO/Vo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-lYY4dhG4NTKgP84AbEnxBQ-1; Tue, 26 May 2020 12:19:03 -0400
X-MC-Unique: lYY4dhG4NTKgP84AbEnxBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2D29461;
        Tue, 26 May 2020 16:19:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25C265C1BB;
        Tue, 26 May 2020 16:18:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1590415886-52353-1-git-send-email-xiyuyang19@fudan.edu.cn>
References: <1590415886-52353-1-git-send-email-xiyuyang19@fudan.edu.cn>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] afs: Fix afs_cb_interest refcnt leak in afs_select_fileserver()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3193792.1590509939.1@warthog.procyon.org.uk>
Date:   Tue, 26 May 2020 17:18:59 +0100
Message-ID: <3193793.1590509939@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiyu Yang <xiyuyang19@fudan.edu.cn> wrote:

>  	error = afs_wait_for_fs_probes(fc->server_list, fc->untried);
> -	if (error < 0)
> +	if (error < 0) {
> +		afs_put_cb_interest(afs_v2net(vnode), fc->cbi);
>  		goto failed_set_error;
> +	}

Ummm...  Did you try this?  afs_end_vnode_operation() should then cause a
double free because you don't clear fc->cbi.

You can try it by installing the kafs-client package if your distribution has
it available and starting the afs.mount service or doing:

	mount -t afs none /afs -o dyn

and then:

	ls /afs/grand.central.org/

David

