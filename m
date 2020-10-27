Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAA129AA3B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898913AbgJ0LFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2898906AbgJ0LFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603796753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrjeCAan5jwNXoKxJoHy3Krr60faw0rldSpx6L/g/YM=;
        b=QAHatsGNIWsbbpQY/mVJnieTBypB02TkZxDleKxk9wi5CIxfeCaeWH1UpRNQCyjPH1Mhez
        2xknsRNKLyNrjr7z/HDRXeefNeHEPaGp1+tT2bowZpXGOUGKa+iulydcMNjuVit33dBoKP
        3xbg2/RRcV/EvzvztsjsVmb9TC9Gmzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-Hb0IV2mzMM6PWJegTkv_9w-1; Tue, 27 Oct 2020 07:05:49 -0400
X-MC-Unique: Hb0IV2mzMM6PWJegTkv_9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9201D101F7A6;
        Tue, 27 Oct 2020 11:05:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-70.rdu2.redhat.com [10.10.120.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 899275D9F3;
        Tue, 27 Oct 2020 11:05:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20201021131133.128016-1-colin.king@canonical.com>
References: <20201021131133.128016-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] afs: fix a dereference on pointer cell before cell is null checked
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3189276.1603796746.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 27 Oct 2020 11:05:46 +0000
Message-ID: <3189277.1603796746@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> @@ -606,7 +605,7 @@ void afs_unuse_cell(struct afs_net *net, struct afs_=
cell *cell, enum afs_cell_tr
>  =

>  	u =3D atomic_read(&cell->ref);
>  	a =3D atomic_dec_return(&cell->active);
> -	trace_afs_cell(debug_id, u, a, reason);
> +	trace_afs_cell(cell->debug_id, u, a, reason);

It's probably better to read cell->debug_id before calling
atomic_dec_return().

I have a patch for this based on a report by Dan Carpenter, so no need to =
send
a revised patch.

Thanks,
David

