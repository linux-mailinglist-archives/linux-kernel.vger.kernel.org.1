Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C99E26D88B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIQKLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgIQKLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:11:04 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B002C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:11:03 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id r22so1253946qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=sJWgbUXV7tBH1Nrf3exc56L3qAUgK89a+WyZAGRDQ00=;
        b=tXr9kxBN+1DeO1NclFjz9P101oud7t9jr3/SYWFi1j6/l5qz1wD1aBjR6Evbi5L3jk
         ff6Lcl9QX369PdkhkpA0YOrnur/T6DDY6jWssxKdtYZfAbFBr0UDFlnFJJ01GdP+PNoj
         Tu//Wr5W6u7hxL8BHBAd73T9GLPEjrMbXK2i4CQIFZL9DKPoTpNkF3ZcCJd+qsx3QlNR
         mJzU+HdkqCf/RqZ9ZA9873PFQHCdKBUvL6yT6Kbz/sLhAhZPy6Jva6H9iOG6Xkis6diW
         Q/N0sxvBEnz89hzOZXtdCQM9G3MYCGM5G2Os1hdTsT4POlQdIgUgnihH7hhBW/BpOIKp
         Au3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=sJWgbUXV7tBH1Nrf3exc56L3qAUgK89a+WyZAGRDQ00=;
        b=WJhblZ8di9sRGNmDpq5Vn+BwGm8Y3vsRCQxRJXMx8r2jrlDMVN3aMXb+LAJ86rZSxE
         GfZtISqXtnLB8f9ECGdjhdfyUCZSSBw8VZl/B7XLFDs9ga5ylhI3JTerk1K/uD6/u4rR
         opfzp9ar1pE9HTlqHpUYGFeWQT0wAfJwJLVpyA9QrsRra6L1SJTrSxLzaSYECmdBQX92
         SFdGv2T0pVB89eDp5Sdz912qltpgaaLQ6fafv0fhT5/bfJBrRSNQ1zpqi5kH35i3vpH3
         q+veeXyE+hd7V+pmWOqf7BbqQM5Hc4LzNRYJFFLfYkyodvoyImb2IzGX4GE2nZOBLGQ5
         qy7A==
X-Gm-Message-State: AOAM530On7l/iNgbtFQYcQFxDTZwTsiAA7aZEUBhyIxoopQNwodAWYTy
        GTLwz766D9rz15MjPC22FczPbc0rBqLz
X-Google-Smtp-Source: ABdhPJz/eapZ/gc9UKSZaUAcY88gjIx/FwwW9+oDol/bMcUBxGLnlzngSiMypax4DUu9AAewZIGVH/QutXyK
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a05:6214:c2:: with SMTP id
 f2mr11115403qvs.44.1600337462181; Thu, 17 Sep 2020 03:11:02 -0700 (PDT)
Date:   Thu, 17 Sep 2020 18:10:56 +0800
Message-Id: <20200917181031.v1.1.I67a8b8cd4def8166970ca37109db46d731b62bb6@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v1] Bluetooth: Check for encryption key size on connect
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When receiving connection, we only check whether the link has been
encrypted, but not the encryption key size of the link.

This patch adds check for encryption key size, and reject L2CAP
connection which size is below the specified threshold (default 7)
with security block.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>

---

 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ade83e224567..b4fc0ad38aaa 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4101,7 +4101,8 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != cpu_to_le16(L2CAP_PSM_SDP) &&
-	    !hci_conn_check_link_mode(conn->hcon)) {
+	    (!hci_conn_check_link_mode(conn->hcon) ||
+	    !l2cap_check_enc_key_size(conn->hcon))) {
 		conn->disc_reason = HCI_ERROR_AUTH_FAILURE;
 		result = L2CAP_CR_SEC_BLOCK;
 		goto response;
-- 
2.28.0.681.g6f77f65b4e-goog

