Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9B42E9BD6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 18:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbhADRRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 12:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbhADRRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:17:01 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE27FC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 09:16:20 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c79so16810727pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 09:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjOs6LGR9BzFtb9WyecLB0AUz/XSu0O5wA5oQbJ4FlM=;
        b=lOo/XzwqYMVGKsrTCZPlZXtQTRkReKeLcybKCge7YWK2zggLKwH3k6u6GW3L9CpWID
         iL95BzJHXXMHXpPQ4xJyCz6JeBOZRgjOkUaPMjqdpJhoTI6uK6wf4ssQAKYnp66Paj4T
         /7hzfwGHC1dQk5qIDdRWdRwdWivoYJ09z/s4ESi0GWfMyArTp6Qz2IM+Qq1KPl10Cbzk
         MnCJa1SxiWSwBr74CV8CSTgDTOWn13bPNH6Mr9WiN82MTAyqibiyc61MHzjzD9QK7Qoa
         uc5zkKW8mw6DZ817I82nBDXSK/08sRQL2hE2lrQ2isn8SdevqK8FwyvIcxeu7GJiwxIq
         0fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjOs6LGR9BzFtb9WyecLB0AUz/XSu0O5wA5oQbJ4FlM=;
        b=Tkmf3x1rd0Y6+ub8Zn/Yub01Rwf/23HHR5JqSxZevvXyqmJ8Xb9MqdShsOy1wuxCNP
         fdaw20bWpMhyDiHViFZum6Ntuva9m67BmyaVAZ7iv10CjNIRUN7Et1+rUv/uJwyEwg4x
         bXBBkx+rtfOGui4hDcZ/RTtUS0yRfLVtAOou3IiUkiRZhFM2qwhT6h1QP6AEgGluhbGx
         ZYL2042O1yinn4g/rtLLvHj6U1xrwu/yHRwSsfD6ZJpbcBCeyy12Gkn+PouWTQQfMzLg
         Ol67PLCv+8EhvfAAXfdTxPA/owZWT0ynpLIvtDPXecSV/Oij9JzMVrSUxI9YqB5ohzxV
         q3mw==
X-Gm-Message-State: AOAM531fca1Qc169cKoW3pGWxkwdfBRsm9JxKvd+gVq4h84ll4pkNdKj
        mkMQgLZr4wBq7YUytDXLNMIFAw==
X-Google-Smtp-Source: ABdhPJwEE5CG603nglRi/PhtwYgUwWCBOcj6TL6PDpX2sU/fBvE/ZNVz9xqabNiYEhnD507/ptg+Tw==
X-Received: by 2002:aa7:810a:0:b029:1a6:501b:19ed with SMTP id b10-20020aa7810a0000b02901a6501b19edmr45701657pfi.17.1609780580403;
        Mon, 04 Jan 2021 09:16:20 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id o140sm55920429pfd.26.2021.01.04.09.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 09:16:19 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add co-maintainer for remoteproc/RPMSG subsystems
Date:   Mon,  4 Jan 2021 10:16:18 -0700
Message-Id: <20210104171618.2702461-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After discussing with Bjorn, stepping forward to help with the
maintenance of the remoteproc and RPMSG subsystems.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..6fa304038f2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15087,6 +15087,7 @@ F:	fs/reiserfs/
 REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM
 M:	Ohad Ben-Cohen <ohad@wizery.com>
 M:	Bjorn Andersson <bjorn.andersson@linaro.org>
+M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 L:	linux-remoteproc@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git rproc-next
@@ -15100,6 +15101,7 @@ F:	include/linux/remoteproc/
 REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM
 M:	Ohad Ben-Cohen <ohad@wizery.com>
 M:	Bjorn Andersson <bjorn.andersson@linaro.org>
+M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 L:	linux-remoteproc@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git rpmsg-next
-- 
2.25.1

