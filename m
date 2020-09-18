Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D7B26FC13
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgIRMGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:06:48 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56317 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIRMGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:06:47 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MatZt-1kvKrO07Yp-00cUGJ; Fri, 18 Sep 2020 14:06:21 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Pirko <jiri@mellanox.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Jens Axboe <axboe@kernel.dk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dev_ioctl: split out SIOC?IFMAP ioctls
Date:   Fri, 18 Sep 2020 14:05:19 +0200
Message-Id: <20200918120536.1464804-2-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918120536.1464804-1-arnd@arndb.de>
References: <20200918120536.1464804-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SpgfmsP8dPVCBUGnsc/GtZuhJHOhBfKG0KX3A+zcFP47h5rfFQN
 D4Vu19EzMBzfDP/yJNqIRjEyxnZqMJR8dLMampA8MsnKKK7MXzVzM9pDRBgHVqBIEfQMMHT
 jte9XsR6BlJyxtqE5fQYmCWIF2D7BZijwlg2uQdzgZri+6kGJgqhl0ENvJr5lhxTBkqCRub
 UCVOPzdQ/pkli2TdvrpAg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vdx+Zw2V9zQ=:O1k+thivTP74yCgnXgsJcD
 9uNDZ9c43yYbpmmmMrSUHoVHztz8Jg08voiKwFNYlAFXtAB5xg4XjBL7x4BVT0yM002EgpNSg
 5vql1vsDz5QLSaHwMHro15maTaicZ6MOK/gEChx/8Nq+blqH1TeaG1d9K2mm6XLEx7zv03X+V
 tQRD8ri3zrJu5oCCkuX15Zxh3Z545j9OYm4gW4gdVxe+rtzWGnZOZVxp+bCZiZ7Lz4BntY6pv
 cL0X+2WjriB6nbUUiBRprjy8Qfhr/f7GjxaCLL0jyVgdoP04pjqaD8kTDD0jdQewpDKn37FQ8
 xNGvI4vzE1SNDKpuKUjwFT08iI4lzEpRk3gfJY2HCsTryL53/7+jBq8Ewg9+cwuz7UdlwnGMj
 5pIiYsT5CtqBuPOoFOuQ9K6+nWOm1dKpFWYyiJBPGaeSrPGXmTCIEMbb0k9eGE91Ee52ngoQW
 7H6OXHeqzezLRVaeGhTkrR4Q6RTTLAdPqQ6WhRcu3DayvLcV/pj2MXO+vT3q9331dPLb4Kyyp
 DK3AGkiZjHFiSr21XOf5IJz1t8/sCKRncWbpyrrqNIOb5IXav/m+Yy/J7vqzYfUWv/2T6B24k
 W9zQ3FnVFOH2Xdq14g7AEmUAQhguBLTwc0qvdR04s+VF3R33mvjWTDe235YfrKfGLgQADMV3+
 RBjT6juv/ZT5PozsxqDlOndhke1y/ojjQ+5eYvspdqNXn73bvQV7E/fW1laCjf029dWZG/+mR
 vzf5UyQa+WFbaX74mjJQVzUcvKwBVEsC6GksGfPkcPq99BtOC7AkV8AWVyADEUB4OLZAx/Jnx
 LL1zwwWOIaW6jBe3UerdQsFwSda1HujRPt/S+Nm53PAqKI/7ITQvFKil/JCBtDDsLOtnbAl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ifreq ioctls need a special compat handler at the moment because of
the size difference between the struct on native and compat architectures,
but this difference exists only for one pair of ioctls, SIOCGIFMAP
and SIOCSIFMAP.

Splitting these two out of dev_ioctl() into their own higher level
implementation means the ifreq structure can be redefined in the kernel
to be identical for all applications, avoiding the need for copying the
structure around multiple times, and removing one of the call sites for
compat_alloc_user_space() and copy_in_user().

This should also make it easier for drivers to implement ioctls correct
that take an ifreq __user pointer and need to be careful about the size
difference. This has been a problem in the past, but currently the kernel
does not appear to have any drivers suffering from it.

