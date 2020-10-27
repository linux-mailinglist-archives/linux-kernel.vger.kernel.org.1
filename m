Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A368229C840
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829299AbgJ0TET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1822827AbgJ0TES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603825456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Lh9LpJ3xp/HEd5FTWkXTDeH3pzRCHbh41QZoY7qmsLY=;
        b=K2zsQWc9KV3mzRHjyqffyvniricWSDaZ7PTmrjAD6FsViM4WlziZujvy+Fl0hKLTLChylj
        IkkSRUQKSJ9pPlcr94WLdG/MYbzCb23/ERaKUBBSuRR8E2PvE5mOYgkdRtrDc6Cc1NsXOz
        YNP3MCxyvL3bRQlg5JZzSrHf0soNw10=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-w5466XMIOF-_dTkP6zsIkw-1; Tue, 27 Oct 2020 15:04:14 -0400
X-MC-Unique: w5466XMIOF-_dTkP6zsIkw-1
Received: by mail-oi1-f200.google.com with SMTP id j9so1122628oii.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lh9LpJ3xp/HEd5FTWkXTDeH3pzRCHbh41QZoY7qmsLY=;
        b=nuJyxY4mNah8iwdwURpmx6bFuJOiVhk881hDxURJuYfZvoHPW6xt3UY5qpXH/uPnYG
         N9Y7HeyVb5HzVpdHjZEH4tP6QiPtYjH6b3cuHMAeQHok4sASbc0AzzCFlUBI903s/7Ep
         8U0pentR+xAeI4vjazn2x8+AsM4+n1drBvYlTMg9TK814WKeTSD/nMNxPufpzlK7n+lB
         zvT38eIalR8Nq/1O82s994JYrZ/3Ec/zXsb/a9czqcsPDVft5nd0nUnetkH8HAc009bL
         sAshsbxJAKhFYBlqPFnlnpjO0xHF/QjWJgkYtGHt7sZumJ17WBJhc6LfIE+5bPEvhJHL
         /M3g==
X-Gm-Message-State: AOAM533eiP0lyrOSLMwbAUtO7zgRI0yBpmalIdmwXUBE6mg5o3++CAhf
        JLhM4G0mKQqUjrMc9DIy4pyJZLHr09SI6Z973PnT+TxsLS1Gn3L8Q78aqJEqn/DxsqrwFtHSchm
        YTw5w0tskHWO3Xg0hyvw8Mie/
X-Received: by 2002:a4a:d8c1:: with SMTP id c1mr2914224oov.31.1603825453197;
        Tue, 27 Oct 2020 12:04:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvw7oDmX4Y9Qq+lv0BXLIdNWKnR8vgPIn4RzyZlnd2saiZ8H8D1LJGtyG5d3zxPaP61mcgtQ==
X-Received: by 2002:a4a:d8c1:: with SMTP id c1mr2914198oov.31.1603825452956;
        Tue, 27 Oct 2020 12:04:12 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q10sm1698690oih.56.2020.10.27.12.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:04:12 -0700 (PDT)
From:   trix@redhat.com
To:     giovanni.cabiddu@intel.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, ebiggers@google.com,
        dominik.przychodni@intel.com, wojciech.ziemba@intel.com,
        mpatocka@redhat.com, geert+renesas@glider.be, ardb@kernel.org
Cc:     qat-linux@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] crypto: qat: remove unneeded semicolon
Date:   Tue, 27 Oct 2020 12:04:07 -0700
Message-Id: <20201027190407.1587980-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/crypto/qat/qat_common/qat_algs.c      | 2 +-
 drivers/crypto/qat/qat_common/qat_asym_algs.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index d552dbcfe0a0..f5d890206e86 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -103,7 +103,7 @@ static int qat_get_inter_state_size(enum icp_qat_hw_auth_algo qat_hash_alg)
 		return ICP_QAT_HW_SHA512_STATE1_SZ;
 	default:
 		return -EFAULT;
-	};
+	}
 	return -EFAULT;
 }
 
diff --git a/drivers/crypto/qat/qat_common/qat_asym_algs.c b/drivers/crypto/qat/qat_common/qat_asym_algs.c
index 846569ec9066..04f2cf769fc1 100644
--- a/drivers/crypto/qat/qat_common/qat_asym_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_asym_algs.c
@@ -201,7 +201,7 @@ static unsigned long qat_dh_fn_id(unsigned int len, bool g2)
 		return g2 ? PKE_DH_G2_4096 : PKE_DH_4096;
 	default:
 		return 0;
-	};
+	}
 }
 
 static inline struct qat_dh_ctx *qat_dh_get_params(struct crypto_kpp *tfm)
@@ -577,7 +577,7 @@ static unsigned long qat_rsa_enc_fn_id(unsigned int len)
 		return PKE_RSA_EP_4096;
 	default:
 		return 0;
-	};
+	}
 }
 
 #define PKE_RSA_DP1_512 0x1c161b3c
@@ -606,7 +606,7 @@ static unsigned long qat_rsa_dec_fn_id(unsigned int len)
 		return PKE_RSA_DP1_4096;
 	default:
 		return 0;
-	};
+	}
 }
 
 #define PKE_RSA_DP2_512 0x1c131b57
@@ -635,7 +635,7 @@ static unsigned long qat_rsa_dec_fn_id_crt(unsigned int len)
 		return PKE_RSA_DP2_4096;
 	default:
 		return 0;
-	};
+	}
 }
 
 static int qat_rsa_enc(struct akcipher_request *req)
-- 
2.18.1

