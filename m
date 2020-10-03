Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BCE2824D6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgJCOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:41:50 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48691 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgJCOlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:41:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9E98D5C0063;
        Sat,  3 Oct 2020 10:41:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 03 Oct 2020 10:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=H6puvhrgYZHDVVaYva6xc8DUGmD
        nM9CFm5zTkvAog78=; b=T1xV0Jg0NcZvI4HrLZkdkc8gJz8Wia7YzyVRF70Rc7U
        BDdyaqalo3+PzZ+/HtMNk8Skc9CqyMsfEz3JNt75topnF2GNVd8B4/RUPMRFg4pI
        emVowaGhzi6Ey2XDcGtH0/P7F2gOqOo7EEWNSKd2H+MVV3VuP463YzpCZG6FV2X0
        zlbhfQBhQcK60wbCQM3fK9gvE3BR78T0lXctPLiZfHrh+Nfjuca7jccPrS407AUA
        5RoLlykBdnMpcViUKmzE9xCCo0cUcfZ3B/PIWKz9Dh6vBGfIuCCZ0RhjdALi2g+3
        eRTwU3SbgMSZEaLHGksYalhKBkQ2Dn6laWfYu2M8w2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=H6puvh
        rgYZHDVVaYva6xc8DUGmDnM9CFm5zTkvAog78=; b=CYpuytumuQhpN8sDe9h/Aq
        roi/+eYrk60Z0xgYPiHoaAaeFFMsjjVTFjA7Cv3R17itcJ9wF1OvDwN3FBvyKXxG
        gwez/F3QctlR1X6G3yBNC0SHUZdFuVasdvNl2jkUP6ex1v/rFBiMgf96vIwvEQ29
        augxOow8KndVIDgwq56xTnFx8fFNccTPf6Im5lLqJUDLHB8pdCPf+hpYYsVAmNlZ
        DszSLYYYy6+YNrgYZEYilGViPEOTtpKx7OGwPaxqeeUyKGM/ipkx28c96xBbObQS
        4lKPYitzNwxUn96wTbfXpwq1+pk7hJ0ffaNFHKV+23lJnvB0oiZ8Y09c8HSBsLnw
        ==
X-ME-Sender: <xms:q414XzGl7LLKlDn6iCcI8tFrKo4t-l0urVx73wnZd-Ak5Gaz7eJvIg>
    <xme:q414XwV4TtoXqCoJM2I2DdT17lwC5g07QCsuhEBfeaY5rzi8iKNpsecNjU-l_8xYH
    M_Rng7CSmfsbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeekgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeeuleeltdehkeeltefhleduuddvhfffuedvffduveegheekge
    eiffevheegfeetgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeekfedr
    keeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:q414X1LwOWXLw5JzRPWX1tFaKJN7gf73MazyHRO_K8cJ8s5MtvMbHg>
    <xmx:q414XxFrEBRDSP-GohrYEpcMtYn0d9k9vu0DBrL-wNXv50p80dgwaw>
    <xmx:q414X5WgHvkCwOKS9NIx2wTRzcLPjlZJfLWdnH386ShZgyn6N2j0yQ>
    <xmx:q414X6cF4toY7qO_uybDYDabhM94IkrBGQi4yd3vN3Os1RGZaxIu9w>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id EFBDB3280064;
        Sat,  3 Oct 2020 10:41:46 -0400 (EDT)
Date:   Sat, 3 Oct 2020 16:42:33 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     sgarzare@redhat.com, stable-commits@vger.kernel.org
Subject: Re: Patch "vsock/virtio: add transport parameter to the
 virtio_transport_reset_no_sock()" has been added to the 4.9-stable tree
