Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ECE266990
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 22:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgIKUf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 16:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgIKUfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 16:35:19 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7757C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:35:18 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r24so13569364ljm.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7BOkuAAAnRPtTIYiJzNAj8jrykzlMY8oNL7fVbfn4E=;
        b=sLiQVhtSnIueOJxEk2WJdRgT88I4uOL0yBwdfIzdf4mQPgigKStRIlz4HbrKNEgZA9
         juyeNYwtF9WLD5bbibhifuqPl6CUYKHhxH9Kj/p/QDfjSGVQvqsDMPX9ukLiC564qZTJ
         j6jZ8OULFnGdhPcc0gD3zDSF0za5zVu4e9bltdHbB407QN2yiORdE1emuYG6uZtVywP1
         oGaAkg17JzXzjGR8mMo6ioyq0w9M0H9HeENlJyuiiCRLrYZ5zFzlGfVq0pLwJHMitmSE
         b5g7FVMsbSV50NhY27ZdU195qK0EDmPWgSsGS8dlD3WA7q94+cgdE2BOr6Z0JgGDXptz
         jMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7BOkuAAAnRPtTIYiJzNAj8jrykzlMY8oNL7fVbfn4E=;
        b=pXZejrW6Pgj6XgUiMtjRoMAbq+ReQMX0cGEd0Lbr3d92dQ0BEFKHW0NIYpruwooHCu
         SUXQsu6Wi9etJT+kAXnyJzm8cazJBQULhLwWBfGdCk3+V11dbtpbr3cXaw2e1teHXHdu
         1Q/x+b2ODtRUlsrCj0GocA/Ghs0GdIPG1WzHzvjjKXXxRJVy6JLqnVTetPVmQ0LoJySm
         bpRSwt+ch7H/JfodTzoGw4HiFz9yUwx+qmu1u/Zil6Pk97FbZTi403i/oAFrxmsANYk3
         ILSnlkZyiqf2E5nJ69H0KpEwjgKThEK/HmJwnPD/aPzKDZBxajMKVwJB/sWKp1qNs9LW
         PdWQ==
X-Gm-Message-State: AOAM5315E/tgwfLW5BxSNGOsbZ0oOLIsR9VsUEg8xWWaN6o7Ew8YLq4Q
        m6ZMmYInffKQsnlbHy9SLlsApvoxpKbQIg==
X-Google-Smtp-Source: ABdhPJw/H1QPjzBKjyRDC4GrcZUJP+Zn/RNiQmKk1wAlzm3f1fypnyO0PC81jCoO53hLyc3k/WxsLw==
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr1395732ljp.281.1599856517185;
        Fri, 11 Sep 2020 13:35:17 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id d1sm214390lfe.180.2020.09.11.13.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 13:35:16 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 2/3] virtio_input: Constify id_table
Date:   Fri, 11 Sep 2020 22:35:08 +0200
Message-Id: <20200911203509.26505-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911203509.26505-1-rikard.falkeborn@gmail.com>
References: <20200911203509.26505-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

id_table is not modified, so make it const to allow the compiler to put
it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/virtio/virtio_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 877b2ea3ed05..f1f6208edcf5 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -363,7 +363,7 @@ static int virtinput_restore(struct virtio_device *vdev)
 static unsigned int features[] = {
 	/* none */
 };
-static struct virtio_device_id id_table[] = {
+static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_INPUT, VIRTIO_DEV_ANY_ID },
 	{ 0 },
 };
-- 
2.28.0

