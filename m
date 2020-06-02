Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15491EBDE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 16:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgFBOS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 10:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgFBOS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:18:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA02FC08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 07:18:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nu7so1437991pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IFVZxk2HGJlMEd0AkzA5r6bJ1EWPxWtJbu5fiwrTlkk=;
        b=JvpZSL2lWhR5tYa+0MyrURuF3XxT4Bg05zgghXWrj8m/9g+1Ox6Ir5KISwxK/MpNTP
         ZffKHyQE1dUV1zirFPktPK6i7z16ntuaOjYZ9A8P1OZSkkD3qx2GtsID1JO/gtTpFcYM
         2pZqkBlMO6NoKN/YPKlFeOSQKkZvWOuTuRHeHjs8Jy6fLWlzoHouK2HGOPVBUWTYFMGf
         RFQFyMVfYpxNN2fzo5WWah0E6j6QvQ/I7aOA+6WhewtBo4ASxJyyhUcMvSa9IxyGzTFg
         aO4E+qT2PdLHJZp7NDFT4uG75TDUwgUrMz4lixMisDIeKT9AAYW+6bvntiSYvqW+hODb
         WkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IFVZxk2HGJlMEd0AkzA5r6bJ1EWPxWtJbu5fiwrTlkk=;
        b=HD1KB7/qRtweBfLtHz5tzzuf8fgsoDIh+v5oSKe4+dOmtQX2tiGIFC710XozyQHYTj
         lwN8UJzwQ0qdkP3TDQ6RdW3Bfz2G1R8NZbDG7/oh12BmTMRCY4uEaOYwy42FzjhDZpTO
         NBQKlVMA0rWkYnZEk/gtDvXJEfXtzjbAlLgsmyy7z5qlsHosNPwc1zxFWDPKYrdTQfTL
         6oH6kQcK2PcSiRJxd16ma8tTsf3Qwe6N0iIeIuIda2a4ojPg1L1U0K4KHsWU0OjQbABv
         4g12bnOr6ydKxgu0l6/NJAZvHlMZwOxt5nukJ81VvkIgAUKKZTnm8yqF2IgaNncqgy6o
         5buw==
X-Gm-Message-State: AOAM531a0/5wBYy+mlAxICyScoxgzkR/vmjF/W/EV+l4aBUXITVib20/
        D6NVQrn2EPZinVEoe8CuYHieqQ==
X-Google-Smtp-Source: ABdhPJyEDi3JjDMMnzCMHmH2BT/npctwWmmUyygPOyrdqNRu+XCIL7pP9LG1SrYenp+nsP4IZAqzgw==
X-Received: by 2002:a17:90b:4c91:: with SMTP id my17mr5390973pjb.81.1591107535207;
        Tue, 02 Jun 2020 07:18:55 -0700 (PDT)
Received: from localhost.localdomain ([117.252.66.248])
        by smtp.gmail.com with ESMTPSA id 141sm2529670pfz.171.2020.06.02.07.18.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 07:18:53 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 0/4] Introduce TEE based Trusted Keys support
Date:   Tue,  2 Jun 2020 19:48:21 +0530
Message-Id: <1591107505-6030-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TEE based trusted keys where TEE provides the functionality
to seal and unseal trusted keys using hardware unique key. Also, this is
an alternative in case platform doesn't possess a TPM device.

This patch-set has been tested with OP-TEE based early TA which is already
merged in upstream [1].

[1] https://github.com/OP-TEE/optee_os/commit/f86ab8e7e0de869dfa25ca05a37ee070d7e5b86b

Changes in v5:
1. Drop dynamic detection of trust source and use compile time flags
   instead.
2. Rename trusted_common.c -> trusted_core.c.
3. Rename callback: cleanup() -> exit().
4. Drop "tk" acronym.
5. Other misc. comments.
6. Added review tags for patch #3 and #4.

Changes in v4:
1. Pushed independent TEE features separately:
  - Part of recent TEE PR: https://lkml.org/lkml/2020/5/4/1062
2. Updated trusted-encrypted doc with TEE as a new trust source.
3. Rebased onto latest tpmdd/master.

Changes in v3:
1. Update patch #2 to support registration of multiple kernel pages.
2. Incoporate dependency patch #4 in this patch-set:
   https://patchwork.kernel.org/patch/11091435/

Changes in v2:
1. Add reviewed-by tags for patch #1 and #2.
2. Incorporate comments from Jens for patch #3.
3. Switch to use generic trusted keys framework.

Sumit Garg (4):
  KEYS: trusted: Add generic trusted keys framework
  KEYS: trusted: Introduce TEE based Trusted Keys
  doc: trusted-encrypted: updates with TEE as a new trust source
  MAINTAINERS: Add entry for TEE based Trusted Keys

 Documentation/security/keys/trusted-encrypted.rst | 203 ++++++++++---
 MAINTAINERS                                       |   8 +
 include/keys/trusted-type.h                       |  48 ++++
 include/keys/trusted_tee.h                        |  66 +++++
 include/keys/trusted_tpm.h                        |  15 -
 security/keys/Kconfig                             |  31 +-
 security/keys/trusted-keys/Makefile               |   6 +-
 security/keys/trusted-keys/trusted_core.c         | 321 +++++++++++++++++++++
 security/keys/trusted-keys/trusted_tee.c          | 280 ++++++++++++++++++
 security/keys/trusted-keys/trusted_tpm1.c         | 335 ++++------------------
 10 files changed, 981 insertions(+), 332 deletions(-)
 create mode 100644 include/keys/trusted_tee.h
 create mode 100644 security/keys/trusted-keys/trusted_core.c
 create mode 100644 security/keys/trusted-keys/trusted_tee.c

-- 
2.7.4