Note that the user space definition is unchanged, so struct ifreq now
has a different size between user space and kernel, but this is not a
problem when the user space definition is larger, and the only time the
extra members are accessed is in the ifmap ioctls.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/netdevice.h |   1 +
 include/uapi/linux/if.h   |   6 +++
 net/core/dev_ioctl.c      | 107 +++++++++++++++++++++++++++++++-------
 net/socket.c              |  93 +++------------------------------
 4 files changed, 101 insertions(+), 106 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b0e303f6603f..31b170a9ac9c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3787,6 +3787,7 @@ void netdev_rx_handler_unregister(struct net_device *dev);
 bool dev_valid_name(const char *name);
 int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 		bool *need_copyout);
+int dev_ifmap(struct net *net, struct ifreq __user *ifr, unsigned int cmd);
 int dev_ifconf(struct net *net, struct ifconf *, int);
 int dev_ethtool(struct net *net, struct ifreq *);
 unsigned int dev_get_flags(const struct net_device *);
diff --git a/include/uapi/linux/if.h b/include/uapi/linux/if.h
index 797ba2c1562a..a332d6ae4dc6 100644
--- a/include/uapi/linux/if.h
+++ b/include/uapi/linux/if.h
@@ -247,7 +247,13 @@ struct ifreq {
 		short	ifru_flags;
 		int	ifru_ivalue;
 		int	ifru_mtu;
+#ifndef __KERNEL__
+		/*
+		 * ifru_map is rarely used but causes the incompatibility
+		 * between native and compat mode.
+		 */
 		struct  ifmap ifru_map;
+#endif
 		char	ifru_slave[IFNAMSIZ];	/* Just fits the size */
 		char	ifru_newname[IFNAMSIZ];
 		void __user *	ifru_data;
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index b2cf9b7bb7b8..7c8aeff98214 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -98,6 +98,94 @@ int dev_ifconf(struct net *net, struct ifconf *ifc, int size)
 	return 0;
 }
 