Message-ID: <20201003144233.GA803461@kroah.com>
References: <20201002231819.A7CAC206FA@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002231819.A7CAC206FA@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 07:18:18PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     vsock/virtio: add transport parameter to the virtio_transport_reset_no_sock()
> 
> to the 4.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      vsock-virtio-add-transport-parameter-to-the-virtio_t.patch
> and it can be found in the queue-4.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 00c0b1b3723f51d243538ace6661a31c4e279dc1
> Author: Stefano Garzarella <sgarzare@redhat.com>
> Date:   Thu Nov 14 10:57:40 2019 +0100
> 
>     vsock/virtio: add transport parameter to the virtio_transport_reset_no_sock()
>     
>     [ Upstream commit 4c7246dc45e2706770d5233f7ce1597a07e069ba ]
>     
>     We are going to add 'struct vsock_sock *' parameter to
>     virtio_transport_get_ops().
>     
>     In some cases, like in the virtio_transport_reset_no_sock(),
>     we don't have any socket assigned to the packet received,
>     so we can't use the virtio_transport_get_ops().
>     
>     In order to allow virtio_transport_reset_no_sock() to use the
>     '.send_pkt' callback from the 'vhost_transport' or 'virtio_transport',
>     we add the 'struct virtio_transport *' to it and to its caller:
>     virtio_transport_recv_pkt().
>     
>     We moved the 'vhost_transport' and 'virtio_transport' definition,
>     to pass their address to the virtio_transport_recv_pkt().
>     
>     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>     Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 2ac966400c428..554e131d17b3b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -349,6 +349,52 @@ static bool vhost_vsock_more_replies(struct vhost_vsock *vsock)
>  	return val < vq->num;
>  }
>  
> +static struct virtio_transport vhost_transport = {
> +	.transport = {
> +		.get_local_cid            = vhost_transport_get_local_cid,
> +
> +		.init                     = virtio_transport_do_socket_init,
> +		.destruct                 = virtio_transport_destruct,
> +		.release                  = virtio_transport_release,
> +		.connect                  = virtio_transport_connect,
> +		.shutdown                 = virtio_transport_shutdown,
> +		.cancel_pkt               = vhost_transport_cancel_pkt,
> +
> +		.dgram_enqueue            = virtio_transport_dgram_enqueue,
> +		.dgram_dequeue            = virtio_transport_dgram_dequeue,
> +		.dgram_bind               = virtio_transport_dgram_bind,
> +		.dgram_allow              = virtio_transport_dgram_allow,
> +
> +		.stream_enqueue           = virtio_transport_stream_enqueue,
> +		.stream_dequeue           = virtio_transport_stream_dequeue,
> +		.stream_has_data          = virtio_transport_stream_has_data,
> +		.stream_has_space         = virtio_transport_stream_has_space,
> +		.stream_rcvhiwat          = virtio_transport_stream_rcvhiwat,
> +		.stream_is_active         = virtio_transport_stream_is_active,
> +		.stream_allow             = virtio_transport_stream_allow,
> +
> +		.notify_poll_in           = virtio_transport_notify_poll_in,
> +		.notify_poll_out          = virtio_transport_notify_poll_out,
> +		.notify_recv_init         = virtio_transport_notify_recv_init,
> +		.notify_recv_pre_block    = virtio_transport_notify_recv_pre_block,
> +		.notify_recv_pre_dequeue  = virtio_transport_notify_recv_pre_dequeue,
> +		.notify_recv_post_dequeue = virtio_transport_notify_recv_post_dequeue,
> +		.notify_send_init         = virtio_transport_notify_send_init,
> +		.notify_send_pre_block    = virtio_transport_notify_send_pre_block,
> +		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
> +		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
> +
> +		.set_buffer_size          = virtio_transport_set_buffer_size,
> +		.set_min_buffer_size      = virtio_transport_set_min_buffer_size,
> +		.set_max_buffer_size      = virtio_transport_set_max_buffer_size,
> +		.get_buffer_size          = virtio_transport_get_buffer_size,
> +		.get_min_buffer_size      = virtio_transport_get_min_buffer_size,
> +		.get_max_buffer_size      = virtio_transport_get_max_buffer_size,
> +	},
> +
> +	.send_pkt = vhost_transport_send_pkt,
> +};
> +
>  static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>  {
>  	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
> @@ -402,7 +448,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>  		if (le64_to_cpu(pkt->hdr.src_cid) == vsock->guest_cid &&
>  		    le64_to_cpu(pkt->hdr.dst_cid) ==
>  		    vhost_transport_get_local_cid())
> -			virtio_transport_recv_pkt(pkt);
> +			virtio_transport_recv_pkt(&vhost_transport, pkt);
>  		else
>  			virtio_transport_free_pkt(pkt);
>  
> @@ -745,52 +791,6 @@ static struct miscdevice vhost_vsock_misc = {
>  	.fops = &vhost_vsock_fops,
>  };
>  
> -static struct virtio_transport vhost_transport = {
> -	.transport = {
> -		.get_local_cid            = vhost_transport_get_local_cid,
> -
> -		.init                     = virtio_transport_do_socket_init,
> -		.destruct                 = virtio_transport_destruct,
> -		.release                  = virtio_transport_release,
> -		.connect                  = virtio_transport_connect,
> -		.shutdown                 = virtio_transport_shutdown,
> -		.cancel_pkt               = vhost_transport_cancel_pkt,
> -
> -		.dgram_enqueue            = virtio_transport_dgram_enqueue,
> -		.dgram_dequeue            = virtio_transport_dgram_dequeue,
> -		.dgram_bind               = virtio_transport_dgram_bind,
> -		.dgram_allow              = virtio_transport_dgram_allow,
> -
> -		.stream_enqueue           = virtio_transport_stream_enqueue,
> -		.stream_dequeue           = virtio_transport_stream_dequeue,
> -		.stream_has_data          = virtio_transport_stream_has_data,
> -		.stream_has_space         = virtio_transport_stream_has_space,
> -		.stream_rcvhiwat          = virtio_transport_stream_rcvhiwat,
> -		.stream_is_active         = virtio_transport_stream_is_active,
> -		.stream_allow             = virtio_transport_stream_allow,
> -
> -		.notify_poll_in           = virtio_transport_notify_poll_in,
> -		.notify_poll_out          = virtio_transport_notify_poll_out,
> -		.notify_recv_init         = virtio_transport_notify_recv_init,
> -		.notify_recv_pre_block    = virtio_transport_notify_recv_pre_block,
> -		.notify_recv_pre_dequeue  = virtio_transport_notify_recv_pre_dequeue,
> -		.notify_recv_post_dequeue = virtio_transport_notify_recv_post_dequeue,
> -		.notify_send_init         = virtio_transport_notify_send_init,
> -		.notify_send_pre_block    = virtio_transport_notify_send_pre_block,
> -		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
> -		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
> -
> -		.set_buffer_size          = virtio_transport_set_buffer_size,
> -		.set_min_buffer_size      = virtio_transport_set_min_buffer_size,
> -		.set_max_buffer_size      = virtio_transport_set_max_buffer_size,
> -		.get_buffer_size          = virtio_transport_get_buffer_size,
> -		.get_min_buffer_size      = virtio_transport_get_min_buffer_size,
> -		.get_max_buffer_size      = virtio_transport_get_max_buffer_size,
> -	},
> -
> -	.send_pkt = vhost_transport_send_pkt,
> -};
> -
>  static int __init vhost_vsock_init(void)
>  {
>  	int ret;
> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index 584f9a647ad4a..0860cf4ae0461 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -148,7 +148,8 @@ virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
>  
>  void virtio_transport_destruct(struct vsock_sock *vsk);
>  
> -void virtio_transport_recv_pkt(struct virtio_vsock_pkt *pkt);
> +void virtio_transport_recv_pkt(struct virtio_transport *t,
> +			       struct virtio_vsock_pkt *pkt);
>  void virtio_transport_free_pkt(struct virtio_vsock_pkt *pkt);
>  void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct virtio_vsock_pkt *pkt);
>  u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 67aba63b5c96d..43f6c4240b2a8 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -271,58 +271,6 @@ static bool virtio_transport_more_replies(struct virtio_vsock *vsock)
>  	return val < virtqueue_get_vring_size(vq);
>  }
>  
> -static void virtio_transport_rx_work(struct work_struct *work)
> -{
> -	struct virtio_vsock *vsock =
> -		container_of(work, struct virtio_vsock, rx_work);
> -	struct virtqueue *vq;
> -
> -	vq = vsock->vqs[VSOCK_VQ_RX];
> -
> -	mutex_lock(&vsock->rx_lock);
> -
> -	if (!vsock->rx_run)
> -		goto out;
> -
> -	do {
> -		virtqueue_disable_cb(vq);
> -		for (;;) {
> -			struct virtio_vsock_pkt *pkt;
> -			unsigned int len;
> -
> -			if (!virtio_transport_more_replies(vsock)) {
> -				/* Stop rx until the device processes already
> -				 * pending replies.  Leave rx virtqueue
> -				 * callbacks disabled.
> -				 */
> -				goto out;
> -			}
> -
> -			pkt = virtqueue_get_buf(vq, &len);
> -			if (!pkt) {
> -				break;
> -			}
> -
> -			vsock->rx_buf_nr--;
> -
> -			/* Drop short/long packets */
> -			if (unlikely(len < sizeof(pkt->hdr) ||
> -				     len > sizeof(pkt->hdr) + pkt->len)) {
> -				virtio_transport_free_pkt(pkt);
> -				continue;
> -			}
> -
> -			pkt->len = len - sizeof(pkt->hdr);
> -			virtio_transport_recv_pkt(pkt);
> -		}
> -	} while (!virtqueue_enable_cb(vq));
> -
> -out:
> -	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> -		virtio_vsock_rx_fill(vsock);
> -	mutex_unlock(&vsock->rx_lock);
> -}
> -
>  /* event_lock must be held */
>  static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
>  				       struct virtio_vsock_event *event)
> @@ -485,6 +433,85 @@ static struct virtio_transport virtio_transport = {
>  	.send_pkt = virtio_transport_send_pkt,
>  };
>  
> +static void virtio_transport_loopback_work(struct work_struct *work)
> +{
> +	struct virtio_vsock *vsock =
> +		container_of(work, struct virtio_vsock, loopback_work);
> +	LIST_HEAD(pkts);
> +
> +	spin_lock_bh(&vsock->loopback_list_lock);
> +	list_splice_init(&vsock->loopback_list, &pkts);
> +	spin_unlock_bh(&vsock->loopback_list_lock);
> +
> +	mutex_lock(&vsock->rx_lock);
> +
> +	if (!vsock->rx_run)
> +		goto out;
> +
> +	while (!list_empty(&pkts)) {
> +		struct virtio_vsock_pkt *pkt;
> +
> +		pkt = list_first_entry(&pkts, struct virtio_vsock_pkt, list);
> +		list_del_init(&pkt->list);
> +
> +		virtio_transport_recv_pkt(&virtio_transport, pkt);
> +	}
> +out:
> +	mutex_unlock(&vsock->rx_lock);
> +}
> +
> +static void virtio_transport_rx_work(struct work_struct *work)
> +{
> +	struct virtio_vsock *vsock =
> +		container_of(work, struct virtio_vsock, rx_work);
> +	struct virtqueue *vq;
> +
> +	vq = vsock->vqs[VSOCK_VQ_RX];
> +
> +	mutex_lock(&vsock->rx_lock);
> +
> +	if (!vsock->rx_run)
> +		goto out;
> +
> +	do {
> +		virtqueue_disable_cb(vq);
> +		for (;;) {
> +			struct virtio_vsock_pkt *pkt;
> +			unsigned int len;
> +
> +			if (!virtio_transport_more_replies(vsock)) {
> +				/* Stop rx until the device processes already
> +				 * pending replies.  Leave rx virtqueue
> +				 * callbacks disabled.
> +				 */
> +				goto out;
> +			}
> +
> +			pkt = virtqueue_get_buf(vq, &len);
> +			if (!pkt) {
> +				break;
> +			}
> +
> +			vsock->rx_buf_nr--;
> +
> +			/* Drop short/long packets */
> +			if (unlikely(len < sizeof(pkt->hdr) ||
> +				     len > sizeof(pkt->hdr) + pkt->len)) {
> +				virtio_transport_free_pkt(pkt);
> +				continue;
> +			}
> +
> +			pkt->len = len - sizeof(pkt->hdr);
> +			virtio_transport_recv_pkt(&virtio_transport, pkt);
> +		}
> +	} while (!virtqueue_enable_cb(vq));
> +
> +out:
> +	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> +		virtio_vsock_rx_fill(vsock);
> +	mutex_unlock(&vsock->rx_lock);
> +}
> +
>  static int virtio_vsock_probe(struct virtio_device *vdev)
>  {
>  	vq_callback_t *callbacks[] = {
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index aa9d1c7780c3d..d64285afe68f3 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -599,9 +599,9 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
>  /* Normally packets are associated with a socket.  There may be no socket if an
>   * attempt was made to connect to a socket that does not exist.
>   */
> -static int virtio_transport_reset_no_sock(struct virtio_vsock_pkt *pkt)
> +static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> +					  struct virtio_vsock_pkt *pkt)
>  {
> -	const struct virtio_transport *t;
>  	struct virtio_vsock_pkt *reply;
>  	struct virtio_vsock_pkt_info info = {
>  		.op = VIRTIO_VSOCK_OP_RST,
> @@ -621,7 +621,6 @@ static int virtio_transport_reset_no_sock(struct virtio_vsock_pkt *pkt)
>  	if (!reply)
>  		return -ENOMEM;
>  
> -	t = virtio_transport_get_ops();
>  	if (!t) {
>  		virtio_transport_free_pkt(reply);
>  		return -ENOTCONN;
> @@ -919,7 +918,8 @@ static bool virtio_transport_space_update(struct sock *sk,
>  /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
>   * lock.
>   */
> -void virtio_transport_recv_pkt(struct virtio_vsock_pkt *pkt)
> +void virtio_transport_recv_pkt(struct virtio_transport *t,
> +			       struct virtio_vsock_pkt *pkt)
>  {
>  	struct sockaddr_vm src, dst;
>  	struct vsock_sock *vsk;
> @@ -941,7 +941,7 @@ void virtio_transport_recv_pkt(struct virtio_vsock_pkt *pkt)
>  					le32_to_cpu(pkt->hdr.fwd_cnt));
>  
>  	if (le16_to_cpu(pkt->hdr.type) != VIRTIO_VSOCK_TYPE_STREAM) {
> -		(void)virtio_transport_reset_no_sock(pkt);
> +		(void)virtio_transport_reset_no_sock(t, pkt);
>  		goto free_pkt;
>  	}
>  
> @@ -952,7 +952,7 @@ void virtio_transport_recv_pkt(struct virtio_vsock_pkt *pkt)
>  	if (!sk) {
>  		sk = vsock_find_bound_socket(&dst);
>  		if (!sk) {
> -			(void)virtio_transport_reset_no_sock(pkt);
> +			(void)virtio_transport_reset_no_sock(t, pkt);
>  			goto free_pkt;
>  		}
>  	}

This breaks the build, so I'm dropping it from the queue :(

