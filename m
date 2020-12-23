Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F922E213A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgLWUWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 15:22:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726159AbgLWUWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 15:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608754863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x3eUzDOlre6OzFc4Fnd3U1sW8oJ2QW693hf6TerZBd4=;
        b=a7fVuJ9SeVGB6cFkZdeI85qOClGTSRMFemXaQfw77UihCH3okSqp4SnLwv3yuNI5MxoGnU
        jx2+Rv4HxVA69nGjDh5zeGOQoC9TC7evy94+QFpsPlm8dnOS7D8T1fyli/gkhmnbMA0jkJ
        2WqW9SlwPBXXtPGINQ+fkyxTHVth5Ss=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-njKlicJRO0qBKSSTDVzlAg-1; Wed, 23 Dec 2020 15:21:01 -0500
X-MC-Unique: njKlicJRO0qBKSSTDVzlAg-1
Received: by mail-oo1-f71.google.com with SMTP id t7so110997oog.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 12:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x3eUzDOlre6OzFc4Fnd3U1sW8oJ2QW693hf6TerZBd4=;
        b=P3Us28IgIICkd5jaSEE79DWswoBrKwGe6wiCZXuz41JsZZAt4cvXvTtWEGSkfHmiDR
         pTQ0bYTi+k/0F7WwZrCvotbLXIV5FZV39//N07IMS83xkEF5YvtvnGcfrS28PzjZf6pr
         oQh/5x+irhgt5zDqLMKjqdHXs2N3jd/9xWpetLkriIS0GBLO2XyAk4YqHfGWyrZuQdor
         STdlvmMO8wEYZXSz6awUQoGLeiAnaiEPAQ/5uFDXPvH48WPirQic/IV6L0MQbzsd/2/+
         Cmf8PlFcGb/jgI2DRIPcDh9MJorKIJpKCr+zxmYhM8TQ2bIN8hhH9vM900ADvTiF+HAV
         hOMQ==
X-Gm-Message-State: AOAM530hnLDICrZ6+dQHuQqVPKNbyopdpJFttqGKtwMM1A8ObReA1fry
        YeQcYN34w4qZAc/7emIz/HIDs8cQTq2msTqP1Z8Le/HUGauOtuLZyqby0n4cQOl+tO3+lYv2cx7
        ubqz2HS0/HGKJd+84ZHOsnDF8
X-Received: by 2002:aca:4a84:: with SMTP id x126mr964387oia.111.1608754860907;
        Wed, 23 Dec 2020 12:21:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCJcyiQN+z1tAiA3oSMbqegtykmJK1TSH2GZJFQ65+lvlNg7nilfFh1ihD/nOadkkbMfXapA==
X-Received: by 2002:aca:4a84:: with SMTP id x126mr964364oia.111.1608754860713;
        Wed, 23 Dec 2020 12:21:00 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f201sm5591363oig.21.2020.12.23.12.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 12:21:00 -0800 (PST)
From:   trix@redhat.com
To:     kuba@kernel.org, simon.horman@netronome.com, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        gustavoars@kernel.org, louis.peens@netronome.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nfp: remove h from printk format specifier
Date:   Wed, 23 Dec 2020 12:20:53 -0800
Message-Id: <20201223202053.131157-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c      | 2 +-
 drivers/net/ethernet/netronome/nfp/crypto/tls.c        | 4 ++--
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_mutex.c | 2 +-
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c   | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
index e92ee510fd52..2681b5d56a38 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
@@ -828,7 +828,7 @@ int nfp_bpf_opt_replace_insn(struct bpf_verifier_env *env, u32 off,
 		return 0;
 	}
 
-	pr_vlog(env, "unsupported instruction replacement %hhx -> %hhx\n",
+	pr_vlog(env, "unsupported instruction replacement %x -> %x\n",
 		meta->insn.code, insn->code);
 	return -EINVAL;
 }
