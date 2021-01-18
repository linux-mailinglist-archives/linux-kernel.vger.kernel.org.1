Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B752FA3EF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404179AbhARPBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:01:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405292AbhAROxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610981527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bvHYXveaY1fYHKCh/4G0s4Eb72E980+xC2zhbE72Tuc=;
        b=FyOH29XzDEIYbttk4Mi0bU24VrkOgnqhwoY4qYvj8yO7YxApcqkbbA0QVlDxk7zNjzWvrU
        nqv6ifYuypBoMYgNR3ftGbVOrDyR7qdSiBberGXBjx4NaX/P+C43D1iCTTPm0F55t9J0Kv
        N1M2q2qZhMB9LMKBuM8uiCZboe78T/A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-D-5vz38ZNSiuvY4IWpWGxg-1; Mon, 18 Jan 2021 09:52:03 -0500
X-MC-Unique: D-5vz38ZNSiuvY4IWpWGxg-1
Received: by mail-wr1-f69.google.com with SMTP id z8so8410965wrh.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bvHYXveaY1fYHKCh/4G0s4Eb72E980+xC2zhbE72Tuc=;
        b=nTKEFzkBBwoNm5LlpVA92WpJuxYvTjwDfBk/dfVYzPBSxbeCVyZwPGEDFB6WAEI3rQ
         UzwFsDXZebUo/KkWkUF1zSr5E6MUXYO8vucS8LIek/9kZ/juf+g+emVilci1SIjOBuZU
         ZK0QNNm1Ur68PAsZ1gFXBW3YWLNE2DuA+t3VfRSbCJXMQbH3232zBX8/j34xngSIZxih
         ERpq2WqwZCHvQOzF2YrHbWIphpO9Tup/zkJ1cXMFphpNRIsXy5RiFn+JmqDmdZwo5e9R
         instpSXrLPAOEC0VBDiEuxnKfCrTN78bstGzcS8Z2dhrtn1D2nYatWCcfqgBKLXB28Hi
         0jtA==
X-Gm-Message-State: AOAM533cLajxmsWzEnlMjp1n9HgOol+jQyq64viwnisX94UxGebZ9Rlh
        mTCLIbyCc1IX+L7TkDfzYnBKmLmvebURProSWipj+g/0jfh9huwOHChIpw9DNIr1J89Cdty1rPg
        BBDJUMOddRVYE2rP3qpxbJbQg
X-Received: by 2002:a5d:42d0:: with SMTP id t16mr26110645wrr.230.1610981522393;
        Mon, 18 Jan 2021 06:52:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLYqyNMVyFEoAlbSpKAd9WKw+ODMCj85rmyuhMgWAf133vbbFpPK94WXLLheaXzynpxdDRUg==
X-Received: by 2002:a5d:42d0:: with SMTP id t16mr26110629wrr.230.1610981522214;
        Mon, 18 Jan 2021 06:52:02 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id x25sm1728972wmk.20.2021.01.18.06.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 06:52:01 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:51:58 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Jeff Vander Stoep <jeffv@google.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v2 01/13] af_vsock: implement 'vsock_wait_data()'.
Message-ID: <20210118145158.ufakay5mbezjex4v@steredhat>
References: <20210115053553.1454517-1-arseny.krasnov@kaspersky.com>
 <20210115054028.1455574-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210115054028.1455574-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 08:40:25AM +0300, Arseny Krasnov wrote:
>This adds 'vsock_wait_data()' function which is called from user's read
>syscall and waits until new socket data is arrived. It was based on code
>from stream dequeue logic and moved to separate function because it will
>be called both from SOCK_STREAM and SOCK_SEQPACKET receive loops.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 47 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 47 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index b12d3a322242..af716f5a93a4 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1822,6 +1822,53 @@ static int vsock_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> 	return err;
> }
>
>+static int vsock_wait_data(struct sock *sk, struct wait_queue_entry *wait,
>+			   long timeout,
>+			   struct vsock_transport_recv_notify_data *recv_data,
>+			   size_t target)
>+{
>+	int err = 0;
>+	struct vsock_sock *vsk;
>+	const struct vsock_transport *transport;

Please be sure that here and in all of the next patches, you follow the 
"Reverse Christmas tree" rule followed in net/ for the local variable 
declarations (order variable declaration lines longest to shortest).

>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;
>+
>+	if (sk->sk_err != 0 ||
>+	    (sk->sk_shutdown & RCV_SHUTDOWN) ||
>+	    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
>+		finish_wait(sk_sleep(sk), wait);
>+		return -1;
>+	}
>+	/* Don't wait for non-blocking sockets. */
>+	if (timeout == 0) {
>+		err = -EAGAIN;
>+		finish_wait(sk_sleep(sk), wait);
>+		return err;
>+	}
>+
>+	if (recv_data) {
>+		err = transport->notify_recv_pre_block(vsk, target, recv_data);
>+		if (err < 0) {
>+			finish_wait(sk_sleep(sk), wait);
>+			return err;
>+		}
>+	}
>+
>+	release_sock(sk);
>+	timeout = schedule_timeout(timeout);
>+	lock_sock(sk);
>+
>+	if (signal_pending(current)) {
>+		err = sock_intr_errno(timeout);
>+		finish_wait(sk_sleep(sk), wait);
>+	} else if (timeout == 0) {
>+		err = -EAGAIN;
>+		finish_wait(sk_sleep(sk), wait);
>+	}
>+

Since we are calling finish_wait() before return in all path, why not 
doing somethig like this:

out:
	finish_wait(sk_sleep(sk), wait);
>+	return err;
>+}

Then in the error paths you can do:

	err = XXX;
	goto out;

Thanks,
Stefano

>
> static int
> vsock_stream_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>-- 
>2.25.1
>

