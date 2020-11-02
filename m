Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381882A2538
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgKBHbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgKBHbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:31:01 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0EAC0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 23:31:01 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id e7so10301041pfn.12
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 23:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MG0UcDuTmhCAz3mOj/tjGMPWdlek6t88bi1IXitM3dc=;
        b=iVDsqKEMNONxG1vTn3P+WS/+YVecrpSTk0oI8yZGNR2VyE1AXCwmm6YZPIatk2h4mD
         BbXJfBZxbY29Wfi1qSST0kNPH5WvPxoSNe8Qj96oDBQyrmg8CmpH8iFSdCkV2P8Vr5IU
         ivthg1ENcwEzgnb0PRJB8DXLHQPj2IqbEr3GABHmYjd8KWKozqN9GA27kxkIvO7hvVpt
         9A7R5oDaKB+JN6AvCzTIBLhug+eNNAziSqEvK+kJzzSfj58TREaOr+8EQoaTUtSpCdkA
         nMRUBGfFmVoyITCM4VzBfRjuvwrc/aNbKmp/OftnBAMcvl5sU3xcdfwAPgPe0A30xy5R
         QgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MG0UcDuTmhCAz3mOj/tjGMPWdlek6t88bi1IXitM3dc=;
        b=nrIgxcEzRZ4P+wXQ0+9O2oBI8j/UsQXDCVZnvTGOlDDkFN/PpuBS6qtJLR8QWveair
         Xef8pxD7Lno8sMKpM85Zdkh0bZ+g/jzDda+IUlN1i7AMd7okL/g6ST1RIDD5gz9nD1GN
         IXSSb/YkPvJgwz8rV7Sqw/niztQ5ysiC/i8uh5h0hfbFy6oEVqbe7+1cW0T7yY+Ta29f
         xrnZBYu+xgzAtjuX/ubjTxAZXV60wqhc8i8RUFLmBUpAKiwY0WRHW1UxgDK/x5PAcXAR
         vhJ82jLulX5KXlDsvDlWWk4gmEH7Ihl9R1rJ9q5aiWWV7DKl02AhT8GyhNRsq+t0si44
         tjaA==
X-Gm-Message-State: AOAM532lBf2TsfM/EVQPJfptSvweJPQSr+2VGGp/Ff0OJB5RwEuKhauq
        an4ACSXrAQuALpbqe/vkNL3whnOWPUHRUw==
X-Google-Smtp-Source: ABdhPJxljOc46LeX6iByBE7ryl60id+toVy9Oeillh9upVxSzVbgg0FI/Jgc+88nQT7Yu9jSu65oow==
X-Received: by 2002:a17:90a:6c61:: with SMTP id x88mr16592187pjj.13.1604302260701;
        Sun, 01 Nov 2020 23:31:00 -0800 (PST)
Received: from vultr.guest ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id r4sm4763065pgs.54.2020.11.01.23.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 23:31:00 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] riscv: uaccess: fix __put_kernel_nofault()
Date:   Mon,  2 Nov 2020 15:30:52 +0800
Message-Id: <20201102073052.199638-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copy_from_kernel_nofault() is broken on riscv because the 'dst' and
'src' are mistakenly reversed in __put_kernel_nofault() macro.

copy_to_kernel_nofault:
...
0xffffffe0003159b8 <+30>:    sd      a4,0(a1) # a1 aka 'src'

Fixes: d464118cdc ("riscv: implement __get_kernel_nofault and __put_user_nofault")
Signed-off-by: Changbin Du <changbin.du@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index c47e6b35c551..824b2c9da75b 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -476,7 +476,7 @@ do {									\
 do {									\
 	long __kr_err;							\
 									\
-	__put_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
+	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
 	if (unlikely(__kr_err))						\
 		goto err_label;						\
 } while (0)
-- 
2.17.1