diff --git a/drivers/net/ethernet/netronome/nfp/crypto/tls.c b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
index 84d66d138c3d..697317d60d29 100644
--- a/drivers/net/ethernet/netronome/nfp/crypto/tls.c
+++ b/drivers/net/ethernet/netronome/nfp/crypto/tls.c
@@ -486,7 +486,7 @@ int nfp_net_tls_rx_resync_req(struct net_device *netdev,
 	th = pkt + req->l4_offset;
 
 	if ((u8 *)&th[1] > (u8 *)pkt + pkt_len) {
-		netdev_warn_once(netdev, "invalid TLS RX resync request (l3_off: %hhu l4_off: %hhu pkt_len: %u)\n",
+		netdev_warn_once(netdev, "invalid TLS RX resync request (l3_off: %u l4_off: %u pkt_len: %u)\n",
 				 req->l3_offset, req->l4_offset, pkt_len);
 		err = -EINVAL;
 		goto err_cnt_ign;
@@ -507,7 +507,7 @@ int nfp_net_tls_rx_resync_req(struct net_device *netdev,
 		break;
 #endif
 	default:
-		netdev_warn_once(netdev, "invalid TLS RX resync request (l3_off: %hhu l4_off: %hhu ipver: %u)\n",
+		netdev_warn_once(netdev, "invalid TLS RX resync request (l3_off: %u l4_off: %u ipver: %u)\n",
 				 req->l3_offset, req->l4_offset, iph->version);
 		err = -EINVAL;
 		goto err_cnt_ign;
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_mutex.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_mutex.c
index 7bc17b94ac60..041801f0e668 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_mutex.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_mutex.c
@@ -195,7 +195,7 @@ int nfp_cpp_mutex_lock(struct nfp_cpp_mutex *mutex)
 		if (time_is_before_eq_jiffies(warn_at)) {
 			warn_at = jiffies + NFP_MUTEX_WAIT_NEXT_WARN * HZ;
 			nfp_warn(mutex->cpp,
-				 "Warning: waiting for NFP mutex [depth:%hd target:%d addr:%llx key:%08x]\n",
+				 "Warning: waiting for NFP mutex [depth:%d target:%d addr:%llx key:%08x]\n",
 				 mutex->depth,
 				 mutex->target, mutex->address, mutex->key);
 		}
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
index 10e7d8b21c46..06d03081a4dd 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c
@@ -247,12 +247,12 @@ static int nfp_nsp_check(struct nfp_nsp *state)
 	state->ver.minor = FIELD_GET(NSP_STATUS_MINOR, reg);
 
 	if (state->ver.major != NSP_MAJOR) {
-		nfp_err(cpp, "Unsupported ABI %hu.%hu\n",
+		nfp_err(cpp, "Unsupported ABI %u.%u\n",
 			state->ver.major, state->ver.minor);
 		return -EINVAL;
 	}
 	if (state->ver.minor < NSP_MINOR) {
-		nfp_err(cpp, "ABI too old to support NIC operation (%u.%hu < %u.%u), please update the management FW on the flash\n",
+		nfp_err(cpp, "ABI too old to support NIC operation (%u.%u < %u.%u), please update the management FW on the flash\n",
 			NSP_MAJOR, state->ver.minor, NSP_MAJOR, NSP_MINOR);
 		return -EINVAL;
 	}
@@ -662,7 +662,7 @@ nfp_nsp_command_buf(struct nfp_nsp *nsp, struct nfp_nsp_command_buf_arg *arg)
 	int err;
 
 	if (nsp->ver.minor < 13) {
-		nfp_err(cpp, "NSP: Code 0x%04x with buffer not supported (ABI %hu.%hu)\n",
+		nfp_err(cpp, "NSP: Code 0x%04x with buffer not supported (ABI %u.%u)\n",
 			arg->arg.code, nsp->ver.major, nsp->ver.minor);
 		return -EOPNOTSUPP;
 	}
-- 
2.27.0

