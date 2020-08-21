Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E6E24E3DD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 01:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgHUXYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 19:24:08 -0400
Received: from smtprelay0023.hostedemail.com ([216.40.44.23]:40982 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726856AbgHUXYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:24:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 0766F181D341E;
        Fri, 21 Aug 2020 23:24:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1711:1730:1747:1777:1792:1801:2194:2198:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:4250:4321:4605:5007:9149:9592:10004:10848:11026:11232:11473:11657:11658:11914:12043:12048:12291:12297:12438:12555:12683:12740:12760:12895:13161:13229:13439:14110:14659:14721:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: game49_02002042703d
X-Filterd-Recvd-Size: 5177
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 23:24:03 +0000 (UTC)
Message-ID: <32801506f274e046e329da069839ff75443b2b78.camel@perches.com>
Subject: Re: [PATCH] vdpa/mlx5: Avoid warnings about shifts on 32-bit
 platforms
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Eli Cohen <eli@mellanox.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Fri, 21 Aug 2020 16:24:02 -0700
In-Reply-To: <1975c0a0-c19a-c91e-dc10-2918061cc4e7@infradead.org>
References: <20200821225018.940798-1-natechancellor@gmail.com>
         <1975c0a0-c19a-c91e-dc10-2918061cc4e7@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-21 at 16:13 -0700, Randy Dunlap wrote:
> On 8/21/20 3:50 PM, Nathan Chancellor wrote:
> > Clang warns several times when building for 32-bit ARM along the lines
> > of:

The defines are quite horrible to read.
Maybe:
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 +++++++++++++++++++++++++++-----
-------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 9df69d5efe8c..62b6eec713b2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -15,24 +15,49 @@
 
 #define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
 
-#define VALID_FEATURES_MASK                                                                        \
-	(BIT(VIRTIO_NET_F_CSUM) | BIT(VIRTIO_NET_F_GUEST_CSUM) |                                   \
-	 BIT(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT(VIRTIO_NET_F_MTU) | BIT(VIRTIO_NET_F_MAC) |   \
-	 BIT(VIRTIO_NET_F_GUEST_TSO4) | BIT(VIRTIO_NET_F_GUEST_TSO6) |                             \
-	 BIT(VIRTIO_NET_F_GUEST_ECN) | BIT(VIRTIO_NET_F_GUEST_UFO) | BIT(VIRTIO_NET_F_HOST_TSO4) | \
-	 BIT(VIRTIO_NET_F_HOST_TSO6) | BIT(VIRTIO_NET_F_HOST_ECN) | BIT(VIRTIO_NET_F_HOST_UFO) |   \
-	 BIT(VIRTIO_NET_F_MRG_RXBUF) | BIT(VIRTIO_NET_F_STATUS) | BIT(VIRTIO_NET_F_CTRL_VQ) |      \
-	 BIT(VIRTIO_NET_F_CTRL_RX) | BIT(VIRTIO_NET_F_CTRL_VLAN) |                                 \
-	 BIT(VIRTIO_NET_F_CTRL_RX_EXTRA) | BIT(VIRTIO_NET_F_GUEST_ANNOUNCE) |                      \
-	 BIT(VIRTIO_NET_F_MQ) | BIT(VIRTIO_NET_F_CTRL_MAC_ADDR) | BIT(VIRTIO_NET_F_HASH_REPORT) |  \
-	 BIT(VIRTIO_NET_F_RSS) | BIT(VIRTIO_NET_F_RSC_EXT) | BIT(VIRTIO_NET_F_STANDBY) |           \
-	 BIT(VIRTIO_NET_F_SPEED_DUPLEX) | BIT(VIRTIO_F_NOTIFY_ON_EMPTY) |                          \
-	 BIT(VIRTIO_F_ANY_LAYOUT) | BIT(VIRTIO_F_VERSION_1) | BIT(VIRTIO_F_ACCESS_PLATFORM) |      \
-	 BIT(VIRTIO_F_RING_PACKED) | BIT(VIRTIO_F_ORDER_PLATFORM) | BIT(VIRTIO_F_SR_IOV))
-
-#define VALID_STATUS_MASK                                                                          \
-	(VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK |        \
-	 VIRTIO_CONFIG_S_FEATURES_OK | VIRTIO_CONFIG_S_NEEDS_RESET | VIRTIO_CONFIG_S_FAILED)
+#define VALID_FEATURES_MASK						\
+	(BIT_ULL(VIRTIO_NET_F_CSUM) |					\
+	 BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |				\
+	 BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) |			\
+	 BIT_ULL(VIRTIO_NET_F_MTU) |					\
+	 BIT_ULL(VIRTIO_NET_F_MAC) |					\
+	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |				\
+	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |				\
+	 BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |				\
+	 BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |				\
+	 BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |				\
+	 BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |				\
+	 BIT_ULL(VIRTIO_NET_F_HOST_ECN) |				\
+	 BIT_ULL(VIRTIO_NET_F_HOST_UFO) |				\
+	 BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |				\
+	 BIT_ULL(VIRTIO_NET_F_STATUS) |					\
+	 BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |				\
+	 BIT_ULL(VIRTIO_NET_F_CTRL_RX) |				\
+	 BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |				\
+	 BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |				\
+	 BIT_ULL(VIRTIO_NET_F_GUEST_ANNOUNCE) |				\
+	 BIT_ULL(VIRTIO_NET_F_MQ) |					\
+	 BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |				\
+	 BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |				\
+	 BIT_ULL(VIRTIO_NET_F_RSS) |					\
+	 BIT_ULL(VIRTIO_NET_F_RSC_EXT) |				\
+	 BIT_ULL(VIRTIO_NET_F_STANDBY) |				\
+	 BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX) |				\
+	 BIT_ULL(VIRTIO_F_NOTIFY_ON_EMPTY) |				\
+	 BIT_ULL(VIRTIO_F_ANY_LAYOUT) |					\
+	 BIT_ULL(VIRTIO_F_VERSION_1) |					\
+	 BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |				\
+	 BIT_ULL(VIRTIO_F_RING_PACKED) |				\
+	 BIT_ULL(VIRTIO_F_ORDER_PLATFORM) |				\
+	 BIT_ULL(VIRTIO_F_SR_IOV))
+
+#define VALID_STATUS_MASK						\
+	(VIRTIO_CONFIG_S_ACKNOWLEDGE |					\
+	 VIRTIO_CONFIG_S_DRIVER |					\
+	 VIRTIO_CONFIG_S_DRIVER_OK |					\
+	 VIRTIO_CONFIG_S_FEATURES_OK |					\
+	 VIRTIO_CONFIG_S_NEEDS_RESET |					\
+	 VIRTIO_CONFIG_S_FAILED)
 
 struct mlx5_vdpa_net_resources {
 	u32 tisn;


