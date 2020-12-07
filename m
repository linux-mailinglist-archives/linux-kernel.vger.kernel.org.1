Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EABF2D0DAE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgLGKBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:01:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726641AbgLGKB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607335202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MeeG0OxJl0Wqa0+h/cgdVYDpvRXoWkEFJelsPnzYQ2A=;
        b=hexA83EoXmPI3Xq84eJcOvN5e813gvCfnmWOoEJq7/T/h6csnFypdseaYQvYh3TxAxu9bK
        lihpmx/rR9qOMAdKZenywacbi2zLCPtft0NTW7EyCeGXXmnm/0k7EIi7ewGploaXGw4FG0
        /+CtHMD0DamRFIrhhZnVz21XVzi+Rik=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-sPqHAr3mPXqTffoVZvz_1g-1; Mon, 07 Dec 2020 04:59:58 -0500
X-MC-Unique: sPqHAr3mPXqTffoVZvz_1g-1
Received: by mail-wm1-f72.google.com with SMTP id k126so2196616wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 01:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MeeG0OxJl0Wqa0+h/cgdVYDpvRXoWkEFJelsPnzYQ2A=;
        b=E9IbK8PMEoSxHlKrpBKmpZezRMRqL0U02z+vnz7CtpLAqiIt29wbIwr0piH6PD85DR
         CVkggqj2xdCNpmfkJl0FjUvgI6YX6idW2LOXTQdqFebBdjouidQxHieHn8weCV0/Jm7c
         EaqCicdYJdNKI5ReiDaMWwca0q9znga1/H03gMMyZzcH8yi2HG5qLj/B7xCsihwokM/+
         Wo1mrmEn8ET7SDzOKGHG83kc3CY1xukfTR2ooro2VXI5kfaIMQvopJl81s0utu37chjN
         7/OSPgNKG4BV4S0L3/rtKxWwIMTtaSYFHi4W7La9wVs5VAi12IUIRRCVErkSdOM7ZTUj
         l3mw==
X-Gm-Message-State: AOAM532t/j1WSpMiQFfk9QeFamI/c/3CFTH4aSVVsMrQzr2Y6qWTen2Q
        Hj820Ln1khcprD/W1RkoX52Do8kwKZrJrwY+VcnZJ314F9y6XDKOnm7wUVAwKeUodMy2t1HscKy
        Ji9oRr0hql0T+MxbvgaW7COTk
X-Received: by 2002:adf:c648:: with SMTP id u8mr18783891wrg.215.1607335197818;
        Mon, 07 Dec 2020 01:59:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDi2lyVb4GCNib4TwGV0pQfYMjbA1IKPguqVDqsqxyLFn/MepU5WZs0cTe5uAf0UGWQriXsA==
X-Received: by 2002:adf:c648:: with SMTP id u8mr18783877wrg.215.1607335197622;
        Mon, 07 Dec 2020 01:59:57 -0800 (PST)
Received: from steredhat (host-79-24-227-66.retail.telecomitalia.it. [79.24.227.66])
        by smtp.gmail.com with ESMTPSA id m4sm13401938wmi.41.2020.12.07.01.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 01:59:57 -0800 (PST)
Date:   Mon, 7 Dec 2020 10:59:54 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Andra Paraschiv <andraprs@amazon.com>
Cc:     netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        David Duncan <davdunc@amazon.com>,
        Dexuan Cui <decui@microsoft.com>,
        Alexander Graf <graf@amazon.de>,
        Jorgen Hansen <jhansen@vmware.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH net-next v2 3/4] af_vsock: Set VMADDR_FLAG_TO_HOST flag
 on the receive path
Message-ID: <20201207095954.5gvp557xnulvledx@steredhat>
References: <20201204170235.84387-1-andraprs@amazon.com>
 <20201204170235.84387-4-andraprs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201204170235.84387-4-andraprs@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 07:02:34PM +0200, Andra Paraschiv wrote:
>The vsock flags can be set during the connect() setup logic, when
>initializing the vsock address data structure variable. Then the vsock
>transport is assigned, also considering this flags field.
>
>The vsock transport is also assigned on the (listen) receive path. The
>flags field needs to be set considering the use case.
>
>Set the value of the vsock flags of the remote address to the one
>targeted for packets forwarding to the host, if the following conditions
>are met:
>
>* The source CID of the packet is higher than VMADDR_CID_HOST.
>* The destination CID of the packet is higher than VMADDR_CID_HOST.
>
>Changelog
>
>v1 -> v2
>
>* Set the vsock flag on the receive path in the vsock transport
>  assignment logic.
>* Use bitwise operator for the vsock flag setup.
>* Use the updated "VMADDR_FLAG_TO_HOST" flag naming.
>
>Signed-off-by: Andra Paraschiv <andraprs@amazon.com>
>---
> net/vmw_vsock/af_vsock.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d10916ab45267..83d035eab0b05 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -431,6 +431,18 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 	unsigned int remote_cid = vsk->remote_addr.svm_cid;
> 	int ret;
>
>+	/* If the packet is coming with the source and destination CIDs higher
>+	 * than VMADDR_CID_HOST, then a vsock channel where all the packets are
>+	 * forwarded to the host should be established. Then the host will
>+	 * need to forward the packets to the guest.
>+	 *
>+	 * The flag is set on the (listen) receive path (psk is not NULL). On
>+	 * the connect path the flag can be set by the user space application.
>+	 */
>+	if (psk && vsk->local_addr.svm_cid > VMADDR_CID_HOST &&
>+	    vsk->remote_addr.svm_cid > VMADDR_CID_HOST)
>+		vsk->remote_addr.svm_flags |= VMADDR_FLAG_TO_HOST;
>+
> 	switch (sk->sk_type) {
> 	case SOCK_DGRAM:
> 		new_transport = transport_dgram;
>-- 
>2.20.1 (Apple Git-117)
>
>
>
>
>Amazon Development Center (Romania) S.R.L. registered office: 27A Sf. Lazar Street, UBC5, floor 2, Iasi, Iasi County, 700045, Romania. Registered in Romania. Registration number J22/2621/2005.
>

