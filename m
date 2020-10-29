Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9176D29EBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgJ2MXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725613AbgJ2MXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603974182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VsGY64wc+hD5SlzcuKwVLp8jJY3JLUIdMZBJzQEsGWE=;
        b=Ta27j+18LFVnROEpLty3cRXG4umLKl1tu+bjT+/bGCXfO/Y0ET1CwTIhbyzAjCMquDUKLW
        QKQ8/ggJPa8wiqK7GBwmXSWRrFifnC2WS+OUK7fdTRdGcSNj9YPM0aki8jaMadxW9jVYB5
        8lr1qTXFaVXqNiqSSfYU4Gq+BLlnSBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-Z7O9eMgDMRWqA0HNr7kjlg-1; Thu, 29 Oct 2020 08:20:53 -0400
X-MC-Unique: Z7O9eMgDMRWqA0HNr7kjlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5E78879525;
        Thu, 29 Oct 2020 12:20:52 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-113-197.ams2.redhat.com [10.36.113.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63BA155764;
        Thu, 29 Oct 2020 12:20:51 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 0/2] vdpasim: allow to set MAC address
Date:   Thu, 29 Oct 2020 13:20:48 +0100
Message-Id: <20201029122050.776445-1-lvivier@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series starts by fixing a bug:=0D
vdpa_sim generates a MAC address that is never show to=0D
upper layer, and thus virtio-net generates another random=0D
MAC address, that changes each time virtio-net is loaded=0D
(even if vdpa_sim is not unloaded).=0D
=0D
Then it adds a parameter to vpa_sim module to allow the user to=0D
set the MAC address. With that we use vdpa_sim with a stable=0D
MAC addres, that doesn't change between reboots.=0D
=0D
Laurent Vivier (2):=0D
  vdpasim: fix MAC address configuration=0D
  vdpasim: allow to assign a MAC address=0D
=0D
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 17 +++++++++++++++--=0D
 1 file changed, 15 insertions(+), 2 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