+int dev_ifmap(struct net *net, struct ifreq __user *ifr, unsigned int cmd)
+{
+	struct net_device *dev;
+	char ifname[IFNAMSIZ];
+	char *colon;
+	struct compat_ifmap cifmap;
+	struct ifmap ifmap;
+	int ret;
+
+	if (copy_from_user(ifname, ifr->ifr_name, sizeof(ifname)))
+		return -EFAULT;
+	ifname[IFNAMSIZ-1] = 0;
+	colon = strchr(ifname, ':');
+	if (colon)
+		*colon = 0;
+	dev_load(net, ifname);
+
+	switch (cmd) {
+	case SIOCGIFMAP:
+		rcu_read_lock();
+		dev = dev_get_by_name_rcu(net, ifname);
+		if (!dev) {
+			rcu_read_unlock();
+			return -ENODEV;
+		}
+
+		if (in_compat_syscall()) {
+			cifmap.mem_start = dev->mem_start;
+			cifmap.mem_end   = dev->mem_end;
+			cifmap.base_addr = dev->base_addr;
+			cifmap.irq       = dev->irq;
+			cifmap.dma       = dev->dma;
+			cifmap.port      = dev->if_port;
+			rcu_read_unlock();
+
+			ret = copy_to_user(&ifr->ifr_data,
+					   &cifmap, sizeof(cifmap));
+		} else {
+			ifmap.mem_start  = dev->mem_start;
+			ifmap.mem_end    = dev->mem_end;
+			ifmap.base_addr  = dev->base_addr;
+			ifmap.irq        = dev->irq;
+			ifmap.dma        = dev->dma;
+			ifmap.port       = dev->if_port;
+			rcu_read_unlock();
+
+			ret = copy_to_user(&ifr->ifr_data,
+					   &ifmap, sizeof(ifmap));
+		}
+		ret = ret ? -EFAULT : 0;
+		break;
+
+	case SIOCSIFMAP:
+		if (!capable(CAP_NET_ADMIN) ||
+		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+			return -EPERM;
+
+		if (in_compat_syscall()) {
+			if (copy_from_user(&cifmap, &ifr->ifr_data,
+					   sizeof(cifmap)))
+				return -EFAULT;
+
+			ifmap.mem_start  = cifmap.mem_start;
+			ifmap.mem_end    = cifmap.mem_end;
+			ifmap.base_addr  = cifmap.base_addr;
+			ifmap.irq        = cifmap.irq;
+			ifmap.dma        = cifmap.dma;
+			ifmap.port       = cifmap.port;
+		} else {
+			if (copy_from_user(&ifmap, &ifr->ifr_data,
+					   sizeof(ifmap)))
+				return -EFAULT;
+		}
+
+		rtnl_lock();
+		dev = __dev_get_by_name(net, ifname);
+		if (!dev || !netif_device_present(dev))
+			ret = -ENODEV;
+		else if (!dev->netdev_ops->ndo_set_config)
+			ret = -EOPNOTSUPP;
+		else
+			ret = dev->netdev_ops->ndo_set_config(dev, &ifmap);
+		rtnl_unlock();
+		break;
+	}
+	return ret;
+}
+
 /*
  *	Perform the SIOCxIFxxx calls, inside rcu_read_lock()
  */
@@ -138,15 +226,6 @@ static int dev_ifsioc_locked(struct net *net, struct ifreq *ifr, unsigned int cm
 		err = -EINVAL;
 		break;
 
-	case SIOCGIFMAP:
-		ifr->ifr_map.mem_start = dev->mem_start;
-		ifr->ifr_map.mem_end   = dev->mem_end;
-		ifr->ifr_map.base_addr = dev->base_addr;
-		ifr->ifr_map.irq       = dev->irq;
-		ifr->ifr_map.dma       = dev->dma;
-		ifr->ifr_map.port      = dev->if_port;
-		return 0;
-
 	case SIOCGIFINDEX:
 		ifr->ifr_ifindex = dev->ifindex;
 		return 0;
@@ -285,14 +364,6 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, unsigned int cmd)
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
 		return 0;
 
-	case SIOCSIFMAP:
-		if (ops->ndo_set_config) {
-			if (!netif_device_present(dev))
-				return -ENODEV;
-			return ops->ndo_set_config(dev, &ifr->ifr_map);
-		}
-		return -EOPNOTSUPP;
-
 	case SIOCADDMULTI:
 		if (!ops->ndo_set_rx_mode ||
 		    ifr->ifr_hwaddr.sa_family != AF_UNSPEC)
@@ -429,7 +500,6 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 	case SIOCGIFMTU:
 	case SIOCGIFHWADDR:
 	case SIOCGIFSLAVE:
-	case SIOCGIFMAP:
 	case SIOCGIFINDEX:
 	case SIOCGIFTXQLEN:
 		dev_load(net, ifr->ifr_name);
@@ -474,7 +544,6 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
 	 *	- require strict serialization.
 	 *	- do not return a value
 	 */
-	case SIOCSIFMAP:
 	case SIOCSIFTXQLEN:
 		if (!capable(CAP_NET_ADMIN))
 			return -EPERM;
diff --git a/net/socket.c b/net/socket.c
index 3fe30ba2a09a..f57a24f10109 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1194,6 +1194,10 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 						   cmd == SIOCGSTAMP_NEW,
 						   false);
 			break;
+		case SIOCGIFMAP:
+		case SIOCSIFMAP:
+			err = dev_ifmap(net, argp, cmd);
+			break;
 		default:
 			err = sock_do_ioctl(net, sock, cmd, arg);
 			break;
@@ -3162,88 +3166,6 @@ static int compat_ifr_data_ioctl(struct net *net, unsigned int cmd,
 	return dev_ioctl(net, cmd, &ifreq, NULL);
 }
 
