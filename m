Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD84292E41
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbgJSTPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:15:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35940 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731088AbgJSTPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603134907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=RGSj1Okw6bTtmOh6LtFIfqugUnOPwzH6b+MxduTDcFI=;
        b=Pw+0XjprlKpO3uBxoe8GNq4sASbr2vue1sMa6gljSkXSIlkB/2VZCvQP9ZGxCSejSQu9pF
        HwVkNMkhOyBUobwwmvVaH8UiXZelEH1s+aMPUY3BUnjRgEODAQQwDE6Ed8IIuP09J1OKEl
        MpqRr4GWUoTslbdr1/6BHyjqfe7xHzI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-FO_SJVFEM_2SK6CG8Ecx4g-1; Mon, 19 Oct 2020 15:15:06 -0400
X-MC-Unique: FO_SJVFEM_2SK6CG8Ecx4g-1
Received: by mail-qt1-f200.google.com with SMTP id n8so660663qtf.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 12:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RGSj1Okw6bTtmOh6LtFIfqugUnOPwzH6b+MxduTDcFI=;
        b=dF4ikHUzmHKAJTq6ETuw4zHAmFjTts//jdUsCuv3EBntf1B227nl2klyD0fF5ZEmdB
         qcqaP8nFMi4zhff6LhI35oepiQLc4SRv9A/trhF7kCKkmURcHM6+r70abunvKSP+FZG+
         ElQC9AFszTB7eIPv1uXYGG4So4lylsiQ/fYfGgJxTG+EwPKtMYoljL0HCxIuW3YXdv7N
         MNHiQciZq0VsXHI2E7XggqVgaBmgnKO6wY2A/IjX2KfW6+VjdKkOOn0KCNJf7dcIOXD2
         HHxBWiLjcClM02F8aPZE6M0X46oajuz+f4/EGBDn77uqxGL6zuul9VDbmKTvV8Nm82Kc
         W+cQ==
X-Gm-Message-State: AOAM531SCGm5qgkMHxcOzG8TqsCkHv+NL2nFx7yBHkmYEGhZRs6atGp5
        1lZzC8vAuR2OUNXiUAzrwHH8ZSqaBPP2SHrPT8K63KzCt2HHBl+W5du9YRShK+imxns6CE3vcqF
        Om/q7zod0rcjJ6v6/x4LGKC06
X-Received: by 2002:a37:ac0e:: with SMTP id e14mr1073218qkm.336.1603134905683;
        Mon, 19 Oct 2020 12:15:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwe7gZkbDPpHASbLaACCMlaKx46gerbINgHx+8qtcEjJmA0BMQ/ELyGF8Sg3X49xeIdSppc6w==
X-Received: by 2002:a37:ac0e:: with SMTP id e14mr1073199qkm.336.1603134905473;
        Mon, 19 Oct 2020 12:15:05 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b191sm419142qkg.81.2020.10.19.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:15:04 -0700 (PDT)
From:   trix@redhat.com
To:     mgreer@animalcreek.com, davem@davemloft.net, bianpan2016@163.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] nfc: remove unneeded break
Date:   Mon, 19 Oct 2020 12:15:00 -0700
Message-Id: <20201019191500.9264-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/nfc/st21nfca/core.c | 1 -
 drivers/nfc/trf7970a.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/nfc/st21nfca/core.c b/drivers/nfc/st21nfca/core.c
index 2ce17932a073..6ca0d2f56b18 100644
--- a/drivers/nfc/st21nfca/core.c
+++ b/drivers/nfc/st21nfca/core.c
@@ -794,7 +794,6 @@ static int st21nfca_hci_im_transceive(struct nfc_hci_dev *hdev,
 					      skb->len,
 					      st21nfca_hci_data_exchange_cb,
 					      info);
-		break;
 	default:
 		return 1;
 	}
diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 3bd97c73f983..c70f62fe321e 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -1382,7 +1382,6 @@ static int trf7970a_is_iso15693_write_or_lock(u8 cmd)
 	case ISO15693_CMD_WRITE_DSFID:
 	case ISO15693_CMD_LOCK_DSFID:
 		return 1;
-		break;
 	default:
 		return 0;
 	}
-- 
2.18.1

