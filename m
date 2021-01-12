Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9D22F3AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436859AbhALTnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406835AbhALTnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:43:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1524AC061387
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:42:15 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y17so3719173wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbacyc4brsO7fCWWmN34VX2kLRLEZOENYLDCsoU/LjI=;
        b=frDPSNM1J/dOImSb6yTvFEc5DFfgGXbEaLLgKaM0mONN1LJTeaMDvsD7N43EhUuKwM
         OzKSpdv9zyp8xkewtP83v/WGTWyMClGmamwcnslMUaaz1lav+C2aXiTjba4BdOhqxWXs
         YOItPqRzhgs4NU2YffFSmcJDQxMpi6pdbU7itsTGkKpcxuOJWziSQooRJUBKdpBzUYxD
         xIoivLmBPS3zxn3DPlnmaHb6St45vGGHON4Tw0XUnv4jTlfHbt6WSZPGEcTHqdLKQA8A
         oh9+TRaqxpOgBEf5HrtBEHkkj3ACTaqZOa/BiIncvZJTrHDMblqXE+TF/HZ3Eh4T7R9X
         TU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbacyc4brsO7fCWWmN34VX2kLRLEZOENYLDCsoU/LjI=;
        b=hq3V2bxBW4cDKYq/CyPLuKCDBpnTTKVJgi6HAZ6pmQ4PhBFjR4Nq1qdgR8RVri4k8T
         JVI5/Gx0YnA+eP1uAU5z5SJo9fWp+xVdYfL72w3x/uUdSc3X2+2tUKbDqnEkbi0YzGDR
         OL8+jUglcESXvZ50FigM2SepwnKMGBW61y3yZ5Y3JJUb3ls9GmA+j7fMY4KkG7wTzKXF
         ckfl0u0f8FpPIkxluguQHcRxWSr5Rivs6oMFnFjBFa7aN93/PzMQUY7ijrWeNUHfJXWr
         8ffNK0S/trb4CKnChsIDM7/vZWrniv2LxqpglL3pvGAHtP0PwVJIbTOBgIicHc7WaZKs
         bPtQ==
X-Gm-Message-State: AOAM533VGMjx2oNH13W+FsQViGQ7momk6d7ZExbQ5mVQDMmh4MqBC2cf
        /UeiLXu5Q3J/CZERrE9RLVI4Nw==
X-Google-Smtp-Source: ABdhPJzR2K4OZsCoyd0N4J9iZegxzvR23ddSEOzUWZ1flur5F4V7qRoMhDvf+/K03T/6v7gHKGCucw==
X-Received: by 2002:adf:df08:: with SMTP id y8mr431800wrl.278.1610480533859;
        Tue, 12 Jan 2021 11:42:13 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net. [79.183.72.147])
        by smtp.gmail.com with ESMTPSA id z63sm4885315wme.8.2021.01.12.11.42.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jan 2021 11:42:13 -0800 (PST)
From:   Yuri Benditovich <yuri.benditovich@daynix.com>
To:     davem@davemloft.net, kuba@kernel.org, mst@redhat.com,
        jasowang@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        rdunlap@infradead.org, willemb@google.com, gustavoars@kernel.org,
        herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
        nogikh@google.com, pablo@netfilter.org, decui@microsoft.com,
        cai@lca.pw, jakub@cloudflare.com, elver@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Cc:     yan@daynix.com
Subject: [RFC PATCH 6/7] tun: populate hash in virtio-net header when needed
Date:   Tue, 12 Jan 2021 21:41:42 +0200
Message-Id: <20210112194143.1494-7-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112194143.1494-1-yuri.benditovich@daynix.com>
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the BPF program populated the hash in the skb the tun
propagates the hash value and hash report type to the
respective fields of virtio-net header.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 drivers/net/tun.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 45f4f04a4a3e..214feb0b16fb 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -556,15 +556,20 @@ static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 {
 	struct tun_prog *prog;
 	u32 numqueues;
-	u16 ret = 0;
+	u32 ret = 0;
 
 	numqueues = READ_ONCE(tun->numqueues);
 	if (!numqueues)
 		return 0;
 
 	prog = rcu_dereference(tun->steering_prog);
-	if (prog)
+	if (prog) {
 		ret = bpf_prog_run_clear_cb(prog->prog, skb);
+		if (tun->bpf_populates_hash) {
+			*skb_hash_report_type(skb) = (__u8)(ret >> 16);
+			ret &= 0xffff;
+		}
+	}
 
 	return ret % numqueues;
 }
@@ -2062,6 +2067,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 
 	if (vnet_hdr_sz) {
 		struct virtio_net_hdr gso;
+		__u16 extra_copy = 0;
 
 		if (iov_iter_count(iter) < vnet_hdr_sz)
 			return -EINVAL;
@@ -2085,7 +2091,20 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 		if (copy_to_iter(&gso, sizeof(gso), iter) != sizeof(gso))
 			return -EFAULT;
 
-		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso));
+		if (tun->bpf_populates_hash &&
+		    vnet_hdr_sz >= sizeof(struct virtio_net_hdr_v1_hash)) {
+			struct virtio_net_hdr_v1_hash hdr;
+
+			hdr.hdr.num_buffers = 0;
+			hdr.hash_value = cpu_to_le32(skb_get_hash(skb));
+			hdr.hash_report = cpu_to_le16(*skb_hash_report_type(skb));
+			hdr.padding = 0;
+			extra_copy = sizeof(hdr) - sizeof(gso);
+			if (copy_to_iter(&hdr.hdr.num_buffers, extra_copy, iter) != extra_copy)
+				return -EFAULT;
+		}
+
+		iov_iter_advance(iter, vnet_hdr_sz - sizeof(gso) - extra_copy);
 	}
 
 	if (vlan_hlen) {
-- 
2.17.1