-static int compat_ifreq_ioctl(struct net *net, struct socket *sock,
-			      unsigned int cmd,
-			      struct compat_ifreq __user *uifr32)
-{
-	struct ifreq __user *uifr;
-	int err;
-
-	/* Handle the fact that while struct ifreq has the same *layout* on
-	 * 32/64 for everything but ifreq::ifru_ifmap and ifreq::ifru_data,
-	 * which are handled elsewhere, it still has different *size* due to
-	 * ifreq::ifru_ifmap (which is 16 bytes on 32 bit, 24 bytes on 64-bit,
-	 * resulting in struct ifreq being 32 and 40 bytes respectively).
-	 * As a result, if the struct happens to be at the end of a page and
-	 * the next page isn't readable/writable, we get a fault. To prevent
-	 * that, copy back and forth to the full size.
-	 */
-
-	uifr = compat_alloc_user_space(sizeof(*uifr));
-	if (copy_in_user(uifr, uifr32, sizeof(*uifr32)))
-		return -EFAULT;
-
-	err = sock_do_ioctl(net, sock, cmd, (unsigned long)uifr);
-
-	if (!err) {
-		switch (cmd) {
-		case SIOCGIFFLAGS:
-		case SIOCGIFMETRIC:
-		case SIOCGIFMTU:
-		case SIOCGIFMEM:
-		case SIOCGIFHWADDR:
-		case SIOCGIFINDEX:
-		case SIOCGIFADDR:
-		case SIOCGIFBRDADDR:
-		case SIOCGIFDSTADDR:
-		case SIOCGIFNETMASK:
-		case SIOCGIFPFLAGS:
-		case SIOCGIFTXQLEN:
-		case SIOCGMIIPHY:
-		case SIOCGMIIREG:
-		case SIOCGIFNAME:
-			if (copy_in_user(uifr32, uifr, sizeof(*uifr32)))
-				err = -EFAULT;
-			break;
-		}
-	}
-	return err;
-}
-
-static int compat_sioc_ifmap(struct net *net, unsigned int cmd,
-			struct compat_ifreq __user *uifr32)
-{
-	struct ifreq ifr;
-	struct compat_ifmap __user *uifmap32;
-	int err;
-
-	uifmap32 = &uifr32->ifr_ifru.ifru_map;
-	err = copy_from_user(&ifr, uifr32, sizeof(ifr.ifr_name));
-	err |= get_user(ifr.ifr_map.mem_start, &uifmap32->mem_start);
-	err |= get_user(ifr.ifr_map.mem_end, &uifmap32->mem_end);
-	err |= get_user(ifr.ifr_map.base_addr, &uifmap32->base_addr);
-	err |= get_user(ifr.ifr_map.irq, &uifmap32->irq);
-	err |= get_user(ifr.ifr_map.dma, &uifmap32->dma);
-	err |= get_user(ifr.ifr_map.port, &uifmap32->port);
-	if (err)
-		return -EFAULT;
-
-	err = dev_ioctl(net, cmd, &ifr, NULL);
-
-	if (cmd == SIOCGIFMAP && !err) {
-		err = copy_to_user(uifr32, &ifr, sizeof(ifr.ifr_name));
-		err |= put_user(ifr.ifr_map.mem_start, &uifmap32->mem_start);
-		err |= put_user(ifr.ifr_map.mem_end, &uifmap32->mem_end);
-		err |= put_user(ifr.ifr_map.base_addr, &uifmap32->base_addr);
-		err |= put_user(ifr.ifr_map.irq, &uifmap32->irq);
-		err |= put_user(ifr.ifr_map.dma, &uifmap32->dma);
-		err |= put_user(ifr.ifr_map.port, &uifmap32->port);
-		if (err)
-			err = -EFAULT;
-	}
-	return err;
-}
-
 /* Since old style bridge ioctl's endup using SIOCDEVPRIVATE
  * for some operations; this forces use of the newer bridge-utils that
  * use compatible ioctls
@@ -3277,9 +3199,6 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 		return compat_dev_ifconf(net, argp);
 	case SIOCWANDEV:
 		return compat_siocwandev(net, argp);
-	case SIOCGIFMAP:
-	case SIOCSIFMAP:
-		return compat_sioc_ifmap(net, cmd, argp);
 	case SIOCGSTAMP_OLD:
 	case SIOCGSTAMPNS_OLD:
 		if (!sock->ops->gettstamp)
@@ -3294,6 +3213,8 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	case SIOCGHWTSTAMP:
 		return compat_ifr_data_ioctl(net, cmd, argp);
 
+	case SIOCGIFMAP:
+	case SIOCSIFMAP:
 	case FIOSETOWN:
 	case SIOCSPGRP:
 	case FIOGETOWN:
@@ -3347,8 +3268,6 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	case SIOCBONDRELEASE:
 	case SIOCBONDSETHWADDR:
 	case SIOCBONDCHANGEACTIVE:
-		return compat_ifreq_ioctl(net, sock, cmd, argp);
-
 	case SIOCSARP:
 	case SIOCGARP:
 	case SIOCDARP:
-- 
2.27.0

